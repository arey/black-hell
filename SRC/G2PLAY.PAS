{unité du jeu black hell à 2 joueurs }
UNIT G2PLAY;
INTERFACE
USES DOS,CRT;

CONST LEFT   = 75;     LEFT2   = 30;
      RIGHT  = 77;     RIGHT2  = 31;
      UP     = 72;     UP2     = 17;
      DOWN   = 80;     DOWN2   = 44;
      TIR    = 28;     TIR2    = 57;
      Tmoins = 74;
      Tplus  = 78;


TYPE VirtualPtr=^Virtual;
     Virtual=ARRAY[0..63999] of BYTE;

VAR Player : ARRAY[1..2] of VirtualPtr;
    Sp,Decors : VirtualPtr;
    Screen  : Virtual ABSOLUTE $A000:0;
    Palette : ARRAY[0..767] of BYTE;
    i,j,u,v : INTEGER;
    f : TEXT;
    l : LONGINT;
    Ch,Ch2,Tr1,Tr2 : CHAR;
    Sens,Droite,Gauche,Haut,Bas,Espace,Esc,Enter,Decomp,Colis,ExitFinal : BOOLEAN;
    Touch,Speed,Images,vit,Choix : BYTE;
    Compt,total :  WORD;
    Tout : STRING;
    Pl1,Pl2 : BYTE;
    ColExpl : ARRAY[0..3] OF WORD; { Existe,cX,cY,Sprite }
    Clef : Byte;
    VAR Sinus,Cosinus : ARRAY[1..360] of LONGINT;
    SpeedSync : Integer;


CONST Destcol : ARRAY[0..15,0..15] of BYTE =
   ((29,0,39,19,47,30,37,31,30,35,24,31,13,30,21,19),
    (40,2,45,21,42,33,32,33,30,35,28,29,20,17,24,17),
    (50,8,39,25,35,38,27,35,19,34,17,27,13,19,26,16),
    (54,15,37,29,29,39,20,34,14,30,15,23,16,14,29,17),
    (54,24,34,32,22,36,16,31,12,26,16,19,22,13,36,20),
    (52,34,27,33,15,35,12,27,12,21,18,16,17,2,35,21),
    (44,41,25,33,8,30,12,22,14,16,23,15,31,10,35,24),
    (36,45,20,31,9,25,14,17,10,13,27,13,37,14,35,28),
    (24,46,16,26,7,15,17,14,24,10,31,14,41,14,32,27),
    (13,43,15,25,13,14,22,12,30,10,36,16,42,21,29,29),
    (5,37,15,21,19,6,27,11,36,13,37,19,43,26,26,29),
    (1,30,15,18,27,5,33,9,40,16,39,23,38,30,23,29),
    (0,19,18,15,35,7,38,15,42,21,37,26,35,34,19,26),
    (2,12,25,12,40,11,41,18,42,25,35,29,32,36,18,19),
    (9,5,29,12,47,16,43,23,40,30,33,32,23,35,18,20),
    (18,1,33,13,48,22,40,28,37,33,28,31,18,30,20,19));

CONST FalCol  : ARRAY[0..15,0..15] of BYTE =
   ((31,9,33,17,58,29,48,35,32,38,13,35,2,29,25,26),
    (42,9,39,17,57,36,45,38,29,36,13,27,6,18,27,23),
    (51,12,45,19,53,41,41,40,23,31,16,20,13,9,33,20),
    (59,18,47,23,46,46,36,41,25,26,22,13,25,4,19,36),
    (63,26,51,27,38,48,31,39,27,23,31,10,38,2,41,20),
    (62,33,50,31,30,47,28,36,30,20,40,10,51,4,46,23),
    (59,42,49,36,23,44,27,32,36,19,51,12,62,11,49,27),
    (54,48,45,38,18,38,25,29,41,20,57,58,75,21,50,30),
    (45,51,41,41,15,32,26,25,22,41,62,25,72,32,49,34),
    (32,52,36,41,16,25,30,23,49,26,62,34,68,42,46,38),
    (22,49,30,41,21,19,33,21,47,27,58,41,60,51,42,40),
    (16,45,25,38,27,15,38,21,49,34,51,47,49,57,37,49),
    (11,37,23,33,35,13,42,21,47,38,42,51,35,59,32,40),
    (11,26,22,29,43,14,46,24,42,40,32,51,22,56,28,38),
    (12,19,23,24,51,17,47,28,37,41,24,47,11,49,25,34),
    (19,13,27,20,55,23,49,31,32,41,17,42,4,40,24,30));

CONST SkilCol : ARRAY[0..15,0..15] of BYTE =
   ((34,0,40,15,52,15,48,26,34,30,20,27,15,15,29,8),
    (49,2,48,19,58,21,45,31,34,30,24,24,24,10,38,9),
    (61,8,53,22,60,28,48,34,35,29,28,18,34,7,50,10),
    (69,19,55,28,59,36,46,36,30,19,34,15,45,9,54,16),
    (73,27,56,34,54,42,39,37,36,28,40,18,54,14,62,23),
    (71,41,51,40,48,48,36,38,37,28,44,21,52,15,53,31),
    (65,50,47,44,39,50,33,37,38,29,47,24,64,29,61,42),
    (53,58,39,46,30,49,29,36,31,30,50,28,63,38,53,46),
    (41,60,31,45,22,45,26,34,39,31,34,52,56,45,44,51),
    (23,58,24,41,15,40,24,31,38,31,49,38,48,50,34,52),
    (12,54,21,39,13,33,27,27,38,32,44,42,38,53,24,50),
    (3,44,17,33,14,25,28,24,37,32,38,43,27,52,15,5),
    (0,31,17,27,18,19,32,23,36,32,33,42,19,46,10,37),
    (1,20,22,21,25,13,22,36,35,32,26,41,11,40,9,28),
    (7,12,26,17,34,10,40,23,34,32,23,37,8,32,12,20),
    (18,4,36,16,43,12,42,26,31,33,20,32,9,23,19,14));

CONST DestClip : ARRAY[1..4,0..15] of BYTE =
   ((14,11,11,12,13,10,7,6,8,13,6,1,0,3,10,18),
    (46,41,49,54,54,51,44,36,40,43,43,42,41,44,48,49),
    (0,3,8,15,12,9,9,10,11,9,6,5,7,11,5,1),
    (34,37,40,40,39,35,40,45,45,43,37,30,34,36,36,35));

CONST FalClip : ARRAY[1..4,0..15] of BYTE =
   ((0,1,7,17,25,22,16,13,14,14,18,14,10,9,8,2),
    (60,59,56,59,64,64,65,71,73,73,67,56,48,51,57,60),
    (8,7,7,2,0,1,6,14,21,18,13,11,11,12,15,12),
    (40,42,47,49,49,49,46,49,53,53,53,59,60,47,55,46));

CONST SkilClip : ARRAY[1..4,0..15] of BYTE =
   ((13,20,27,32,34,34,32,25,18,13,10,4,0,1,6,7),
    (54,60,62,69,73,71,66,65,60,52,45,40,38,38,41,47),
    (0,2,6,7,11,14,23,27,29,29,27,22,16,11,9,4),
    (32,32,34,39,45,50,52,57,66,59,55,54,50,44,38,34));

{ Variables réservées à l'XMS }
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

Procedure JEU_2_JOUEURS(s :Integer);

IMPLEMENTATION
PROCEDURE ERROR_EXIT(Num : BYTE);
BEGIN
 For i:=1 to 2 do Dispose(Player[i]);
 Dispose(Sp);Dispose(Decors);
 ASM
     XOR AL,AL
     OUT 21h,AL
     MOV AX,3
     INT 10h
 END;
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
             $80 : Xerror:=' Fonction appelée inconnue ';
             $81 : Xerror:=' Ram disk VDISK détecté ';
             $82 : Xerror:=' Erreur sur canal d''adresses A20 ';
             $8E : Xerror:=' Erreur pilote à caractère général ';
             $8F : Xerror:=' Erreur irratrapable ';
             $90 : Xerror:=' HMA introuvable ';
             $91 : Xerror:=' HMA déjà appelée ';
             $92 : Xerror:=' Taille HMA insuffisante ';
             $93 : Xerror:=' HMA non affectée ';
             $94 : Xerror:=' Canal d''adresses A20 encore actif ';
             $A0 : Xerror:=' Plus de mémoire étendue disponible ';
             $A1 : Xerror:=' Ts les identifs XMS sont pris ';
             $A2 : Xerror:=' Identificateur invalide ';
             $A3 : Xerror:=' Identificateur source invalide ';
             $A4 : Xerror:=' Décalage source invalide ';
             $A5 : Xerror:=' Identificateur destination invalide ';
             $A6 : Xerror:=' Décalage destination invalide ';
             $A7 : Xerror:=' Longueur invalide pour fonction Move ';
             $A8 : Xerror:=' Recouvrement interdit ';
             $A9 : Xerror:=' Erreur de parité ';
             $AA : Xerror:=' UMB n''est pas bloqué ';
             $AB : Xerror:=' UMB est encore bloqué ';
             $AC : Xerror:=' Débordement du compteur de blocage ';
             $AD : Xerror:=' L''UMB ne peut pas être bloqué ';
             $B0 : Xerror:=' Plus petit UMB disponible ';
             $B1 : Xerror:=' Plus d''UMB disponible ';
             $B2 : Xerror:=' L''adresse du segment UMB est invalide ';
   END;
   ERROR_EXIT(1);
 END;
END;
PROCEDURE XMS_INIT;
{ Vérifie que l'XMS est installée }
BEGIN
  XMSExists:=false;
  WITH Regs DO
   BEGIN
    AX:=$4300;
    Intr($2F,regs);
    if Regs.al = $80 then
     Begin
      { Copie l'adresse d'accès au pilote XMS }
      AX:=$4310;
      Intr($2F,regs);
      XMSDrv:=Ptr(ES,BX);
      XMSExists:=true;
      { Détermine la taille de mémoire étendue disponible }
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

PROCEDURE PutSprAt(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
    CASE Num OF
       1 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Player[1]^[(320*(y1+numlines)+x1)+c1] <>0 then
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Player[1]^[(320*(y1+numlines)+x1)+c1];
       2 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Player[2]^[(320*(y1+numlines)+x1)+c1] <>0 then
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Player[2]^[(320*(y1+numlines)+x1)+c1];
       3 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            If Decors^[(320*(y1+numlines)+x1)+c1] <>0 then
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Decors^[(320*(y1+numlines)+x1)+c1];
    END;
END;

PROCEDURE PutSprSt(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
    CASE Num OF
       1 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Player[1]^[(320*(y1+numlines)+x1)+c1];
       2 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Player[2]^[(320*(y1+numlines)+x1)+c1];
       3 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
            Sp^[((320*y1des+x1des)+numlines*320)+c1]:=Decors^[(320*(y1+numlines)+x1)+c1];
    END;
END;

TYPE VAIS=OBJECT
       Imat,Vit,Sprite,Pll                  : BYTE;
       Cx,Cy,Live                           : INTEGER;
       Droite,Gauche,Haut,Bas,Tir,Miss,Dead : BOOLEAN;
       AutoFire,Ntir,Invincible,Lost        : BOOLEAN;
       PuisTir,SpeedTir,App,Timer           : BYTE;
       Las : ARRAY[1..50,0..7] Of WORD;        { Feuer,LasX,LasY,Rotat,Vit,Spécial,Explosions,PuisTir }
       DbTir : ARRAY[1..50,0..7] OF WORD;
       OptVais : ARRAY[0..8] of BOOLEAN;
       Circle  : ARRAY[0..5] of INTEGER;
       PROCEDURE INIT(Vers,Pl : BYTE);
       PROCEDURE AFF;
       PROCEDURE FIRE;
       PROCEDURE KEYBTEST;
END;
VAR Play1,Play2 : VAIS;

VAR OptCase : ARRAY[0..7] Of INTEGER;
    Optchop : BOOLEAN;
    RotX,RotY : INTEGER;
    ScrY,ScrX : INTEGER;

PROCEDURE CIRCLEFIRE;
VAR AllBool : BYTE;
    Bool : BOOLEAN;

BEGIN
 AllBool:=0;
 If Play1.Circle[0]=1 then
 BEGIN
   Bool:=False;
   { Rotation autour des Z }
    RotX:=((Play1.Circle[1]*Cosinus[Play1.Circle[3]*23+1]) shr 10) - ((Play1.Circle[2]*Sinus[Play1.Circle[3]*23+1]) shr 10);
    RotY:=((Play1.Circle[1]*Sinus[Play1.Circle[3]*23+1]) shr 10 ) + ((Play1.Circle[2]*Cosinus[Play1.Circle[3]*23+1]) shr 10);

    ScrY:=(RotY shl 6) div 45;
    ScrX:=(RotX shl 6) div 45;
    ScrY:=Play1.Cy+ScrY+Play1.Circle[5];
    ScrX:=Play1.Cx+ScrX+Play1.Circle[4];
    If (ScrX>0) and (ScrX<314) and (ScrY>0) and (ScrY<149) then
    PutSprAt(10,122,14,126,ScrX+3,ScrY+3,3);
   i:=1;
   REPEAT
   IF Play1.Las[i,0]=1 then
      BEGIN
        Play1.Las[i,1]:=ScrX;Play1.Las[i,2]:=ScrY;
        Play1.Las[i,0]:=2;
        Play1.las[i,3]:=Play1.Circle[3];
        Play1.Las[i,5]:=1;Play1.Las[i,7]:=Play1.PuisTir;Play1.Las[i,4]:=Play1.SpeedTir;
        Bool:=True;
      END;
   Inc(i);
   UNTIL (i=50) or (Bool);
   Inc(Play1.Circle[3]);
   If Play1.Circle[3]>=16 then Play1.Circle[3]:=0;
 END;
 AllBool:=0;
 If Play2.Circle[0]=1 then
 BEGIN
   Bool:=False;
   { Rotation autour des Z }
    RotX:=((Play2.Circle[1]*Cosinus[Play2.Circle[3]*23+1]) shr 10) - ((Play2.Circle[2]*Sinus[Play2.Circle[3]*23+1]) shr 10);
    RotY:=((Play2.Circle[1]*Sinus[Play2.Circle[3]*23+1]) shr 10 ) + ((Play2.Circle[2]*Cosinus[Play2.Circle[3]*23+1]) shr 10);

    ScrY:=(RotY shl 6) div 45;
    ScrX:=(RotX shl 6) div 45;
    ScrY:=Play2.Cy+ScrY+Play2.Circle[5];
    ScrX:=Play2.Cx+ScrX+Play2.Circle[4];
    If (ScrX>0) and (ScrX<314) and (ScrY>0) and (ScrY<149) then
    PutSprAt(10,122,14,126,ScrX+3,ScrY+3,3);
    i:=1;
   REPEAT
   IF Play2.Las[i,0]=1 then
      BEGIN
        Play2.Las[i,1]:=ScrX;Play2.Las[i,2]:=ScrY;
        Play2.Las[i,0]:=2;
        Play2.las[i,3]:=Play2.Circle[3];
        Play2.Las[i,5]:=1;Play2.Las[i,7]:=Play2.PuisTir;Play2.Las[i,4]:=Play2.SpeedTir;
        Bool:=True;
      END;
   Inc(i);
   UNTIL (i=50) or (Bool);
   Inc(Play2.Circle[3]);
   If Play2.Circle[3]>=16 then Play2.Circle[3]:=0;
 END;
END;

PROCEDURE OPCHOP1;
BEGIN
 If Play1.invincible then If MEM[$3E:$8D]-Play1.Timer >=2 then
   BEGIN Play1.Invincible:=False;Play1.optVais[7]:=False; END;
 optChop:=False;
 u:=Sp^[320*Optcase[2]+Optcase[1]];
 v:=Sp^[320*(Optcase[2]+13)+(Optcase[1]+8)];
 i:=Sp^[320*(Optcase[2]+13)+(Optcase[1])];
 j:=Sp^[320*(Optcase[2])+(Optcase[1]+8)];
 If ((u<>0) and (u<224)) or ((i<>0) and (i<224)) or ((j<>0) and (j<224))
 or ((v<>0) and (v<224)) then
   BEGIN
    OptCase[0]:=0;
    OptChop:=True;
    If Play1.optVais[OptCase[6]+1]=False then
     BEGIN
      Play1.OptVais[OptCase[6]+1]:=True;
      CASE OptCase[6]+1 OF
        2 : BEGIN INC(Play1.Vit,4);Inc(Play1.SpeedTir,4); END;  { Speed }
        3 : BEGIN                                                { Cercle de feu }
               Play1.Circle[0]:=1;Play1.Circle[1]:=0;Play1.Circle[2]:=-30;
               Play1.Circle[3]:=0;
               If Play1.imat=2 then BEGIN Play1.Circle[4]:=27;Play1.Circle[5]:=23; END
               ELSE BEGIN Play1.Circle[4]:=37;Play1.Circle[5]:=31; END
            END;
        4 : Inc(Play1.PuisTir);               { Double la puissance du Tir }
        5 : Play1.Autofire:=True;             { Autofire                   }
        6 : Dec(Play2.Live,Random(25));       { Bombe éclair               }
        7 : BEGIN Play1.Invincible:=True;     { invincibilité              }
            Play1.Timer:=MEM[$3E:$8D]; END;
        8 : Play1.Live:=100;                  { Trousse de soins           }
      END;
     END;
   END;
END;

PROCEDURE OPCHOP2;
BEGIN
 If Play2.invincible then If MEM[$3E:$8D]-Play2.Timer >=2 then
  BEGIN Play2.Invincible:=False;Play2.OptVais[7]:=False; END;
 u:=Sp^[320*Optcase[2]+Optcase[1]];
 v:=Sp^[320*(Optcase[2]+13)+(Optcase[1]+8)];
 i:=Sp^[320*(Optcase[2]+13)+(Optcase[1])];
 j:=Sp^[320*(Optcase[2])+(Optcase[1]+8)];
 If (((u<>0) and (u<224)) or ((i<>0) and (i<224)) or ((j<>0) and (j<224))
 or ((v<>0) and (v<224))) and not OptChop then
   BEGIN
    OptCase[0]:=0;
    If Play2.optVais[OptCase[6]+1]=False then
     BEGIN
      Play2.OptVais[OptCase[6]+1]:=True;
      CASE OptCase[6]+1 OF
        2 : BEGIN INC(Play2.Vit,4);INC(Play2.SpeedTir,4); END;
        3 : BEGIN                                                { Cercle de feu }
               Play2.Circle[0]:=1;Play2.Circle[1]:=0;Play2.Circle[2]:=-30;
               Play2.Circle[3]:=0;
               If Play2.imat=2 then BEGIN Play2.Circle[4]:=27;Play2.Circle[5]:=23; END
               ELSE BEGIN Play2.Circle[4]:=37;Play2.Circle[5]:=31; END
            END;
        4 : Inc(Play2.PuisTir);               { Double la puissance du Tir }
        5 : Play2.Autofire:=True;             { Autofire                   }
        6 : Dec(Play1.Live,Random(25));       { Bombe éclair               }
        7 : BEGIN Play2.Invincible:=True;     { Invincibilité              }
            Play2.Timer:=MEM[$3E:$8D]; END;
        8 : Play2.Live:=100;                  { Trousse de soins           }
      END;
     END;
   END;
END;

PROCEDURE OPTIONS_BAR;
VAR Ct : INTEGER;
    Op : BOOLEAN;

BEGIN
 If OptCase[7]<=0 then OptCase[0]:=0;
 Op:=False;
 If Random(50)=0 then If OptCase[0]=0 then op:=True;
 If Op then
   BEGIN
     OptCase[0]:=1;
      CASE Random(4) of
       0 : BEGIN OptCase[1]:=312;OptCase[2]:=Random(161);optCase[4]:=2; END;
       1 : BEGIN OptCase[1]:=0;OptCase[2]:=Random(161);optCase[4]:=0;   END;
       2 : BEGIN OptCase[1]:=Random(312);OptCase[2]:=161;OptCase[4]:=3; END;
       3 : BEGIN OptCase[1]:=Random(312);OptCase[2]:=0;OptCase[4]:=1;   END;
      END;
     OptCase[5]:=Random(6)+1;
     OptCase[6]:=Random(8);  { Options : DoubleTir,Speed,Boule,Puistir*2,Multi-Tir,MegaBombe,Invincible,Medikit }
     OptCase[7]:=2;
   END;
 If (optCase[0]=1) and ((OptCase[1]>312) or (OptCase[1]<0)
 or (OptCase[2]<0)  or (OptCase[2]>161)) then OptCase[0]:=0;
 If OptCase[0]=1 then
  BEGIN
    CASE OptCase[4] OF
     0 : Inc(OptCase[1],OptCase[5]);
     1 : Inc(OptCase[2],OptCase[5]);
     2 : Dec(OptCase[1],OptCase[5]);
     3 : Dec(OptCase[2],OptCase[5]);
    END;
     PutSprAt(0+(OptCase[6]*9),153,6+(OptCase[6]*9),165,OptCase[1],OptCase[2],3);
  END;
END;

PROCEDURE VAIS.FIRE;
VAR u,v : BYTE;
    Touche,Touche2 : BOOLEAN;
BEGIN
 { Collisions }
  For i:=1 to 50 do If (Las[i,0]=2) and (Las[i,5]=1) then
   BEGIN
   Touche:=False;Touche2:=False;
   for u:=1 to 4 do for v:=1 to 4 do If (Sp^[320*(Las[i,2]+u)+(Las[i,1])+v]<224) and (Sp^[320*(Las[i,2]+u)+(Las[i,1])+v]<>0)
     then Touche:=True;
   for u:=1 to 4 do for v:=1 to 4 do If (Sp^[320*(Las[i,2]+u)+(Las[i,1])+v]<=234) and (Sp^[320*(Las[i,2]+u)+(Las[i,1])+v]>=216)
     then Touche2:=True;
   If Touche2 then Dec(OptCase[7]);
   If (touche) or (touche2) then BEGIN
      Las[i,0]:=3;Las[i,6]:=1;
      If (not touche2) then BEGIN If (Pll=1) and (not Play2.invincible) then Dec(Play2.Live,Las[i,7])
      ELSE IF not Play1.invincible then Dec(Play1.Live,Las[i,7]);END;
   END;
   END;
 For i:=1 to 50 do If (Las[i,6]<>0) and (Las[i,0]=3) then
   BEGIN
     PutSprAt(298,1+((Las[i,6]-1)*12),313,11+((Las[i,6]-1)*12),Las[i,1],Las[i,2],3);
     Inc(Las[i,6]);
     If Las[i,6]=6 then BEGIN Las[i,6]:=0;las[i,0]:=1; END;
   END;

 For i:=1 to 50 do If (Dbtir[i,0]=2) and (Dbtir[i,5]=4) then
   BEGIN
   Touche:=False;Touche2:=False;
   for u:=1 to 4 do for v:=1 to 4 do If (Sp^[320*(Dbtir[i,2]+u)+(Dbtir[i,1])+v]<224)
   and (Sp^[320*(Dbtir[i,2]+u)+(Dbtir[i,1])+v]>0) then Touche:=True;
   for u:=1 to 4 do for v:=1 to 4 do If (Sp^[320*(Dbtir[i,2]+u)+(Dbtir[i,1])+v]<=234)
   and (Sp^[320*(Dbtir[i,2]+u)+(Dbtir[i,1])+v]>=216) then Touche2:=True;
   If Touche2 then Dec(OptCase[7]);
   If (touche) or (touche2) then BEGIN
      Dbtir[i,0]:=3;Dbtir[i,6]:=1;
      If not touche2 then BEGIN If (Pll=1) and (Not Play2.Invincible) then Dec(Play2.Live,Dbtir[i,7])
      ELSE IF (Not Play1.Invincible) then Dec(Play1.Live,Dbtir[i,7]);END;
   END;
   END;

 For i:=1 to 50 do If (Dbtir[i,6]<>0) and (Dbtir[i,0]=3) then
   BEGIN
     PutSprAt(298,1+((Dbtir[i,6]-1)*12),313,11+((Dbtir[i,6]-1)*12),Dbtir[i,1],Dbtir[i,2],3);
     Inc(Dbtir[i,6]);
     If Dbtir[i,6]=6 then BEGIN Dbtir[i,6]:=0;Dbtir[i,0]:=1; END;
   END;

 For i:=1 to 50 do BEGIN
  If Las[i,5]=0 then Las[i,5]:=1;
  IF (Las[i,0]=2) then BEGIN
    CASE Las[i,3] OF
     0 : Dec(Las[i,2],Las[i,4]+(Las[i,4] Shr 1));
     1 : BEGIN Dec(Las[i,2],Las[i,4]+(Las[i,4] Shr 1));Inc(Las[i,1],Las[i,4]-(Las[i,4] Shr 3));END;
     2 : BEGIN Dec(Las[i,2],Las[i,4]);Inc(Las[i,1],Las[i,4]); END;
     3 : BEGIN Dec(Las[i,2],Las[i,4]-2);Inc(Las[i,1],Las[i,4]+(Las[i,4] Shr 1)); END;
     4 : Inc(Las[i,1],Las[i,4]+(Las[i,4] Shr 1));
     5 : BEGIN Inc(Las[i,1],Las[i,4]+(Las[i,4] Shr 1));Inc(Las[i,2],Las[i,4]-(Las[i,4] Shr 3)); END;
     6 : BEGIN Inc(Las[i,1],Las[i,4]);Inc(Las[i,2],Las[i,4]); END;
     7 : BEGIN Inc(Las[i,1],Las[i,4]-2);Inc(Las[i,2],Las[i,4]+(Las[i,4] Shr 1)); END;
     8 : Inc(Las[i,2],Las[i,4]+(Las[i,4] Shr 1));
     9 : BEGIN Inc(Las[i,2],Las[i,4]+(Las[i,4] Shr 1));Dec(Las[i,1],Las[i,4]-(Las[i,4] Shr 3)); END;
     10: BEGIN Inc(Las[i,2],Las[i,4]);Dec(Las[i,1],Las[i,4]); END;
     11: BEGIN Inc(Las[i,2],Las[i,4]-2);Dec(Las[i,1],Las[i,4]+(Las[i,4] Shr 1)); END;
     12: Dec(Las[i,1],Las[i,4]+(Las[i,4] Shr 1));
     13: BEGIN Dec(Las[i,1],Las[i,4]+(Las[i,4] Shr 1));Dec(Las[i,2],Las[i,4]-(Las[i,4] Shr 3)); END;
     14: BEGIN Dec(Las[i,1],Las[i,4]);Dec(Las[i,2],Las[i,4]); END;
     15: BEGIN Dec(Las[i,1],Las[i,4]-2);Dec(Las[i,2],Las[i,4]+(Las[i,4] Shr 1)); END;
    END;
    IF (Las[i,1]<=2) or (Las[i,1]>=317) or (Las[i,2]<=2) or (Las[i,2]>=197) then Las[i,0]:=1
    ELSE PutSprAt(0,122,3,125,Las[i,1],Las[i,2],3);
  END;
  END;
  For i:=1 to 50 do BEGIN
  If DbTir[i,5]=3 then DbTir[i,5]:=4;
  If DbTir[i,5]=2 then DbTir[i,5]:=3;
  If DbTir[i,5]=1 then DbTir[i,5]:=2;
  If DbTir[i,5]=0 then DbTir[i,5]:=1;
  IF (DbTir[i,0]=2) then BEGIN
    CASE DbTir[i,3] OF
     0 : Dec(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1));
     1 : BEGIN Dec(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1));Inc(DbTir[i,1],DbTir[i,4]-(DbTir[i,4] Shr 3));END;
     2 : BEGIN Dec(DbTir[i,2],DbTir[i,4]);Inc(DbTir[i,1],DbTir[i,4]); END;
     3 : BEGIN Dec(DbTir[i,2],DbTir[i,4]-2);Inc(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1)); END;
     4 : Inc(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1));
     5 : BEGIN Inc(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1));Inc(DbTir[i,2],DbTir[i,4]-(DbTir[i,4] Shr 3)); END;
     6 : BEGIN Inc(DbTir[i,1],DbTir[i,4]);Inc(DbTir[i,2],DbTir[i,4]); END;
     7 : BEGIN Inc(DbTir[i,1],DbTir[i,4]-2);Inc(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1)); END;
     8 : Inc(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1));
     9 : BEGIN Inc(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1));Dec(DbTir[i,1],DbTir[i,4]-(DbTir[i,4] Shr 3)); END;
     10: BEGIN Inc(DbTir[i,2],DbTir[i,4]);Dec(DbTir[i,1],DbTir[i,4]); END;
     11: BEGIN Inc(DbTir[i,2],DbTir[i,4]-2);Dec(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1)); END;
     12: Dec(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1));
     13: BEGIN Dec(DbTir[i,1],DbTir[i,4]+(DbTir[i,4] Shr 1));Dec(DbTir[i,2],DbTir[i,4]-(DbTir[i,4] Shr 3)); END;
     14: BEGIN Dec(DbTir[i,1],DbTir[i,4]);Dec(DbTir[i,2],DbTir[i,4]); END;
     15: BEGIN Dec(DbTir[i,1],DbTir[i,4]-2);Dec(DbTir[i,2],DbTir[i,4]+(DbTir[i,4] Shr 1)); END;
    END;
    IF (DbTir[i,1]<=2) or (DbTir[i,1]>=317) or (DbTir[i,2]<=2) or (DbTir[i,2]>=197) then DbTir[i,0]:=1
    ELSE PutSprAt(5,122,8,125,DbTir[i,1],DbTir[i,2],3);
   END;
 END;
END;

PROCEDURE VAIS.INIT(Vers,Pl : BYTE);
BEGIN
   Lost:=False;
   Invincible:=False;
   Ntir:=False;
   App:=6;
   AutoFire:=False;
   SpeedTir:=8;
   Dead:=False;
   Live:=100;
   PuisTir:=1;
   Pll:=Pl;
   Droite:=False;
   Gauche:=False;
   Haut:=False;
   Bas:=False;
   Tir:=False;
   Miss:=False;
   Vit:=4;
   Sprite:=0;
   Imat:=Vers;
   For i:=1 to 8 do OptVais[i]:=False;
   OptVais[0]:=True;
   CASE Pll OF
       1 : BEGIN Cx:=20;Cy:=100; END;
       2 : BEGIN Cx:=150;Cy:=100; END;
   END;
   For i:=1 to 50 do BEGIN Las[i,0]:=1;Las[i,4]:=SpeedTir;Las[i,1]:=0;Las[i,2]:=0;Las[i,6]:=0;END;
   For i:=1 to 50 do BEGIN DbTir[i,0]:=1;DbTir[i,4]:=SpeedTir;DbTir[i,1]:=0;DbTir[i,2]:=0;DbTir[i,6]:=0;END;
   Circle[0]:=0;
END;

PROCEDURE VAIS.AFF;
VAR PlusX,PlusY,SpL,Nx,Imag : WORD;
BEGIN
   CASE Imat OF
      2 : BEGIN PlusX:=55;PlusY:=46;SpL:=5;Imag:=Pll;  { Destroyer }
                 CASE Sprite OF
                    0..4 : Nx:=Sprite*PlusX;
                    5..9 : Nx:=(Sprite-5)*PlusX ;
                    10..14 : Nx:=(Sprite-10)*PlusX;
                    15 : Nx :=(Sprite-15)*PlusX;
                 END;
          END;
      1 : BEGIN PlusX:=74;PlusY:=61;SpL:=4;Imag:=Pll;  { Skiller   }
                 CASE Sprite OF
                    0..3   : Nx:=Sprite*PlusX;
                    4..7   : Nx:=(Sprite-4)*PlusX ;
                    8..11  : Nx:=(Sprite-8)*PlusX;
                    12..15 : BEGIN Nx:=(Sprite-12)*PlusX;Imag:=3; END;
                 END;

          END;
      3 : BEGIN PlusX:=74;PlusY:=61;SpL:=4;Imag:=Pll;  { Falcon    }
                 CASE Sprite OF
                    0..3   : Nx:=Sprite*PlusX;
                    4..7   : Nx:=(Sprite-4)*PlusX ;
                    8..11  : Nx:=(Sprite-8)*PlusX;
                    12..15 : BEGIN Nx:=(Sprite-12)*PlusX;Imag:=3; END;
                 END;
          END;
   END;
   If (Imag=3) and (Imat=1) then PutSprAt(Nx,0,Nx+PlusX-2,PlusY-2,Cx,Cy,Imag)
   ELSE If (Imag=3) and (Imat=3) then PutSprAt(Nx,PlusY,Nx+PlusX-2,PlusY*2-2,Cx,Cy,Imag)
   ELSE PutSprAt(Nx,PlusY*(sprite div Spl),Nx+PlusX-2,PlusY*(Sprite div Spl)+PlusY-2,Cx,Cy,Imag);

   If Pll=2 then
   If ColExpl[0]=1 then
     BEGIN
       CASE ColExpl[3] Of
        1 : PutSprAt(297,68,318,91,ColExpl[1]-12,ColExpl[2]-12,3);
        2 : PutSprAt(297,92,318,115,ColExpl[1]-12,ColExpl[2]-12,3);
      3,4 : PutSprAt(297,116,318,138,ColExpl[1]-12,ColExpl[2]-12,3);
        5 : PutSprAt(297,139,318,161,ColExpl[1]-12,ColExpl[2]-12,3);
       END;
       Inc(ColExpl[3]);
       If(ColExpl[3]=6) then BEGIN ColExpl[0]:=0;ColExpl[3]:=1; END;
     END;
END;

PROCEDURE VAIS.KEYBTEST;
VAR Sortie  : BOOLEAN;
    Cx2,Cy2 : INTEGER;
    Sprite2 : BYTE;

PROCEDURE COLISIONS;
VAR Plx,Ply : INTEGER;
    v,u     : BYTE;
BEGIN
  If (Colis) and (pll=1) Then
    BEGIN
       Colis:=False;
       CASE Sprite OF
          0 : Inc(Cy2,Vit+(Vit Shr 1));
          1 : BEGIN Inc(Cy2,(Vit+(Vit shr 1)) Shl 2);Dec(Cx2,(Vit-(Vit shr 3)) Shl 2);END;
          2 : BEGIN Inc(Cy2,Vit Shl 2);Dec(Cx2,Vit Shl 2); END;
          3 : BEGIN Inc(Cy2,(Vit-2) Shl 2);Dec(Cx2,(Vit+(Vit shr 1)) Shl 2); END;
          4 : Dec(Cx2,(Vit+(Vit shr 1))Shl 2);
          5 : BEGIN Dec(Cx2,(Vit+(Vit shr 1)) Shl 2);Dec(Cy2,(Vit-(Vit shr 3)) Shl 2); END;
          6 : BEGIN Dec(Cx2,Vit Shl 2);Dec(Cy2,Vit Shl 2); END;
          7 : BEGIN Dec(Cx2,(Vit-2) Shl 2);Dec(Cy2,(Vit+(Vit shr 3)) Shl 2); END;
          8 : Dec(Cy2,(Vit+(Vit shr 1)) Shl 2);
          9 : BEGIN Dec(Cy2,(Vit+(Vit shr 1))Shl 2);Inc(Cx2,(Vit-(Vit shr 1)) Shl 2); END;
          10: BEGIN Dec(Cy2,Vit Shl 2);Inc(Cx2,Vit Shl 2); END;
          11: BEGIN Dec(Cy2,(Vit-2) Shl 2);Inc(Cx2,(Vit+(Vit shr 1)) Shl 2); END;
          12: Inc(Cx2,(Vit+(Vit shr 1)) Shl 2);
          13: BEGIN Inc(Cx2,(Vit+(Vit shr 1)) Shl 2);Inc(Cy2,(Vit-(Vit shr 3)) Shl 2); END;
          14: BEGIN Inc(Cx2,Vit Shl 2);Inc(Cy2,Vit Shl 2); END;
          15: BEGIN Inc(Cx2,(Vit-2) Shl 2);Inc(Cy2,(Vit+(Vit shr 1)) Shl 2); END;
       END;
    IF Not Play1.Invincible then Dec(Play1.Live,Random(10));
    If Not Play2.Invincible then Dec(Play2.Live,Random(10));
    Cx:=Cx2;Cy:=Cy2;Sprite:=Sprite2;
    END
  ELSE BEGIN
  For i:=1 to 8 do BEGIN
   CASE Imat Of
   1 : If pll=2 then
    BEGIN
     Ply:=Cy2+SkilCol[Sprite2,(i shl 1)+1];
     Plx:=Cx2+SkilCol[Sprite2,(i shl 1)];
    END;
   2 : If pll=2 then
    BEGIN
     Ply:=Cy2+DestCol[Sprite2,(i shl 1)+1];
     Plx:=Cx2+DestCol[Sprite2,(i shl 1)];
    END;
   3 : If pll=2 then
    BEGIN
     Ply:=Cy2+FalCol[Sprite2,(i shl 1)+1];
     Plx:=Cx2+FalCol[Sprite2,(i shl 1)];
    END;
   END;
   If (ply>=0) and (Ply<=174) and (Plx>=0) and (Plx<=319) then
   If (Sp^[320*Ply+Plx]<224) and (Sp^[320*Ply+Plx]>0) then
     BEGIN
      Colis:=True;
      { Boom ! }
      If (ColExpl[0]=0) then
       BEGIN
        ColExpl[0]:=1;ColExpl[1]:=PlX;
        ColExpl[2]:=PlY;ColExpl[3]:=1;
      END;
     END;
   END;
  END;
END;

BEGIN
{ AutoFire }
  IF Ntir then
   BEGIN
    Inc(App);
    If App>=6 then BEGIN Tir:=True;App:=0; END
    ELSE Tir:=False;
   END;

Cx2:=Cx;Cy2:=Cy;Sprite2:=Sprite;Sortie:=False;
If Gauche then BEGIN If Sprite2=0 then Sprite2:=15 Else Dec(Sprite2); END;
If Droite then BEGIN If Sprite2=15 then Sprite2:=0 Else Inc(Sprite2); END;
If Haut then
      BEGIN
        CASE Sprite2 Of
          0 : Dec(Cy2,Vit+(Vit shr 1));
          1 : BEGIN Dec(Cy2,Vit+(Vit shr 1));Inc(Cx2,Vit-(Vit shr 3));END;
          2 : BEGIN Dec(Cy2,Vit);Inc(Cx2,Vit); END;
          3 : BEGIN Dec(Cy2,Vit-2);Inc(Cx2,Vit+(Vit shr 1)); END;
          4 : Inc(Cx2,Vit+(Vit shr 1));
          5 : BEGIN Inc(Cx2,Vit+(Vit shr 1));Inc(Cy2,Vit-(Vit shr 3)); END;
          6 : BEGIN Inc(Cx2,Vit);Inc(Cy2,Vit); END;
          7 : BEGIN Inc(Cx2,Vit-2);Inc(Cy2,Vit+(Vit shr 1)); END;
          8 : Inc(Cy2,Vit+(Vit shr 1));
          9 : BEGIN Inc(Cy2,Vit+(Vit shr 1));Dec(Cx2,Vit-(Vit shr 3)); END;
          10: BEGIN Inc(Cy2,Vit);Dec(Cx2,Vit); END;
          11: BEGIN Inc(Cy2,Vit-2);Dec(Cx2,Vit+(Vit shr 1)); END;
          12: Dec(Cx2,Vit+(Vit shr 1));
          13: BEGIN Dec(Cx2,Vit+(Vit shr 1));Dec(Cy2,Vit-(Vit shr 3)); END;
          14: BEGIN Dec(Cx2,Vit);Dec(Cy2,Vit); END;
          15: BEGIN Dec(Cx2,Vit-2);Dec(Cy2,Vit+(Vit shr 1)); END;
        END;
      END;
 Colisions;
 If Sortie then EXIT;
 Cx:=Cx2;Cy:=Cy2;Sprite:=Sprite2;

 { Spécial Clipping }
 CASE Imat OF
   2 : BEGIN
          IF (Cy+DestClip[3,Sprite]<=0) then Cy:=-DestClip[3,Sprite]
          ELSE If (Cy+DestClip[4,Sprite]>=174) then Cy:=174-DestClip[4,Sprite];
          IF (Cx+Destclip[1,Sprite]<=0) then Cx:=-DestClip[1,Sprite]
          ELSE If (Cx+DestClip[2,Sprite]>=319) then Cx:=319-DestClip[2,Sprite];
       END;
   3 : BEGIN
          IF (Cy+FalClip[3,Sprite]<=0) then Cy:=-FalClip[3,Sprite]
          ELSE If (Cy+FalClip[4,Sprite]>=174) then Cy:=174-FalClip[4,Sprite];
          IF (Cx+FalClip[1,Sprite]<=0) then Cx:=0-FalClip[1,Sprite]
          ELSE If (Cx+FalClip[2,Sprite]>=319) then Cx:=319-FalClip[2,Sprite];
       END;
   1 : BEGIN
          IF (Cy+SkilClip[3,Sprite]<=0) then Cy:=-SkilClip[3,Sprite]
          ELSE If (Cy+SkilClip[4,Sprite]>=174) then Cy:=174-SkilClip[4,Sprite];
          IF (Cx+SkilClip[1,Sprite]<=0) then Cx:=-SkilClip[1,Sprite]
          ELSE If (Cx+SkilClip[2,Sprite]>=319) then Cx:=319-SkilClip[2,Sprite];
       END;
 END;

  { Double Tir }
  i:=1;j:=0;
  IF (Tir) AND (OptVais[1]) then
   BEGIN
     REPEAT
     If DbTir[i,0]=1 Then
      BEGIN
        CASE Imat OF
           2 : BEGIN DbTir[i,1]:=Cx+DestCol[Sprite,4];DbTir[i,2]:=Cy+DestCol[Sprite,5];
               DbTir[i+1,1]:=Cx+DestCol[Sprite,12];DbTir[i+1,2]:=Cy+DestCol[Sprite,13];END;
           1 : BEGIN DbTir[i,1]:=Cx+SkilCol[Sprite,4];DbTir[i,2]:=Cy+SkilCol[Sprite,5];
               DbTir[i+1,1]:=Cx+SkilCol[Sprite,12];DbTir[i+1,2]:=Cy+SkilCol[Sprite,13];END;
           3 : BEGIN DbTir[i,1]:=Cx+FalCol[Sprite,4]-2;DbTir[i,2]:=Cy+FalCol[Sprite,5]-2;
               DbTir[i+1,1]:=Cx+FalCol[Sprite,12]-2;DbTir[i+1,2]:=Cy+FalCol[Sprite,13]-2;END;
        END;
      DbTir[i,0]:=2;DbTir[i,3]:=Sprite;DbTir[i,5]:=0;DbTir[i,7]:=PuisTir;DbTir[i,4]:=SpeedTir;
      DbTir[i+1,0]:=2;DbTir[i+1,3]:=Sprite;DbTir[i+1,5]:=0;DbTir[i+1,7]:=PuisTir;DbTir[i+1,4]:=SpeedTir;
      j:=2;
      END;
     Inc(i,2);
     UNTIL (j=2) or (i>=51);
   END;

  { Simple Tir }
  IF Tir then FOR i:=1 to 50 do
     IF Las[i,0]=1 then
      BEGIN
          CASE Imat OF
            2 : BEGIN Las[i,1]:=Cx+DestCol[Sprite,0];Las[i,2]:=Cy+DestCol[Sprite,1]; END;
            1 : BEGIN Las[i,1]:=Cx+SkilCol[Sprite,0];Las[i,2]:=Cy+SkilCol[Sprite,1]; END;
            3 : BEGIN Las[i,1]:=Cx+FalCol[Sprite,0]-2;Las[i,2]:=Cy+FalCol[Sprite,1]-2; END;
          END;
          Las[i,0]:=2;Las[i,3]:=Sprite;Las[i,5]:=0;Las[i,7]:=PuisTir;Las[i,4]:=SpeedTir;
          EXIT;
      END;
END;

PROCEDURE LIFEBAR;
BEGIN
  If Play1.live<=0 then BEGIN Play1.dead:=True;Play1.Lost:=True; END;
  If Play2.live<=0 then BEGIN Play2.dead:=True;Play2.Lost:=True; END;
  PutSprSt(0,176,319,199,0,176,3);
  For i:=1 to 5 do FILLCHAR(Sp^[320*(180+i)+34],Play1.Live,247);
  For i:=1 to 5 do FILLCHAR(Sp^[320*(180+i)+195],Play2.Live+1,247);

  For i:=0 To 8 do If Play1.OptVais[i] then PutSprSt(0+(i*9),168,6+(i*9),174,54+(i*9),190,3);
  For i:=0 To 8 do If Play2.OptVais[i] then PutSprSt(0+(i*9),168,6+(i*9),174,216+(i*9),190,3);
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
END;

VAR j1b1,j1b2 : BYTE;
    joyX,JoyY : WORD;

PROCEDURE JOYBOUTCOOR;ASSEMBLER;
ASM
  MOV AH,84h
  MOV DX,1
  INT 15h
  MOV JoyX,AX
  MOV JoyY,BX
END;

PROCEDURE JOYKEYB;
BEGIN
 CASE JoyX OF
       5,4 : Play2.Gauche:=True;
   152,153 : Play2.Droite:=True;
        78 : BEGIN Play2.Gauche:=False;Play2.Droite:=False; END;
 END;
 CASE JoyY OF
         4 : Play2.Haut:=True;
   166,168 : Play2.Bas:=True;
        85 : BEGIN Play2.Haut:=False;Play2.Bas:=False; END;
 END;
END;

PROCEDURE WRITEPAL;
VAR Regs : REGISTERS;
BEGIN
    With regs do BEGIN
       ah:=$10;
       al:=18;
       bx:=0;
       cx:=256;
       es:=seg(palette);
       dx:=ofs(palette);
       intr($10,regs);
    END;
END;

PROCEDURE SETPAL(s:STRING);
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
BEGIN
 DecodPal(s,Palette);
 WritePal;
END;

PROCEDURE DECOMPACT(Ne:String;Num:Word);
VAR Nb : WORD;
    Color    : BYTE;
BEGIN
    Total:=0;
    Assign(f,ne);
    Reset(f);
    REPEAT
      Read(f,Ch);
      Read(f,ch2);
      Nb:=Ord(ch);
      Color:=Ord(ch2);
      i:=0;
      REPEAT
        CASE Num OF
           0 : Sp^[Total+i]:=Color;
           1 : Player[1]^[Total+i]:=Color;
           2 : Player[2]^[Total+i]:=Color;
           3 : Decors^[Total+i]:=color;
        END;
        if nb>i then inc(i);
      UNTIL (i=nb);
    Inc(Total,nb);
    UNTIL Total>=64000;
    Close(f);
end;

PROCEDURE Synchro;ASSEMBLER;
LABEL Attend_VBL;
LABEL Attend_fin_HBL;
ASM
  mov DX,$3DA
  Attend_VBL:
  IN AL,DX
  AND AL,8
  jz Attend_VBL
  Mov DX,$3DA
  Attend_fin_HBL:
  IN AL,DX
  AND AL,1
  jnz Attend_fin_HBL
END;

PROCEDURE CADRE(xc,yc,xcf,ycf : WORD;Coul : BYTE);
VAR Long,Ha : WORD;
BEGIN
FOR Long:=1 to (xcf-xc) do Sp^[(320*yc+xc+Long)]:=Coul;
FOR Long:=1 to (xcf-xc) do Sp^[(320*ycf+xc+Long)]:=Coul;
For ha:=1 to (ycf-yc)+1 do Sp^[(320*(yc+ha-1)+xc)]:=Coul;
For ha:=1 to (ycf-yc) do Sp^[(320*(yc+ha)+xcf)]:=Coul;
END;

PROCEDURE KEYBREAD;
PROCEDURE KEYBREAD2;
BEGIN
Touch:=PORT[$60];
 CASE Touch OF
   LEFT       : Play1.Gauche:=True;
   LEFT2      : Play2.Gauche:=True;
   RIGHT      : Play1.Droite:=True;
   RIGHT2     : Play2.Droite:=True;
   UP         : Play1.Haut:=True;
   UP2        : Play2.Haut:=True;
   UP+128     : Play1.Haut:=False;
   LEFT+128   : Play1.Gauche:=False;
   RIGHT+128  : Play1.Droite:=False;
   RIGHT2+128 : Play2.Droite:=False;
   LEFT2+128  : Play2.Gauche:=False;
   UP2+128    : Play2.Haut:=False;
   TIR        : BEGIN If play1.AutoFire then Play1.tir:=True ELSE Play1.Ntir:=True; END;
   TIR+128    : BEGIN Play1.Tir:=False;Play1.App:=6;Play1.Ntir:=False END;
   TIR2       : BEGIN If play2.AutoFire then Play2.tir:=True ELSE Play2.Ntir:=True; END;
   TIR2+128   : BEGIN Play2.Tir:=False;Play2.App:=6;Play2.Ntir:=False END;
   28         : Enter:=True;
   156        : Enter:=False;
   Tmoins     : Inc(SpeedSync);
   Tplus      : Dec(SpeedSync);
 END;
 If SpeedSync<0 then SpeedSync:=0;
 if SpeedSync>560 then SpeedSync:=560;
END;
BEGIN
KeybRead2;
{JoyBoutCoor;
JoyKeyb;}
Touch:=PORT[$60];
 CASE Touch OF
     1 : Esc:=True;
   157 : BEGIN delay(10);REPEAT KEYBREAD2 UNTIL (PORT[$60]=157);Delay(100); END;
 END;
END;

PROCEDURE PresFich;
VAR Exist : BOOLEAN;
VAR hel : FILE OF BYTE;
BEGIN
   Exist:=True;
   Assign(hel,'Ibh11.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>13740) then Exist:=False;
   Assign(hel,'Ibh12.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>16524) then Exist:=False;
   Assign(hel,'Ibh21.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>14134) then Exist:=False;
   Assign(hel,'Ibh22.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>25082) then Exist:=False;
   Assign(hel,'Ibh31.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>11866) then Exist:=False;
   Assign(hel,'Ibh32.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>16968) then Exist:=False;
   Assign(hel,'Skiller.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>13668) then Exist:=False;
   Assign(hel,'Destroy.ima');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>15396) then Exist:=False;
   Assign(hel,'Game.cod');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>768) then Exist:=False;
   Assign(hel,'hell.cod');Reset(hel);
   IF (IOResult<>0) or (FileSize(hel)<>768) then Exist:=False;
   If not exist then BEGIN Close(hel);Error_exit(2); END;
   Close(hel);
END;

PROCEDURE INIT2PLAYER;
VAR j1,j2,Images2 : BYTE;
    ib,jb         : INTEGER;
    End1,End2     : BOOLEAN;

PROCEDURE PP(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
  CASE Num OF
  1 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
  Decors^[((320*y1des+x1des)+numlines*320)+c1]:=Player[1]^[(320*(y1+numlines)+x1)+c1];
  2 : For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
  Decors^[((320*y1des+x1des)+numlines*320)+c1]:=Player[2]^[(320*(y1+numlines)+x1)+c1];
  END;
END;

PROCEDURE JV1;
BEGIN
  CASE j1 OF
   1 : Xms_Ram(3,64000,Player[1]);
   2 : Xms_Ram(5,64000,Player[1]);
   3 : Xms_Ram(1,64000,Player[1]);
  END;
END;

PROCEDURE JV1_2;
BEGIN
  CASE j1 OF
   1 : Xms_Ram(4,64000,Player[1]);
   2 : Xms_Ram(6,64000,Player[1]);
   3 : Xms_Ram(2,64000,Player[1]);
  END;
END;

PROCEDURE JV2;
BEGIN
  CASE j2 OF
   1 : Xms_Ram(3,64000,Player[2]);
   2 : Xms_Ram(5,64000,Player[2]);
   3 : Xms_Ram(1,64000,Player[2]);
  END;
END;

PROCEDURE JV2_2;
BEGIN
  CASE j2 OF
   1 : Xms_Ram(4,64000,Player[2]);
   2 : Xms_Ram(6,64000,Player[2]);
   3 : Xms_Ram(2,64000,Player[2]);
  END;
END;

PROCEDURE TESTK;
BEGIN
Touch:=Port[$60];
  CASE touch OF
     Left   : If not End1 then BEGIN If (j1<>1) then Dec(j1);i:=0;j:=0;Images:=1;JV1; END;
     Right  : If not End1 then BEGIN If (j1<> 3) then Inc(j1);i:=0;j:=0;Images:=1;JV1; END;
     Left2  : If not End2 then BEGIN If (j2<> 1) then Dec(j2);ib:=0;jb:=0;Images2:=1;JV2; END;
     Right2 : If not End2 then BEGIN If (j2<> 3) then Inc(j2);ib:=0;jb:=0;Images2:=1;JV2; END;
     Tir    : BEGIN Pl1:=j1;End1:=True END;
     Tir2   : BEGIN Pl2:=j2;End2:=True END;
  END;
END;

BEGIN
Decompact('Hell2p.ima',3);Ram_Xms(Decors,64000,7);
Decompact('ibh11.ima',1);Ram_Xms(Player[1],64000,1);
Decompact('ibh12.ima',0);Ram_Xms(Sp,64000,2);
Decompact('ibh21.ima',2);Ram_Xms(Player[2],64000,3);
Decompact('ibh22.ima',0);Ram_Xms(Sp,64000,4);
Decompact('ibh31.ima',3);Ram_Xms(Decors,64000,5);
Decompact('ibh32.ima',0);Ram_Xms(Sp,64000,6);
SetPal('Hell.cod');
i:=0;j:=0;jb:=0;ib:=0;
Images:=1;Images2:=1;
J1:=1;J2:=2;End1:=False;End2:=False;
Xms_Ram(3,64000,Player[1]);
Xms_Ram(5,64000,Player[2]);
REPEAT
    Xms_ram(7,64000,Sp);
    CASE J1 OF
       1 : PutSprSt(i,j,i+48,j+48,42,105,1);
       2 : PutSprSt(i,j,i+48,j+48,134,105,1);
       3 : PutSprSt(i,j,i+48,j+48,226,105,1);
    END;
    CASE J2 OF
       1 : If j1<>1 then PutSprSt(ib,jb,ib+48,jb+48,42,105,2);
       2 : If j1<>2 then PutSprSt(ib,jb,ib+48,jb+48,134,105,2);
       3 : If j1<>3 then PutSprSt(ib,jb,ib+48,jb+48,226,105,2);
    END;
    Cadre(39+((j1-1)*92),102,94+((j1-1)*92),157,249);
    Cadre(38+((j2-1)*92),101,95+((j2-1)*92),158,255);

    MOVE(Sp^,Screen,64000);

    { joueur 1 }
    Inc(i,50);
    If i=6*50 then BEGIN i:=0;Inc(j,50); END;
    If (i=4*50) and (j=3*50) then BEGIN i:=0;j:=0;
    If images=1 then BEGIN JV1_2;Images:=2; END
    Else BEGIN JV1;Images:=1; END;END;

    { joueur 2 }
    Inc(ib,50);
    If ib=6*50 then BEGIN ib:=0;Inc(jb,50); END;
    If (ib=4*50) and (jb=3*50) then BEGIN ib:=0;jb:=0;
    If images2=1 then BEGIN JV2_2;Images2:=2; END
    Else BEGIN JV2;Images2:=1; END;END;

    TestK;
UNTIL (End1) and (End2);
END;


PROCEDURE JEU_2_JOUEURS( s : integer);
PROCEDURE WINNER;
PROCEDURE Sinusoide;
VAR Spirn : BYTE;
PROCEDURE Spiral(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR SpX,SpY : WORD;
    C1       : INTEGER;
BEGIN
  For SpY:=0 to (Y2-Y1) DO For SpX:=0 to (X2-X1) do
  If Decors^[320*(SpY+Y1)+(SpX+X1)]<>0 then
  Sp^[320*(SpY+y1des)+(SpX+x1des)+(Sinus[Spy shl 1+j] shr 5)+ (j shr 3)]:=Decors^[320*(SpY+Y1)+(SpX+X1)];
END;

BEGIN
  Decompact('Youwin.Ima',3);
  IF Play1.lost then
    CASE Play2.Imat OF
     1 : BEGIN Decompact('P2Skilw.Ima',1);SetPal('P1Skilw.cod');SpirN:=3; END;
     2 : BEGIN Decompact('P2Destw.Ima',1);SetPal('P1Destw.cod');SpirN:=2; END;
     3 : BEGIN Decompact('P2Falcw.Ima',1);SetPal('P1Falcw.cod');SpirN:=1; END;
    END
  ELSE CASE Play1.Imat OF
     1 : BEGIN Decompact('P1Skilw.Ima',1);SetPal('P1Skilw.cod');SpirN:=3; END;
     2 : BEGIN Decompact('P1Destw.Ima',1);SetPal('P1Destw.cod');SpirN:=2; END;
     3 : BEGIN Decompact('P1Falcw.Ima',1);SetPal('P1Falcw.cod');SpirN:=1; END;
    END;
  FILLCHAR(Screen,64000,0);
  j:=1;i:=5;
  DirectVideo:=False;
  REPEAT
    MOVE(Player[1]^,Sp^,64000);
    CASE SpirN OF
      1 :Spiral(0,0,152,29,84,160,3);
      2 :Spiral(0,30,152,59,84,160,3);
      3 :Spiral(0,60,152,89,84,160,3);
    END;
    For i:=0 to (SpeedSync shr 3) do Synchro;
    MOVE(Sp^,Screen,64000);
    Inc(j,I);if (j>=286) or (j<=1) then j:=1;
  UNTIL PORT[$60]=1;
END;

PROCEDURE PIXALISATION;
VAR  Long,demi : WORD;
     Coul : BYTE;
     impair : BYTE;

PROCEDURE CUB(x1,y1,x2,y2 : WORD;Cl : BYTE);
VAR Ct : WORD;
BEGIN
  For Ct:=y1 to (y2-1) do FILLCHAR(Sp^[320*Ct+x1],(x2-x1),cl);
END;

BEGIN
Long:=1;
MOVE(Sp^,Player[1]^,64000);
REPEAT
  j:=0;i:=0;
  Inc(Long,2);
  Impair:=0;
  Demi:=long div 2;
  REPEAT
     Coul:=Sp^[320*j+i];
     If (i-demi>=0) and (j-demi>=0) and (i+demi<=319) and (j+demi<=199)
     then CUB(i-demi,j-demi,i+demi,j+demi,Coul)
     ELSE BEGIN
     FILLCHAR(Sp^,demi*320,0);
     FILLCHAR(Sp^[320*(200-demi)],demi*320,0);
     CUB(0,0,demi+1,199,0);
     CUB(319-demi,0,320,199,0);
     END;
     Inc(i,Demi shl 1);
     If i>=320 then BEGIN i:=0;Inc(j,Demi shl 1); END;
  UNTIL (j>=200);
  Synchro;
  MOVE(Sp^,Screen,64000);
UNTIL (Long>=40) or (PORT[$60]=1);
END;

BEGIN { Winner }
  Sinusoide;
  Pixalisation;
END;

BEGIN
ASM
 MOV AX,13h
 INT 10h
 MOV Clef,010100101b
 IN AL,21h
 OR AL,2
 OUT 21h,AL
END;
Randomize;
SpeedSync:=s shl 1;
For i:=1 to 360 do Sinus[i]:=Trunc(Round(Sin(i*Pi/180)*1024));
For i:=1 to 360 do Cosinus[i]:=Trunc(Round(Cos(i*Pi/180)*1024));
Xms_init;Write('Xms initialisèe ...');
For i:=1 to 10 do Get_XMS(i,64);
For i:=1 to 2 do New(Player[i]);
New(Decors);New(Sp);
Decompact('n1dec.ima',2);
SetPal('Niv1.pal');
MOVE(Decors^,MEM[$A000:0],64000);
Delay(2000);
AllFalse;
Init2Player;
For j:=0 to 3 do ColExpl[j]:=0;
Play1.Init(Pl1,1);
Play2.Init(Pl2,2);
CASE Play1.Imat OF
  1 : Decompact('Skiller.ima',1);
  2 : Decompact('Destroy.ima',1);
  3 : Decompact('Falcon.ima',1);
END;
Ram_Xms(Player[1],64000,1);
CASE Play2.Imat OF
  1 : Decompact('Skiller.ima',2);
  2 : Decompact('Destroy.ima',2);
  3 : Decompact('Falcon.ima',2);
END;
Ram_Xms(Player[2],64000,2);
Decompact('Decvais.ima',3);Ram_Xms(Decors,64000,3);
SetPal('Game.cod');
For j:=0 to 5 do OptCase[j]:=0;
i:=0;Vit:=8;
REPEAT
   KeybRead;
   FILLCHAR(Sp^,64000,0);
   Options_bar;
   KeybRead;
   Play1.KeybTest;
   Play1.Aff;
   OpChop1;
   Play2.KeybTest;
   Play2.Aff;
   OpChop2;
   CIRCLEFIRE;
   Play1.Fire;
   Play2.Fire;
   LifeBar;
   KeybRead;
   For i:=0 to (SpeedSync shr 3) do Synchro;
   MOVE(Sp^,Screen,64000);
UNTIL (Esc) or (Play1.Lost) or (Play2.Lost);
IF Play1.Lost or Play2.Lost then WINNER;
Dispose(Sp);Dispose(Decors);
For i:=1 to 2 do Dispose(Player[i]);
For i:=1 to 10 do Dispose_xms(i);
END;

BEGIN
END.