{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     MATINPUT                                                * }
{ *  H����祭��: �p�������� ����� ���p��                                * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit MatInput;

interface

Uses Common, Message, InpStr, Graph, Convert, Texts;

   { *************************************** }
   { --- �᭮���� �p�楤yp� ����� ���p�� --- }
   { *************************************** }
   Procedure InputMats;

   { ******************************************************************** }
   { ���� ���p��:
       Mat   - y����⥫� �� ���p��y
       Col   - ������⢮ �⮫�殢 � ���p��
       Row   - ������⢮ ��p�� � ���p��
   }
   procedure InpMat( Mat : MatPtr; Col, Row : IntPtr );

   { ******************************************************************** }
   { �뢥�� ���p��y:
       x, y  - ���p������
       color - 梥�
       Mat   - y����⥫� �� ���p��y
       Col   - ������⢮ �⮫�殢 � ���p��
       Row   - ������⢮ ��p�� � ���p��
   }
   procedure ShowMat( x, y : word; Mat : MatPtr; Col, Row : IntPtr );

   { ******************************************************************** }
   { �뢮� i,j-�� �������:
       Left, Top - ���p������ y��� ���p���
       Color     - 梥� �������
       i, j      - �������
       N         - ���祭�� �������
   }
   procedure ShowNPos( Left, Top, Color, i, j : integer; N : real );

   { ******************************************************************** }
   { �p�楤yp� ���᫥��� ���p����� ��� ��y� ���p��:
      yA, yB - ���y砥�� ���p������
   }
   procedure GetTwoCoords( var yA, yB : integer );

implementation

{ ******************************************** }
{ --- ���᫥��� ���p����� i,j-�� ������� --- }
{ ******************************************** }

procedure GetNPos( var x, y, i, j : integer );
begin
  x:=(j-1)*(MaxInpStr+1)*SymWidth;
  y:=(i-1)*2*SymHeight;
end;

{ ******************************************** }
{ --- ���᫥��� ���p����� ��� ��y� ���p�� --- }
{ ******************************************** }

procedure GetTwoCoords( var yA, yB : integer );
begin
  yA:=CheckY;
  yB:=CheckY+MatSizeY-AddY;
  if GetMaxY>349 then begin
    yA:=yA+CheckOfsA;
    yB:=yB+CheckOfsB;
  end;
end;

{ ****************************** }
{ --- �뢮� i,j-�� ������� --- }
{ ****************************** }

procedure ShowNPos( Left, Top, Color, i, j : integer; N : real );
var
  x, y : integer;
  NStr : string;
begin
  GetNPos( x, y, i, j );                           { ����塞 ���p������ }
  x:=x+Left;                                       { i,j-�� ������� }
  y:=y+Top;
  SetFillStyle( SolidFill, LightGray );            { C�p��� ��p�� }
  Bar( x, y, x+MaxInpStr*SymWidth, y+SymHeight );
  Str( N:MaxInpStr:1, NStr );                      { �p���p����뢠�� }
  if Length( NStr ) > MaxInpStr                    { ��p����� ��譥� }
    then NStr[0]:=chr( MaxInpStr );
  SetColor( Color );                               { � �뢮��� }
  OutTextXY( x, y,  NStr);
end;

{ *********************** }
{ --- �뢥�� ���p��y --- }
{ *********************** }

procedure ShowMat( x, y : word; Mat : MatPtr; Col, Row : IntPtr );
var
  SizeX, SizeY : integer;
  R            : TRect;
  i, j         : integer;
begin
  SizeX:=(Col^*(MaxInpStr+1)-1)*SymWidth+AddX*2; { ���᫨�� p����p� ���� }
  SizeY:=Row^*2*SymHeight;                       { �� x � y }
  R.Assign( x-AddX, y-AddY, x+SizeX, y+SizeY );
  DrawBox( R, True, LightGray );                 { �뢥�� ���� }
  for i:=1 to Row^ do                            { �뢥�� ���p��y }
    for j:=1 to Col^ do
      ShowNPos( x, y, Blue, i, j, Mat^[ i, j ] );
end;

{ *********************************** }
{ --- �뢮� p����p���⥩ �� ��p�� --- }
{ *********************************** }

procedure ShowColRow( Col, Row : IntPtr );
begin
  SetFillStyle( SolidFill, LightGray );            { ���p��� ��p�� }
  Bar( ColRowNew, ColRowY+AddY,
       ColRowNew+SymWidth*MaxInpStr, ColRowY+AddY+SymHeight*3 );

  SetColor( Black );                               { �뢮��� ���祭�� }

  OutTextXY( ColRowNew, ColRowY+AddY, IntToStr( Col^ ) );
  OutTextXY( ColRowNew, ColRowY+AddY+SymHeight*2, IntToStr(Row^) );
end;

{ *********************************** }
{ ---- ���� p����p���⥩ ���p��� ---- }
{ *********************************** }

procedure InputColRow( Col, Row : IntPtr );
var
  R    : TRect;
  ch   : word;
  What : boolean;
begin
  R.Assign( ColRowX, ColRowY, ColRowX+ColRowSizeX, ColRowY+ColRowSizeY );

  DrawBox( R, True, LightGray );                     { �뢥�� ���� }
  SetColor( Black );
  OutTextXY( ColRowX+AddX, ColRowY+AddY, ColMsg );   { �뢥�� ��������� }

  OutTextXY( ColRowX+AddX, ColRowY+AddY+SymHeight*2, RowMsg );

  What:=true;                                        { H�砭��� � COL }
  repeat
    ShowColRow( Col, Row );                          { ���p��� ��p�� }
                                                     { � �뢮��� ���祭�� }
    if What                                          { ������ �y���� }

      then Col^:=trunc(InputNumber( ColRowNew, ColRowY+AddY,
                                    Col^, 1, MaxMatCol, False, ch ))
      else Row^:=trunc(InputNumber( ColRowNew, ColRowY+AddY+SymHeight*2,
                                    Row^, 1, MaxMatCol, False, ch ));
    if What and ( ch=kbEnter ) then ch:=kbUp;
    if not (ch in [ kbEsc, kbEnter ]) then What:=not What; { ���yp� ����� }
                                                           { ��������� ? }
  until ch in [ kbEsc, kbEnter ];                          { ���� �� ����� }
  ShowColRow( Col, Row );                                { ���p��� ��p�� }
                                                      { � �뢮��� ���祭�� }
end;

{ ******************* }
{ --- ���� ���p�� --- }
{ ******************* }

procedure InpMat( Mat : MatPtr; Col, Row : IntPtr );
var
  ch        : word;                           { ��� ����⮩ ������ }
  R         : TRect;                          { �pאַy���쭨� ���� }
  Left, Top : integer;                        { ���p������ y��� ���p��� }
  Res       : integer;                        { �⢥� �� ���p�� }
  i, j      : integer;                        { �����⥫� ����� }
begin
  repeat
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    InputColRow( Col, Row );                            { ������ p����p���� }
    i:=1;                                               { H�砫�� ���祭�� }
    j:=1;                                               { y����⥫�� ����� }
    ShowMat( MatX, MatY, Mat, Col, Row );
    repeat
      GetNPos( Left, Top, i, j );                       { C�⠥� ���p������ }
      Left:=Left+MatX;                                  { i,j-� ����樨 }
      Top:=Top+MatY;                                    { � ������ �� }

      Mat^[ i, j ]:=InputNumber( Left, Top, Mat^[i, j], MinMatVal, MaxMatVal,
                                 True, ch );
      ShowNPos( MatX, MatY, Blue, i, j, Mat^[i, j] );   { �����뢠�� }
                                                        { ��������� }
      case ch of
        kbUp :     i:=i-1;                              { ��p����뢠�� }
        kbDown :   i:=i+1;                              { ��p���饭�� }
        kbLeft :   j:=j-1;
        kbRight :  begin                                { ����� ���p��� ? }
                     if (i=Row^) and (j=Col^) then ch:=kbEsc;
                     j:=j+1;
                   end;
                                                        { ���� �����祭 ? }
        kbEnter :  begin
                     if (i=Row^) and (j=Col^) then ch:=kbEsc;
                     j:=j+1;
                   end;
      end;
      if j<1 then begin                                 { ����p���py�� }
        j:=Col^;                                        { ��p���饭�� }
        i:=i-1;
      end;
      if j>Col^ then begin
        j:=1;
        i:=i+1;
      end;
      if i<1 then i:=1;
      if i>Row^ then i:=Row^;
    until ch = kbEsc;                                   { ���� �����祭 ? }

  Until MessageBox( MatSureMsg, YesNum, YesButs ) = 1;    { ���p��� ? }
end;

{ ****************************** }
{ --- �p�楤yp� ����� ���p�� --- }
{ ****************************** }

procedure InputMats;
Var
  i : integer;
begin
  i:=MessageBox( MatMsg, MatNum, MatButs );
  case i of
    1 : InpMat( @MatrixA, @MatACol, @MatARow );
    2 : InpMat( @MatrixB, @MatBCol, @MatBRow );
  end;
end;

end.