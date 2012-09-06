{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     DRAWMATS                                                * }
{ *  H����祭��: �᫮���� �p�p�ᮢ�� ���p��                              * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit DrawMats;

interface

Uses Common, Graph, Message, Texts;

  { ******************************************************************* }
  { �᫮���� �p�p�ᮢ�� ���p���:
     Col, Row  - p����p���� ���p���
  }
  procedure DrawMat( Col, Row : integer );

  { ******************************************************************* }
  { �뢮� i,j-�� �������:
     i, j     - �������
     Selected - ���� ���ᢥ⪨
  }
  procedure DrawNElem( i, j : integer; Selected : boolean );

  { ******************************************************************* }
  { �p�楤yp� ��p������ ��p��� ��� ���p�楩 }
  procedure SaveMatScr;

  { ******************************************************************* }
  { �p�楤yp� ����⠭������� ��p��� ��� ���p�楩 }
  procedure RestMatScr;

var

  ScrBuf : Pointer;                             { �y�p ��� ��p�� }

implementation

  { ******************************************************************* }
  { ---                �᫮���� �p�p�ᮢ�� ���p���                  --- }
  { ******************************************************************* }

  procedure DrawMat( Col, Row : integer );
  var
    R    : TRect;
    i, j : integer;
  begin
    R.Assign( DrawX, DrawY, DrawEndX, DrawEndY );     { ���y�� 䮭 }
    DrawBox( R, True, LightGray );
    OutTextXY( DrawX+AddX, DrawY+AddY, DrawRes );     { � ��������� }
    for i:=1 to Row do                                { � ᠬy ���p��y }
      for j:=1 to Col do
        DrawNElem( i, j, False );
  end;

  { ******************************************************************* }
  { �뢮� i,j-�� �������:
     x, y     - ���p������ y��� ���p���
     i, j     - �������
     Selected - ���� ���ᢥ⪨
  }
  procedure DrawNElem( i, j : integer; Selected : boolean );
  var
    Color : integer;
    x, y  : integer;
  begin
    x:=DrawX+(j-1)*(ElemX+SpaceX)-1+SpaceX;            { ��p�� ���p������ }
    y:=DrawY+(i-1)*(ElemY+SpaceY)-1+SpaceY+DrawTextY;
    Color:=Black;
    if Selected then Color:=Red;
    SetFillStyle( SolidFill, Color );                  { � p��y�� ������� }
    Bar( x, y, x+ElemX, y+ElemY );
  end;

  { ******************************************************************* }
  { ---            �p�楤yp� ��p������ ��p��� ��� ���p�楩         --- }
  { ******************************************************************* }

  procedure SaveMatScr;
  begin
    GetMem( ScrBuf, ImageSize( DrawX, DrawY, DrawEndX, DrawEndY ) ) ;
    GetImage( DrawX, DrawY, DrawEndX, DrawEndY, ScrBuf^ );
  end;

  { ******************************************************************* }
  { --          �p�楤yp� ����⠭������� ��p��� ��� ���p�楩        --- }
  { ******************************************************************* }

  procedure RestMatScr;
  begin
    PutImage( DrawX, DrawY, ScrBuf^, NormalPut );
  end;

end.