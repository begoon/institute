{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     INPSTR                                                  * }
{ *  H����祭��: �p�������� ����� ��p�� � �ᥫ                         * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit InpStr;

interface

Uses Common, Graph, Message, Convert, Texts;

  { ******************************************************************* }
  { �y���� ����� ��p���:
      x, y       - ���p������
      S          - ��砫쭠� ��p���
      ch         - ��� ����⮩ ᯥ�-������
      ���y����  - ��������� ��p���
  }
  function InputStr( x, y : integer; S : InpStrType; var ch:word ) : string;

  { ******************************************************************* }
  { �y���� ����� �᫠:
      x, y       - ���p������
      N          - ��砫쭮� �᫮
      Min,Max    - �p����� ���祭�� �᫠
      NumType    - True - real, False - integer
      ch         - ��� ����⮩ ᯥ�-������
      ���y����  - ��������� �᫮
  }
  function InputNumber( x, y : integer; N : real; Min, Max : real;
                        NumType : boolean; var ch : word ) : real;

Implementation

  { ******************************************************************* }
  { ---                    �y���� ����� ��p���                     --- }
  { ******************************************************************* }

  function InputStr( x, y : integer; S : InpStrType; var ch:word ) : string;
  var
    Res : string;                          { ���y���� ����� }
    Key : word;                            { ��� ����⮩ ������ }
    Ptr : word;                            { ������ � ��p��� }
  begin
    Res:=S;                                { H�砫쭮� ���祭�� }
    Ptr:=1;                                { H�砫쭠� ������ � ��p��� }
    repeat
      SetFillStyle( SolidFill, White );                  { �뢥�� 䮭 }
      Bar( x, y, x+MaxInpStr*SymWidth-1, y+SymHeight-1 );
      SetFillStyle( SolidFill, Green );                  { �뢥�� �yp�p }

      Bar( x+(Ptr-1)*SymWidth, y, x+Ptr*SymWidth-1, y+SymHeight-1 );
      SetColor( Black );
      OutTextXY( x, y, Res );                            { �뢥�� ��p��y }
      Key:=GetKey;                             { ����� ��� ������ }
      Ch:=0;                                   { C�p���� ��� ᯥ�-������ }
      case Key of
        kbLeft :            Ptr:=Ptr-1;        { ��p���饭�� ����� }
        kbRight :           Ptr:=Ptr+1;        { ��p���饭�� ��p��� }
        kbUp, kbDown,                          { H����� ᯥ�-������ }
        kbEnter :
                            begin
                              ch:=Key;
                              Key:=kbEnter;
                            end;
        kbEsc :             ch:=kbEsc;         { ����� ����� }
        ord('0')..ord('9'),
        ord('.'), ord('-'),
        ord(' ') :                             { ���p��� ������ }
                            begin
                              Res[Ptr]:=chr(Key);   { ������� ���y� ��py }
                              Ptr:=Ptr+1;
                            end;
      end;
      if Ptr>MaxInpStr then begin              { �p���p��� ����y ����� }
        ch:=kbRight;
        Key:=kbEnter;
      end;
      If Ptr<1 then begin
        ch:=kbLeft;
        Key:=kbEnter;
      end;
    until Key in [ kbEnter,kbEsc ];            { ���� �� ����� ����� }
    if Key=kbEsc then Res:=S;                  { �᫨ Esc, � �� ������ }
    InputStr:=Res;                             { ��p�y�� p��y���� }
  end;

  { ******************************************************************* }
  { ---                     �y���� ����� �᫠                     --- }
  { ******************************************************************* }

  function InputNumber( x, y : integer; N : real; Min, Max : real;
                        NumType : boolean; var ch : word ) : real;
  var
    Origin : InpStrType;                        { H�砫쭮� �᫮-��p��� }
    S      : InpStrType;                        { ��������� ��p��� }
    i      : real;                              { ���y���� ����� }
    Code   : integer;                           { ���y���� �p���p�������� }
    Need   : boolean;                           { ���� ���祭�� �᫠ }
    Res    : integer;
  begin
    if NumType                                 { ��p����� N � ��p��y }
      then Origin:=RealToStr( N )
      else Origin:=IntToStr( trunc(N) );
    repeat
      S:=Origin;
      S:=InputStr( x, y, Origin, ch );  { �����-�������� ��p��y }
      Val( DelSpaces(S), i, Code );     { ��p����� S � �᫮ }
      if Code<>0 then begin             { ��᫮ �p����쭮� ? }
        Beep;
        Res:=MessageBox( BadMsg, OkNum, OkButs );   { ��p������ �訡�y }
        Need:=False;
      end else begin                    { ��᫮ � �y���� �p����� ? }
        Need:=(i>=Min) and (i<=Max);
        if not Need then begin                        { ��p������ �訡�y }
          Beep;
          Res:=MessageBox( NeedMsg, OkNum, OkButs );
        end;
      end;
    until (Code=0) and Need;                      { ���� ���p����쭮 }
    InputNumber:=i;                               { ��p�y�� p��y���� }
  end;

end.