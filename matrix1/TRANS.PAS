{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     TRANS                                                   * }
{ *  H����祭��: �p�������� �p��ᯮ��p������ ���p���                    * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Trans;

interface

Uses Common, MatInput, Texts, Ident, Graph, Message, Crt;

  { ******************************************************************** }
  { �p�楤yp� �p��ᯮ��p������ ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
  }
  procedure Transpon( Mat : MatPtr; MatCol, MatRow : IntPtr );

implementation

  { ******************************************************************** }
  { ---             �p�楤yp� �p��ᯮ��p������ ���p���               --- }
  { ******************************************************************** }

  procedure Transpon( Mat : MatPtr; MatCol, MatRow : IntPtr );
  var
    New    : MatType;                                   { ���p��-����� }
    R      : TRect;
    yA, yB : integer;                                   { ���p������ }
    i, j   : integer;
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    for i:=1 to MatRow^ do                              { ���樠����py�� }
      for j:=1 to MatCol^ do                            { ���y���� }
        New[j, i]:=0;
    GetTwoCoords( yA, yB );
    ShowMat( CheckX, yA, Mat,  MatCol, MatRow );       { �������� ���p��� }
    ShowMat( CheckX, yB, @New, MatRow, MatCol );
    i:=MessageBox( TransInf, OkNum, OkButs );          { ���p���� }
    for i:=1 to MatRow^ do
      for j:=1 to MatCol^ do begin                     { �p��ᯮ��py�� ... }
        New[j, i]:=Mat^[i, j];
        ShowNPos( CheckX, yA, Yellow, i, j, Mat^[i,j]); { �뢮��� ⥪y騥 }
        ShowNPos( CheckX, yB, Yellow, j, i, New[j,i]);  { ����樨 }
        Delay( ShowDelay );                            { ���� }
      end;
    i:=MatRow^;                                        { ���塞 }
    MatRow^:=MatCol^;                                  { p����p���� }
    MatCol^:=i;
    for i:=1 to MatRow^ do
      for j:=1 to MatCol^ do                           { ���y���� ... }
        Mat^[i, j]:=New[i, j];
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY); { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );        { �������� ���p��y }
    LocalMsg( TransMsg );                              { C���饭��   }
  end;

end.