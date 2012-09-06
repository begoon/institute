{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     COMMON                                                  * }
{ *  H����祭��: ������� �᭮���� ����⠭�, ��ꥪ⮢ � �p�楤yp       * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Common;

interface

Uses Crt;

const

  { -------- �p������ �p���p��⨪� p����� ���p�� --------- }

  MaxMatCol    = 10;       { ���ᨬ��쭮� ���-�� �⮫�殢 }
  MaxMatRow    = 10;       { ���ᨬ��쭮� ���-�� ��p�� }
  MaxMatVal    = 9.9;      { ���ᨬ��쭮� ���祭�� ������� ���p��� }
  MinMatVal    = -9.9;     { �������쭮� ���祭�� ������� ���p��� }

type

  { --- ��� ���p�� --- }

  MatType     = array [1..MaxMatRow, 1..MaxMatCol ] of real;
  MatPtr      = ^MatType;
  IntPtr      = ^integer;

Var

  { --- ���p�� � --- }

  MatrixA     : MatType;    { ���p�� }
  MatACol     : integer;    { ��᫮ �⮫�殢 }
  MatARow     : integer;    { ��᫮ ��p�� }

  { --- ���p�� B --- }
  MatrixB      : MatType;   { ���p�� }
  MatBCol      : integer;   { ��᫮ �⮫�殢 }
  MatBRow      : integer;   { ��᫮ ��p�� }

Const

  MaxInpStr    = 4 ;        { ���ᨬ��쭠� ����� �������� ��p��� }

Type

  InpStrType   = string [ MaxInpStr ] ; { ��� �������� ��p�� }

Const

  { ---- ��� 䠩�� � 䮭⮬ ---- }

  FontName     = 'hi8x8.fnt';
  FontSize     = 1024;                            { �����p 䮭� }
  FontInt      = 31;                              { �p�p뢠��� 䮭� }

  { ---- C��⥬�� �訡�� �p����� �ᯮ������ ERRORLEVEL ----- }

  G_INIT_ERROR = 200;       { H� ���樠����py���� �p�䨪� }
  EVENTS_ERROR = 201;       { ��p��������� � ��p��� ᮡ�⨩ }
  FONT_ERROR   = 202;       { H�� 䠩�� � 䮭⮬ }

  { ---- ����⠭�� ��� ��p�ᮢ�� ��⥩ ���p䥩� ---- }

  SymHeight    = 8;         { ���� ������ ᨬ���� }
  SymWidth     = 8;         { ��p��� ������ ᨬ���� }
  StartX       = 10;        { ���p����� X ��p⨪��쭮�� ���� }
  StartY       = 20;        { ���p����� Y ��p⨪��쭮�� ���� }
  DeltaY       = 10;        { �����ﭨ� ����y �������� �� X }
  DeltaX       = 10;        { �����ﭨ� ����y �������� �� Y }
  AddX         = 5;         { C��饭�� ⥪�� ��y�p� ������ }
  AddY         = 7;
  FullHeight   = SymHeight+AddY*2+DeltaY;  {  ���� ����� ������ }
  FullWidth    = SymWidth+AddX*2+DeltaX;   {  ��p��� ����� ������ }

  { ------------ ������� �������� ���� ------------- }

  cmInput      = 1;
  cmFill       = 2;
  cmEqu        = 3;
  cmAdd        = 4;
  cmMultNumber = 5;
  cmMultMat    = 6;
  cmTrans      = 7;
  cmType       = 8;
  cmAbout      = 9;
  cmExit       = 10;

  { --------------- ��p�����騥 ������� --------------- }

  cmTab        = 200;
  cmSTab       = 201;
  cmEnter      = 202;
  cmBreak      = 203;

  { ------------- ���� y�p������� ������ -------------- }

  kbEsc        = 27;
  kbTab        = 9;
  kbShiftTab   = 15;
  kbEnter      = 13;
  kbUp         = 328;
  kbDown       = 336;
  kbLeft       = 331;
  kbRight      = 333;
  kbF1         = 315;
  kbF10        = 324;
  kbSpace      = 32;

  { --- ����⠭�� ��� �p�p�ᮢ�� 䮭� --- }

  MainBackX   = 186;
  MainBackY   = 12;

  { --- ����⠭�� ��� ����� p����p���⥩ ���p��� --- }

  MaxColRow   = 30;                                    { ����� ���� }
  ColRowX     = MainBackX+30;                          { ���p������ ����� }
  ColRowY     = MainBackY+10;                          { p����p���⥩ }
  ColRowSizeX = MaxColRow*SymHeight+AddY*2;            { �����p� ���� ��� }
  ColRowSizeY = 2*SymHeight+AddY*4;                    { ����� p����p���⥩ }
                                                       { ���p����� ����� }
                                                       { ᠬ�� �ᥫ }

  ColRowNew   = ColRowX+ColRowSizeX-SymWidth*(MaxInpStr+1)-AddX;

  { --- ���⠭�� ��� ����� ���p��� --- }

  MatX        = MainBackX+30+AddX;                        { ���p������ }
  MatY        = ColRowY+ColRowSizeY+AddX+20;              { �뢮�� ���p�� }
  MatSizeX    = MaxMatCol*(MaxInpStr+1)*SymWidth+AddX*2;  { �����p� ����� }
  MatSizeY    = MaxMatRow*2*SymHeight+AddY*2;             { ����樨 }

  { --- �����p� y᫮���� ����p������ ���p�� --- }

  ElemX       = 7;                                       { �����p� ������ }
  ElemY       = 7;                                       { ������� }
  SpaceX      = 3;                                       { �����ﭨ� }
  SpaceY      = 3;                                       { ����y ������⠬� }
  ElemSizeX   = ElemX+SpaceX;                            { ����� p����p� }
  ElemSizeY   = ElemY+SpaceY;                            { ������ ������� }
  FullElemX   = ElemSizeX*MaxMatCol+SpaceX;              { ���ᨬ���� }
  FullElemY   = ElemSizeY*MaxMatRow+SpaceY;              { p����p� ���p��� }
  DrawTextY   = SymHeight+AddY*2;                        { Y ��� ��������� }
  DrawX       = (MainBackX-FullElemX) div 2;             { ���p������ }
  DrawY       = 175;                                     { �p�p�ᮢ�� }
  DrawEndX    = DrawX+FullElemX;                         { �ᥩ }
  DrawEndY    = DrawY+FullElemY+DrawTextY;               { ���p��� }

  { --- ����⠭�� ��� ������䨪�樨 ⨯� ���p��� --- }

  IdnX        = MatX;                                    { ���p������ }
  IdnY        = MatY;                                    { ��o�� ���p��� }

  { --- ����⠭�� ��� �p���p�� p�����⢠ ���p�� --- }

  CheckX      = MatX;                                    { ���p������ ��� }
  CheckY      = MainBackY+AddY;                          { �뢮�� 2-� ���p�� }
  CheckOfsA   = AddY*4;                                  { C��饭�� ��� }
  CheckOfsB   = CheckOfsA+AddY*8;                        { p����� 640x480 }

  { --- ����⠭�� ��� ᫮����� ���p�� --- }

  AddMatX     = MatX;                                    { ���p������ }
  AddMatY     = MatY;                                    { �뢮�� ���p��� }

  { --- ����⠭�� ��� ����� �᫠ � �p����襭��� --- }

  MaxNInp     = 40;                                      { ����� �p����襭�� }
  NInpX       = MainBackX+30;                            { ���p������ }
  NInpY       = MainBackY+20;                            { ���� }
  NInpTextX   = NInpX+AddX;                              { ���p������ }
  NInpTextY   = NInpY+AddY;                              { ⥪�� }
  NInpWidth   = MaxInpStr*SymWidth;                      { ��p��� ⥪�� }
  NInpSizeX   = MaxNInp*SymHeight+AddY*2;                { �����p� �᫠ }
  NInpSizeY   = SymHeight+AddY*2;                            { �p� ����� }
  NInpNumX    = NInpX+NInpSizeX-SymWidth*(MaxInpStr+1)-AddX; { ���p������ }
                                                             { �᫠ �p� }
                                                             { ����� }

  { --- ����⠭�� ��� �����쭮�� ᮮ�饭�� --- }

  RepX        = IdnX;                                      { ���p������ }
  RepY        = IdnY+MatSizeY+AddY*2;                      { ���� }
  RepSizeX    = 640-MainBackX-AddX*4-30;                   { �����p� }
  RepSizeY    = SymHeight+AddX*2;                          { ���� }

  ShowDelay   = 100;                       { ����p��� �p� �뢮�� �� ��p�� }

type

  { ------- ��ꥪ� - �窠 ------- }

  TPoint = record
    X, Y : integer;
  end;

  { -------- ��ꥪ� - �pאַy���쭨� -------- }

  TRect = object
    A, B : TPoint;                               { ���p������ y���� }
    procedure Assign( XA, YA, XB, YB : Integer); { �p�᢮���� }
    function  Contains( P : TPoint ) : Boolean;  { �p���p�� �p����������� }
  end;

  { *********************************************** }
  { --- �y���� ����� p���p������ ���� ������ --- }
  { *********************************************** }
  function GetKey : word;

  { *********************************************** }
  { ---       �p�楤yp� ��y������ ᨣ����       --- }
  { *********************************************** }
  procedure Beep;

implementation

  { ********************************************************** }
  { --------------- ���樠������ �p���y���쭨�� ------------- }
  { ********************************************************** }

  procedure TRect.Assign( XA, YA, XB, YB : Integer);
  begin
    A.X:=XA;
    A.Y:=YA;
    B.X:=XB;
    B.Y:=YB;
  end;

  { **************************************************************** }
  { --------- �p���p�� �p����������� �窨 �pאַy���쭨�y --------- }
  { **************************************************************** }

  function TRect.Contains( P : TPoint ) : boolean;
  begin
    Contains:= (P.X>=A.X) and (P.Y>=A.Y) and ( P.X<=B.X ) and ( P.Y<=B.Y );
  end;

  { *********************************************** }
  { --- �y���� ����� p���p������ ���� ������ --- }
  { *********************************************** }

  function GetKey : word;
  var
    Res : char;
  begin
    Res := ReadKey;
    if Res=#0
      then GetKey:=256+ord( ReadKey )
      else GetKey:=ord( Res );
  end;

  { *********************************************** }
  { ---       �p�楤yp� ��y������ ᨣ����       --- }
  { *********************************************** }

  procedure Beep;
  begin
    Write(#7);
  end;

end.