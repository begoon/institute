{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     DETERM                                                  * }
{ *  H����祭��: ���᫥��� ��p�����⥫� ���p���                         * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Determ;

interface

Uses Common;

  { ******************************************************************* }
  { �y���� ���᫥��� ��p�����⥫� ���p���:
      Mat            - y����⥫� �� ���p��y
      N              - p����p����� ���p���
      ���y����      - ��p�����⥫�
  }
  function Determinate( Mat : MatPtr; N : Integer ) : real;


implementation

  { *********************************************** }
  { --- �y���� ���᫥��� ��p�����⥫� ���p��� --- }
  { *********************************************** }

  function Determinate( Mat : MatPtr; N : Integer ) : real;
  var
    New            : MatType;                 { �y���py��� ���p�� }
    MaxElm         : real;                    { ���ᨬy� � ������p�� }
    MaxCol, MaxRow : integer;                 { ������� ���ᨬy�� }
    Det            : real;                    { ��p�����⥫� }
    g              : real;                    { ����-� ���������� }
    Sign           : real;                    { C���� ����� }
    Temp           : real;
    i, j, k        : integer;
  begin
    for i:=1 to N do for j:=1 to N do New[i, j]:=Mat^[i, j]; { ����py�� }
    Sign:=1;
    Det:=1;
    for k:=1 to N-1 do begin                          { ���� �� ���p�� }
      MaxElm:=-1;
      for i:=k to N do for j:=k to N-1 do             { �饬 ���ᨬ���� }
        if MaxElm < abs( New[i,j] ) then begin        { ������� � }
          MaxElm:=abs( New[i, j] );                   { ������p�� }
          MaxCol:=j;
          MaxRow:=i;
        end;
      if MaxElm=0 then det:=0;                        { ���p�� ��p������ }
      if k<>MaxRow then begin                         { ��p��⠢�塞 }
        for j:=k to N do begin                        { ��p��� }
          temp:=New[k, j];
          New[k, j]:=New[ MaxRow, j];
          New[MaxRow, j]:=temp;
        end;
        Sign:=-Sign;                                  { ���塞 ���� }
      end;
      if k<>MaxCol then begin                         { ��p��⠢�塞 }
        for i:=k to N do begin                        { �⮫��� }
          temp:=New[ i, k ];
          New[ i, k ]:=New[ i, MaxCol ];
          New[ i, MaxCol ]:=temp;
        end;
        Sign:=-Sign;                                  { ���塞 ���� }
      end;
      if Det<>0 then                                  { C����� � }
        for i:=k+1 to N do begin                      { �p�y���쭨�y }
          g:=New[ i, k ] / New[ k, k ];
          for j:=k to N do New[ i, j ]:=New[ i, j ] - g*New[ k, j ];
        end;
    end;
    for i:=1 to N do Det:=Det*New[ i, i ];            { C�⠥� }
    Determinate:=Det*Sign;                            { ��p�����⥫� }
  end;

end.