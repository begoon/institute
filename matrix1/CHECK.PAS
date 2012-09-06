{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     CHECK                                                   * }
{ *  H����祭��: �p���p�� ���p�� �� p�����⢮                            * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Check;

interface

Uses Common, Texts, Graph, MatInput, Message, Crt;

  { ****************************************************************** }
  { �p�楤yp� �p���p�� ���p�� �� p�����᢮:
      MatA       - y����⥫� �� ��p�y� ���p��y
      ColA, RowA - y����⥫� �� p����p���� ���p��� �
      MatB       - y����⥫� �� ��py� ���p��y
      ColB, RowB - y����⥫� �� p����p���� ���p��� B
  }
  procedure CheckEqu( MatA : MatPtr; ColA, RowA : IntPtr;
                      MatB : MatPtr; ColB, RowB : IntPtr );

implementation

  { ********************************************** }
  { --- �p�楤yp� �p���p�� ���p�� �� p�����᢮ --- }
  { ********************************************** }

  procedure CheckEqu( MatA : MatPtr; ColA, RowA : IntPtr;
                      MatB : MatPtr; ColB, RowB : IntPtr );
  var
    R        : TRect;
    yA, yB   : integer;                                 { ���p������ }
    i, j     : integer;
    Equ      : boolean;                                 { ������ p�����⢠ }
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    GetTwoCoords( yA, yB );                             { ��p�� ���p������ }
    ShowMat( CheckX, yA, MatA, ColA, RowA );            { �뢮��� ���p��� }
    ShowMat( CheckX, yB, MatB, ColB, RowB );
    i:=MessageBox( CheckInfMsg, OkNum, OkButs );       { ���p���� }
    if (ColA^=ColB^) and (RowA^=RowB^) then begin      { C��p�� p����p���� }
      Equ:=True;
      for i:=1 to RowA^ do for j:=1 to ColA^ do begin     { ���� �� ���p�� }
        ShowNPos( CheckX, yA, Yellow, i, j, MatA^[i, j]);  { �������� }
        ShowNPos( CheckX, yB, Yellow, i, j, MatB^[i, j]);  { ����樨 }
        delay( ShowDelay );                               { ��������� }
        if MatA^[i, j]<>MatB^[i, j] then begin            { C��p��� ? }
          ShowNPos( CheckX, yA, Red, i, j, MatA^[i, j]);  { �������� �訡�y }
          ShowNPos( CheckX, yB, Red, i, j, MatB^[i, j]);
          Equ:=false;
        end;
        delay( ShowDelay );                               { ��������� }
      end;
      if Equ
        then i:=MessageBox( CheckYesMsg, OkNum, OkButs )  { �⢥�-����� }
        else i:=MessageBox( CheckNoMsg,  OkNum, OkButs ); { �⢥�-H� p���� }
    end else begin
      Beep;                                               { "���娥" }
      i:=MessageBox( CheckDifMsg, OkNum, OkButs );        { p����p���� }
    end;
  end;

end.