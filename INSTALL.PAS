PROGRAM INSTALL_BH;
USES DOS,CRT;
VAR f      : Text;
    s      : String;
    a      : Byte;
    Code   : Integer;
BEGIN
 Assign(f,'Config.bh');
 Rewrite(f);
 REPEAT
  Write('Donnez une valeur : ');
  Readln(s);
  Val(s,a,code);
 UNTIL (Code=0) and (a<58) and (a>=0);
 Write(f,chr(a));
 Close(f);
END.
