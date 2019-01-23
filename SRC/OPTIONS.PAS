UNIT OPTIONS;
INTERFACE
USES DOS,CRT;
TYPE VirtualPtr=^Virtual;
     Virtual=ARRAY[0..63999] of BYTE;

VAR Player : ARRAY[1..2] of VirtualPtr;
    Sp,Decors : VirtualPtr;              { Pointeurs repr‚sentants des ‚crans virtuels }
    Screen  : Virtual ABSOLUTE $A000:0;  { Pointe directement sur la m‚moire vid‚o     }
    Palette : ARRAY[0..767] of BYTE;     { Palette de 256 couleurs : 3 composantes*256 => 768 }
    i,j,u,v : INTEGER;
    f       : Text;
    Ch,Ch2  : CHAR;
    vga : boolean;
    clef : Word;

PROCEDURE OPTIONS_DEPLA(param1,param2 : string);

IMPLEMENTATION
PROCEDURE SETPAL2(s:STRING);
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
DecodPal(s,Palette );
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

PROCEDURE DECOMPACT(Ne:String;Num:Word);
{ D‚compacte les
    - fichiers images compress‚s dont la taille est < 64000 octets
    - fichiers images non compress‚s dont la taille = 64000 octets
  Mode de compression :
    - 1 octet = nb de fois que la couleur suivante est
     … inscrire … la suite
    - 1 octet = pour coder la couleur                      }
VAR Nb,total : WORD;
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


PROCEDURE OPTIONS_DEPLA(param1,param2:string);
VAR Shit,t1,t2   : BOOLEAN;
    Choix,Letsgo : BYTE;
    Fpage        : WORD;

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

PROCEDURE MEM2MX(Page,Taille : WORD);ASSEMBLER;
VAR Plan_l   : BYTE;
    Plan_pos : WORD;
ASM
    MOV DX,03CEh
    MOV AX,4005h
    OUT DX,AX

    MOV PLAN_L,1
    PUSH DS
    LDS SI,DWORD ptr DS:Decors
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

PROCEDURE Greetings;
var compt:word;
BEGIN
   InitModX;
   SetPal2('Options.cod');
   Decompact('Opt01.ima',3);MEM2MX(0,16000);
   Decompact('Opt02.ima',3);MEM2MX(16000,16000);
   Decompact('Opt03.ima',3);MEM2MX(32000,16000);
   Decompact('Opt04.ima',3);MEM2MX(48000,16000);
   Compt:=0;
   REPEAT
       ASM
     @Sync: MOV DX,3DAh
       IN AL,DX
       TEST AL,8
       JE @Sync
         MOV DX,3D4h
         MOV AL,0Ch
         MOV AH,Byte Ptr Compt + 1
         OUT DX,AX
         MOV AL,0Dh
         MOV AH,Byte Ptr Compt
         OUT DX,AX
       END;
   CASE Port[$60] Of
      80 : If Compt<48000 then Inc(Compt,80);
      72 : If Compt>0 then Dec(Compt,80);
   END;
   UNTIL PORT[$60]=1;
END;

PROCEDURE VESA;
BEGIN
 ASM
  MOV AX,4F02h
  MOV BX,100h     { 640*400 : 256 couleurs }
  INT 10h
 END;
END;

PROCEDURE SNDCARD;
{ Non disponible pour cause de coneries }
BEGIN
(*  ASM
   MOV AX,13h
   INT 10h
  END;
  SetPal('Soundim.pal');
  Decompact('Soundim.ima',0);
  Decompact('SdCard.ima',3);
  i:=1;
  REPEAT
    PutSprAt(0,0,105,48,200,10,1);
    CASE i Of
     1 : PutSprAt(110,0,215,12,200,10,1);
     2 : PutSprAt(110,13,215,24,200,22,1);
     3 : PutSprAt(110,25,215,48,200,36,1);
    END;
    CASE PORT[$60] OF
    1 :;
    END;
  UNTIL PORT[$60]=1;*)
END;

PROCEDURE DIFOPTIONS;
BEGIN
 CASE Letsgo OF
  1 : Sndcard;      { Sound }
  2 : ;
  3 : Greetings;   { Info  }
 END;
 If vga then ASM MOV AX,19
  INT 10h END Else VESA;
END;

PROCEDURE CP(n:WORD);
BEGIN
 ASM
    MOV AH,4Fh
    MOV AL,05h
    MOV BH,00h
    MOV BL,0
    MOV DX,n
    INT 10h
 END;
END;

PROCEDURE PUTSPRVES(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
If Decors^[(640*(y1+numlines)+x1)+c1] <>0 then
Screen[((640*y1des+x1des)+numlines*640)+c1]:=Decors^[(640*(y1+numlines)+x1)+c1];
END;

PROCEDURE PUTSPR(x1,y1,x2,y2,x1des,y1des : WORD;Num : BYTE);
VAR NumLines : WORD;
    C1       : INTEGER;
BEGIN
For numlines:=0 to (y2-y1+1) do for c1:=0 to x2-x1+1 do
If Decors^[(320*(y1+numlines)+x1)+c1] <>0 then
Screen[((320*y1des+x1des)+numlines*320)+c1]:=Decors^[(320*(y1+numlines)+x1)+c1];
END;

PROCEDURE VESREAD(ne:string);
var f : TEXT;
    f2 : File;
    c1,l,Tot:longint;
    nb,nbc,color,ccol:byte;
    n : INTEGER;
    Hand : Word;
BEGIN
    Assign(f,ne);
    Reset(f);
    For i:=0 to 2 do BEGIN Cp(i);
    For l:=0 to 65535 do BEGIN
     Read(f,Ch);MEM[$A000:l]:=ord(ch); END; END;
    Cp(3);For l:=0 to 59391 do BEGIN
     Read(f,Ch);MEM[$A000:l]:=ord(ch); END;
   Close(f);
END;

BEGIN
   ASM MOV Clef,010100101b  { D‚finit la clef } END;
   For i:=1 to 2 do New(Player[i]);
   New(Decors);New(Sp);
   Fillchar(Screen,64000,0);
   If (Param1='-vga') or (Param2='-vga') then vga:=True;
   If not Vga then Vesa;
   REPEAT
   SetPal('Base.pal');
   Decompact('Options.ima',3);
   If Vga then Begin Decompact('Base.ima',10);Move(Sp^,Screen,64000) End
   Else VesRead('Base.ves');
   IF Vga then Begin PutSpr(0,141,78,198,235,5,1);PutSpr(80,141,159,160,235,5,1); End
   Else Begin
   Cp(0);PutSprVes(0,0,159,56,470,15,1);
   PutSprVes(160,0,319,18,470,15,1); End;
   Choix:=1;Shit:=False;T1:=False;T2:=False;PORT[$60]:=255;Letsgo:=0;
   REPEAT
   If (Port[$60]<128) and (not t1) then
   BEGIN
    If Vga then PutSpr(0,141,78,198,235,5,1) Else PutSprVes(0,0,159,56,470,15,1);
    CASE PORT[$60] OF
      72 : If Choix>1 then Dec(Choix);
      80 : If Choix<3 then Inc(Choix);
      28 : Letsgo:=Choix;
      1  : Shit:=True;
    END;
    CASE Choix OF
      1 : If vga then PutSpr(80,141,159,160,235,5,1) else PutSprVes(160,0,319,18,470,15,1);
      2 : If vga then PutSpr(80,160,159,179,235,24,1) else PutSprVes(160,19,319,38,470,34,1);
      3 : If vga then PutSpr(80,180,159,198,235,44,1) else PutSprVes(160,39,319,56,470,54,1);
    END;
   T1:=True;
   END;
   If Port[$60]>128 then t1:=False;
   UNTIL (Shit) or (Letsgo<>0);
   If Letsgo<>0 then DIFOPTIONS;
   UNTIL Shit;
   ASM
    MOV AX,13h
    INT 10h
   END;
   Dispose(Sp);Dispose(Decors);
   For i:=1 to 2 do Dispose(Player[i]);
END;

BEGIN
END.

