PROGRAM INSTALL_BH;
USES DOS,CRT;
Var f : Text;
    s : String;
    a,code : integer;

BEGIN
 TextBackGround(7);
 TextColor(0);
 ClrScr;
 GotoXY(24,3);Write('BLACK HELL  - Tonio  (C) 1995');
 GotoXY(32,4);Write('Version 1.12');
 Assign(f,'Config.bh');
 Rewrite(f);
 REPEAT
  GotoXY(4,7);Write('Programme pour déterminer la rapidité du jeu Black Hell');
  GotoXY(3,8);Write('Pour celà, veuillez entrer une valeur comprise entre : ');
  GotoXY(3,9);Write(' - 0 pour les 486 SX 25 et inférieurs ');
  GotoXY(3,10);Write(' - 5 pour les 486 DX 25 et inférieurs ');
  GotoXY(3,11);Write(' - 8 pour les 486 DX2 66 et inférieurs ');
  GotoXY(3,12);Write(' - 10 pour les Pentiums et inférieurs ');
  GotoXY(3,13);Write('A vous de choisir la bonne vitesse, celle indiquèe sont à titre indicatif');
  GotoXY(3,14);Write('Vous pourrez toujours modifier la vitesse avec les touches "+" et "-"  du');
  GotoXY(3,15);Write('pavé numérique.');
  GotoXY(4,17);Write('Précisez la valeur choisie : ');
  Readln(s);
  Val(s,a,code);
 UNTIL (Code=0) and (a<58) and (a>=0);
 Write(f,chr(a));
 Close(f);
 TextBackGround(0);
 TextColor(7);
 ASM
  MOV AX,3
  INT 10h
 END;
 Write('Amusez vous bien !');
END.
