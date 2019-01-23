USES DOS,CRT,G1PLAY,G2PLAY,OPTIONS;

TYPE VirtualPtr=^Virtual;
     Virtual=ARRAY[0..63999] of BYTE;

VAR Player  : ARRAY[1..2] of VirtualPtr;
    Sp      : VirtualPtr;                { Pointeurs représentants des écrans virtuels }
    Screen  : Virtual ABSOLUTE $A000:0;  { Pointe directement sur la mémoire vidéo     }
    Palette : ARRAY[0..767] of BYTE;     { Palette de 256 couleurs : 3 composantes*256 => 768 }
    i,j     : INTEGER;
    Choix   : Byte;                      { 3 choix 1:Jeu 1 joueur , 2:Jeu 2 joueurs , 3:Options }
    f       : Text;
    Ch,Ch2  : CHAR;
    ExitFinal : BOOLEAN;                 { Sortie du jeu }
    param1,param2 : String;              { Paramères du jeu }
    vga : boolean;                       { Paramètre vga  en mode 320*200 ds les options }
    SpeedSync : Byte;                    { Vitesse du jeu ( en attendant le timer ) }

PROCEDURE PutSprSt(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
{ Vieille "procédure" de sprites }
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

PROCEDURE DECOMPACT(Ne:String;Num:Word);
{ Décompacte les
    - fichiers images compressés dont la taille est < 64000 octets
    - fichiers images non compressés dont la taille = 64000 octets
  Mode de compression :
    - 1 octet = nb de fois que la couleur suivante est
     à inscrire à la suite
    - 1 octet = pour coder la couleur                      }
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
           0 : Sp^[Total]:=Color;
           1 : Player[1]^[Total]:=Color;
           2 : Player[2]^[Total]:=Color;
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
   END;
end;

PROCEDURE SETPAL(Fich : STRING);
VAR f : FILE;
BEGIN
 { Lit la palette de 256 couleurs :
   composante Rouge Vert Bleu ( RVB ) par couleur =>  3*256 = 768  }
 Assign(f,Fich);
 Reset(f,1);
 BlockRead(f,Palette,768);
 Close(f);
 { Ecrit la palette }
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

PROCEDURE INTRO;
Procedure testTouch;
{ intercepte les touches }
Var Touch : Byte;
Begin
  Touch:=Port[$60];  { PORT[$60] est le port du clavier }
  CASE touch OF
     72 : begin delay(100);If i<>1 then Dec(i) end;                 { Touche Flèche vers le haut }
     80 : begin delay(100);If i<>3 then Inc(i) end;                 { Touche Flèche vers la bas  }
     28 : Choix:=i;                            { Touche Entrèe              }
     1  : BEGIN;ExitFinal:=True;Choix:=4; END; { Touche Escape              }
  END;
End;
Procedure EcPrinc;
BEGIN
   ASM
    MOV AX,13h
    INT 10h
   END;
   Decompact('ih1.ima',1);
   Decompact('ih2.ima',2);
   SetPal('IntHell.pal');
   i:=1;Choix:=0;
   REPEAT
      MOVE(Player[1]^,Sp^,64000);
      TestTouch;
      CASE i OF
         1 : PutSprSt(0,0,80,16,117,126,2);
         2 : PutSprSt(0,17,80,35,117,143,2);
         3 : PutSprSt(0,36,80,49,117,162,2);
      END;
      MOVE(Sp^,Screen,64000);
   UNTIL (Choix<>0);
end;
BEGIN
  EcPrinc;
END;

BEGIN
{ Enregistre les paramètres :
   -vga : écran d'option en VGA  }
Case paramCount of
 1 : Param1:=paramStr(1);
 2 : begin Param1:=paramStr(1);Param2:=paramStr(2); End;
End;
ASM
  IN AL,21h
  OR AL,2
  OUT 21h,AL
  MOV AX,13h
  INT 10h
END;
For i:=1 to 2 do New(Player[i]);
New(Sp);
ExitFinal:=False;
Assign(f,'Config.bh');
Reset(f);Read(f,Ch);Close(f); { Charge de la config la rapidité du jeu }
SpeedSync:=Ord(Ch);
REPEAT
 Intro;
 Dispose(Sp);Dispose(Player[2]);Dispose(Player[1]);
 CASE Choix OF
  1 : JEU_1_JOUEUR(SpeedSync);  { Shoot'em up à 1 joueur  + vitesse du jeu }
  2 : JEU_2_JOUEURS(SpeedSync); { Shoot'em up à 2 joueurs + viteese du jeu }
  3 : Options_Depla(param1,param2); { Options du jeu          }
 END;
 New(Player[1]);New(Player[2]);New(Sp);
UNTIL EXITFINAL;
Dispose(Sp);
For i:=1 to 2 do Dispose(Player[i]);
ASM
  IN AL,21h
  AND AL,253
  OUT 21h,AL
  MOV AX,3
  INT 10h
END;
END.