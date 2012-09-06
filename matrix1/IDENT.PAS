{$A+,B-,D+,E+,F-,I+,L+,N-,O-,R-,S+,V-}
{$M 16384,0,655360}
{ ************************************************************************ }
{ *                                                                      * }
{ *  ���y��:     IDENT                                                   * }
{ *  H����祭��: �����䨪��� ⨯� ���p���                              * }
{ *  ��p��:     1.0                                                     * }
{ *  ���p:      ����ᠭ�p �����, ���, ���. 302, 1995                    * }
{ *  ���:       Turbo Pascal 5.5                                        * }
{ *                                                                      * }
{ ************************************************************************ }

Unit Ident;

interface

Uses Common, Message, MatInput, Graph, Texts, Crt, Events, Determ;

  { ********************************************************************** }
  { �p�楤yp� �����䨪�樨 ⨯� ���p���:
      MatA           - y����⥫� �� ���p��y
      MatCol, MatRow - p����p���� ���p���
  }
  procedure CheckType( Mat : MatPtr; MatCol, MatRow : IntPtr );

  { ********************************************************************** }
  { �p�楤yp� �뢮� �����쭮�� ᮮ�饭��:
      Msg - ⥪�� ᮮ�饭��
  }
  procedure LocalMsg( Msg : string );

  { ********************************************************************** }
  { �p���p�� ���p��� �� ����p�⭮��� � �뢮� ᮮ�饭�� �� �⮬:
      Col, Row  - p����p���� ���p���
      Title     - ᮮ�饭�� �p� �p���p��
      ���y���� - True - ����p�⭠�, False - ���
  }
  function TestSqrMat( Col, Row : integer; Title : string ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� �y��-���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True - �y��-���p��, False - ���
  }
  function NullMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� �����筮� � ��������쭮� ���p��:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      Local          - ᮮ�饭�� � p����
      Idn            - �����䨪��p ���p���
      Yes, No        - ᮮ�饭�� � p����� p��y�����
      YesMsg, NoMsg  - ���� � p����� p��y�����
      What           - True - �p���p塞 ��������쭮���, False - �����筮���
      ���y����      - True - ��������쭠� ��� �����筠�, False - ���
  }
  function SingleDiagMat( Mat : MatPtr; MatCol, MatRow : IntPtr;
                          Local, Idn, Yes, No, YesMsg, NoMsg : string;
                          what : boolean
                         ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� ᨬ���p�筮� � ���ᨬ���p�筮� ���p��� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      Local          - ᮮ�饭�� � p����
      Idn            - �����䨪��p ���p���
      Yes, No        - ᮮ�饭�� � p����� p��y�����
      YesMsg, NoMsg  - ���� � p����� p��y�����
      N              - 0  - �p���p塞 �p�y���쭮���
                       1  - �p���p塞 ᨬ���p�筮���
                       -1 - �p���p塞 ���ᨬ���p�筮���
      ���y����      - True - �p�y���쭠� ��� ���/ᨬ���p��᪠�
                       False - ���
  }
  function SymmSlantTriaMat( Mat : MatPtr; MatCol, MatRow : IntPtr;
                             Local, Idn, Yes, No, YesMsg, NoMsg : string;
                             N : integer
                           ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� ��������쭮� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-��������쭠�, False - ���
  }
  function DiagMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� �����筮� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-�����筠�, False - ���
  }
  function SingleMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� ᨬ���p�筮� ���p��� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-ᨬ���p��᪠�, False - ���
  }
  function SymmMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� ���ᨬ���p�筮� ���p��� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-���ᨬ���p��᪠�, False - ���
  }
  function SlantMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� �p�y���쭮� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-�p�y���쭠�, False - ���
  }
  function TriaMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

  { ********************************************************************** }
  { �y���� �p���p�� ��p�������� ���p���:
      Mat            - ���p��
      MatCol, MatRow - p����p���� ���p���
      ���y����      - True-��p��������, False - ���
  }
  function DegenMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;

implementation

  { ********************************** }
  { --- �뢮� �����쭮�� ᮮ�饭�� --- }
  { ********************************** }

  procedure LocalMsg( Msg : string );
  var
    Event : TEvent;                                      { C���⨥ }
    R     : TRect;                                       { � ��� ����c�� }
    i     : word;
  begin
    R.Assign( RepX, RepY, RepX+RepSizeX, RepY+RepSizeY ); { H�p�ᮢ���� }
    DrawButton( R, Msg, True, Cyan, 0, Black );           { ������y }
    if Msg=AnyKeyMsg then begin                           { �� ᮮ�饭�� }
      Event.Rect:=R;                                      { "Press key" ? }
      Event.Command:=1;                                   { �᫨ ��, �   }
      Event.Key:=kbSpace;                                 { ��p����       }
      MakeEvent( Event );                                 { ᮡ�⨥ �� ��y }
      i:=GetEvent( i );                                   { �����y         }
      ClearEvents;
    end;
  end;

  { ****************************************************************** }
  { --- �p���p�� ���p��� �� ����p�⭮��� � �뢮� ᮮ�饭�� �� �⮬ --- }
  { ****************************************************************** }

  function TestSqrMat( Col, Row : integer; Title : string ) : boolean;
  var
    i : integer;
  begin
    if Col<>Row then begin                              { ��� ����p�⭠� ? }
      Beep;
      i:=MessageBox( SqrOneMsg+Title+SqrTwoMsg, OkNum, OkButs );
      LocalMsg( NotSqrMsg );
      TestSqrMat:=false;                                { �⢥� - ��� }
    end else TestSqrMat:=true;                          { �⢥� - ��  }
  end;

  { ************************************* }
  { --- �y���� �p���p�� �y��-���p��� --- }
  { ************************************* }

  function NullMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  var
    i, j : integer;
    Flag : boolean;                                    { ������ p��y���� }
  begin
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );        { �뢥�� ���p��y }
    LocalMsg( NullTestMsg );                           { C���饭�� � p���� }
    flag:=true;
    for i:=1 to MatRow^ do for j:=1 to MatCol^ do begin  { ���� �� ���p�� }
      ShowNPos( IdnX, IdnY, Yellow, i, j, Mat^[i, j] );  { �뢥�� ������� }
      delay( ShowDelay );                                { ��������� }
      if Mat^[i,j]<>0 then begin                         { �� �� 0 ? }
        ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] );   { �������� �� 0 }
        delay( ShowDelay );                              { ��������� }
        Flag:=False;
      end;
    end;
    LocalMsg( AnyKeyMsg );                               { ���� ������ }
    if Flag then begin
      LocalMsg( NullTitle );                             { Hy����� }
      i:=MessageBox( NullMsg, OkNum, OkButs );
    end else begin
      LocalMsg( NullNoTitle );                           { H� �y����� }
      i:=MessageBox( NullNoMsg, OkNum, OkButs );
    end;
    NullMat:=Flag;                                       { ���y���� }
  end;

  { ****************************************************** }
  { -- �y���� �p���p�� �����筮� � ��������쭮� ���p�� -- }
  { ****************************************************** }

  function SingleDiagMat( Mat : MatPtr; MatCol, MatRow : IntPtr;
                          Local, Idn, Yes, No, YesMsg, NoMsg : string;
                          what : boolean
                         ) : boolean;
  var
    i, j : integer;
    Flag : boolean;                                    { p��y���� }
  begin
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );        { �������� ���p��y }
    LocalMsg( Local );                                 { C���饭�� � p���� }
    flag:=false;
    if TestSqrMat(MatCol^, MatRow^, Idn ) then begin    { ��� ����p�⭠� ? }
      flag:=true;
      for i:=1 to MatRow^ do for j:=1 to MatCol^ do begin { ���� �� ���p�� }
        ShowNPos( IdnX, IdnY, Yellow, i, j, Mat^[i, j] ); { �뢥�� ������� }
        delay( ShowDelay );                               { ��������� }
        if i=j then begin                                 { H� ��������� ? }
          ShowNPos( IdnX, IdnY, Green, i, j, Mat^[i, j] );{ �뢥�� ������� }
          if What and (Mat^[i,j]=0) then begin            { �������� �訡�y }
            ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] );{ y ��������쭮� }
            Flag:=False;                                  { ���p��� }
          end;
          if (not What) and (Mat^[i,j]<>1) then begin     { �������� �訡�y }
            ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] );{ y �����筮� }
            Flag:=False;                                  { ���p��� }
          end;
        end;
        if (i<>j) and (Mat^[i, j]<>0) then begin          { �������� �訡�y }
          ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] );  { y ����� }
          Flag:=False;                                    { ���p�� }
        end;
        delay( ShowDelay );                               { ��������� }
      end;
      LocalMsg( AnyKeyMsg );                              { ���� ������ }
      if Flag then begin
        LocalMsg( Yes );                                  { �⢥� �� }
        i:=MessageBox( YesMsg, OkNum, OkButs );
      end else begin
        LocalMsg( No );                                   { �⢥� ��� }
        i:=MessageBox( NoMsg, OkNum, OkButs );
      end;
    end;
    SingleDiagMat:=flag;                                  { ���y���� }
  end;

  { ********************************************************************** }
  { -- �y���� �p���p�� ᨬ���p�筮� � ���ᨬ���p�筮� ���p��� ���p��� -- }
  { ********************************************************************** }

  function SymmSlantTriaMat( Mat : MatPtr; MatCol, MatRow : IntPtr;
                             Local, Idn, Yes, No, YesMsg, NoMsg : string;
                             N : integer
                           ) : boolean;
  var
    i, j : integer;
    Flag : boolean;                                     { p��y���� }
  begin
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );         { �������� ���p��y }
    LocalMsg( Local );                                  { �������� ���p��y }
    flag:=false;
    if TestSqrMat(MatCol^, MatRow^, Idn ) then begin    { ��� ����p�⭠� ? }
      flag:=true;
      if MatCol^<>1 then begin                          { ��� ����� 祬 }
                                                        { �p��� �᫮ ? }
        for i:=2 to MatRow^ do for j:=1 to i-1 do begin { ���� �� ���p�� }
                                                        { �������� ������� }
                                                           { ���p��� }
          ShowNPos( IdnX, IdnY, Yellow, i, j, Mat^[i, j] );
          delay( ShowDelay );                               { ��������� }
          if N=0 then begin                              { �p���p塞 }
                                                         { �p�y���쭮��� ? }
            if Mat^[i,j]<>0 then begin                       { ��������    }
              ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] ); { �訡�y �    }
              Flag:=False;                                   { �p�y���쭮� }
            end;                                             { ���p��     }
          end else begin
            ShowNPos( IdnX, IdnY, Yellow, j, i, Mat^[j, i] );
            if Mat^[i,j]<>Mat^[j,i]*N then begin             { ��������   }
              ShowNPos( IdnX, IdnY, RED, i, j, Mat^[i, j] ); { �訡�y     }
              ShowNPos( IdnX, IdnY, RED, j, i, Mat^[j, i] ); { � ���/    }
              Flag:=False;                                   { ᨬ���p-�  }
            end;                                             { ���p��    }
          end;
          delay( ShowDelay );                                { ��������� }
        end;
        LocalMsg( AnyKeyMsg );                              { ���� ������ }
        if Flag then begin
          LocalMsg( Yes );                                   { �⢥� �� }
          i:=MessageBox( YesMsg, OkNum, OkButs );
        end else begin
          LocalMsg( No );                                    { �⢥� ��� }
          i:=MessageBox( NoMsg, OkNum, OkButs );
        end;
      end;
    end;
    SymmSlantTriaMat:=flag;                                  { ���y���� }
  end;

  { ********************************************* }
  { --- �y���� �p���p�� ��������쭮� ���p��� --- }
  { ********************************************* }

  function DiagMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  begin
    DiagMat:=SingleDiagMat( Mat, MatCol, MatRow,
                            DiagTestMsg, DiagIdn, DiagTitle,
                            DiagNoTitle, DiagMsg, DiagNoMsg, True );
  end;

  { ****************************************** }
  { --- �y���� �p���p�� �����筮� ���p��� --- }
  { ****************************************** }

  function SingleMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  begin
    SingleMat:=SingleDiagMat( Mat, MatCol, MatRow,
                             SingleTestMsg, SingleIdn, SingleTitle,
                             SingleNoTitle, SingleMsg, SingleNoMsg, False );
  end;

  { *************************************************** }
  { -- �y���� �p���p�� ᨬ���p�筮� ���p��� ���p��� -- }
  { *************************************************** }

  function SymmMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  begin
    SymmMat:=SymmSlantTriaMat( Mat, MatCol, MatRow,
                               SymmTestMsg, SymmIdn, SymmTitle,
                               SymmNoTitle, SymmMsg, SymmNoMsg, 1 );
  end;

  { ******************************************************* }
  { -- �y���� �p���p�� ���ᨬ���p�筮� ���p��� ���p��� -- }
  { ******************************************************* }

  function SlantMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  begin
    SlantMat:=SymmSlantTriaMat( Mat, MatCol,  MatRow,
                                SlantTestMsg, SlantIdn, SlantTitle,
                                SlantNoTitle, SlantMsg, SlantNoMsg, -1 );
  end;

  { ******************************************** }
  { --- �y���� �p���p�� �p�y���쭮� ���p��� --- }
  { ******************************************** }

  function TriaMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  begin
    TriaMat:=SymmSlantTriaMat( Mat, MatCol,  MatRow,
                               TriaTestMsg, TriaIdn, TriaTitle,
                               TriaNoTitle, TriaMsg, TriaNoMsg, 0 );
  end;

  { ******************************************** }
  { --- �y���� �p���p�� ��p�������� ���p��� --- }
  { ******************************************** }

  function DegenMat( Mat : MatPtr; MatCol, MatRow : IntPtr ) : boolean;
  var
    Det    : real;
    DetStr : string;
    Depend : boolean;
    i      : integer;
  begin
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );          { �뢮��� ���p��y }
    LocalMsg( DegenTestMsg );                               { C���饭�� }
    if MatCol^=MatRow^ then begin                           { ����p�⭠� ? }
      if MatCol^<>1 then begin
        Det:=Determinate( Mat, MatCol^ );                   { ��p�����⥫� }
        Depend:=Det=0;
        if Depend then begin
          LocalMsg( DegenTitle );                           { �⢥� - �� }
          i:=MessageBox( DegenMsg, OkNum, OkButs );
        end else begin
          Str( Det:5:1, DetStr );                           { �⢥� - ��� }
          LocalMsg( DegenNoTitle+DetStr+' ' );
          i:=MessageBox( DegenNoMsg, OkNum, OkButs );
        end;
      end;
    end else begin                                        { �� �� }
      Beep;                                               { ����p�⭠� }
      i:=MessageBox( DegenSqrMsg, OkNum, OkButs );        { ���p�� }
      LocalMsg( NotSqrMsg );                              { C���饭�� �� }
      Depend:=false;                                      { �⮬ }
    end;
    DegenMat:=Depend;
  end;

  { ******************************************** }
  { --- �p�楤yp� �����䨪�樨 ⨯� ���p��� --- }
  { ******************************************** }

  procedure CheckType( Mat : MatPtr; MatCol, MatRow : IntPtr );

  var
    R    : TRect;
    i    : integer;
    flag : boolean;
  begin
    R.Assign( MainBackX, MainBackY, GetMaxX, GetMaxY);  { C�p��� ��p�� }
    DrawBox( R, True, DarkGray );
    R.Assign( 0, 0, MainBackX-1, GetMaxY);
    DrawBox( R, True, LightBlue );
    ShowMat( IdnX, IdnY, Mat, MatCol, MatRow );         { �뢥�� ���p��y }
    repeat
      i:=Menu( False, 0, CheckNum, CheckButs );         { �� ������ ? }
      Delay( ShowDelay );                               { ��������� }
      if not ( i in [ 0, 8 ] ) then begin
        case i of                                       { �p���p��: }
          1 : Flag:=NullMat( Mat, MatCol, MatRow );     { Hy����� }
          2 : Flag:=DiagMat( Mat, MatCol, MatRow );     { ��������쭮�   }
          3 : Flag:=SingleMat( Mat, MatCol, MatRow );   { �����筮�      }
          4 : Flag:=SymmMat( Mat, MatCol, MatRow );     { C�����p��᪮� }
          5 : Flag:=SlantMat( Mat, MatCol, MatRow );    { ����C�����p-�  }
          6 : Flag:=TriaMat( Mat, MatCol, MatRow );     { �p�y���쭮�    }
          7 : Flag:=DegenMat( Mat, MatCol, MatRow );    { ��p��������    }
        end;
      end;
    until i in [ 0, 8 ];                                { ���� �� ����� }
  end;

end.
