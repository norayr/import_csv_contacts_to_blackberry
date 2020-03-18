MODULE test;
  IMPORT blackberry;

PROCEDURE work;
VAR
  l: LONGINT;
BEGIN
  blackberry.init;
  l := blackberry.probe();
END work;

BEGIN
  work;
END test.
