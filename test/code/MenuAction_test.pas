{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MenuAction_test;

interface

uses
  SysUtils, Menus,
  MenuAction,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TMenuActionTest = class sealed(TTestCase)
  published

  end;

implementation

initialization

RegisterTest(TMenuActionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
