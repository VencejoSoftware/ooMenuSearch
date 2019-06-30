{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Form to admin menu actions
  @created(30/06/2019)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit MenuActionForm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, StdCtrls, Windows,
  MenuAction;

type
{$REGION 'documentation'}
{
  @abstract(Form to admin menu actions)
  @member(btnExecuteClick Execute selected menu action)
  @member(edFindChange Filter list by user input)
  @member(lbMenuItemsClick Select menu action by user)
  @member(lbMenuItemsDrawItem Draw styled list for menu actions and states)
  @member(lbMenuItemsMeasureItem Calculate item list size)
  @member(chkOnlyExecutablesClick User input to filter list by menu action executables)
  @member(FormCreate Create menu action and update with owner form TMenu);
  @member(FormDestroy Destroy menu action list)
  @member(
    ShowItems Show menu actions in list
    @return(List @link(TMenuActionList Menu action list))
  )
  @member(SelectedMenuAction Return selected menu action)
  @member(
    Search Build a list filtered by user and display in TListBox
  )
  @member(
    Show Create form and show in modal mode
    @param(Owner Owner component, parent of TMenu)
    @return(Modal result)
  )
}
{$ENDREGION}
  TMenuSearchForm = class(TForm)
    edFind: TEdit;
    btnExecute: TButton;
    lblPath: TLabel;
    lbMenuItems: TListBox;
    chkOnlyExecutables: TCheckBox;
    lblCount: TLabel;
    procedure btnExecuteClick(Sender: TObject);
    procedure edFindChange(Sender: TObject);
    procedure lbMenuItemsClick(Sender: TObject);
    procedure lbMenuItemsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure lbMenuItemsMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
    procedure chkOnlyExecutablesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    _MenuActionList: TMenuActionList;
  private
    procedure ShowItems(const List: TMenuActionList);
    procedure Search;
    function SelectedMenuAction: IMenuAction;
  public
    class function Show(const Owner: TComponent): TModalResult;
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

function TMenuSearchForm.SelectedMenuAction: IMenuAction;
begin
  if lbMenuItems.ItemIndex > - 1 then
    Result := TMenuAction(lbMenuItems.Items.Objects[lbMenuItems.ItemIndex])
  else
    Result := nil;
end;

procedure TMenuSearchForm.lbMenuItemsClick(Sender: TObject);
var
  MenuAction: IMenuAction;
begin
  MenuAction := SelectedMenuAction;
  if Assigned(MenuAction) then
  begin
    btnExecute.Enabled := MenuAction.CanExecute;
    lblPath.Caption := MenuAction.Path;
  end;
end;

procedure TMenuSearchForm.lbMenuItemsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  MenuAction: IMenuAction;
  X, Y: Integer;
begin
  MenuAction := _MenuActionList.FindByID(lbMenuItems.Items[Index]);
  if odSelected in State then
    lbMenuItems.Canvas.Brush.Color := clHighlight
  else
    lbMenuItems.Canvas.Brush.Color := lbMenuItems.Color;
  lbMenuItems.Canvas.FillRect(Rect);
  OffsetRect(Rect, 2, 2);
  if odSelected in State then
    lbMenuItems.Canvas.Font.Color := clHighlightText
  else
  begin
    if MenuAction.CanExecute then
      lbMenuItems.Canvas.Font.Color := lbMenuItems.Font.Color
    else
      lbMenuItems.Canvas.Font.Color := clDkGray;
  end;
  lbMenuItems.Canvas.Font.Style := [fsBold];
  X := Rect.Left + 2;
  Y := Rect.Top;
  lbMenuItems.Canvas.TextOut(X, Y, MenuAction.Caption);
  if Length(MenuAction.Hint) > 0 then
  begin
    X := X + 4;
    Y := Y + lbMenuItems.Canvas.TextHeight(MenuAction.Caption) + 1;
    lbMenuItems.Canvas.Font.Style := [fsItalic];
    lbMenuItems.Canvas.TextOut(X, Y, MenuAction.Hint);
  end;
end;

procedure TMenuSearchForm.lbMenuItemsMeasureItem(Control: TWinControl; Index: Integer; var Height: Integer);
var
  MenuAction: IMenuAction;
begin
  MenuAction := _MenuActionList.FindByID(lbMenuItems.Items[Index]);
  if Assigned(MenuAction) and (Length(MenuAction.Hint) > 0) then
    Height := (lbMenuItems.Canvas.TextHeight('A') * 2) + 6
  else
    Height := Height + 3;
end;

procedure TMenuSearchForm.btnExecuteClick(Sender: TObject);
var
  MenuAction: IMenuAction;
begin
  MenuAction := SelectedMenuAction;
  Hide;
  MenuAction.Execute;
  ModalResult := mrOk;
end;

procedure TMenuSearchForm.ShowItems(const List: TMenuActionList);
var
  MenuAction: IMenuAction;
begin
  lbMenuItems.Items.BeginUpdate;
  try
    lbMenuItems.Clear;
    for MenuAction in List do
      lbMenuItems.AddItem(MenuAction.ID, MenuAction as TObject);
  finally
    lbMenuItems.Items.EndUpdate;
  end;
  lbMenuItems.Invalidate;
  lblPath.Caption := EmptyStr;
  btnExecute.Enabled := False;
end;

procedure TMenuSearchForm.chkOnlyExecutablesClick(Sender: TObject);
begin
  Search;
end;

procedure TMenuSearchForm.Search;
var
  SearchList: TMenuActionList;
begin
  SearchList := _MenuActionList.ListByPattern(edFind.Text, chkOnlyExecutables.Checked);
  try
    ShowItems(SearchList);
    lblCount.Caption := Format('%d Items', [SearchList.Count]);
  finally
    SearchList.Free;
  end;
end;

procedure TMenuSearchForm.edFindChange(Sender: TObject);
begin
  Search;
end;

procedure TMenuSearchForm.FormCreate(Sender: TObject);
begin
  _MenuActionList := TMenuActionList.New(Owner);
  _MenuActionList.Update;
  Search;
end;

procedure TMenuSearchForm.FormDestroy(Sender: TObject);
begin
  _MenuActionList.Free;
end;

class function TMenuSearchForm.Show(const Owner: TComponent): TModalResult;
var
  Form: TMenuSearchForm;
begin
  Form := TMenuSearchForm.Create(Owner);
  try
    Form.ShowModal;
    Result := Form.ModalResult;
  finally
    Form.Free;
  end;
end;

end.
