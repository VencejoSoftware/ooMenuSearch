{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus, StdCtrls,
  MenuActionForm;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    MenuA1: TMenuItem;
    MenuB1: TMenuItem;
    MenuC1: TMenuItem;
    Item11: TMenuItem;
    Item21: TMenuItem;
    Itemm1: TMenuItem;
    Itemj1: TMenuItem;
    Submenu11: TMenuItem;
    Citem1: TMenuItem;
    Citemb1: TMenuItem;
    Citemc1: TMenuItem;
    Subitemc1: TMenuItem;
    Subitemcbis1: TMenuItem;
    Supersubitemc11: TMenuItem;
    Supersubitemc21: TMenuItem;
    Supersubitemc31: TMenuItem;
    Lasttreeitem1: TMenuItem;
    Button1: TButton;
    procedure Item21Click(Sender: TObject);
    procedure Submenu11Click(Sender: TObject);
    procedure Citemc1Click(Sender: TObject);
    procedure Supersubitemc31Click(Sender: TObject);
    procedure Lasttreeitem1Click(Sender: TObject);
    procedure Item11Click(Sender: TObject);
    procedure Itemj1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var
  NewMainForm: TMainForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMainForm.Citemc1Click(Sender: TObject);
begin
  ShowMessage('CItemC');
end;

procedure TMainForm.Item11Click(Sender: TObject);
begin
  ShowMessage('Item1');
end;

procedure TMainForm.Item21Click(Sender: TObject);
begin
  ShowMessage('Item2');
end;

procedure TMainForm.Itemj1Click(Sender: TObject);
begin
  ShowMessage('Item j');
end;

procedure TMainForm.Lasttreeitem1Click(Sender: TObject);
begin
  ShowMessage('Last');
end;

procedure TMainForm.Submenu11Click(Sender: TObject);
begin
  ShowMessage('Submenu1');
end;

procedure TMainForm.Supersubitemc31Click(Sender: TObject);
begin
  ShowMessage('Supersubitemc3');
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  TMenuSearchForm.Show(Self);
end;

end.
