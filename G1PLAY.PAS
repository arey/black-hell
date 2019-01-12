{$G+}
UNIT G1PLAY;
{ Unit‚ reprogramm‚e pour mettre ce jeu en freeware ansi que pour
  participer … un concours , am‚liorations :
     - codage de la palette pour ne pas qu'on choure les images
   }
INTERFACE
USES DOS,CRT;

CONST LEFT   = 75;     LEFT2   = 30;
      RIGHT  = 77;     RIGHT2  = 31;
      UP     = 72;     UP2     = 17;
      DOWN   = 80;     DOWN2   = 44;
      TIR    = 28;     TIR2    = 57;
      SHOOT  = 29;                      { Contr“le }
      TALT   = 56;
      TD     = 32;
      TI     = 23;
      Tmoins = 74;
      Tplus  = 78;

CONST N1NDALIEN = 231;

CONST NIV1_ALIEN : ARRAY[1..6,1..N1NDALIEN] of INTEGER =
  { Ligne         }
 (( 50, 85, 85,110,180,180,220,220,260,280,300,320,340,360,420,445,485,500,540,540,570,570,570,610,625,640,655,655,660,670,
   675,675,680,695,700,705,715,720,800,800,825,840,840,870,880,890,880,870,940,940,940,940,980,980,980,980,990,990,999,999,
   1060,1060,1060,1110,1135,1160,1170,1195,1220,1230,1255,1280,1400,1360,1320,1360,1400,1600,1550,1500,1550,1600,1660,1655,
   1655,1660,1710,1715,1720,1725,1770,1780,1790,1800,1790,1796,1802,1810,1810,1825,1870,1885,1885,1895,1905,1905,1915,1920,
   1960,1960,1975,1980,1995,2005,2020,2025,2035,2045,2080,2090,2100,2140,2140,2150,2150,2150,2150,2200,2200,2200,2230,2230,
   2230,2290,2290,2290,2290,2320,2320,2320,2320,2370,2370,2370,2400,2400,2400,2440,2440,2460,2460,2480,2480,2510,2510,2510,
   2550,2550,2550,2560,2560,2570,2575,2580,2585,2585,2595,2600,2610,2610,2620,2635,2635,2645,2645,2650,2680,2680,2690,2690,
   2730,2730,2745,2745,2760,2760,2785,2785,2785,2785,2785,2785,2785,2785,2785,2785,2790,2795,2800,2800,2810,2810,2815,2820,
   2825,2830,2830,2840,2840,2850,2855,2860,2870,2870,2900,2900,2900,2900,2900,2920,2920,3050,3115,3120,3115,3050,3270,3270,
   3380,3380,3500 ),
  { Deplacement   }
  (  1,  1,  1,  1,  2,  3,  5,  4,  6,  6,  6,  7,  7,  7,  1,  1,  1,  1,  2,  3,  1,  1,  1, 99, 99, 99, 99, 99, 99, 99,
    99, 99, 99, 99, 99, 99, 99, 99,  6,  7,  1,  6,  7,  1,  1,  1,  1,  1,  3,  3,  2,  2, 99, 99, 99, 99, 99, 99, 99, 99,
     10,   9,   1,   7,   7,   7,   6,   6,   6,   7,   7,   7,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   3,   5,
      4,   2,   6,   6,   6,   6,   7,   7,   7,   7,  99,  99,  99,  99,  99,  99,   1,   1,   1,   1,   1,   1,   1,   1,
      1,   1,   1,   1,   1,   1,   1,   1,   1,   1,  99,  99,  99,   1,   1,   4,   4,   5,   5,   7,   7,   7,   6,   6,
      6,   7,   7,   7,   7,   6,   6,   6,   6,  99,  99,  99,  99,  99,  99,  10,   9,  10,   9,  10,   9,   1,   1,   1,
     99,   1,  99,  99,   1,  99,   2,  99,  99,  99,   3,   6,  99,  99,  10,   9,   1,  99,   1,  99,  99,  99,  99,  99,
     10,   9,  10,   9,  10,   9,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,  99,
     99,  99,  99,  99,  99,  99,  99,  99,  99,  99,   2,   5,   1,   4,   3,   8,  11,  11,  11,   1,   8,   8,  10,   9,
      6,   7, 999 ),
  { begin X       }
  (130, 15,285,130, 10,290,110,200,  2,  2,  2,317,317,317, 50, 50,270,270, 20,270,100,130,160, 10,180, 60,270,130,150, 50,
    10,259,150,175,198,290, 12,245,110,150,130,110,150, 20, 80,140,200,260, 80,110,140,170,  0,100,200,300, 40,280,100,220,
     90, 170, 130, 280, 280, 280,  20,  20,  20, 280, 280, 280,  10,  70, 130, 190, 250,  10,  70, 130, 190, 250,  90, 120,
    170, 220, -50,   0,  50, 100, 350, 300, 250, 200,  10, 120,  60, 190, 300, 250,  10, 180, 290,  90, 110,  60, 220, 160,
     90,  10, 190,  40, 120, 250, 200,  50,  80, 160,  10, 130, 250, 115, 155,  20,  50, 230, 260, 300, 340, 380, -60, -20,
     20, 360, 320, 280, 240, -40,   0,  40,  80, 300, 260, 220, -40,   0,  40, 110, 160,  90, 190,  60, 210, 100, 130, 160,
    -10, 260, 320, 110, 190, 290,  50,  80, 280, 200, 100, 130, 160, 180, 290, 160, 220, 250, 120,  15,  20,  60, 100, 140,
    110, 150,  80, 180,  50, 210,   0,  32,  64,  96, 128, 160, 192, 224, 256, 288, 130, 220,  12,  60, 280, 310, 180, 130,
     20,  70, 110, 320, 280,  50, 220, 260, 190,   0,  10, 100, 130, 180, 250, 130, 165,   0,  30, 140, 300, 270, 120, 160,
    -30, 330, 108 ),
  { Bombes : Spr  }
  ( 11, 11, 11, 12, 11, 11, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
     0,  0,  0,  0,  0,  0,  0,  0, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 11, 11, 11, 11,  0,  0,  0,  0,  0,  0,  0,  0,
     11,  11,  11,  12,  12,  12,  12,  12,  12,  12,  12,  12,  11,  11,  11,  11,  11,  12,  12,  12,  12,  12,  11,  11,
     11,  11,  11,  12,  11,  12,  12,  11,  12,  11,   0,   0,   0,   0,   0,   0,  11,  11,  11,  11,  11,  11,  11,  11,
     12,  12,  12,  12,  12,  12,  12,  12,  12,  12,  11,  11,  11,  11,  11,  12,  12,  12,  12,  11,  11,  11,  11,  11,
     11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  12,  12,  12,  11,  11,  11,  11,  11,  11,  12,  12,  12,
     11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  12,  12,  12,  12,
     11,  11,  11,  11,  11,  11,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
      0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  12,  12,  12,  12,  12,  13,  13,  12,  12,  13,  12,  12,  13,  13,
     13,  13, 999 ),
  { Type d'aliens }
  (  1,  1,  1,  1,  3,  3,  1,  1,  1,  1,  1,  1,  1,  1,  3,  3,  3,  3,  4,  4,  1,  1,  1,  5,  5,  5,  5,  5,  5,  5,
     5,  5,  5,  5,  5,  5,  5,  5,  4,  4,  4,  4,  4,  3,  3,  3,  3,  3,  1,  1,  1,  1,  5,  5,  5,  5,  5,  5,  5,  5,
      4,   4,   4,   1,   1,   1,   3,   3,   3,   4,   4,   4,   3,   3,   4,   3,   3,   2,   1,   3,   1,   2,   3,   1,
      1,   3,   3,   3,   3,   3,   1,   1,   1,   1,   5,   5,   5,   5,   5,   5,   1,   1,   1,   1,   1,   1,   1,   1,
      4,   4,   4,   4,   4,   4,   4,   4,   4,   4,   6,   6,   6,   1,   1,   3,   3,   3,   3,   1,   1,   1,   1,   1,
      1,   3,   3,   3,   3,   3,   3,   3,   3,   6,   6,   6,   6,   6,   6,   4,   4,   1,   1,   1,   1,   3,   3,   3,
      5,   4,   5,   5,   3,   6,   1,   5,   5,   5,   1,   1,   5,   5,   3,   3,   4,   6,   1,   5,   6,   6,   6,   6,
      4,   4,   4,   4,   4,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,
      5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   1,   3,   4,   3,   1,   1,   1,   1,   1,   3,   1,   1,   1,   1,
      3,   3, 999 ),
  { Life          }
  ( 10,  8,  8, 15, 10, 10, 10, 10,  8,  8,  8,  8,  8,  8,  4,  4,  4,  4, 10, 10, 12, 12, 12,  6,  6,  6,  6,  6,  6,  6,
    10, 10, 10, 10, 10, 10, 10, 10, 10, 10,  6,  6,  6, 12, 12, 15, 12, 12,  8,  8,  8,  8,  6,  6,  6,  6,  6,  6,  6,  6,
     10,  10,  10,   2,   3,   4,   5,   6,   7,   8,   9,  10,  12,  12,  16,  12,  12,  12,  12,  18,  12,  12,  10,  10,
     10,  10,   8,   8,   8,   8,   6,   5,   4,   4,   6,   6,   8,   8,  10,  10,   8,   8,   8,   8,   8,   8,   8,   8,
      8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   6,   6,   6,  10,  10,  10,  10,  10,  10,   8,   8,   8,   8,   8,
      8,   9,   9,   9,   9,   9,   9,   9,   9,   4,   4,   4,   6,   6,   6,   8,   8,   8,   8,   8,   8,  10,  16,  10,
      4,   8,   4,   3,   8,   4,   8,   4,   2,   3,   6,   6,   5,   5,   8,   9,   9,   5,   9,   8,   9,   9,   9,   9,
     12,  12,  10,  10,  10,  10,   3,   3,   3,   3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,
      4,   4,   4,   4,   4,   4,   4,   4,   4,   4,   8,   9,  10,   9,   8,  25,  25,   6,   6,   4,   6,   6,  14,  14,
      8,   8, 300 ));

TYPE VirtualPtr=^Virtual;
     Virtual=ARRAY[0..63999] of BYTE;

VAR Player1,Player2 : VirtualPtr;
    Spr,Decors : VirtualPtr;
    Screen  : Virtual ABSOLUTE $A000:0;
    Palette,Palette2 : ARRAY[0..767] of BYTE;
    i,j,u,v,n,k,m : INTEGER;
    f : TEXT;
    l : LONGINT;
    Ch,Ch2,Tr1,Tr2 : CHAR;
    Sens,Droite,Gauche,Haut,Bas,Espace,Esc,Enter,Decomp,Colis,ExitFinal,Fire,Alt,D,DX2,DX4 : BOOLEAN;
    NivEnd1,NivEnd2,NivEnd3,NivEnd4,Invulnerable,Inv : BOOLEAN;
    Touch,Speed,Images,vit,Choix : BYTE;
    Compt,total,Defil :  WORD;
    Sens1p,Letsgo,Letsgo2 : BOOLEAN;
    Lose : Word;
    NdFond,BossEnd : BYTE;
    Tout : STRING;
    CoulRead,Pl1,Pl2 : BYTE;
    ColExpl : ARRAY[0..3] OF WORD; { Existe,cX,cY,Sprite }
    Sinus,Cosinus : ARRAY[1..360] of LONGINT;
    TotalLignes : WORD;
    Clef : Byte; { Clef pour le d‚codage de la palette }
    SpeedSync : Longint;

{ Variables r‚serv‚es … l'XMS }
TYPE xregisters = record
                 ax,
                 bx,
                 dx,
                 si : word;
               end;
     transfer   = record
                Blocklen   : longint;
                SrcHandle  : word;
                SrcOffset  : pointer;
                DestHandle : word;
                DestOffset : pointer;
              end;

VAR  XMSDrv     : POINTER;
     XRegs      : XREGISTERS;
     Regs       : REGISTERS;
     XMSExists  : BOOLEAN;
     EMBParam   : TRANSFER;
     XMF,XML    : WORD;
     XHandles   : ARRAY[1..32] Of WORD;
     Key        : CHAR;
     Xms_Error  : BYTE;
     Xerror : STRING;

PROCEDURE Jeu_1_joueur(s : integer); { Seule proc‚dure lan‡able }

IMPLEMENTATION

PROCEDURE ERROR_EXIT(Num : BYTE);
BEGIN
 Dispose(Player1);Dispose(Player2);
 Dispose(Spr);Dispose(Decors);
 ASM
     XOR AL,AL
     OUT 21h,AL
     MOV AX,3
     INT 10h
 END;
 Textmode(80);
 Writeln('Game Exit ... ');
 CASE Num OF
  1 : Writeln('XMS : ',Xerror);
  2 : Writeln('Fichier inexistant ou fichier corrompu ?');
 END;
END;

PROCEDURE XMSCall(var Xregs : xregisters);
BEGIN
 Xerror:='';
 ASM
   LES  DI,[BP+4]
   MOV  AX,ES:[DI]
   MOV  BX,ES:[DI+2]
   MOV  DX,ES:[DI+4]
   MOV  SI,ES:[DI+6]
   CALL [XMSDrv]
   MOV  XMS_Error,bl
   LES  DI,[BP+4]
   MOV  ES:[DI],AX
   MOV  ES:[DI+2],BX
   MOV  ES:[DI+4],DX
   MOV  ES:[DI+6],SI
 END;
IF Xms_Error <> 0 then
  BEGIN
   CASE Xms_Error OF
             $00 : Xerror:=' Pas d''erreur ';
             $80 : Xerror:=' Fonction appel‚e inconnue ';
             $81 : Xerror:=' Ram disk VDISK d‚tect‚ ';
             $82 : Xerror:=' Erreur sur canal d''adresses A20 ';
             $8E : Xerror:=' Erreur pilote … caractŠre g‚n‚ral ';
             $8F : Xerror:=' Erreur irratrapable ';
             $90 : Xerror:=' HMA introuvable ';
             $91 : Xerror:=' HMA d‚j… appel‚e ';
             $92 : Xerror:=' Taille HMA insuffisante ';
             $93 : Xerror:=' HMA non affect‚e ';
             $94 : Xerror:=' Canal d''adresses A20 encore actif ';
             $A0 : Xerror:=' Plus de m‚moire ‚tendue disponible ';
             $A1 : Xerror:=' Ts les identifs XMS sont pris ';
             $A2 : Xerror:=' Identificateur invalide ';
             $A3 : Xerror:=' Identificateur source invalide ';
             $A4 : Xerror:=' D‚calage source invalide ';
             $A5 : Xerror:=' Identificateur destination invalide ';
             $A6 : Xerror:=' D‚calage destination invalide ';
             $A7 : Xerror:=' Longueur invalide pour fonction Move ';
             $A8 : Xerror:=' Recouvrement interdit ';
             $A9 : Xerror:=' Erreur de parit‚ ';
             $AA : Xerror:=' UMB n''est pas bloqu‚ ';
             $AB : Xerror:=' UMB est encore bloqu‚ ';
             $AC : Xerror:=' D‚bordement du compteur de blocage ';
             $AD : Xerror:=' L''UMB ne peut pas ˆtre bloqu‚ ';
             $B0 : Xerror:=' Plus petit UMB disponible ';
             $B1 : Xerror:=' Plus d''UMB disponible ';
             $B2 : Xerror:=' L''adresse du segment UMB est invalide ';
   END;
   ERROR_EXIT(1);
 END;
END;
PROCEDURE XMS_INIT;
{ V‚rifie que l'XMS est install‚e }
BEGIN
  XMSExists:=false;
  WITH Regs DO
   BEGIN
    AX:=$4300;
    Intr($2F,regs);
    if Regs.al = $80 then
     Begin
      { Copie l'adresse d'accŠs au pilote XMS }
      AX:=$4310;
      Intr($2F,regs);
      XMSDrv:=Ptr(ES,BX);
      XMSExists:=true;
      { D‚termine la taille de m‚moire ‚tendue disponible }
      Xregs.AX:=$0800;
      XmsCall(XRegs);
      XMF:=Xregs.AX;
      XML:=Xregs.DX;
     End;
  END;
  If (not XmsExists) or (XML<1024) then
     BEGIN
        ClrScr;
        If not XmsExists then Write('Xms indisponible ...')
        Else Write(XmF,' Ko d''XMS libre et il en faut au moins 1024 ...');
        Halt;
     END;
END;

PROCEDURE GET_XMS(HandNb : byte;taille : word);
BEGIN
  XRegs.ax := $0900;
  XRegs.dx := taille;
  XMSCall(XRegs);
  XHandles[HandNb] := XRegs.dx;
END;

PROCEDURE DISPOSE_XMS(HandNb : byte);
BEGIN
  XRegs.ax := $0A00;
  XRegs.dx := XHandles[HandNb];
  XMSCall(XRegs);
END;

PROCEDURE RAM_XMS(Source : pointer;Longueur : longint;HandNb : byte);
BEGIN
  with EMBParam do begin;
    Blocklen := Longueur;
    SrcHandle := 0;      { Ram }
    SrcOffset := Source;
    DestHandle := XHandles[HandNb];
    DestOffset := nil;
  end;
  XRegs.ax := $0B00;
  XRegs.si := OFS(EMBParam);
  XMSCall(XRegs);
END;

PROCEDURE XMS_RAM(HandNb : byte;Longueur : longint;Dest : pointer);
BEGIN
  with EMBParam do begin;
    Blocklen := Longueur;
    SrcHandle := XHandles[HandNb];
    SrcOffset := nil;
    DestHandle := 0; { Ram }
    DestOffset := Dest;
  end;
  XRegs.ax := $0B00;
  XRegs.si := OFS(EMBParam);
  XMSCall(XRegs);
END;

VAR Fpage : WORD;

Type SpriteTyp=Record  { structure d'un bloc de donn‚es d‚crivant un sprite}
  Adr:Pointer;         { pointe sur les donn‚es graphiques }
  dtx,dty:Word;        { largeur et hauteur en pixels }
  px,py,               { position courante, facultatif *}
  sx,sy:Integer;       { vitesse courante, facultatif *}
  Deb : Word;
End;

Type AliensTyp=Record
   Spd : Word;
   typ   : Integer;
   Ax,Ay : Integer;
   Depla : Word;
   Where : Word;
   Live  : INTEGER;
   Trajet: INTEGER;
   FinX,FinY : INTEGER;
   Plus : Shortint;
   Bobo : Byte;
   TypMis : Byte;
   Ndtime : Word;
   PlusEnd : Integer;
End;

Type MitraTyp=Record
   Exist     : BOOLEAN;
   TirX,TirY : INTEGER;
   FinX,FinY : INTEGER;
   Depla     : Word;
   Puissance : Byte;
   Speed     : Byte;
   WhereSpr  : Byte;
   Typ       : Word;
   Plus      : Shortint;
End;

Type ExplosionsTyp=Record
   Exist       : BOOLEAN;
   BoomX,BoomY : INTEGER;
   Typ         : Byte;
   Sprite      : Byte;
End;

VAR Sprite : ARRAY[1..120] of SpriteTyp;
    Aliens : ARRAY[1..50] of AliensTyp;
    Canon  : ARRAY[1..100] of MitraTyp;
    Boomb  : ARRAY[1..50] of ExplosionsTyp;

PROCEDURE INITMODX;ASSEMBLER;
ASM
   MOV AX,13h
   INT 10h

   MOV DX,3C4h                  { TS                                       }
   MOV AL,4
   OUT DX,AL
   INC DX
   IN AL,DX
   AND AL,0F7h
   OR AL,4h                     { D‚sensenclenche le mode Chain 4          }
   OUT DX,AL

   DEC DX                       { Efface les 4 pages graphiques            }
   MOV AX,0F02h
   OUT DX,AX
   MOV AX,0A000h
   MOV ES,AX
   XOR DI,DI
   XOR AX,AX
   MOV CX,0FFFFh
   CLD
   REP STOSW

   MOV DX,3D4h                  { CRTC                                     }
   MOV AL,14h
   OUT DX,AL
   INC DX
   IN AL,DX
   AND AL,0BFh                  {  bit 6 du doubleword … 0                 }
   OUT DX,AL
   DEC DX
   MOV AL,17h
   OUT DX,AL
   INC DX
   IN AL,DX
   OR AL,40h                    { bit 6 … 1                                }
   OUT DX,AL

   MOV FPAGE,0;
END;

PROCEDURE BLACKPAGE;ASSEMBLER;
ASM
   MOV DX,3C4h
   MOV AX,0F02h
   OUT DX,AX
   MOV AX,0A000h
   MOV ES,AX
   XOR DI,DI
   ADD DI,Fpage
   XOR AX,AX
   MOV CX,8000d
   REP STOSW
END;


PROCEDURE MOVE(VAR Source,But;Taille : WORD);ASSEMBLER;
ASM
   MOV DX,DS
   MOV CX,Taille
   MOV AX,CX
   OR CX,CX
   Jz @Fin
   MOV BX,CX
   SHR CX,1
   AND BX,$0001
   Les DI,But
   Lds SI,Source
   Cmp SI,DI
   Jnb @sensp
   Std
   Dec AX
   Add SI,AX
   Add DI,AX
   OR BL,BL
   Jz @pair
   Movsb
   OR CX,CX
   Jz @fin
  @Pair: Dec SI
         Dec DI
     Rep Movsw
         Jmp @fin
  @Sensp: Cld
          OR CX,CX
          Jz @Seul
     Rep Movsw
  @Seul: OR BL,BL
         Jz @Fin
         Movsb
  @Fin: MOV DS,DX
END;

PROCEDURE FILLCHAR(VAR Source;Taille : Word;Valeur:Byte);ASSEMBLER;
ASM
   MOV CX,Taille
   OR CX,CX
   JZ @Fin
   Les DI,Source
   Cld
   MOV DX,$0001
   AND DX,CX
  @Double: SHR CX,1
           JZ @Un
           MOV AL,Valeur
           MOV AH,AL
      Rep Stosw
          OR DL,DL
          JZ @Fin
  @Un: Stosb
  @Fin:
END;

PROCEDURE TELELINE(VAR x1, y1, x2, y2 : integer;Vite : BYTE);
{ Utilisation de i }
var d, dx, dy,
    aincr, bincr,
    xincr, yincr,
    x, y                 : integer;
    ajout : byte;

procedure SwapInt( var i1, i2: integer );
var dummy : integer;
begin
  dummy := i2;
  i2    := i1;
  i1    := dummy;
end;

begin
  ajout:=0;
  if ( abs(x2-x1) < abs(y2-y1) ) then     {Parcours : par axe X ou Y ? }
    begin                                            { par l'axe des Y }
      if ( y1 > y2 ) then                         { y1 sup‚rieur … y2? }
        begin
      SwapInt( x1, x2 );                      { Oui, ‚change X1 et X2, }
      SwapInt( y1, y2 );                                    { Y1 et Y2 }
        end;

      if ( x2 > x1 ) then xincr := 1          { Fixe le pas horizontal }
                     else xincr := -1;

      dy := y2 - y1;
      dx := abs( x2-x1 );
      d  := (dx shl 1) - dy;
      aincr := (dx - dy) shl 1;
      bincr := dx shl 1;
      x := x1;
      y := y1;
      Inc(Ajout);
      IF Ajout=Vite then BEGIN X1:=x;Y1:=y;Exit;END;
      for y:=y1+1 to y2 do                      { Parcourt l'axe des Y }
        begin
          if ( d >= 0 ) then
            begin
              inc( x, xincr );
              inc( d, aincr );
            end
          else
            inc( d, bincr );
            Inc(Ajout);IF Ajout=Vite then BEGIN X1:=x;Y1:=y;Exit;END;
        end;
    end
  else                                               { par l'axe des X }
    begin
      if ( x1 > x2 ) then                      { x1 plus grand que x2? }
        begin
      SwapInt( x1, x2 );                       { Oui, ‚change X1 et X2 }
      SwapInt( y1, y2 );                                    { Y1 et Y2 }
        end;

      if ( y2 > y1 ) then yincr := 1            { Fixe le pas vertical }
                     else yincr := -1;

      dx := x2 - x1;
      dy := abs( y2-y1 );
      d  := (dy shl 1) - dx;
      aincr := (dy - dx) shl 1;
      bincr := dy shl 1;
      x := x1;
      y := y1;
      Inc(Ajout);IF Ajout=Vite then BEGIN X1:=x;Y1:=y;Exit;END;
      for x:=x1+1 to x2 do                      { Parcourt l'axe des X }
        begin
          if ( d >= 0 ) then
            begin
              inc( y, yincr );
              inc( d, aincr );
            end
          else
            inc( d, bincr );
            Inc(Ajout);IF Ajout=Vite then BEGIN X1:=x;Y1:=y;Exit;END;
       end;
    end;
end;

PROCEDURE PutSprAt(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
    CASE Num OF
       1 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Player1^[(320*(y1+numlines)+x1)+c1] <>0 then
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Player1^[(320*(y1+numlines)+x1)+c1];
       2 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Player2^[(320*(y1+numlines)+x1)+c1] <>0 then
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Player2^[(320*(y1+numlines)+x1)+c1];
       3 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Decors^[(320*(y1+numlines)+x1)+c1] <>0 then
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Decors^[(320*(y1+numlines)+x1)+c1];
    END;
END;

PROCEDURE PutSprSt(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
    CASE Num OF
       1 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Player1^[(320*(y1+numlines)+x1)+c1];
       2 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Player2^[(320*(y1+numlines)+x1)+c1];
       3 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Spr^[((320*y1des+x1des)+numlines*320)+c1]:=Decors^[(320*(y1+numlines)+x1)+c1];
    END;
END;

PROCEDURE SYNCHRO;ASSEMBLER;
ASM
   MOV DX,3DAh
 @Wait1:
   IN AL,DX
   TEST AL,8h
   jnz @Wait1
 @Wait2:
   IN AL,DX
   TEST AL,8h
   jz @Wait2
END;

PROCEDURE SETPAL(s:STRING;Indice : Byte);
PROCEDURE DECODPAL(Nom : String;var Palet : ARRAY of Byte);
Var f,f2   : Text;
    ch,ch2,ch3,ch4,ch5,ch6 : Char;
    inter : Byte;
BEGIN
 Assign(f,Nom);Reset(f);
  For j:=0 to 127 do   { 768/6 -1 }
   Begin
    Read(f,Ch);Read(f,ch2);Read(f,ch3);
    Read(f,Ch4);Read(f,ch5);Read(f,ch6);
    inter:=ord(Ch );inter:=Not inter;Palet[j*6]:=inter;
    inter:=ord(Ch2);inter:=Not inter;Palet[j*6+1]:=inter;
    Palet[j*6+2]:=(ord(Ch3) xor Clef);
    inter:=ord(Ch4);inter:=Not inter;Palet[j*6+3]:=inter;
    Palet[j*6+4]:=(ord(Ch5) xor Clef);
    Palet[j*6+5]:=(ord(Ch6) xor Clef);
   End;
  Close(f);
END;

VAR f10 : File;
BEGIN
If Indice=0 then DecodPal(s,Palette );
If Indice=1 then DecodPal(s,Palette2);
If (Indice=2) then MOVE(Palette2,Palette,768);
If (Indice=2) or (indice=0) or (indice=3) then
 ASM
     MOV AX,1012h
     XOR BX,BX
     MOV CX,256
     MOV DX,Seg Palette
     MOV ES,DX
     MOV DX,Offset Palette
     INT 10h
  END;
END;

PROCEDURE FADE_OUT;
Var CoulMax : Byte;
BEGIN
 CoulMax:=63;
 REPEAT
   For i:=0 to 767 do
    BEGIN
      j:=Palette[i];
      If j>0 then Dec(j);
      Palette[i]:=j;
    END;
   Synchro;
   SetPal('',3);
   Dec(CoulMAx);
 UNTIL CoulMax=0;
END;

PROCEDURE DECOMPACT(Ne:String;Num:Word);
VAR Nb : WORD;
    Color    : BYTE;
BEGIN
   Total:=0;
   Assign(f,ne);
   Reset(f);
   If Num>=10 then
     BEGIN
      Dec(Num,10);
      REPEAT
       Read(f,ch);
       Color:=Ord(ch);
       CASE Num OF
           0 : Spr^[Total]:=Color;
           1 : Player1^[Total]:=Color;
           2 : Player2^[Total]:=Color;
           3 : Decors^[Total]:=color;
        END;
        Inc(total);
       UNTIL Total>=64000;
       Close(f);
     END
   ELSE
   BEGIN
    REPEAT
      Read(f,Ch);
      Read(f,ch2);
      Nb:=Ord(ch);
      Color:=Ord(ch2);
      i:=0;
      REPEAT
        CASE Num OF
           0 : Spr^[Total+i]:=Color;
           1 : Player1^[Total+i]:=Color;
           2 : Player2^[Total+i]:=Color;
           3 : Decors^[Total+i]:=color;
        END;
        if nb>i then inc(i);
      UNTIL (i=nb);
    Inc(Total,nb);
    UNTIL Total>=64000;
    Close(f);
   END;
end;

PROCEDURE MEM2MX_2(Page,Taille,DepLine : WORD);ASSEMBLER;
VAR Plan_l   : BYTE;
    Plan_pos : WORD;
ASM
    MOV DX,03CEh
    MOV AX,4005h
    OUT DX,AX

    MOV PLAN_L,1
    PUSH DS
    LDS SI,DWORD ptr DS:Spr
    ADD SI,DepLine
    MOV Plan_pos,SI
    MOV AX,0A000h
    MOV ES,AX
    MOV DI,Page
    MOV CX,Taille
 @LPPLAN:
    MOV AL,02h
    MOV AH,Plan_l
    MOV DX,3C4h
    OUT DX,AX

  @LP1:
    MOVSB
    ADD SI,3
    LOOP @lp1

    MOV DI,Page
    INC Plan_pos
    MOV SI,plan_pos
    MOV CX,Taille
    SHL Plan_l,1
    CMP Plan_l,10h
    JNE @lpplan

    POP DS
END;

PROCEDURE ALLFALSE;
BEGIN
   ExitFinal:=False;
   Colis:=False;
   Droite:=False;
   Gauche:=False;
   Haut:=False;
   Bas:=False;
   Espace:=False;
   Esc:=False;
   Enter:=False;
   Decomp:=False;
   Fire:=False;
   Alt:=False;
   D:=False;
   DX2:=True;
   DX4:=True;
   Inv:=False;
END;

PROCEDURE COPY_BLOCK(destination,source,largeur,hauteur:word);ASSEMBLER;
VAR interligne:word;
ASM
  mov dx,3ceh                   { GDC                                      }
  mov ax,4105h                  { Mode de lecture 0, Mode d'‚criture 1     }
  out dx,ax                     { ‚mis sur le registre 5 : GDC Mode        }
  mov dx,3c4h                   { TS                                       }
  mov ax,0f02h                  { active tous les plans                    }
  out dx,ax                     { ‚mis sur le registre 2 : Write Plane Mask}

  push ds
  mov ax,0a000h                 { copier … l'int‚rieur de VGA              }
  mov es,ax                     { -> les deux segments … 0a000h            }
  mov ds,ax
  mov si,source                 { donn‚es d'origine                        }
  mov di,destination            { copi‚e en destination                    }
  mov dx,hauteur                { copie "hauteur" ligne                    }

  mov ax,80                     { calcul l'intervalle entre deux lignes    }
  sub ax,largeur                { (= 80-largeur)                           }
  mov interligne,ax
@line_lp:
  mov cx,largeur                { charge la largeur                        }
  rep movsb                     { copie une ligne                          }
  add si,interligne
  add di,interligne

  dec dx                        { compteur de lignes                       }
  jne @line_lp

  pop ds
END;

PROCEDURE PUTPIXEL(x,y,coul : WORD);ASSEMBLER;
ASM
   MOV AX,0A000h                { charge le segment                        }
   MOV ES,AX
   MOV CX,x                     { Comme x mod 4 en Pascal                  }
   AND CX,3                     { D‚termine le plan d'‚criture             }
   MOV AX,1
   SHL AX,CL
   MOV AH,AL
   MOV DX,03C4h                 { Registre 2 du TS                         }
   MOV AL,2
   OUT DX,AX                    { D‚termine le plan de bit                 }

   MOV AX,80
   MUL y
   MOV DI,AX
   ADD DI,Fpage
   MOV AX,x
   SHR AX,2
   ADD DI,AX                    { offset = Y*80 + X div 4 }
   MOV AL,byte ptr coul
   MOV ES:[DI],AL
END;

PROCEDURE READPIXEL(x,y : WORD);
BEGIN
ASM
  MOV AX,80
  MUL y
  MOV SI,x
  MOV CX,SI
  SHR SI,2
  ADD SI,AX
  AND CL,3
  MOV AH,CL
  MOV AL,4
  MOV DX,3CEh
  OUT DX,AX
  MOV AX,0A000h
  MOV ES,AX
  ADD SI,Fpage
  MOV AL,ES:[SI]
  MOV CoulRead,AL
END;
END;

PROCEDURE SHOWPAGE(t : word );ASSEMBLER;
ASM
  MOV DX,3D4h
  MOV AL,0Ch
  MOV AH,BYTE PTR t + 1
  OUT DX,AX
  MOV AL,0Dh
  MOV AH,BYTE PTR t
  OUT DX,AX
END;

PROCEDURE CHPAGE;ASSEMBLER;
ASM
  MOV DX,3D4h
  MOV AL,0Ch
  MOV AH,BYTE PTR Fpage + 1
  OUT DX,AX
  MOV AL,0Dh
  MOV AH,BYTE PTR FPage
  OUT DX,AX

  MOV BX,Fpage
  CMP BX,16000d
  JE @Anul
  MOV Fpage,16000
  ret
 @Anul:
  MOV Fpage,0
END;

PROCEDURE MEM2MX(Page,Taille : WORD);ASSEMBLER;
VAR Plan_l   : BYTE;
    Plan_pos : WORD;
ASM
    MOV DX,03CEh
    MOV AX,4005h
    OUT DX,AX

    MOV PLAN_L,1
    PUSH DS
    LDS SI,DWORD ptr DS:Spr
    MOV Plan_pos,SI
    MOV AX,0A000h
    MOV ES,AX
    MOV DI,Page
    MOV CX,Taille
 @LPPLAN:
    MOV AL,02h
    MOV AH,Plan_l
    MOV DX,3C4h
    OUT DX,AX

  @LP1:
    MOVSB
    ADD SI,3
    LOOP @lp1

    MOV DI,Page
    INC Plan_pos
    MOV SI,plan_pos
    MOV CX,Taille
    SHL Plan_l,1
    CMP Plan_l,10h
    JNE @lpplan

    POP DS
END;

PROCEDURE READANM(Ne:String;Num:Word);
VAR Fichier : FILE;
    Nb,taille : WORD;
    Clean : WORD;
BEGIN
    Assign(fichier,Ne);
    Reset(Fichier);
    BLOCKREAD(fichier,Spr^,500);MEM2MX(32000,16000);
    BLOCKREAD(fichier,Spr^,500);MEM2MX(48000,16000);
    For i:=3 to Num do
      BEGIN
        BLOCKREAD(fichier,Spr^,500);
        Ram_Xms(Spr,64000,i);
      END;
    Close(fichier);
END;

PROCEDURE COPYSCREEN(ziel,quelle,taille:word);ASSEMBLER;
ASM
  mov dx,3c4h
  mov ax,0f02h
  out dx,ax
  mov dx,3ceh
  mov ax,4105h
  out dx,ax

  push ds
  mov ax,0a000h
  mov es,ax
  mov ds,ax
  mov si,quelle
  mov di,ziel
  mov cx,taille
  rep movsb
  pop ds
  mov dx,3ceh
  mov ax,4005h
  out dx,ax
END;

Procedure GetSprite(Ofs,dtx,dty:Word;var dSprite:SpriteTyp;Num : BYTE);
Var ppp:Array[0..3] of Byte; {table avec le nombre de pixels … copier par plan }
    Skip:word;               {nombre d'octets … sauter}
    Plane_Count:Word;        {nombre de plans d‚j… copi‚s }
Begin
  If DSprite.Deb<>0 then Freemem(dSprite.adr,Dsprite.deb);
  Dsprite.Deb:=Dtx*Dty;
  GetMem(dSprite.adr,Dsprite.Deb); {alloue de la m‚moire }
  dSprite.dtx:=dtx;            {prend note de la largeur et de la hauteur }
  dSprite.dty:=dty;            {dans l'enregistrement du sprite }

  i:=dtx shr 2;                {nombre de groupes de 4 octets}
  ppp[0]:=i;ppp[1]:=i;         {correspond au nombre minimum d'octets … copier }
  ppp[2]:=i;ppp[3]:=i;
  For i:=1 to dtx and 3 do   {m‚morise en ppp les pixels restants  }
    Inc(ppp[(i-1) and 3]);   {ajoute les pixels en commen‡ant par le plan de d‚but}
  Plane_Count:=4;            {copie 4 plans }
asm
  push ds
  mov di,word ptr dSprite  {charge d'abord un pointeur sur le bloc de donn‚es}
  les di,[di]              {es:di va pointer sur les donn‚es graphiques}
  lea bx,ppp               {bx r‚f‚rence le tableau ppp}

  Cmp  Num,1
  Jnz @Else1
 @Then1:
  Lds si,Decors
  Jmp @EndIf1
 @Else1:
  Cmp Num,2
  jnz @Else2
  Lds Si,Player1
  Jmp @EndIf1
 @Else2:
  Lds Si,Player2
 @EndIf1:


        {charge un pointeur sur l'‚cran}
   add Ofs,si         {ajoute l'offset des donn‚es du sprite proprement dites}
@lcopy_plane:         {boucle des plans}
  mov si,ofs          {si re‡oit l'adresse de d‚but des donn‚es du sprite }
  mov dx,dty          {le compteur d'ordonn‚es re‡oit le nombre de lignes}

  xor ah,ah           {efface ah}
  mov al,ss:[bx]      {charge en al l'‚l‚ment courant de ppp}
  shl ax,2            {on d‚place des groupes de 4 octets}
  sub ax,320          {calcule la diff‚rence par rapport … 320}
  neg ax              {convertit ax-320 en 320-ax }
  mov skip,ax         {sauvegarde le r‚sultat en Skip }

@lcopy_y:             {boucle des lignes }
  mov cl,ss:[bx]      {tire la largeur du tableau ppp }
@lcopy_x:             {boucle des pixels }
  movsb               {copie un octet }
  add si,3            {point suivant dans le mˆme plan }
  dec cl              {copie tous les points de la ligne }
  jne @lcopy_x

  add si,skip         {passe … la ligne suivante }
  dec dx              {copie toutes les lignes }
  jne @lcopy_y

  inc bx              {pointe sur l'‚l‚ment suivant de ppp }
  inc ofs             {se positionne sur le nouveau d‚but de plan }
  dec plane_count     {copie tous les plans }
  jne @lcopy_plane

  pop ds
End;
End;

Procedure PutSprite(pg_ofs,x,y:Integer;sSprite:spritetyp);
var plane_count,              {nombre de plans d‚j… copi‚s }
    masqueplan:Byte;          {masque Write-Plane dans le registre 2 du TS }
    Skip,                     {nombre d'octets … sauter }
    ofs,                      {offset courant dans la m‚moire d'‚cran }
    plane,                    {num‚ro du plan courant }
    Largeur,                  {largeur en octets … copier dans une ligne }
    dty:Word;                 {hauteur }
    source:Pointer;     {pointe sur les donn‚es graphiques lorsque ds varie }
    clip_lt, clip_rt:integer; {nombre de pixels restant … droite et … gauche }
    clipact_lt,               {nombre d'octets restants }
    clipact_rt,               {pour le plan courant }
    clip_dn,clip_up:Word;     {nombre de lignes restant en haut et en bas }

    ppp:Array[0..3] of Byte;  {nombre de pixels par plan }
    cpp:Array[0..3] of Byte;  {nombre d'octets restants par plan }

Begin
  if (x > 319) or               {pas de dessin }
  (x+sSprite.dtx < 0) or        {sprite en dehors de l'‚cran ?}
  (y > 199) or
  (y+sSprite.dty < 0) then exit;
  clip_rt:=0;                   {normalement pas de clipping }
  clip_lt:=0;                   {-> toutes les variables de clipping … 0 }
  clip_dn:=0;
  clip_up:=0;
  clipact_rt:=0;
  clipact_lt:=0;
   with sSprite do begin
    if y+dty > 200 then begin  {premier cas de clipping : en bas}
      clip_dn:=(y+dty-200);    {nombre de lignes restantes }
      dty:=200-y;              {r‚duit la hauteur du sprite }
    End;
    if y<0 then begin          {deuxiŠme cas de clipping: en haut}
      clip_up:=-y;             {nombre de lignes restantes }
      dty:=dty+y;              {r‚duit la hauteur du spr }
      y:=0;          {ordonn‚e de d‚part nulle, au bord sup‚rieur de l'‚cran }
    End;
    if x+dtx > 320 then begin   {troisiŠme cas de clipping : … droite }
      clip_rt:=x+dtx-320;       {pixels restants }
      dtx:=320-x;               {r‚duit la largeur }
    End;
    if x<0 then begin           {quatriŠme cas de clipping : … gauche }
      clip_lt:=-x;              { nombre de pixels restants }
      plane:=4-(clip_lt mod 4); {nouveau plan de d‚but pour la colonne 0 }
      plane:=plane and 3;       {ramŠne … l'intervalle 0..3 }
      ofs:=pg_ofs+80*y+((x+1) div 4) - 1;  {Ofs sur groupe de 4 octets }
      x:=0;                                {colonne de d‚but }
    End Else Begin                         {… droite pas de clipping?}
      plane:=x mod 4;                    {alors calcul conventionnel du plan }
      ofs:=pg_ofs+80*y+(x div 4);        {et de l'offset }
    End;
  End;
  Source:=sSprite.adr;         {m‚morise pointeur sur les donn‚es graphiques }
  dty:=sSprite.dty;            {et hauteur dans variables locales }
  Largeur:=0;                  {initialise largeur et Skip }
  Skip:=0;

  i:=sSprite.dtx shr 2;      {nombre de groupes de 4 octets complets}
  ppp[0]:=i;ppp[1]:=i;       {correspond au nombre minimum d'octets … copier }
  ppp[2]:=i;ppp[3]:=i;
  For i:=1 to sSprite.dtx and 3 do{m‚morise en ppp les pixels restants }
    Inc(ppp[(plane+i - 1) and 3]);{ajoute les pixels en commen‡ant par le plan de d‚but }

  i:=(clip_lt+clip_rt) shr 2;
  cpp[0]:=i;cpp[1]:=i;          {valeurs par d‚faut du clipping}
  cpp[2]:=i;cpp[3]:=i;
  For i:=1 to clip_rt and 3 do  {si clipping … droite }
    Inc(cpp[i-1]);              {enregistre le nombre dans les plans }
  For i:=1 to clip_lt and 3 do  {si clipping … gauche }
    Inc(cpp[4-i]);              {enregistre le nombre dans les plans }

asm
  mov dx,3ceh                   {met le registre 5 du GDC (GDC Mode)}
  mov ax,4005h                  {en mode Write 0 }
  out dx,ax
  push ds                       {sauve ds}
  mov ax,0a000h                 {charge le segment de destination (VGA) }
  mov es,ax

  lds si,source       {ds:si va pointer sur la source (donn‚es graphiques ) }
  mov cx,plane        {masque de plan de d‚part }
  mov ax,1            {d‚cale le bit 0 vers la gauche }
  shl ax,cl
  mov masqueplan,al           {sauve le masque }
  shl al,4                    {le reporte dans le quartet sup‚rieur }
  or masqueplan,al
  mov plane_count,4          {4 plans … copier }
@lplane:                     {boucle des plans }
  mov cl,byte ptr plane      {charge le plan courant }
  mov di,cx                  {en di}
  mov cl,byte ptr ppp[di]    {charge le nombre ppp corrrespondant en cx }
  mov byte ptr Largeur,cl    {recalcule Skip }
  mov ax,80                  {forme la diff‚rence 80-largeur }
  sub al,cl
  mov byte ptr skip,al       {et la reporte dans skip }

  mov al,byte ptr cpp[di] {charge la largeur de clipping sp‚cifique au plan }
  cmp clip_lt,0           {si pas de clipping … gauche, voyons … droite }
  je @adroite
{sauve en clip_act_lt clip. plan + sp‚cif.}
  mov clipact_lt,ax
  sub Largeur,ax          {r‚duit le nombre d'octets … copier }
  jmp @clip_rdy           {… droite pas de clipping}
@adroite:                 {si pas de clipping … gauche }
  mov clipact_rt,ax       {clipping pour tous les plans en clip_act}
@clip_rdy:
  mov ax,Largeur          {calcule la largeur totale en octets }
  add ax,clipact_rt
  add ax,clipact_lt
  mul clip_up      {multiplie par le nombre de lignes du clipping sup‚rieur }
  add si,ax        {octets non repr‚sent‚s }
  mov cx,Largeur   {charge la largeur en cx }
  or cl,cl         {largeur 0, plan termin‚ }
  je @planfini

  mov di,ofs            {offset de destination dans l'‚cran en di}
  mov ah,masqueplan     {r‚duit le masque de plan aux bits [0..3] }
  and ah,0fh
  mov al,02h            {active le registre 2 du TS (Write Plane Mask)}
  mov dx,3c4h
  out dx,ax
  mov bx,dty                 {initialise le compteur de lignes y }
@lcopy_y:                    {boucle des lignes y }
  add si,clipact_lt          {pointeur source au-del… clipping gauche }
  add di,clipact_lt          {idem pour le pointeur de destination }
@lcopy:                      {boucle des pixels }
  lodsb                      {lit un octet }
  or al,al                   {si 0, pas de traitement }
  je @Valeur0
  stosb                      {sinon copie }
@entry:
  loop @lcopy                {suite de la boucle }

  add si,clipact_rt          {aprŠs ligne complŠte, clipping droit }

  dec bx                     {incr‚mente le compteur de lignes }
  je @planfini               {compteur de lignes  = 0, plan suivant }
  add di,skip                {sinon passe en d‚but de ligne suivante }
  mov cx,Largeur             {r‚initialise le compteur de colonnes }
  jmp @lcopy_y               {retourne dans la boucle des lignes }
@valeur0:                    {couleur du sprite 0 }
  inc di                     {saute l'octet de destination }
  jmp @entry                 {retourne dans la boucle }
@planfini:                   {fin de la boucle des lignes }
  mov ax,Largeur             {calcul la largeur globale en octets }
  add ax,clipact_rt
  add ax,clipact_lt
  mul clip_dn            {multiplie par le nombre de lignes du clipping inf. }
  add si,ax              {octets non r‚pr‚sent‚s }
  rol masqueplan,1       {masque le plan suivant }
  mov cl,masqueplan      {a-t-on s‚lectionn‚ le plan 0 ?}
  and cx,1               {(bit 1 … 1), alors}
  add ofs,cx             {incr‚mente de 1 l'offset de destination (cx bit 1 !)}
  inc plane              {incr‚mente le num‚ro de plan (indice dans ppp) }
  and plane,3            {r‚duit de 0 … 3 }
  dec plane_count        {d‚j… 4 plans copi‚s, on arrˆte }
  jne @lplane
  pop ds                 {restaure ds, ciao}
End;                     {asm}
End;

Procedure PutSpriteSC(pg_ofs,x,y:Integer;sSprite:spritetyp);
var planecount,          {nombre de plans d‚j… copi‚s }
    masqueplan:Byte;     {masque le plan Write dans le registre 2 du TS }
    Skip,                {nombre d'octets … sauter }
    ofs,                 {offset courant dans la m‚moire d'‚cran }
    plane,               {num‚ro du plan courant }
    Largeur,             {largeur en nombre d'octets … copier dans une ligne }
    dty:Word;            {hauteur }
    source:Pointer;      {pointe sur les donn‚es graphiques quand ds varie}

    ppp:Array[0..3] of Byte;    {nombre de pixels par plan }
    i:Word;                     {compteur d'it‚rations local }

Begin
  {if (x + sSprite.dtx > 324)
  or (x <-5)
  or (y + sSprite.dty > 203) or (y < -5) then exit;}
                                     {fixe la direction }
  Source:=sSprite.adr;               {pointe sur les donn‚es graphiques }
  dty:=sSprite.dty;                  {charge la hauteur en local }
   plane:=x mod 4;                   {plan et }
  ofs:=pg_ofs+80*y+(x div 4);        {offset de d‚but }
  Largeur:=0;                        {initialise la largeur et le saut }
  Skip:=0;

  i:=sSprite.dtx shr 2;              {nombre de groupes de 4 octets complets}
  ppp[0]:=i;ppp[1]:=i;               {nombre minimum d'octets … copier }
  ppp[2]:=i;ppp[3]:=i;
  For i:=1 to sSprite.dtx and 3 do{m‚morise en ppp les pixels restants }
    Inc(ppp[(plane+i - 1) and 3]);{ajoute les pixels en commen‡ant par le plan de d‚but }
asm
  push ds                       {sauve ds}
  mov ax,0a000h                 {charge le segment de destination (VGA)}
  mov es,ax

  lds si,source         {ds:di va pointer sur la source (donn‚es graphiques) }
  mov cx,plane          {cr‚e le masque de plan de d‚but }
  mov ax,1              {d‚cale le bit 0 vers la gauche }
  shl ax,cl
  mov masqueplan,al     {sauve le masque }
  shl al,4              {le recopie dans le quartet sup‚rieur }
  or masqueplan,al
  mov planecount,4          {4 plans … copier }
@lplane:                    {boucle des plans }
  mov cl,byte ptr plane     {charge le plan courant }
  mov di,cx                 {en di}
  mov cl,byte ptr ppp[di]   {charge le nombre ppp correspondant en cx }
  mov byte ptr Largeur,cl   {recalcule skip }
  mov ax,80                 {forme la diff‚rence direction-largeur }
  sub ax,cx
  mov skip,ax               {et ‚crit le r‚sultat dans skip }

  mov cx,Largeur            {charge la largeur en cx }
  or cl,cl                  {largeur 0, plan termin‚ }
  je @planfini

  mov di,ofs   {charge en di l'offset de destination dans la m‚moire d'‚cran }
  mov ah,masqueplan      {r‚duit le masque de plan aux bits [0..3] }
  and ah,0fh
  mov al,02h             {active le registre 2 du TS (Write Plane Mask)}
  mov dx,3c4h
  out dx,ax
  mov bx,dty             {initialise le compteur de lignes y }
@lcopy_y:                {boucle des lignes }
@lcopy_x:                {boucle des pixels }
  lodsb                  {lit un octet }
  or al,al               {si 0, passe}
  je @Valeur0
  stosb                  {sinon copie }
@entry:
  loop @lcopy_x          {suite de la boucle }

  dec bx                        {suite du d‚comptage de lignes }
  je @planfini                  {compteur = 0, alors plan suivant }
  add di,skip                   {sinon saute au d‚but de ligne suivant }
  mov cx,Largeur                {r‚initialise le compteur de colonnes }
  jmp @lcopy_y                  {retourne dans la boucle des lignes }
@valeur0:                       {couleur du sprite 0 }
  inc di                        {saute l'octet de destination }
  jmp @entry                    {retourne dans la boucle }
@planfini:                      {fin de la boucle des lignes }

  rol masqueplan,1              {masque le plan suivant }
  mov cl,masqueplan             {plan 0 s‚lectionn‚ ?}
  and cx,1                      {(bit 1 … 1), alors}
  add ofs,cx              {incr‚mente de 1 l'offset de destination (bit 1 !)}
  inc plane               {incr‚mente le num‚ro de plan (indice dans ppp) }
  and plane,3             {r‚duit de 0 … 3 }
  dec planecount          {d‚j… 4 plans copi‚s, on arrˆte }
  jne @lplane
  pop ds                  {restaure ds, ciao }
End;                      {asm}
End;

PROCEDURE Game1Player;
VAR Xp1,Yp1,Live      : INTEGER;
    Gv,Dv,Hv,Bv,SprP1 : BYTE;

PROCEDURE TestClav;
BEGIN
 If (not nivend1) then
 CASE PORT[$60] Of
   UP    : Haut:=True;
   DOWN  : Bas:=True;
   LEFT  : Gauche:=True;
   RIGHT : Droite:=True;
   UP+128    : BEGIN Haut:=False;Hv:=0;SprP1:=6; END;
   DOWN+128  : BEGIN Bas:=False;Bv:=0;SprP1:=6; END;
   LEFT+128  : BEGIN Gauche:=False;Gv:=0;SprP1:=6; END;
   RIGHT+128 : BEGIN Droite:=False;Dv:=0;SprP1:=6; END;
   SHOOT     : Fire:=True;
   SHOOT+128 : Fire:=False;
   TALT      : Alt:=True;
   TALT+128  : Alt:=False;
   TD        : D:=True;
   TD+128    : D:=False;
   TI        : Inv:=True;
   TI+128    : Inv:=False;
   Tmoins    : Inc(SpeedSync);
   Tplus     : Dec(SpeedSync);
 END
 Else begin Haut:=True;bas:=False;Gauche:=false;Droite:=false; End;
 If SpeedSync<0 then SpeedSync:=0
 Else If SpeedSync>560 then SpeedSync:=560;
END;
PROCEDURE VAISGO;
BEGIN
If Gauche then BEGIN
  If Gv<=90 then Inc(Gv,2);Dec(Xp1,Sinus[Gv] shr 6);
  If Gv<=8 then SprP1:=6
  ELSE If Gv<=10 then SprP1:=7
  ELSE If Gv<=12 then SprP1:=8
  ELSE If Gv<=14 then SprP1:=9
  ELSE If Gv<=16 then SprP1:=10
  ELSE If Gv<=18 then SprP1:=11
  ELSE SprP1:=12;
END;
If Droite then BEGIN
  If Dv<=90 then Inc(Dv,2);Inc(Xp1,Sinus[Dv] shr 6);
  If Dv<=8 then SprP1:=6
  ELSE If Dv<=10 then SprP1:=5
  ELSE If Dv<=12 then SprP1:=4
  ELSE If Dv<=14 then SprP1:=3
  ELSE If Dv<=16 then SprP1:=2
  ELSE If Dv<=18 then SprP1:=1
  ELSE SprP1:=0;
END;
If Haut then BEGIN If Hv<=90 then Inc(Hv,2);Dec(Yp1,Sinus[Hv] shr 6); END;
If Bas  then BEGIN If Bv<=90 then Inc(Bv,2);Inc(Yp1,Sinus[Bv] shr 6); END;

CASE SprP1 OF
  0 : BEGIN If Xp1>269+8 then Xp1:=269+8;If Xp1<-8+8 then Xp1:=-8+8; END;
  1 : BEGIN If Xp1>269+7 then Xp1:=269+7;If Xp1<-7+8 then Xp1:=-7+8; END;
  2 : BEGIN IF Xp1>269+6 then Xp1:=269+6;If Xp1<-6+8 then Xp1:=-6+8; END;
  3 : BEGIN If Xp1>269+5 then Xp1:=269+5;If Xp1<-5+8 then Xp1:=-5+8; END;
  4 : BEGIN If Xp1>269+3 then Xp1:=269+3;If Xp1<-3+8 then Xp1:=-3+8; END;
  5 : BEGIN If Xp1>269+1 then Xp1:=269+1;If Xp1<-1+8 then Xp1:=-1+8; END;
  12 : If Xp1<-8+8 then Xp1:=-8+8;
  11 : If Xp1<-7+8 then Xp1:=-7+8;
  10 : If Xp1<-6+8 then Xp1:=-6+8;
  9 : If Xp1<-5+8 then Xp1:=-5+8;
  8 : If Xp1<-3+8 then Xp1:=-3+8;
  7 : If Xp1<-1+8 then Xp1:=-1+8;
  6 : BEGIN If Xp1<8 then Xp1:=8;If Xp1>269 then Xp1:=269; END;
END;
If not nivend1 then If Yp1<-4 then Yp1:=-4;
If Yp1>167 then Yp1:=167;
If nivend1 then if Yp1<-60 then nivend2:=true;
END;

CONST ShadNiv1 : ARRAY[1..63] of BYTE =
      (5,31,6,7,33,8,9,10,36,11,11,13,11,17,18,
       19,19,12,21,13,13,33,18,19,27,21,21,21,28,28,8,
       58,9,10,36,11,38,43,34,58,35,61,63,38,49,59,50,
       62,43,62,58,59,59,59,43,61,62,10,62,62,63,63,11);

CONST FeuNiv1 : ARRAY[1..63] of BYTE=
      (1,1,2,3,3,3,4,5,5,6,6,31,6,2,3,14,14,4,5,31,16,
       3,3,14,22,15,15,15,22,22,3,14,4,5,31,6,14,31,
       3,4,4,5,39,4,5,5,31,39,31,39,4,4,4,5,5,5,31,5,31,39,31,39,6);

PROCEDURE PUTSPRP1;
PROCEDURE Shadow;
VAR Plus : WORD;
    D0001 : BYTE;
    OmbX,OmbY : INTEGER;

BEGIN
  If (SprP1>=0) and (SprP1<=4) then BEGIN Plus:=0;D0001:=0; END
  Else If (SprP1>=5) and (SprP1<=9) then BEGIN Plus:=11200;D0001:=5; END
  Else BEGIN Plus:=22400;D0001:=10; END;
  For u:=1 to 27 do For v:=1 to 17 do
  If Decors^[320*(v shl 1)+(u shl 1)+((SprP1-D0001)*54)+Plus]<>0 then
   BEGIN
    If Yp1+17>=100 then OmbY:=((100-Yp1+48) shr 2);
    If Yp1+17<100 then  OmbY:=((200-Yp1-48) shr 2);
    If Xp1+27>=160 then OmbX:=48-(Xp1 shr 2);
    If Xp1+27<160 then OmbX:=((200-Xp1) shr 2);
    READPIXEL(Xp1+OmbX+u,Yp1+OmbY+v);
    PUTPIXEL(Xp1+OmbX+u,Yp1+OmbY+v,ShadNiv1[CoulRead]);
   END;
END;

PROCEDURE FEUARR;
VAR p1,p2:Shortint;
BEGIN
  CASE SprP1 OF
    0 : BEGIN p1:=20;p2:=33; END;
    6 : BEGIN p1:=18;p2:=34; END;
    12: BEGIN p1:=18;p2:=31; END
    Else BEGIN p1:=18;p2:=34; END;
  END;
  For u:=1 to 6 do for v:=1 to 2 do
    BEGIN
     m:=Random(u);If (m=0) or (m=1) then
      IF (Yp1+31+u<200) and (Yp1+31+u>=0) then
       BEGIN
        READPIXEL(Xp1+p1+v,Yp1+31+u);
        PUTPIXEL(Xp1+p1+v,Yp1+31+u,FeuNiv1[CoulRead]);
       END;
     m:=Random(u);IF (m=0) or (m=1) then
      IF (Yp1+31+u<200) and (Yp1+31+u>=0) then
       BEGIN
        READPIXEL(Xp1+p2+v,Yp1+31+u);
        PUTPIXEL(Xp1+p2+v,Yp1+31+u,FeuNiv1[CoulRead]);
       END;
    END;
END;

BEGIN
  If DX2 then Shadow;
  IF DX2 then FeuArr;
  If (SprP1>=0) and (SprP1<=4) then GetSprite(54*SprP1,54,35,Sprite[1],1)
  ELSE If(SprP1>=5) and (SprP1<=9) then GetSprite(54*(SprP1-5)+11200,54,35,Sprite[1],1)
  ELSE GetSprite(54*(Sprp1-10)+22400,54,35,Sprite[1],1);
  PutSprite(Fpage,Xp1,Yp1,Sprite[1]);
END;

PROCEDURE TestIfAlien;
Procedure Boss;
Begin
 Aliens[v].Spd:=2;n:=0;Aliens[v].Bobo:=75;Aliens[v].ay:=-90;
 Aliens[v].Where:=0;Aliens[v].plus:=0;
 SetPal('Niv1b.cod',2);Bossend:=1;Aliens[v].NdTime:=0;
end;

BEGIN
   For u:=1 to N1ndalien do If (TotalLignes)=(Niv1_Alien[1,u]) then
     BEGIN
       v:=1;LetsGo:=False;
       REPEAT
        If Aliens[v].typ=0 then
         BEGIN
           Letsgo:=True;
           Aliens[v].typ:=Niv1_alien[5,u];
           Aliens[v].ax:=Niv1_alien[3,u];
           Aliens[v].ay:=-60;
           Aliens[v].Depla:=Niv1_alien[2,u];
           Aliens[v].Live:=Niv1_alien[6,u];
           Aliens[v].TypMis:=Niv1_Alien[4,u];
           Aliens[v].Trajet:=0;
           Aliens[v].Bobo:=4;    { D‚gats aux colisions suivant les vaisseaux }
           Aliens[v].Plus:=0;
           Case Aliens[v].typ Of
            1,2 : BEGIN Aliens[v].Spd:=2;n:=0;
                 END;
            3   : BEGIN Aliens[v].Spd:=3;n:=0;
                 END;
            4   : BEGIN Aliens[v].Spd:=3;n:=0;
                 END;
            5   : BEGIN Aliens[v].Spd:=Random(4)+3;n:=0;
                   Aliens[v].FinX:=Xp1+24;Aliens[v].FinY:=Yp1+20;
                   REPEAT Inc(Aliens[v].FinX,Aliens[v].FinX-Aliens[v].Ax);
                          Inc(Aliens[v].FinY,Aliens[v].FinY-Aliens[v].Ay);
                   UNTIL (Aliens[v].FinY<-60) or (Aliens[v].Finy>220) or (Aliens[v].Finx<-20) or (Aliens[v].Finx>340);
                   Aliens[v].plus:=0;Aliens[v].Where:=0;
                   Aliens[v].Bobo:=5;
                   END;
            6   : BEGIN Aliens[v].Spd:=6;Aliens[v].Bobo:=6;
                   Aliens[v].FinX:=Xp1+24;Aliens[v].FinY:=Yp1+20;
                   REPEAT Inc(Aliens[v].FinX,Aliens[v].FinX-Aliens[v].Ax);
                          Inc(Aliens[v].FinY,Aliens[v].FinY-Aliens[v].Ay);
                   UNTIL (Aliens[v].FinY<-60) or (Aliens[v].Finy>220) or (Aliens[v].Finx<-20) or (Aliens[v].Finx>340);
                   Aliens[v].plus:=0;Aliens[v].Where:=0; END;
            999 : Boss;
           END;
         END;
         Inc(v);
         if v>=51 then letsgo:=True;
       UNTIL Letsgo;
     END;
END;

PROCEDURE WRITEALIEN;
PROCEDURE FEUALIEN(Xa,Ya,Long,Lar,p1,p2:INTEGER);
VAR t,r : BYTE;
BEGIN
  For t:=1 to 6 do for r:=1 to 2 do
    BEGIN
     m:=Random(t);If (m=0) or (m=1) then
      IF (Ya<200) and (Ya-t>=0) and (Xa+p1>=0) and (Xa+p1+r<319) then
       BEGIN
        READPIXEL(Xa+p1+r,Ya-t);
        If CoulRead<=63 then PUTPIXEL(Xa+p1+r,Ya-t,FeuNiv1[CoulRead]);
       END;
     m:=Random(t);IF (m=0) or (m=1) then
      IF (Ya<200) and (Ya-6>=0) and (Xa+p2>=0) and (Xa+p2<319) then
       BEGIN
        READPIXEL(Xa+p2+r,Ya-t);
        If CoulRead<=63 then PUTPIXEL(Xa+p2+r,Ya-t,FeuNiv1[CoulRead]);
       END;
    END;
END;
PROCEDURE FEUBOSS(Xa,Ya,Long,Lar,p1X,p1Y,p2X,P2Y,p3x,p3y,p4x,p4y,p5x,p5y:INTEGER);
VAR t,r : BYTE;
BEGIN
  For t:=1 to 6 do for r:=1 to 2 do
    BEGIN
     m:=Random(t);If (m=0) or (m=1) then
      IF (Ya+P1y<200) and (Ya-t+P1Y>=0) and (Xa+p1X>=0) and (Xa+p1X+r<319) then
       BEGIN
        READPIXEL(Xa+p1X+r,Ya-t+p1Y);
        If CoulRead<=63 then PUTPIXEL(Xa+p1X+r,Ya-t+P1Y,FeuNiv1[CoulRead]);
       END;
     m:=Random(t);IF (m=0) or (m=1) then
      IF (Ya+p2y<200) and (Ya-t+p2y>=0) and (Xa+p2X>=0) and (Xa+p2X+r<319) then
       BEGIN
        READPIXEL(Xa+p2X+r,Ya-t+p2y);
        If CoulRead<=63 then PUTPIXEL(Xa+p2X+r,Ya-t+p2Y,FeuNiv1[CoulRead]);
       END;
    END;
  For t:=1 to 8 do for r:=1 to 3 do
    BEGIN
     m:=Random(t);If (m<3) then
      IF (Ya+P3y<200) and (Ya-t+P3Y>=0) and (Xa+p3X>=0) and (Xa+p3X+r<319) then
       BEGIN
        READPIXEL(Xa+p3X+r,Ya-t+p3Y);
        If CoulRead<=63 then PUTPIXEL(Xa+p3X+r,Ya-t+P3Y,FeuNiv1[CoulRead]);
       END;
     m:=Random(t);IF (m<3) then
      IF (Ya+p4y<200) and (Ya-t+p4y>=0) and (Xa+p4X>=0) and (Xa+p4X+r<319) then
       BEGIN
        READPIXEL(Xa+p4X+r,Ya-t+p4y);
        If CoulRead<=63 then PUTPIXEL(Xa+p4X+r,Ya-t+p4Y,FeuNiv1[CoulRead]);
       END;
    END;
    For t:=1 to 15 do for r:=1 to 5 do
    BEGIN
     m:=Random(t);If (m<5) then
      IF (Ya+P5y<200) and (Ya-t+P5Y>=0) and (Xa+p5X>=0) and (Xa+p5X+t<319) then
       BEGIN
        READPIXEL(Xa+p5X+r,Ya-t+p5Y);
        If CoulRead<=63 then PUTPIXEL(Xa+p5X+r,Ya-t+P5Y,FeuNiv1[CoulRead]);
       END;
    END;
END;

PROCEDURE ShadAl(PosX,PosY,Bx,By,LongX,LargY : INTEGER);
VAR Plus : WORD;
    D0001 : BYTE;
    OmbX,OmbY : INTEGER;
    T,R : BYTE;

BEGIN
  For t:=1 to (LongX shr 1) do For r:=1 to (LargY shr 1) do      { 15 et 12 }
  If Player1^[320*((r shl 1)+By)+(t shl 1)+Bx]<>0 then
   BEGIN
    If PosY<0 then OmbY:=50
    Else If PosY+17>199 then OmbY:=3
    Else If PosY>=100 then OmbY:=((200-PosY) shr 2)
    Else If PosY<100 then  OmbY:=((200-PosY) shr 2);
    If PosX+27>=160 then OmbX:=48-(PosX shr 2);
    If PosX+27<160 then OmbX:=((200-PosX) shr 2);
    If (PosY+OmbY+r>=0) and (PosY+OmbY+r<=199) and (PosX+OmbX+t>=0) and (PosX+OmbX+t<=319) then
     BEGIN
      READPIXEL(PosX+OmbX+t,PosY+OmbY+r);
      IF CoulRead<=63 then PUTPIXEL(PosX+OmbX+t,PosY+OmbY+r,ShadNiv1[CoulRead]);
     END;
   END;
END;

CONST AlienTypTir : ARRAY[1..6,1..10] Of INTEGER =      { -1 : Impossible ! }
      ((60,70,100,110,150,160,-1,-1,-1,-1),
       (60,70,100,110,150,160,-1,-1,-1,-1),
       (72,102,150,180,-1,-1,-1,-1,-1,-1),
       (72,102,150,180,-1,-1,-1,-1,-1,-1),
       (-1,-1,-1,-1,-1,-1,-1,-1,-1,-1),
       (0,6,12,-1,-1,-1,-1,-1,-1,-1));

PROCEDURE BOSSTIR;
BEGIN
m:=0;k:=0;
Repeat
 Inc(m);
 If (not Canon[m].Exist) then
 CASE Aliens[u].Typ Of
  999 : BEGIN
        If (Aliens[u].NdTime = 40) or (Aliens[u].NdTime=60) or (Aliens[u].NdTime=80) then
        Case k of
          0:  BEGIN Canon[m].Exist:=True;
           Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+17;
           Canon[m].TirY:=Aliens[u].Ay+48;Canon[m].Depla:=2;
           Canon[m].Speed:=4;
           Canon[m].WhereSpr:=14;
           Canon[m].Puissance:=8;Inc(k);
          End;
          1:  BEGIN Canon[m].Exist:=True;
           Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+78;
           Canon[m].TirY:=Aliens[u].Ay+48;Canon[m].Depla:=2;
           Canon[m].Speed:=4;
           Canon[m].WhereSpr:=14;
           Canon[m].Puissance:=8;Inc(k);
          End;
          2:  BEGIN Canon[m].Exist:=True;
           Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+51;
           Canon[m].TirY:=Aliens[u].Ay+75;Canon[m].Depla:=2;
           Canon[m].Speed:=4;
           Canon[m].WhereSpr:=15;
           Canon[m].Puissance:=2;Inc(k);
          End;
          3:  BEGIN Canon[m].Exist:=True;
           Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+51;
           Canon[m].TirY:=Aliens[u].Ay+75;Canon[m].Depla:=3;
           Canon[m].Speed:=3;
           Canon[m].WhereSpr:=15;
           Canon[m].Puissance:=2;Inc(k);
          End;
          4:  BEGIN Canon[m].Exist:=True;
           Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+51;
           Canon[m].TirY:=Aliens[u].Ay+75;Canon[m].Depla:=4;
           Canon[m].Speed:=3;
           Canon[m].WhereSpr:=15;
           Canon[m].Puissance:=2;Inc(k);
          End;
          5:  m:=100;
         END;
        END;

 END;
Until m=100;
m:=0;k:=1;
Repeat
Inc(m);
 If (not Canon[m].Exist) then
 CASE Aliens[u].Typ Of
  999 : Case k Of
     1 : If Random(450)=0 then
        begin
         Canon[m].Exist:=True;
         Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+1;
         Canon[m].TirY:=Aliens[u].Ay+35;Canon[m].Depla:=5; { T‚l‚guid‚ }
         Canon[m].Speed:=8;
         Canon[m].WhereSpr:=11;
         Canon[m].Puissance:=1;
         Canon[m].FinX:=Xp1+24;Canon[m].FinY:=Yp1+20;
         REPEAT Inc(Canon[m].FinX,Canon[m].FinX-Canon[m].TirX);
                Inc(Canon[m].FinY,Canon[m].FinY-Canon[m].TirY);
         UNTIL (Canon[m].FinY<-20) or (Canon[m].Finy>220) or (Canon[m].Finx<-20) or (Canon[m].Finx>340);
         Inc(k);
        end;
     2 : begin
         Canon[m].Exist:=True;
         Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+105;
         Canon[m].TirY:=Aliens[u].Ay+35;Canon[m].Depla:=5; { T‚l‚guid‚ }
         Canon[m].Speed:=8;
         Canon[m].WhereSpr:=11;
         Canon[m].Puissance:=1;
         Canon[m].FinX:=Xp1+24;Canon[m].FinY:=Yp1+20;
         REPEAT Inc(Canon[m].FinX,Canon[m].FinX-Canon[m].TirX);
                Inc(Canon[m].FinY,Canon[m].FinY-Canon[m].TirY);
         UNTIL (Canon[m].FinY<-20) or (Canon[m].Finy>220) or (Canon[m].Finx<-20) or (Canon[m].Finx>340);
         Inc(k);
        end;
     3 : m:=100;
   END;
 END;
Until m=100;
If Aliens[u].NdTime=100 then Aliens[u].NdTime:=0;
END;

PROCEDURE ALTIR;
CONST Puis_Tir : ARRAY[11..13] of Byte = (1,2,4);
BEGIN
  m:=0;Letsgo:=false;
  REPEAT
  Inc(m);
   If (not Canon[m].Exist) then
    CASE Aliens[u].Typ OF
     1 : BEGIN Canon[m].Exist:=True;Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+15;
           Canon[m].TirY:=Aliens[u].Ay+22;Canon[m].Depla:=2;
           Canon[m].Speed:=4;Canon[m].WhereSpr:=Aliens[u].TypMis;
           Canon[m].Puissance:=Puis_tir[Canon[m].WhereSpr];m:=100;
         END;
     2 : BEGIN Canon[m].Exist:=True;Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+15;
           Canon[m].TirY:=Aliens[u].Ay+22;Canon[m].Depla:=2;
           Canon[m].Speed:=4;Canon[m].WhereSpr:=Aliens[u].TypMis;
           Canon[m].Puissance:=Puis_tir[Canon[m].WhereSpr];m:=100;
         END;
     3 : BEGIN Canon[m].Exist:=True;Canon[m].Typ:=2;
           Canon[m].TirY:=Aliens[u].Ay+12;Canon[m].Depla:=2;
           Canon[m].Speed:=7;Canon[m].WhereSpr:=Aliens[u].TypMis;
           Canon[m].Puissance:=Puis_tir[Canon[m].WhereSpr];
           If (not letsgo) then BEGIN Canon[m].TirX:=Aliens[u].Ax+1;Letsgo:=True;END
           ELSE BEGIN Canon[m].TirX:=Aliens[u].Ax+21;m:=100; END;
         END;
     4 : BEGIN Canon[m].Exist:=True;Canon[m].Typ:=2;
           Canon[m].TirY:=Aliens[u].Ay+12;Canon[m].Depla:=2;
           Canon[m].Speed:=5;Canon[m].WhereSpr:=Aliens[u].TypMis;
           Canon[m].Puissance:=Puis_tir[Canon[m].WhereSpr];
           If (not letsgo) then BEGIN Canon[m].TirX:=Aliens[u].Ax+1;Letsgo:=True;END
           ELSE BEGIN Canon[m].TirX:=Aliens[u].Ax+42;m:=100; END;
         END;
     6 : BEGIN Canon[m].Exist:=True;Canon[m].Typ:=2;Canon[m].TirX:=Aliens[u].Ax+15;
          Canon[m].TirY:=Aliens[u].Ay+22;Canon[m].Depla:=2;
          Canon[m].Speed:=10;Canon[m].WhereSpr:=Aliens[u].TypMis;
          Canon[m].Puissance:=Puis_tir[Canon[m].WhereSpr];m:=100; END;
    END;
  UNTIL m=100;
END;

BEGIN
   For u:=1 to 50 do If Aliens[u].typ<>0 then
     BEGIN
      { Test de vie }
      If Aliens[u].Live<=0 then
         If (abs(Aliens[u].Typ)<>999) then Aliens[u].typ:=0
         Else If Aliens[u].Typ=999 then begin Aliens[u].Typ:=-999;Aliens[u].PlusEnd:=0; end;

      { D‚placement }
      CASE Aliens[u].Depla OF

        {  Depla 1 : ³ }
        1 : BEGIN Inc(Aliens[u].ay,Aliens[u].Spd);If Aliens[u].ay>220 then Aliens[u].Typ:=0;
                  Inc(Aliens[u].trajet,Aliens[u].Spd); END;

        { Depla 2 : ³
                     \
                      ³   }
        2 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>80) and (Aliens[u].Trajet<140) then
                 BEGIN
                  Inc(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;
        { Depla 3 :   ³
                     /
                    ³    }
        3 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>80) and (Aliens[u].Trajet<140) then
                 BEGIN
                  Dec(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;

         { Depla 4 :    ³
                         \
                        /  }
        4 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>70) and (Aliens[u].Trajet<120) then
                 BEGIN
                  Inc(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
               Else IF (Aliens[u].Trajet>119) and (Aliens[u].Trajet<160) then
                 BEGIN
                  Dec(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;
        { Depla 5 :    ³
                      /
                       \   }
        5 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>70) and (Aliens[u].Trajet<120) then
                 BEGIN
                  Dec(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
               Else IF (Aliens[u].Trajet>119) and (Aliens[u].Trajet<160) then
                 BEGIN
                  Inc(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;
        { Depla 6 : \ }
        6 : BEGIN Inc(Aliens[u].ay,Aliens[u].Spd);If Aliens[u].ay>220 then Aliens[u].Typ:=0;
            Inc(Aliens[u].Ax,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;

        { Depla 7 : / }
        7 : BEGIN Inc(Aliens[u].ay,Aliens[u].Spd);If Aliens[u].ay>220 then Aliens[u].Typ:=0;
            Dec(Aliens[u].Ax,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
        { Depla 8 :    ³
                     ³\³
                     ³            }
        8 : BEGIN If (Aliens[u].Ay<70) and (Aliens[u].Plus=0) then
                  BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].Trajet,Aliens[u].Spd); END
                  Else If Aliens[u].Plus=2 then BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].Trajet,Aliens[u].Spd); END
                  Else BEGIN Dec(Aliens[u].Ay,Aliens[u].Spd shr 1);Dec(Aliens[u].Trajet,Aliens[u].Spd shr 1);
                    Dec(Aliens[u].Ax,Aliens[u].Spd);Aliens[u].Plus:=1; END;
                  If (ALiens[u].Ay<=10) and (Aliens[u].Plus=1) then Aliens[u].Plus:=2;
            END;
        { Depla 9 : ³
                     \
                       \  }
        9 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>70) then
                 BEGIN
                  Inc(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd-1);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;
        { Depla 10 :   ³
                     /
                   /     }
        10 : BEGIN
              If Aliens[u].ay>220 then Aliens[u].Typ:=0;
              IF (Aliens[u].Trajet>70) then
                 BEGIN
                  Dec(Aliens[u].Ax,Aliens[u].Spd);
                  Inc(Aliens[u].Ay,Aliens[u].Spd-1);Inc(Aliens[u].trajet,Aliens[u].Spd);
                 END
              Else BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].trajet,Aliens[u].Spd); END;
            END;
        { Depla 11:  ³
                     ³/³
                       ³          }
        11 : BEGIN If (Aliens[u].Ay<70) and (Aliens[u].Plus=0) then
                  BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].Trajet,Aliens[u].Spd); END
                  Else If Aliens[u].Plus=2 then BEGIN Inc(Aliens[u].Ay,Aliens[u].Spd);Inc(Aliens[u].Trajet,Aliens[u].Spd); END
                  Else BEGIN Dec(Aliens[u].Ay,Aliens[u].Spd shr 1);Dec(Aliens[u].Trajet,Aliens[u].Spd shr 1);
                    Inc(Aliens[u].Ax,Aliens[u].Spd);Aliens[u].Plus:=1; END;
                  If (ALiens[u].Ay<=10) and (Aliens[u].Plus=1) then Aliens[u].Plus:=2;
                  If Aliens[u].ay>220 then Aliens[u].Typ:=0;
            END;

        { Depla 99 : T‚l‚comand‚  }
        99 : BEGIN
               IF Aliens[u].ay<0 then inc(Aliens[u].Ay,Aliens[u].Spd)
               Else TELELINE(Aliens[u].Ax,Aliens[u].Ay,Aliens[u].FinX,Aliens[u].FinY,Aliens[u].Spd);
               Aliens[u].Trajet:=Aliens[u].Ay;
               If Aliens[u].ay>220 then Aliens[u].Typ:=0;
               If ALiens[u].ay<-60 then Aliens[u].Typ:=0;
               If ALiens[u].ax<-20 then Aliens[u].Typ:=0;
               If Aliens[u].ax>340 then Aliens[u].Typ:=0;
             END;
       999 : BEGIN
                If Aliens[u].Ay=40 then Aliens[u].Plus:=1;
                If (Aliens[u].Ax=40) and (Aliens[u].Ay=40) then Aliens[u].Plus:=2;
                If (Aliens[u].Ax<10) and (Aliens[u].Ay<20) then Aliens[u].Plus:=3;
                If (Aliens[u].Ax<30) and (Aliens[u].Ay=0) then Aliens[u].Plus:=4;
                If (Aliens[u].Ax=190) and (Aliens[u].Ay=0) then Aliens[u].Plus:=5;
                If (Aliens[u].Ax>190) and (Aliens[u].Ay>20) then Aliens[u].Plus:=6;
                If (Aliens[u].Ax>=190) and (Aliens[u].Ay=40) then Aliens[u].Plus:=1;
                Case Aliens[u].Plus OF
                  0 : Inc(Aliens[u].Ay,Aliens[u].Spd);
                  1 : Dec(Aliens[u].Ax,Aliens[u].Spd);
                  2 : Begin Dec(Aliens[u].Ay,Aliens[u].Spd shr 1);Dec(Aliens[u].Ax,Aliens[u].Spd shr 1); END;
                  3 : Begin Dec(Aliens[u].Ay,Aliens[u].Spd shr 1);Inc(Aliens[u].Ax,Aliens[u].Spd shr 1); END;
                  4 : Inc(Aliens[u].Ax,Aliens[u].Spd);
                  5 : Begin Inc(Aliens[u].Ay,Aliens[u].Spd shr 1);Inc(Aliens[u].Ax,Aliens[u].Spd shr 1); END;
                  6 : Begin Inc(Aliens[u].Ay,Aliens[u].Spd shr 1);Dec(Aliens[u].Ax,Aliens[u].Spd shr 1); END;
                End;
                {Inc(Aliens[u].trajet,Aliens[u].Spd);}   { Trajet non utilis‚ ? }
                If Aliens[u].ay>280 then Aliens[u].Typ:=0;
             END;
     END;
     { R‚acteur + Ombre }
     If DX4 then
      Case Aliens[u].Typ OF
       1,2: BEGIN FeuAlien(Aliens[u].ax,Aliens[u].ay,35,21,13,18);ShadAl(Aliens[u].ax,Aliens[u].ay,0,0,34,26); END;
       3  : BEGIN FeuAlien(Aliens[u].ax,Aliens[u].ay,25,21,11,11);ShadAl(Aliens[u].ax,Aliens[u].ay,34,0,26,27); END;
       4  : BEGIN FeuAlien(Aliens[u].ax,Aliens[u].ay,44,21,15,26);ShadAl(Aliens[u].ax,Aliens[u].ay,60,0,44,24); END;
       5  : ShadAl(Aliens[u].ax,Aliens[u].ay,10,187,17,13);
       6  : BEGIN FeuAlien(Aliens[u].ax,Aliens[u].ay,22,25,9,9);ShadAl(Aliens[u].ax,Aliens[u].ay,104,0,22,25); END;
  999,-999 : BEGIN Feuboss(Aliens[u].ax,Aliens[u].ay,116,80,24,6,78,6,37,3,66,3,51,0);
                  ShadAl(Aliens[u].Ax,Aliens[u].Ay,214,0,106,80); END;
      End;
     { Affichage }
     CASE  Aliens[u].Typ OF
       1,2 : PutSprite(Fpage,Aliens[u].ax,Aliens[u].ay,Sprite[2]);
       3   : PutSprite(Fpage,Aliens[u].ax,Aliens[u].ay,Sprite[3]);
       4   : PutSprite(Fpage,Aliens[u].ax,Aliens[u].ay,Sprite[4]);
       5   : BEGIN { 3 sprite de mines : ds l'ordre =  1 2 3 2 1 2 3 2 1 ...}
              Inc(Aliens[u].Where,Aliens[u].Plus);If (Aliens[u].Where=11) or (Aliens[u].Where=0) then
              If Aliens[u].Plus=1 then Aliens[u].Plus:=-1 Else Aliens[u].Plus:=1;
              PutSprite(Fpage,Aliens[u].ax,Aliens[u].ay,Sprite[5+(Aliens[u].Where shr 2)]);
             END;
       6   : PutSprite(Fpage,Aliens[u].ax,Aliens[u].ay,Sprite[8]);
   999,-999   : BEGIN PutSprite(Fpage,Aliens[u].Ax,Aliens[u].Ay,Sprite[10]);
             Inc(Aliens[u].NdTime); END;
     END;

     { Tir }
     If Aliens[u].Typ<>999 then For n:=1 to 10 do If AlienTypTir[Aliens[u].Typ,n]=Aliens[u].Trajet then AlTir;
     If ALiens[u].Typ=999 then BossTir;
    END;
END;

PROCEDURE TIRFIRE;
VAR c1 : BYTE;
BEGIN
   Letsgo:=False;
   For u:=1 to 100 do If Canon[u].Exist then
    BEGIN
       { Trajectoire }
       CASE Canon[u].Depla Of
         1 : Dec(Canon[u].TirY,Canon[u].Speed);                { YOU       }
         2 : Inc(Canon[u].TirY,Canon[u].Speed);                { ALIEN     }
         3 : begin Inc(Canon[u].TirY,Canon[u].Speed);          { ALIEN     }
             Dec(Canon[u].TirX,Canon[u].Speed); end;
         4 : begin Inc(Canon[u].TirY,Canon[u].Speed);          { ALIEN     }
             Inc(Canon[u].TirX,Canon[u].Speed); end;
         5 : TELELINE(Canon[u].TirX,Canon[u].TirY,Canon[u].FinX,Canon[u].FinY,Canon[u].Speed);   { Mis t‚l‚  }
       End;

       { Test de d‚bordement }
       If (Canon[u].TirY<1) or (Canon[u].TirY>198)         { -2 ? }
       or (Canon[u].TirX<1) or (Canon[u].TirX>318)
        Then BEGIN Canon[u].Exist:=False; END;

       { Test de colisions }
       Letsgo:=False;
       If Canon[u].Exist then
        BEGIN
         C1:=0;
         For m:=1 to (Canon[u].Speed-1) do
          BEGIN
             READPIXEL(Canon[u].TirX,Canon[u].TirY+m);
             If CoulRead>63 then c1:=Coulread;
          END;
          If ((C1>95) and (C1<207)) then     { Skiller + Destroyer + Falcon  ... + Mines }
            BEGIN
             Canon[u].Exist:=False;v:=0;
             REPEAT
             Inc(v);
             CASE Aliens[v].Typ OF
              1,2 : If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+33>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+25>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);v:=50;Letsgo:=True;END;
              3 : If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+26>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+27>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);v:=50;Letsgo:=True;END;
              4 : If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+44>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+24>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);v:=50;Letsgo:=True;END;
              5 : If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+17>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+13>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);v:=50;Letsgo:=True;END;
              6 : If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+17>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+13>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);v:=50;Letsgo:=True;END;
            999 : If Canon[u].Depla<>5 then
                  If (Aliens[v].Ax<Canon[u].Tirx) and (Aliens[v].Ax+106>Canon[u].TirX)
                  and (Aliens[v].AY<Canon[u].TirY+12) and (Aliens[v].Ay+80>Canon[u].TirY)
                  Then BEGIN Dec(Aliens[v].Live,1);Letsgo:=True;v:=50; END;
              END;
             UNTIL v=50;
            END;

          { Explosion }
          If Canon[u].Depla<>5 then { Pour que le boss ne se tire pas dessus }
          If Letsgo then
           BEGIN
             v:=0;
             REPEAT
              Inc(v);
               If (not BoomB[v].Exist) then
                BEGIN
                 Boomb[v].Exist:=True;
                 If Random(2)=0 then Boomb[v].Typ:=2 Else Boomb[v].Typ:=3;
                 Boomb[v].Sprite:=0;
                 Boomb[v].BoomX:=Canon[u].TirX;
                 Boomb[v].BoomY:=Canon[u].TirY+m-5;   { "-5" Style ? }
                 v:=50;
                END;
            UNTIL v=50;

           END;

       { Vaisseau touch‚ }
          IF (Canon[u].Typ<>1) and (CoulRead>=64) and (CoulRead<=92) then
            BEGIN
              Canon[u].Exist:=False;
              Dec(Live,Canon[u].Puissance);
              { Explosion }
                 v:=0;
                 REPEAT
                  Inc(v);
                   If (not BoomB[v].Exist) then
                    BEGIN
                     Boomb[v].Exist:=True;
                     Boomb[v].Typ:=4;
                     Boomb[v].Sprite:=0;
                     Boomb[v].BoomX:=Canon[u].TirX;
                     Boomb[v].BoomY:=Canon[u].TirY+m;
                     v:=50;
                    END;
                UNTIL v=50;
            END;
        END;
       { Affichage }
       If Canon[u].Exist then
       Case Canon[u].Typ OF
         1 : BEGIN  { H‚ro     }
              Putpixel(Canon[u].TirX,Canon[u].TirY,254);
              Putpixel(Canon[u].TirX+Canon[u].plus,Canon[u].TirY+1,253);
             END;
         2 : BEGIN  { Ennemis }
               PutSprite(Fpage,Canon[u].TirX,Canon[u].TirY,Sprite[Canon[u].WhereSpr]);
             END;
         3 : BEGIN  { Boss }
               PutSprite(Fpage,Canon[u].TirX,Canon[u].TirY,Sprite[Canon[u].WhereSpr]);
             END;
       END;
    END;
END;

PROCEDURE IAMTIR;
BEGIN
For i:=1 to 2 do
 BEGIN
  u:=0;
  REPEAT
    Inc(u);
    If Canon[u].Exist=False then
     BEGIN
       Canon[u].Exist:=True;
       if (i=1) then Canon[u].TirX:=Xp1+25-Random(2)
       Else Canon[u].TirX:=Xp1+29+Random(2);
       Canon[u].TirY:=Yp1+15;
       Canon[u].Depla:=1;
       Canon[u].Typ:=1;
       Canon[u].Speed:=15;
       Canon[u].Plus:=Random(3)-1;
       u:=100;
     END;
  UNTIL (u=100);
 END;
END;

PROCEDURE TESTBOOM;
CONST  Colis : ARRAY[0..27] Of BYTE =
   (28,7,23,10,34,10,24,18,33,18,21,23,35,23,
    13,25,45,25,29,31,22,31,35,31,11,31,47,31);
BEGIN
 For u:=0 to 13 do
  BEGIN
    READPIXEL(Xp1+Colis[u shl 1],Yp1+Colis[(u shl 1)+1]);
    If (CoulRead>95) and (CoulRead<207) then
     BEGIN
        { Explosions }
        v:=0;
        REPEAT
         Inc(v);
          If (not BoomB[v].Exist) then
           BEGIN
            Boomb[v].Exist:=True;
            Boomb[v].Typ:=1;Boomb[v].Sprite:=0;
            Boomb[v].BoomX:=Xp1+Colis[u shl 1]-15;
            Boomb[v].BoomY:=Yp1+Colis[(u shl 1)+1]-15;
            v:=50;
           END;
        UNTIL v=50;

       { Bousille l'alien }
       v:=0;
       REPEAT
         Inc(v);
         CASE Aliens[v].Typ OF
          1,2 : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+33>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+25>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
          3  : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+26>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+27>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
          4  : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+44>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+24>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
          5  : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+17>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+13>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
          6  : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+22>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+25>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
        999  : If (Aliens[v].Ax<Xp1+Colis[u shl 1]) and (Aliens[v].Ax+106>Xp1+Colis[u shl 1])
              and (Aliens[v].AY<Yp1+Colis[(u shl 1)+1]) and (Aliens[v].Ay+80>Yp1+Colis[(u shl 1)+1])
              Then BEGIN Aliens[v].Live:=0;Dec(Live,Aliens[v].Bobo);v:=50;END;
          END;
       UNTIL v=50;
     END;
  END;
END;

PROCEDURE BOUMBOUM;
BEGIN
 If BossEnd<>0 then
  Begin
    v:=0;
    Repeat
     Inc(v);
     Case Aliens[v].Typ Of
       -999 : BEGIN
            { Explosions }
            u:=0;
            Inc(Aliens[v].PlusEnd);
            If ALiens[v].PlusEnd>=60 then Begin Aliens[v].PlusEnd:=0;Aliens[v].Typ:=0;NivEnd1:=True; END;
            REPEAT
             Inc(u);
              If (not BoomB[u].Exist) then
               BEGIN
                Boomb[u].Exist:=True;
                Boomb[u].Typ:=5;Boomb[u].Sprite:=0;
                Repeat
                 Boomb[u].BoomX:=Aliens[v].Ax+Random(107);
                 Boomb[u].BoomY:=Aliens[v].Ay+Random(81);
                 ReadPixel(Boomb[u].BoomX,Boomb[u].BoomY);
                until (CoulRead>95) and (CoulRead<207);
                u:=50;
               END;
            UNTIL u=50;
            END;
     End;
    until v=50;
  End;

  If NivEnd3 then    { Vaisseau d‚truit }
  Begin
    u:=0;
    Inc(Lose);
    If Lose >=60 then NivEnd4:=True;
    REPEAT
     Inc(u);
      If (not BoomB[u].Exist) then
       BEGIN
        Boomb[u].Exist:=True;
        Boomb[u].Typ:=4+Random(2);
        Boomb[u].Sprite:=0;
        Repeat
         Boomb[u].BoomX:=Xp1+Random(54);
         Boomb[u].BoomY:=Yp1+Random(35);
         ReadPixel(Boomb[u].BoomX,Boomb[u].BoomY);
        until (CoulRead>63) and (CoulRead<95);
        u:=50;
       END;
    UNTIL u=50;
  End;
  For v:=1 to 50 do If Boomb[v].Exist then
    BEGIN
     CASE Boomb[v].Typ OF
      1 : BEGIN
           PutSprite(Fpage,Boomb[v].BoomX,Boomb[v].BoomY,Sprite[30+Boomb[v].Sprite]);
           If Boomb[v].Sprite=11 then Boomb[v].Exist:=False;
          END;
      2 : BEGIN
           PutSprite(Fpage,Boomb[v].BoomX,Boomb[v].BoomY,Sprite[41+Boomb[v].Sprite]);
           If Boomb[v].Sprite=9 then Boomb[v].Exist:=False;
          END;
      3 : BEGIN
           PutSprite(Fpage,Boomb[v].BoomX,Boomb[v].BoomY,Sprite[50+Boomb[v].Sprite]);
           If Boomb[v].Sprite=9 then Boomb[v].Exist:=False;
          END;
      4 : BEGIN
           PutSprite(Fpage,Boomb[v].BoomX,Boomb[v].BoomY,Sprite[59+Boomb[v].Sprite]);
           If Boomb[v].Sprite=16 then Boomb[v].Exist:=False;
          END;
      5 : BEGIN
           PutSprite(Fpage,Boomb[v].BoomX,Boomb[v].BoomY,Sprite[75+Boomb[v].Sprite]);
           If Boomb[v].Sprite=30 then Boomb[v].Exist:=False;
          END;
     END;
    Inc(Boomb[v].Sprite,1);
    END;
END;

PROCEDURE BARLIVE;
BEGIN
  If Invulnerable then Live:=100;
  if Live<=0 then NivEnd3:=True;
  For i:=(Live-1) downto 1 do
   BEGIN
     PutPixel(4,(200-(i shl 1)),223-(i div 7));
     PutPixel(5,(200-(i shl 1)),223-(i div 7));
     PutPixel(6,(200-(i shl 1)),223-(i div 7));
     PutPixel(7,(200-(i shl 1)),223-(i div 7));
   END;
END;

PROCEDURE FILM;
Var Images : Byte;
    x,y : Word;
BEGIN
 Decompact('BhFilm1.ima',11);
 Decompact('BhFilm2.ima',12);
 SetPal('BhFilm.cod',0);
 { Taille = 80*50 }
 Images:=0;x:=0;y:=0;
 REPEAT
  FillChar(Spr^,64000,0);
  For j:=0 to 49 do
   Begin
    If Images<16 then
     Begin
      y:=Images shr 2;
      x:=Images-(y*4);
      MOVE(Player1^[320*(y*50+j)+(x*80)],Spr^[320*(j+75)+120],80);
     End
    Else
     Begin
      y:=(Images-16) shr 2;
      x:=(Images-16)-(y*4);
      MOVE(Player2^[320*(y*50+j)+(x*80)],Spr^[320*(j+75)+120],80);
     End
   End;
  For i:=0 to (SpeedSync shr 3) do Synchro;
  MOVE(Spr^,Screen,64000);
  Inc(Images);
 UNTIL Images=32;  { Nombre d'images du film }
END;

VAR TRY : LONGINT;

BEGIN
  ASM
   MOV AX,13h
   INT 10h
  END;
  Film;
  InitModX;
  ReadAnm('N1Plain.flx',19);
  Decompact('Sil1p_2.ima',3);
  Decompact('N1Alien.ima',1);
  Decompact('N1Dec.ima',2);
  SetPal('Niv1.cod',0);
  SetPal('Niv1b.cod',1);
  GetSprite(0,33,25,Sprite[2],2);                 { Ennemi : Skiller         }
  GetSprite(34,26,26,Sprite[3],2);                { Ennemi : Destroyer       }
  GetSprite(60,44,23,Sprite[4],2);                { Ennemi : Falcon          }
  GetSprite(104,22,25,Sprite[8],2);               { Ennemi : Bomber          }
  GetSprite(59850,17,13,Sprite[5],2);             {                          }
  GetSprite(59867,17,13,Sprite[6],2);             {       Mines              }
  GetSprite(59884,17,13,Sprite[7],2);             {                          }
  For u:=0 to 10 do GetSprite(29*u,29,29,Sprite[30+u],3);     { Explosions  Vais vs Vais   / typ 1 }
  For u:=0 to 8 do GetSprite(9280+16*u,16,17,Sprite[41+u],3); { Explosions  Mitraille bleu / typ 2 }
  For u:=0 to 8 do GetSprite(175+9280+16*u,16,17,Sprite[50+u],3); { Explosions  Mitraille red  / typ 3 }
  For u:=0 to 15 do GetSprite(14720+20*u,20,16,Sprite[59+u],3); { Explosions  bombe vs vais  / typ 4 }
  For u:=0 to 9 do GetSprite(19840+30*u,30,26,Sprite[75+u],3);
  For u:=0 to 9 do GetSprite(28160+30*u,30,26,Sprite[85+u],3);  { Explosions  boss + vai              }
  For u:=0 to 9 do GetSprite(36480+30*u,30,26,Sprite[95+u],3);
  GetSprite(214,106,79,Sprite[10],2);             { Sprite du Boss           }
  GetSprite(62720,4,4,Sprite[11],2);              { Tir : Boule bleu         }
  GetSprite(62725,4,4,Sprite[12],2);              { Tir : Boule rouge        }
  GetSprite(61181,4,9,Sprite[13],2);              { Tir : Boule fusion       }
  GetSprite(56386,11,24,Sprite[14],2);            { Tir : Big Missile        }
  GetSprite(58638,6,17,Sprite[15],2);             { Tir : Bombe              }
  For i:=1 to 50 do Aliens[i].typ:=0;
  For i:=1 to 100 do Canon[i].Exist:=False;
  For i:=1 to 50 do Boomb[i].Exist:=False;
  Xp1:=130;Yp1:=155;Live:=100;
  Gv:=0;Dv:=0;Hv:=0;Bv:=0;SprP1:=6;
  Fpage:=16000;Sprite[1].Deb:=0;NivEnd1:=False;NivEnd2:=False;NivEnd3:=False;Lose:=0;
  Defil:=0;Sens1p:=False;NdFond:=3;Letsgo:=False;TotalLignes:=1;Try:=0;BossEnd:=0;
  NivEnd4:=False;
  REPEAT
    IF d and alt then If not DX2 then DX2:=True Else If (Dx2) and not Dx4 then
    Dx4:=True Else If Dx2 and Dx4 then BEGIN Dx2:=False;Dx4:=False; END;
    If Inv and alt then If not Invulnerable then Invulnerable:=True Else Invulnerable:=False;
    IF Fpage=0 then Fpage:=16000 Else Fpage:=0;
    TestClav;
    If not Sens1p then
    BEGIN COPYSCREEN(Fpage,64000-Defil,Defil);
    COPYSCREEN(Fpage+Defil,32000,16000-Defil); END
    ELSE BEGIN COPYSCREEN(Fpage,48000-Defil,Defil);
    COPYSCREEN(Fpage+Defil,48000,16000-Defil); END;
    TestClav;
    VaisGo;
    PutSprP1;
    TestClav;
    If not nivend1 then TestIfAlien;
    If not nivend1 then WriteAlien;
    TestClav;
    TestBoom;
    If Fire then Iamtir;
    If not nivend1 then TirFire;
    TestClav;
    BoumBoum;
    BarLive;
    ShowPage(Fpage);
    For i:=0 to (SpeedSync shr 3) do Synchro;
    TestClav;
    If Totallignes<>3600 then BEGIN Inc(Defil,80);Inc(TotalLignes); END;
    If Defil>16000 then
      BEGIN
       Defil:=0;
       If Sens1p then BEGIN Sens1p:=False;Xms_Ram(NdFond,64000,Spr);MEM2MX(48000,16000);Inc(Ndfond); END
       Else BEGIN Sens1p:=True;Xms_Ram(NdFond,64000,Spr);MEM2MX(32000,16000);Inc(Ndfond); END;
      END;
  UNTIL (PORT[$60]=1) or (NivEnd4) or (NivEnd2);
  Fade_out;
  ExitFinal:=True;
END;

PROCEDURE JEU_1_JOUEUR(S : Integer);
BEGIN   { Principal }
ASM
 IN AL,21h
 OR AL,2
 OUT 21h,AL
END;
SpeedSync:=S shl 1;
Randomize;ExitFinal:=False;
For i:=1 to 360 do Sinus[i]:=Trunc(Round(Sin(i*Pi/180)*1024));
For i:=1 to 360 do Cosinus[i]:=Trunc(Round(Cos(i*Pi/180)*1024));
Xms_init;
For i:=1 to 20 do Get_XMS(i,64);
New(Player1);New(Player2);
New(Decors);New(Spr);
ASM
 MOV Clef,010100101b  { D‚finit la clef }
END;
REPEAT
   AllFalse;
  Game1Player;
UNTIL EXITFINAL;
Dispose(Spr);Dispose(Decors);
Dispose(Player2);Dispose(Player1);
For i:=1 to 20 do Dispose_xms(i);
END;

BEGIN
END.
