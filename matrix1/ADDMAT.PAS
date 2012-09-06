{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     ADDMAT                                                  * }
{ *  H����祭��: �p�������� ᫮����� ���p��                             * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit AddMat;

interface

uses Common, Message, Graph, Crt, DrawMats, Texts, MatInput;

  { ****************************************************************** }
  { �p�楤yp� ᫮����� ���p��:
      MatA       - y����⥫� �� ��p�y� ���p��y
      ColA, RowA - y����⥫� �� p����p���� ���p��� �
      MatB       - y����⥫� �� ��py� ���p��y
      ColB, RowB - y����⥫� �� p����p���� ���p��� B
  }
  procedure AddMats( MatA : MatPtr; ColA, RowA : IntPtr;
                     MatB : MatPtr; ColB, RowB : IntPtr );

implementation

  { ****************************************************************** }
  { ---               �p�楤yp� ᫮����� ���p��                    --- }
  { ****************************************************************** }

  procedure AddMats( MatA : MatPtr; ColA, RowA : IntPtr;
                     MatB : MatPtr; ColB, RowB : IntPtr );
  var
    R        : TRect;
    yA, yB   : integer;                                 { ���p������ }
    i, j     : integer;
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    i:=MessageBox( AddMatInfo, OkNum, OkButs );         { ���p���� }
    GetTwoCoords( yA, yB );                             { ��p�� ���p������ }
    ShowMat( CheckX, yA, MatA, ColA, RowA );            { �뢮��� ���p��� }
    ShowMat( CheckX, yB, MatB, ColB, RowB );
    if (ColA^=ColB^) and (RowA^=RowB^) then begin      { C��p�� p����p���� }
      SaveMatScr;                                      { C��p-�� ��p�� }
      DrawMat( ColA^, RowA^ );                         { �뢮��� p��y���� }
      for i:=1 to RowA^ do for j:=1 to ColA^ do begin  { ���� �� ���p�� }
        MatA^[i, j]:=MatA^[i, j]+MatB^[i, j];               { C����뢠�� }
        ShowNPos( CheckX, yA, Yellow, i, j, MatA^[i, j] );  { �뢮��� }
        ShowNPos( CheckX, yB, Yellow, i, j, MatB^[i, j] );  { �������� }
        DrawNElem( i, j, true );                          { ���y���py�騩 }
        delay( ShowDelay );                               { ���� }
        ShowNPos( CheckX, yA, Red, i, j, MatA^[i, j] );   { �뢮��� }
        ShowNPos( CheckX, yB, Red, i, j, MatB^[i, j] );   { �������� }
        delay( ShowDelay );                               { ���� }
      end;
      RestMatScr;                                         { �����-�� ��p�� }
      R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
      DrawBox( R, True, DarkGray );                       { � �뢮��� }
      ShowMat( AddMatX, AddMatY, MatA, ColA, RowA );      { ���y���� }
    end
    else begin
      Beep;                                             { "���娥" }
      i:=MessageBox( AddDifMsg, OkNum, OkButs );        { �����p���� }
    end;
  end;
end.