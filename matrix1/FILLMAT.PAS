{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     FILLMAT                                                 * }
{ *  H����祭��: �p�������� ���������� ���p��                           * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit FillMat;

interface

Uses Common, Texts, Graph, Message, MultNum, MatInput, Crt, Ident;

  { ********************************************************************** }
  { --- �p�楤yp� ���������� ���p�� --- }
  procedure FillMats;

  { ********************************************************************** }
  { �᭮���� �p�楤yp� ���������� ���p���:
      Mat      - ���p��
      Col, Row - p����p���� ���p���
  }
  procedure Fill( Mat : MatPtr; Col, Row : IntPtr );

implementation

{ ********************************************************************** }
{ ---            �᭮���� �p�楤yp� ���������� ���p���               --- }
{ ********************************************************************** }

procedure Fill( Mat : MatPtr; Col, Row : IntPtr );
var
  Answer  : integer;                               { �⢥� ���짮��⥫� }
  N       : real;                                  { ��������� �᫮ }
  Number  : real;                                  { ��᫮ ���������� }
  Ch      : word;                                  { ��� ������ }
  R       : TRect;
  i, j   : integer;

  { --- �y���� ����p�樨 �y砩���� �᫠ --- }
  function RndNum : real;
  begin
    RndNum:=Random( Trunc(MaxMatVal) ) - MaxMatVal / 2;
  end;

begin
  Ch:=kbEnter;
  Randomize;                                              { ��⠭���� RND }
  Answer:=MessageBox( WhatMsg, WhatNum, WhatButs );       { ��� ������塞 ? }
  if Answer in [1, 2] then begin                          { �⢥� �� ? }
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);    { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    ShowMat( MatX, MatY, Mat, Col, Row );                 { �뢥�� ���p��y }
    if Answer=1 then N:=InpNumberMsg( RndFillMsg, Ch );   { ����� �᫮ }
    if Ch=kbEnter then begin                              { Esc �� �뫮 ? }
      LocalMsg( FillingMsg );                              { C���饭�� }
      for i:=1 to Row^ do for j:=1 to Col^ do begin        { ���� � ���p�� }
        ShowNPos( MatX, MatY, Yellow, i, j, Mat^[i,j] );   { �������� }
        Delay( ShowDelay );                                { ������ }
        if Answer=1                                        { ��� �᫠: }
          then Number:=N                                   {  - ��������� }
          else Number:=RndNum;                             {  - �y砩��� }
        Mat^[i, j]:=Number;                                { ��������� }
        ShowNPos( MatX, MatY, Red, i, j, Mat^[i,j] );      { �������� }
        Delay( ShowDelay );                                { ��������� }
      end;
      LocalMsg( FilledMsg );                               { C���饭�� � }
    end;                                                   { ���� p����� }
  end;
end;

{ ********************************************************************** }
{ ---                 �p�楤yp� ���������� ���p��                    --- }
{ ********************************************************************** }

procedure FillMats;
Var
  i : integer;
begin
  i:=MessageBox( FillMsg, MatNum, MatButs );
  case i of
    1 : Fill( @MatrixA, @MatACol, @MatARow );
    2 : Fill( @MatrixB, @MatBCol, @MatBRow );
  end;
end;

end.