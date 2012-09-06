{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     MULTMAT                                                 * }
{ *  H����祭��: �p�������� y�������� ���p��                            * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit MultMat;

interface

uses Common, Message, Graph, Crt, DrawMats, Texts, MatInput;

  { ****************************************************************** }
  { �p�楤yp� y�������� ���p��:
      MatA       - y����⥫� �� ��p�y� ���p��y
      ColA, RowA - y����⥫� �� p����p���� ���p��� �
      MatB       - y����⥫� �� ��py� ���p��y
      ColB, RowB - y����⥫� �� p����p���� ���p��� B
  }
  procedure MultMats( MatA : MatPtr; ColA, RowA : IntPtr;
                      MatB : MatPtr; ColB, RowB : IntPtr );

implementation

  { ****************************************************************** }
  { ---                �p�楤yp� y�������� ���p��                  --- }
  { ****************************************************************** }

  procedure MultMats( MatA : MatPtr; ColA, RowA : IntPtr;
                      MatB : MatPtr; ColB, RowB : IntPtr );
  var
    New      : MatType;                                 { ���y���� }
    R        : TRect;
    yA, yB   : integer;                                 { ���p������ }
    Sum      : real;                                    { Cy��� ��p�� }
    i, j, k  : integer;
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    i:=MessageBox( MultMatInfo, OkNum, OkButs );        { ���p���� }
    GetTwoCoords( yA, yB );                             { ��p�� ���p������ }
    ShowMat( CheckX, yA, MatA, ColA, RowA );            { �뢮��� ���p��� }
    ShowMat( CheckX, yB, MatB, ColB, RowB );
    if ColA^=RowB^ then begin                          { C��p�� p����p���� }
      SaveMatScr;                                      { C��p-�� ��p�� }
      DrawMat( ColB^, RowA^ );                         { �뢮��� p��y���� }
      for i:=1 to RowA^ do for j:=1 to ColB^ do begin  { ���� �� ���p�� }
        Sum:=0;
        for k:=1 to ColA^ do begin
          Sum:=Sum+MatA^[i, k]*MatB^[k, j];                   { Cy���py�� }
          ShowNPos( CheckX, yA, Yellow, i, k, MatA^[i, k] );  { �뢮��� }
          ShowNPos( CheckX, yB, Yellow, k, j, MatB^[k, j] );  { �������� }
          delay( ShowDelay );                                 { ���� }
        end;
        for k:=1 to ColA^ do begin
          ShowNPos( CheckX, yA, Blue, i, k, MatA^[i, k] );    { �뢮��� }
          ShowNPos( CheckX, yB, Blue, k, j, MatB^[k, j] );    { �������� }
        end;
        New[i, j]:=Sum;                                   { Cy��� ��p�� }
        DrawNElem( i, j, true );                          { ���y���py�騩 }
      end;
      RestMatScr;                                         { �����-�� ��p�� }
      R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
      DrawBox( R, True, DarkGray );                       { � �뢮��� }
      ColA^:=ColB^;
      RowA^:=RowA^;
      for i:=1 to RowA^ do                                { ����py�� }
        for j:=1 to ColA^ do                              { p��y���� }
          MatA^[i, j]:=New[i, j];                         { � �뢮��� }
      ShowMat( AddMatX, AddMatY, MatA, ColA, RowA );      { p��y���� }
    end
    else begin
      Beep;                                             { "���娥" }
      i:=MessageBox( MultDifMsg, OkNum, OkButs );       { �����p���� }
    end;
  end;
end.