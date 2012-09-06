{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     EVENTS                                                  * }
{ *  H����祭��: �p�������� ��⥬� ᮡ�⨩                             * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Events;

interface

  Uses Common, Graph, Mouse, Crt;

  const

    { --------- ��p���p��⨪� ᮡ�⨩ ---------- }

    NoEvent         = 0;          { H� �뫮 ᮡ�⨩ }
    KeybEvent       = 1;          { H���� ������ �� �������yp� }
    MLeftDownEvent  = 2;          { H���� ����� ������ �� ��� }
    MRightDownEvent = 4;          { H���� ����� ������ �� ��� }

    MaxEvents       = 100;        { ���ᨬy� ᮡ�⨩ }

  type

    { ------- ��ꥪ� - ᮡ�⨥ -------- }

    TEvent = record
      Command : word;             { ������� }
      Rect    : TRect;            { ������� ��� ��� }
      Key     : word;             { ������ }
      State   : word;             { ��� }
    end;

  { ****************************************************************** }
  { ---- �p�楤yp� �p������樨 �y�⮣� ᮡ���-�������� ----}
  procedure MakeNullEvent;

  { ****************************************************************** }
  { �p�楤yp� �p������樨 ᮡ���:
      Events - ���ᠭ�� ᮡ���
  }
  procedure MakeEvent( Event : TEvent );

  { ****************************************************************** }
  { �p�楤yp� �p������樨 ᮡ���:
       Cmd            - �������
       x1, y1, x2, y2 - ���p������ ������
       �h             - ������
  }
  procedure AddEvent( Cmd, x1, y1, x2, y2, ch : word );

  { ****************************************************************** }
  { �y���� ��p���⪨ ᮡ�⨩:
      Status    - ��� ᮡ���
      ���y���� - ������� �p���⠢襣� ᮡ���
  }
  function  GetEvent ( var Status : word ) : word;

  { ****************************************************************** }
  { ---- �p�楤yp� ���⪨ ᮡ�⨩ �� �������� ---- }
  procedure ClearEvents;

implementation

  Var
    EvtDta     : array [ 1..MaxEvents ] of TEvent;  { ����� � ᮡ���� }
    EvtPtr     : integer;                           { ���-�� ᮡ�⨩ }

  { *********************************************************** }
  { ------ �y���� �p������� ᨬ����� � y�⮬ p�����p� ------- }
  { *********************************************************** }

  function KeysEqu( key, ch : word ) : boolean;
  begin
    KeysEqu:=(Key and $df) = (Ch and $df);
  end;

  { ************************************************** }
  { --------- �p�������� ᮡ���-�������� ----------- }
  { ************************************************** }

  procedure MakeNullEvent;
  begin
    EvtPtr:=1;
    EvtDta[1].Command:=0;
  end;

  { ******************************************** }
  { ----------- �p�������� ᮡ��� ------------ }
  { ******************************************** }

  procedure MakeEvent( Event : TEvent );
  begin
    EvtPtr:=EvtPtr+1;                            { �����稢��� ������⢮ }
    if EvtPtr>MaxEvents then begin               { ��p��������� ? }
      CloseGraph;
      Writeln('Fatal error: Too many events');
      halt( EVENTS_ERROR );
    end;
    EvtDta[ EvtPtr ]:=Event;                     { �����뢠�� ᮡ�⨥ }
  end;

  { ******************************************** }
  { ----------- �p�������� ᮡ��� ------------ }
  { ******************************************** }

  procedure AddEvent( Cmd, x1, y1, x2, y2, ch : word );
  var
    Event : TEvent;                           { C���⨥ }
  begin
    with Event do begin                       { ��p��py�� ������ }
      Command:=Cmd;
      Rect.Assign( x1, y1, x2, y2 );
      Key:=Ch;
    end;
    MakeEvent( Event );                       { ��p��py�� ᮡ�⨥ }
  end;

  { **************************************** }
  { ----- �������� ᮡ�⨩ �� �������� ----- }
  { **************************************** }

  procedure ClearEvents;
  begin
    while (EvtDta[EvtPtr].Command<>0) do EvtPtr:=EvtPtr-1;
  end;

  { ************************************************************ }
  { ------- ���� � ᮡ���� �y����� � �������� �����襩 ------- }
  { ************************************************************ }

  function FindKey( c : Word ) : integer;
  var
    i   : integer;
  begin
    i:=EvtPtr;
    while ( not KeysEqu( EvtDta[i].Key, c ) ) and ( EvtDta[i].Command<>0 )
      do i:=i-1;
    FindKey:=EvtDta[i].Command;
  end;

  { ********************************************************************** }
  { ------- ���� � ᮡ���� �y����� � �������� �������� ��� ���  ------- }
  { ********************************************************************** }

  function FindArea( P : TPoint ) : integer;
  var
    i   : integer;
  begin
    i:=EvtPtr;
    while (not EvtDta[i].Rect.Contains(P)) and (EvtDta[i].Command<>0)
      do i:=i-1;
    FindArea:=EvtDta[i].Command;
  end;

  { ****************************************** }
  { ----------- ��p���⪠ ᮡ�⨩ ------------ }
  { ****************************************** }

  function GetEvent ( var Status : word ) : word;
  var
    FindCommand  : integer;             { H�������� ������� }
    MousePressed : boolean;             { H���� ���� }
    Point        : TPoint;              { ���p������ ��� }
    LButton      : boolean;             { H���� ���ﭨ� }
    RButton      : boolean;             { ������ ��� }
    ch           : word;                { ��� ����⮩ ������ }
    i            : integer;
  begin
    ShowCursor;                         { �뢥�� y����⥫� ��� }
    repeat
      Status:=0;                        { C�p���� ���y� ᮡ��� }
      inline( $FA );
      MemW[0:$41A]:=MemW[0:$41C];       { ������ �y�p �������yp� }
      inline( $FB );
      repeat
        GetMInfo( Point, LButton, RButton );   { ����� ���ﭨ� ��� }

        MousePressed:= LButton or RButton;

      until KeyPressed or MousePressed;        { ���� ��� �� ���������� }
      if KeyPressed then begin                 { H���� ������ ? }
        ch:=GetKey;                             { �p����� �� ��� }
        FindCommand:=FindKey( ch );            { ���᪠�� ᮡ�⨥ � ⠪�� }
        Status:=KeybEvent;                     { ����� ������ }
      end
      else begin                               { H���� ���� ? }
        FindCommand:=FindArea( Point );        { ���᪠�� ᮡ�⨥ � ⠪�� }
                                               { �������� ��� ��� }
        if LButton
          then Status:=MLeftDownEvent          { ����� ������ ? }
          else Status:=MRightDownEvent         { �p���� ������ ? }
      end;
    until FindCommand<>0;                      { ���� �� ������� ������� }
    HideCursor;
    GetEvent:=FindCommand;                     { ��p�y�� ��� ������� }
  end;

{ **************************************** }
{ ----- ���樠������ ���y�� ᮡ�⨩ ----- }
{ **************************************** }

begin
  MakeNullEvent;                { ��⠢��� ᮡ�⨥-�������y }
end.