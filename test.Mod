MODULE test;
  IMPORT blackberry, Out;

PROCEDURE work;
VAR
  l: LONGINT;
  pin: ARRAY 16 OF CHAR;
BEGIN
  blackberry.init;
  l := blackberry.probe(pin);
  Out.Int(l,0); Out.Ln;
  Out.String(pin); Out.Ln;
END work;

BEGIN
  work;
END test.
