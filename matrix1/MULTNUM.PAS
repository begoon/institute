{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     MULTNUM                                                 * }
{ *  H����祭��: �p�������� y�������� ���p��� �� �᫮                  * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit MultNum;

interface

Uses Common, Crt, InpStr, Texts, Graph, Message, MatInput, Convert;

  { ********************************************************************** }
  { �p�楤yp� �����䨪�樨 ⨯� ���p���:
      Mat      - y����⥫� �� ���p��y
      Col, Row - p����p���� ���p���
  }
  procedure MultNumber( Mat : MatPtr; Col, Row : IntPtr );

  { ********************************************************************* }
  { �y���� ����� �᫠ � �p����襭���:
      Msg       - �p����襭�� ��� �����
      Ch        - ��� ��᫥���� ᯥ�-������
      ���y���� - ��������� �᫮
  }
  function InpNumberMsg( Msg : string; Var Ch : word ) : real;

implementation

  { ********************************************************************* }
  { ---              �y���� ����� �᫠ � �p����襭���               --- }
  { ********************************************************************* }

  function InpNumberMsg( Msg : string; Var Ch : word ) : real;
  var
    N : real;                                              { ��᫮ }
    R : TRect;
  begin
    N:=1.0;                                                { H�砫� }
    R.Assign( NInpX, NInpY,                                { �뢥�� 䮭 }
              NInpX+NInpSizeX, NInpY+NInpSizeY );
    DrawBox( R, True, LightGray );                         { �뢥�� }
    SetColor( Black );                                     { �p����襭�� }
    OutTextXY( NInpTextX, NInpTextY, Msg );                { � ����y }
    N:=1.0;                                                { H�砫쭮� }
    repeat                                                 { ���祭�� }
      N := InputNumber( NInpNumX, NInpY+AddY, N,           { ����� �᫮ }
                        MinMatVal, MaxMatVal,
                        True, ch );
      SetFillStyle( SolidFill, LightGray );                { �뢥�� 䮭 }
      Bar( NInpNumX, NInpTextY,                            { C�p��� }
           NInpNumX+NInpWidth-1, NInpTextY+SymHeight-1 );  { ��p�� }
      SetColor( Black );                                   { �뢥�� }
      OutTextXY( NInpNumX, NInpTextY, RealToStr(N) );      { �᫮ }
    until ch in [ kbEnter, kbEsc ];                        { ����� ? }
    InpNumberMsg:=N;
  end;

  { ******************************************************************** }
  { ---           �p�楤yp� �����䨪�樨 ⨯� ���p���               --- }
  { ******************************************************************** }

  procedure MultNumber( Mat : MatPtr; Col, Row : IntPtr );
  var
    N     : real;                                       { ��᫮ ���������� }
    R     : TRect;
    Ch    : word;                                       { ��� ������ }
    i, j  : integer;
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    i:=MessageBox( NMultTitle, OkNum, OkButs );         { ���p���� }
    ShowMat( MatX, MatY, Mat, Col, Row );               { �뢥�� ���p��y }
    N:=InpNumberMsg( NMultInpMsg, Ch );                 { ����� �᫮ }
    if ch=kbEnter then begin                            { ��� y�������� }
       for i:=1 to Row^ do for j:=1 to Col^ do begin         { ���� }
         ShowNPos( MatX, MatY, Yellow, i, j, Mat^[i,j] );    { �������� }
         Delay( ShowDelay );                                 { ������ }
         Mat^[i, j]:=Mat^[i, j]*N;                           { �������� }
         ShowNPos( MatX, MatY, Red, i, j, Mat^[i,j] );       { �������� }
         Delay( ShowDelay );                                 { ��������� }
       end;
    end;
  end;

end.