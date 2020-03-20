MODULE test;
  IMPORT blackberry, Out;

PROCEDURE work;
VAR
  l: LONGINT;
  pin: ARRAY 16 OF CHAR;
  fname, lname, email, phone, homephone, mobilephone: ARRAY 32 OF CHAR;
BEGIN
  blackberry.init;
  l := blackberry.probe(pin);
  Out.Int(l,0); Out.Ln;
  Out.String(pin); Out.Ln;
  fname := "inky";
  lname := "from the tape";
  email := "norayr@arnet.am";
  phone := "322233";
  homephone := "322233";
  mobilephone := "322233";
  blackberry.addContact(fname, lname, email, phone, homephone, mobilephone);
END work;

BEGIN
  work;
END test.
