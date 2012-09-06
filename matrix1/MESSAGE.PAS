{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     MESSAGE                                                 * }
{ *  H����祭��: �᭮��� �p�楤yp� ������� � ���짮��⥫��              * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Message;

interface

uses Graph, Common, Events, Crt, Texts;

  { ********************************************************************* }
  { �p�楤yp� �p�p�ᮢ�� ������:
      R        - �pאַy���쭨�
      Text     - ����� �� ������
      Status   - True - �⦠�, False - �����
      BtColor  - ���� ������
      HotColor - ���� "��p���" ᨬ�����
      TxColor  - ���� ᨬ����� ⥪��
  }
  procedure DrawButton( R : TRect; Text : string; Status : boolean;
                        BtColor, HotColor, TxColor : word );

  { ********************************************************************* }
  { �p�楤yp� �p�p�ᮢ�� ⥪�� �� ������:
      x, y     - ���p������ ⥪��
      Text     - ����� �� ������
      HotColor - ���� "��p���" ᨬ�����
      TxColor  - ���� ᨬ����� ⥪��
  }
  procedure DrawText( x, y : integer; Text : String;
                      HotColor, TxColor : word );

  { ********************************************************************* }
  { �p�楤yp� �p�p�ᮢ�� �pאַy���쭨�� ������:
      R        - �pאַy���쭨�
      Status   - True - �⦠�, False - �����
      BtColor  - ���� ������
  }
  procedure DrawBox( R : TRect; Status : boolean; BtColor : word );

  { ********************************************************************* }
  { �y���� ��p����⠫쭮�� ������� � ���짮��⥫��:
      Title     - ⥪�� �� ������ �������
      N         - ������⢮ �y��⮢ ����
      Cmds      - y����⥫� �� �y���� ���� ⨯� String
      ���y���� - H���p ��p������ �y��� ����
  }
  function  MessageBox( Title : string; N : integer; var Cmds ) : integer;

  { ********************************************************************* }
  { �y���� �뤥����� �� �y��⮢ ���� "��p���" ᨬ�����
      N          - ������⢮ �y��⮢ ����
      Cmds       - y����⥫� �� �y���� ���� ⨯� String
      ���y����  - ��p��� "��p���" ᨬ�����
  }
  function  GetChars( N : integer; var Cmds ) : string;

  { ********************************************************************* }
  { �y���� ᬥ�� p�����p� ᨬ����
      ch        - ᨬ���
      ���y���� - ᨬ��� ��p�⭮�� p�����p�
  }
  function  ChReg ( ch : char) : char;

  { ********************************************************************* }
  { �p�楤yp� ���� � ���짮��⥫��:
      MenuType - True - ��p����⠫쭮�, False - ��p⨪��쭮�
      HorzY    - Y ��� ��p����⠫쭮�� ����
      N        - ������⢮ �y��⮢ ����
      Cmds     - y����⥫� �� �y���� ���� ⨯� String
  }
  function Menu( MenuType : boolean; HorzY, N : word; var Cmds ) : integer;

implementation

{$R-}

{ ************************************************************** }
{ ----------------- C���� p�����p� ᨬ���� --------------------- }
{ ************************************************************** }

function ChReg ( ch : char) : char;
begin
  if (ord(ch) and $20) = 0
    then ChReg:=chr(ord(ch) or  $20)
    else ChReg:=chr(ord(ch) and $df);
end;

{ ***************************************************************** }
{ ----------------- �뤥����� "��p���" ᨬ����� ------------------ }
{ ***************************************************************** }

function GetChars( N : integer; var Cmds ) : string;
var
  Titles : array [1..1] of string absolute Cmds;
  Res    : string;
  i      : integer;
begin
  Res:='';
  for i:=1 to N do Res:=Res+Titles[i][ Pos( SuperChar, Titles[i] ) +1 ];
  GetChars:=Res;
end;

{ ****************************************************************** }
{ ----------------- �p�p�ᮢ�� ⥪�� �� ������ -------------------- }
{ ****************************************************************** }

procedure DrawText( x, y : integer; Text : String;
                    HotColor, TxColor : word );
var
  i    : integer;
  flag : boolean;
begin
  SetColor( TxColor );
  SetTextJustify( LeftText, TopText );
  flag:=true;
  MoveTo( x, y );                         { H�稭��� �p�p�ᮢ�y �� ᨬ����� }
  for i:=1 to Length( Text ) do begin
    if Text[i]=SuperChar then begin       { H�砫� "��p���" ᨬ����� ? }
      if flag
        then SetColor(HotColor)
        else SetColor(TxColor);
      flag:=not flag;
    end
    else OutText( Text[i] );              { �뢥�� ᨬ��� }
  end;
end;

{ ********************************************************************* }
{ ------------------ �p�p�ᮢ�� �pאַy���쭨�� ������ ----------------- }
{ ********************************************************************* }

procedure DrawBox( R : TRect; Status : boolean; BtColor : word );
var
  ShadowLight : integer;
  ShadowDark  : integer;
begin
  if Status then begin
    ShadowLight:=White;                 {  ���� ��� �⦠⮩ ������ }
    ShadowDark:=Black;
  end
  else begin
    ShadowLight:=Black;                 {  ���� ��� ����⮩ ������ }
    ShadowDark:=White;
  end;
  SetFillStyle(SolidFill, BtColor);
  Bar( R.A.X+2, R.A.Y+2, R.B.X-2, R.B.Y-2);    { ���y�� �pאַy���쭨� }
  SetColor( ShadowLight );
  SetLineStyle( SolidLn, 0, NormWidth );
  Line( R.A.X  , R.A.Y  , R.A.X  , R.B.Y   );  { �����-��p��� ⥭� }
  Line( R.A.X+1, R.A.Y+1, R.A.X+1, R.B.Y-1 );
  Line( R.A.X  , R.A.Y  , R.B.X  , R.A.Y   );
  Line( R.A.X+1, R.A.Y+1, R.B.X-1, R.A.Y+1 );
  SetColor( ShadowDark );
  Line( R.B.X  , R.A.Y  , R.B.X  , R.B.Y   );  { �p����-������ ⥭� }
  Line( R.B.X-1, R.A.Y+1, R.B.X-1, R.B.Y-1 );
  Line( R.A.X  , R.B.Y  , R.B.X  , R.B.Y   );
  Line( R.A.X+1, R.B.Y-1, R.B.X-1, R.B.Y-1 );
end;

{ ********************************************************************* }
{ -------------- �p�p�ᮢ�� ������ � ⥪�⮬ � ⥭ﬨ ----------------- }
{ ********************************************************************* }

procedure DrawButton( R : TRect; Text : string; Status : boolean;
                      BtColor, HotColor, TxColor : word );
var
  SizeX : integer;
  SizeY : integer;
  x, y  : integer;
begin
 DrawBox( R, Status, BtColor );                { ���y�� �pאַy���쭨� }
 SetTextStyle( DefaultFont, HorizDir, 0 );
 SizeX:=SymWidth*(Length(Text)-4);             { C�⠥�  }
 SizeY:=SymHeight-1;                           { p����p ⥪�� � �窠� }
 x:=R.A.X+(R.B.X-R.A.X-SizeX-8) div 2;         { � 業�p�py�� ���p������ }
 y:=R.A.Y+(R.B.Y-R.A.Y-SizeY-1) div 2;
 if not Status then begin
   x:=x+2;
   y:=y+2;
 end;
 DrawText( x, y, Text, HotColor, TxColor );    { ���y�� ⥪�� }
end;

{ ********************************************************* }
{ ---------- �p�������� ���� � ���짮��⥫�� ------------- }
{ ********************************************************* }

function Menu( MenuType : boolean; HorzY, N : word; var Cmds ) : integer;
var
  Titles    : array [1..1] of string absolute Cmds;  { �y���� ���� }
  MaxLength : integer;                               { ����� ������ }
  Left      : Word;                                  { ���p������ ������ }
  Right     : Word;
  Top       : Word;
  Bottom    : Word;
  Chars     : string;                                { ��p�稥 ᨬ���� }
  Status    : word;                                  { C��y� ᮡ��� }
  Selected  : word;                                  { ��p���� �y��� }
  i         : word;

{ ***************************************************************** }
{ -------- ���᫥��� ���p����� i-� ������ �� n ������ ------------ }
{ ***************************************************************** }

procedure GetNCoords( n, i : word; var Left, Top, Right, Bottom : word );
var
  Ofs : word;
begin
  if MenuType then begin                           { ��p����⠫�� ������ }
    Ofs:=MaxLength*SymWidth+AddX*2+DeltaX;         { ����� ����� ������ }
    Left:=(GetMaxX-Ofs*n) div 2 + Ofs*(i-1);       { ����p�py�� ���p����y }
    Top:=HorzY;
  end
  else begin                                       { ��p⨪���� ������ }
    Left:=StartX;                                  { ����p�py�� ���p�����y }
    Top:=(GetMaxY-FullHeight*n) div 2 +FullHeight*(i-1);
  end;
  Right:=Left+SymWidth*MaxLength+AddX*2;           { �p�����塞 }
  Bottom:=Top+SymHeight+AddY*2;                    { ����� ������ }
end;

{ ******************************************************* }
{ -------- �p�p�ᮢ�� i-� ������ �� n ������ ------------ }
{ ******************************************************* }

procedure DrawNButton( N, i : word; Selected, Status : boolean );
var
  Left      : Word;                                { ���p������ ������ }
  Right     : Word;
  Top       : Word;
  Bottom    : Word;
  Color     : integer;                             { ���� ������ }
  R         : TRect;                               { �pאַy���쭨� ������ }
begin
  Color:=Blue;                                    { ���� ���筮� ������ }
  if Selected then Color:=DarkGray;                { ���� ⥪y饩 ������ }
  GetNCoords( N, i, Left, Top, Right, Bottom );    { ��p�� ���p������ }
  R.Assign( Left, Top, Right, Bottom );
  DrawButton( R, Titles[i], Status, Color, White, Green ); { ���y�� �����y }
end;

begin                                              { ����塞 ���ᨬ���y� }
  MaxLength:=0;                                    { ����y ������ }
  for i:=1 to N do
    if MaxLength<Length( Titles[i] ) then MaxLength:=Length( Titles[i] );

  Chars:=GetChars( N, Titles );                    { ��p�� ��p�稥 ᨬ����� }
  for i:=1 to N do begin                           { ���y�� i-� �����y }
    GetNCoords( N, i, Left, Top, Right, Bottom );  { C�⠥� ���p������ }

    AddEvent( i, Left, Top, Right, Bottom, ord( Chars[i] ) ); { C���⨥ }
    DrawNButton( N, i, false, true );                         { ���y�� �� }
  end;
  AddEvent( cmTab,   0, 0, 0, 0, kbTab );          { H���p������ }
  AddEvent( cmTab,   0, 0, 0, 0, kbDown );         { y�p�����騥 ᮡ��� }
  AddEvent( cmTab,   0, 0, 0, 0, kbRight );
  AddEvent( cmSTab,  0, 0, 0, 0, kbShiftTab );
  AddEvent( cmSTab,  0, 0, 0, 0, kbUp );
  AddEvent( cmSTab,  0, 0, 0, 0, kbLeft );
  AddEvent( cmEnter, 0, 0, 0, 0, kbEnter );
  AddEvent( cmBreak, 0, 0, 0, 0, kbEsc );

  Selected:=1;                                      { H�稭��� � �y��� 1 }
  repeat
    DrawNButton( N, Selected, true, true );         { ���y�� ⥪y�y� �����y }
    i := GetEvent( Status );                        { ���� ᮡ��� }
    case i of                                       { �����p ᮡ�⨩: }
      cmTab : begin                                       { ��p���饭�� }
                DrawNButton( N, Selected, false, true );  { ���� }
                Selected:=Selected+1;
                if Selected>N then Selected:=1;
              end;
      cmSTab : begin                                      { ��p���饭�� }
                DrawNButton( N, Selected, false, true );  { ���p� }
                Selected:=Selected-1;
                if Selected<1 then Selected:=N;
              end;
      else begin                                          { �y��� ���� }
             if i=cmEnter then i:=Selected;               { ��p�� }
             DrawNButton( N, Selected, false, True );
             Selected:=i;
             DrawNButton( N, Selected, true, False );
             delay( 100 );
           end;
    end;
  until not ( i in [ cmTab, cmSTab ] );                   { ���� �� ����� }
  case i of
    cmEnter : Menu:=Selected;
    cmBreak : Menu:=0;
   else
    Menu:=i;
  end;                                                    { C�p��뢠�� }
  ClearEvents;                                            { ᮡ��� }
end;

{ ******************************************************************* }
{ ------------------- �p�������� ������� � ���⥪�⮬ -------------- }
{ ******************************************************************* }

function MessageBox( Title : string; N : integer; var Cmds ) : integer;
const
  MaxText = 10;                                    { ���ᨬ��쭮� ������⢮}
var                                                { ��p�� ���⥪�� }
  Msgs      : array [1..1] of String absolute Cmds;{ �y���� ���� }
  Text      : array [1..MaxText] of String;        { C�p��� ���⥪�� }
  TextPtr   : word;                                { ���-�� c�p�� ���⥪�� }
  Left      : Word;                                { ���p������ ����誨 }
  Right     : Word;
  Top       : Word;
  Bottom    : Word;
  SizeX     : word;                                { �����p� ����誨 }
  SizeY     : word;
  MaxLength : word;                                { ����� ��p�� ���⥪�� }
  ButLen    : word;                                { ����� ��p�� ���� }
  R         : TRect;                               { �pאַy���쭨� ����誨 }
  MsgSize   : word;                                { �����p � y����⥫� �� }
  MsgPtr    : pointer;                             { ��⮢� ��p�� ��� ���� }
  i, j      : integer;
begin                                              { C�⠥� ���ᨬ���y� }
  ButLen:=0;                                       { ����y ������ }
  for i:=1 to N do
    if ButLen<Length( Msgs[i] ) then ButLen:=Length( Msgs[i] );

  TextPtr:=0;                                      { �뤥�塞 ��p��� }
  MaxLength:=0;                                    { ���⥪�� }
  while Length( Title ) <> 0 do begin
    i:=Pos( DelimChar, Title );                    { H�砫� i-� ��p��� }
    delete( Title, i, 1 );
    j:=Pos( DelimChar, Title);                     { ����� i-� ��p��� }
    TextPtr:=TextPtr+1;
    Text[TextPtr]:=Copy( Title, i, j-i );
    if MaxLength<Length(Text[TextPtr]) then MaxLength:=Length(Text[TextPtr]);
    delete( Title, i, j-i+1);
  end;
  SizeX:= (SymWidth*ButLen+AddX*2+DeltaX)*N+AddX*2; { C�⠥� p����p ������ }
  i:=(MaxLength+2)*SymWidth+AddX*2;                 { � p����p ���⥪�� }
  if SizeX<i then SizeX:=i;                         { ��p�� ���ᨬ��쭮� }
  SizeY:=(TextPtr+3)*SymHeight*2+FullHeight+AddY*2; { C�⠥� p����p ���� }
  Left:=(GetMaxX-SizeX) div 2 - 2;                  { ����p�py�� ���p������ }
  Top:=(GetMaxY-SizeY) div 2 - 16;                  { ������-��p孥�� y��� }
  Right:=Left+SizeX;                                { C�⠥� ���p������ }
  Bottom:=Top+SizeY;                                { �p�����-������� y��� }
  R.Assign( Left, Top, Right, Bottom );
  MsgSize:=ImageSize( Left, Top, Right, Bottom );   { C��p��塞 ����p������ }
  GetMem( MsgPtr, MsgSize );                        { ��� ����� }
  GetImage( Left, Top, Right, Bottom, MsgPtr^ );
  DrawBox( R, True, RED );                          { ���y�� ���� }
  SetTextJustify( CenterText, TopText );
  SetColor( White );                                { ���y�� ���⥪�� }
  for i:=1 to TextPtr do
    OutTextXY( GetMaxX div 2, Top+SymHeight*2*i+AddX, Text[i]);      { ���� }
  MessageBox:=Menu( True, Top+SymHeight*2*(TextPtr+2)+AddX, N, Cmds );

  PutImage( Left, Top, MsgPtr^, NormalPut );        { ����⠭�������� }
  FreeMem( MsgPtr, MsgSize );                       { ����p������ }
end;

end.