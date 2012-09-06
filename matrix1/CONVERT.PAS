{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     CONVERT                                                 * }
{ *  H����祭��: �p�楤yp� ��p����� �ᥫ � ��p��� � �����p��            * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Convert;

interface

Uses Common;

  { --- �y���� ��p����� �᫠ REAL � ��p��y --- }
  function RealToStr( N : real ) : string;

  { --- �y���� ��p����� �᫠ INTEGER � ��p��y --- }
  function IntToStr( N : integer ) : string;

  { --- �y���� y������� ���y�� �p������ � ������ �� �� 墮�⮢� --- }
  function ChangeSpace( S : string ) : string;

  { --- �y���� y������� �p������ �� ��p��� --- }
  function DelSpaces( S : string ) : string;

implementation

  { ****************************************************************** }
  { --- �y���� y������� ���y�� �p������ � ������ �� �� 墮�⮢� --- }
  { ****************************************************************** }

  function ChangeSpace( S : string ) : string;
  var
    i : integer;
  begin
    repeat
      i:=Pos( ' ', S );
      if i=1 then begin
        delete( S, 1, 1);
        S:=S+' ';
      end;
    until i<>1;
    ChangeSpace:=S;
  end;

  { ******************************************* }
  { --- �y���� y������� �p������ �� ��p��� --- }
  { ******************************************* }

  function DelSpaces( S : string ) : string;
  var
    i : integer;
  begin
    repeat
      i:=Pos(' ', S );
      if i<>0 then delete( S, i, 1 );
    until i=0;
    DelSpaces:=S;
  end;

  { ******************************************** }
  { --- �y���� ��p����� �᫠ REAL � ��p��y --- }
  { ******************************************** }

  function RealToStr( N : real ) : string;
  var
    S: string;
  begin
    Str( N:MaxInpStr:1, S );
    RealToStr := ChangeSpace( S );
  end;

  { *********************************************** }
  { --- �y���� ��p����� �᫠ INTEGER � ��p��y --- }
  { *********************************************** }

  function IntToStr( N : integer ) : string;
  var
    S: string;
  begin
    Str( N:MaxInpStr, S );
    IntToStr := ChangeSpace( S );
  end;

end.