{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Menu action object
  @created(30/06/2019)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit MenuAction;

interface

uses
  SysUtils, Classes, Menus,
{$IFDEF FPC}
  regexpr,
{$ELSE}
  RegularExpressions,
{$ENDIF}
  Generics.Collections;

type
{$REGION 'documentation'}
{
  @abstract(Menu action object)
  @member(ID Object identifier)
  @member(Caption Menu caption)
  @member(Hint Menu hint)
  @member(Path Menu address path)
  @member(
    IsEnabled Menu state
    @return(@true if enabled, @false if not)
  )
  @member(
    CanExecute Checks if menu can be executed
    @return(@true if can execute, @false if not)
  )
  @member(
    Execute Execute menu related click action
    @return(@true if execute is ok, @false if fail)
  )
  @member(
    Parent Parent menu action object.
    @return(@link(IMenuAction Menu action parent))
  )
}
{$ENDREGION}
  IMenuAction = interface
    ['{C543BCD0-EF5C-4FBF-8E26-84A661152ECF}']
    function ID: String;
    function Caption: String;
    function Hint: String;
    function Path: String;
    function IsEnabled: Boolean;
    function CanExecute: Boolean;
    function Execute: Boolean;
    function Parent: IMenuAction;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IMenuAction))
  @member(Syntax @seealso(IMenuAction.ID))
  @member(Syntax @seealso(IMenuAction.Caption))
  @member(Syntax @seealso(IMenuAction.Hint))
  @member(Syntax @seealso(IMenuAction.Path))
  @member(Syntax @seealso(IMenuAction.IsEnabled))
  @member(Syntax @seealso(IMenuAction.CanExecute))
  @member(Syntax @seealso(IMenuAction.Execute))
  @member(Syntax @seealso(IMenuAction.Parent))
  @member(
    Create Object constructor
    @param(MenuItem TMenuItem master object)
    @param(@link(IMenuAction Menu action parent))
  )
  @member(
    New Create a new @classname as interface
    @param(MenuItem TMenuItem master object)
    @param(@link(IMenuAction Menu action parent))
  )
}
{$ENDREGION}

  TMenuAction = class sealed(TInterfacedObject, IMenuAction)
  strict private
    _MenuItem: TMenuItem;
    _Parent: IMenuAction;
  public
    function ID: String;
    function Caption: String;
    function Hint: String;
    function Path: String;
    function IsEnabled: Boolean;
    function CanExecute: Boolean;
    function Execute: Boolean;
    function Parent: IMenuAction;
    constructor Create(const MenuItem: TMenuItem; const Parent: IMenuAction);
    class function New(const MenuItem: TMenuItem; const Parent: IMenuAction): IMenuAction;
  end;

{$REGION 'documentation'}
{
  @abstract(List of menu action)
  @member(
    FindByID Find menu action by identifier
    @return(ID Menu action identifier)
    @return(@link(IMenuAction Menu action) or nil if not found)
  )
  @member(
    ListByPattern Uses regular expression to build a new list filtered by a pattern caption
    @return(Pattern Caption pattern to apply)
    @return(OnlyExecutables Filter only menu with CanExecute = True)
    @return(@link(TMenuActionList Menu action list))
  )
  @member(
    Update Search in owner components for menu childs to build the list
  )
  @member(
    Create Object constructor
    @param(Owner Owner component, parent of TMenu)
  )
  @member(
    New Create a new @classname as interface
    @param(Owner Owner component, parent of TMenu)
  )
}
{$ENDREGION}

  TMenuActionList = class sealed(TList<IMenuAction>)
  strict private
    _Owner: TComponent;
  public
    function FindByID(const ID: String): IMenuAction;
    function ListByPattern(const Pattern: String; const OnlyExecutables: Boolean): TMenuActionList;
    procedure Update;
    constructor Create(const Owner: TComponent); reintroduce;
    class function New(const Owner: TComponent): TMenuActionList;
  end;

implementation

function TMenuAction.ID: String;
begin
  Result := _MenuItem.Name;
end;

function TMenuAction.Caption: String;
begin
  Result := StringReplace(_MenuItem.Caption, '&', EmptyStr, []);
end;

function TMenuAction.Hint: String;
begin
  Result := _MenuItem.Hint;
end;

function TMenuAction.Path: String;
begin
  if Assigned(_Parent) then
    Result := _Parent.Path + ' > '
  else
    Result := EmptyStr;
  Result := Result + QuotedStr(Caption);
end;

function TMenuAction.IsEnabled: Boolean;
begin
  Result := _MenuItem.Enabled and _MenuItem.Visible;
  if Assigned(_Parent) then
    Result := Result and _Parent.IsEnabled;
end;

function TMenuAction.CanExecute: Boolean;
begin
  Result := IsEnabled and Assigned(_MenuItem.OnClick)
end;

function TMenuAction.Execute: Boolean;
begin
  Result := IsEnabled;
  if Result then
    _MenuItem.Click;
end;

function TMenuAction.Parent: IMenuAction;
begin
  Result := _Parent;
end;

constructor TMenuAction.Create(const MenuItem: TMenuItem; const Parent: IMenuAction);
begin
  _MenuItem := MenuItem;
  _Parent := Parent;
end;

class function TMenuAction.New(const MenuItem: TMenuItem; const Parent: IMenuAction): IMenuAction;
begin
  Result := TMenuAction.Create(MenuItem, Parent);
end;

{ TMenuActionList }

function TMenuActionList.ListByPattern(const Pattern: String; const OnlyExecutables: Boolean): TMenuActionList;
var
  Item: IMenuAction;
{$IFDEF FPC}
  RegExpr: TRegExpr;
{$ENDIF}
begin
  Result := TMenuActionList.New(_Owner);
  for Item in Self do
    if not OnlyExecutables or (OnlyExecutables and Item.CanExecute) then
      if Length(Pattern) < 1 then
        Result.Add(Item)
      else
      begin
{$IFDEF FPC}
        RegExpr := TRegExpr.Create;
        try
          RegExpr.Expression := Pattern + '.*$';
          RegExpr.ModifierI := True;
          if RegExpr.Exec(Item.Caption) then
            Result.Add(Item);
        finally
          RegExpr.Free;
        end;
{$ELSE}
        if TRegEx.IsMatch(Item.Caption, Pattern + '.*$', [roSingleLine, roIgnoreCase]) then
          Result.Add(Item);
{$ENDIF}
      end;
end;

function TMenuActionList.FindByID(const ID: String): IMenuAction;
var
  Item: IMenuAction;
begin
  Result := nil;
  for Item in Self do
    if CompareText(ID, Item.ID) = 0 then
      Exit(Item);
end;

procedure TMenuActionList.Update;
var
  Component: TComponent;
  i: Integer;
begin
  Clear;
  for i := 0 to Pred(_Owner.ComponentCount) do
  begin
    Component := _Owner.Components[i];
    if Component is TMenuItem then
      if TMenuItem(Component).Caption <> '-' then
        Add(TMenuAction.New(TMenuItem(Component), FindByID(TMenuItem(Component).Parent.Name)));
  end;
end;

constructor TMenuActionList.Create(const Owner: TComponent);
begin
  inherited Create;
  _Owner := Owner;
end;

class function TMenuActionList.New(const Owner: TComponent): TMenuActionList;
begin
  Result := TMenuActionList.Create(Owner);
end;

end.
