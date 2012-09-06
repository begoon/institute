{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     INIT                                                    * }
{ *  H����祭��: ���樠������ �᭮���� ���y��� �p��p����                * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Init;

interface

uses Graph, Message, Common, Texts, Dos;

var

  GraphMode : integer;            { �ᯮ��y��� �p���c��� p���� }

  FontFile  : file;               { ���� � 䮭⮬ }
  FontPtr   : pointer;            { �����⥫� �� ��p� 䮭� }

  Font      : array [ 1..FontSize ] of byte;     { C�� 䮭� }

  procedure GraphInit;            { ���樠������ �p�䨪� }
  procedure DrawBackground;       { �p�p�ᮢ�� 䮭� }
  procedure Done;

implementation

{ ********************************************************** }
{ ---------- �p�楤yp� ���樠����樨 �p�䨪� --------------- }
{ ********************************************************** }

procedure GraphInit;
var
  grDriver : Integer;
  grMode   : Integer;
  ErrCode  : Integer;
begin

  {$I-}
  Assign( FontFile, FontName );             { ��⠥� 䠩� � 䮭⮬ }
  Reset( FontFile, 1);
  BlockRead( FontFile, Font, FontSize );
  Close( FontFile );
  {$I+}
  if IOResult<> 0 then begin
    Writeln('Fatal error: Can''t read font file '+FontName);
    Halt( FONT_ERROR );
  end;

  GetIntVec( FontInt, FontPtr );
  SetIntVec( FontInt, @Font );              { ��⠭�������� 䮭� }

  grDriver := Detect;                    { ��⮬���᪨� p���� }
  grMode   := VGAMed;
  InitGraph(grDriver, grMode,' ');          { �室�� � �p�䨪y }
  ErrCode := GraphResult;                   { �p���p塞 �訡�� }
  if ErrCode <> grOk then begin
    Writeln('Graphics error: ', GraphErrorMsg(ErrCode));
    halt( G_INIT_ERROR );
  end;                                      { �p���p塞 �y��� p����� }

  if ( GetMaxX<639 ) or ( GetMaxY<349 ) then begin
    CloseGraph;
    Writeln('Graphics error: Can''t init 640x350 or hi');
    halt( G_INIT_ERROR );
  end;
end;

procedure Done;
begin
  SetIntVec( 31, FontPtr );
end;

{ ******************************************************** }
{ ----------------- �p�p�ᮢ�� 䮭� ---------------------- }
{ ******************************************************** }

procedure DrawBackground;
var
  R : TRect;
begin
  R.Assign( 0, 0, MainBackX-1, GetMaxY);
  DrawBox( R, True, LightBlue );
  R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);
  DrawBox( R, True, DarkGray );
  R.Assign( MainBackX, 0, GetMaxX, MainBackY-1);
  DrawButton( R, Copyright, True, White, Red, Black );
end;

{ *********************************************** }
{ ----------- �᭮���� ���樠������ ------------ }
{ *********************************************** }

Var
  i, j : integer;

begin

  { --- ���樠������ ���p�� ---}

  for i:=1 to MaxMatRow do for j:=1 to MaxMatCol do begin
    MatrixA[i,j]:=0;
    MatrixB[i,j]:=0;
  end;
  MatACol:=10;
  MatARow:=10;
  MatBCol:=10;
  MatBRow:=10;

end.