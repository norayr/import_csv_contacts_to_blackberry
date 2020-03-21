MODULE test;
  IMPORT blackberry, outlookCSV, Args, Out;

PROCEDURE work(VAR fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes: ARRAY OF CHAR);
VAR
  l: LONGINT;
  pin: ARRAY 16 OF CHAR;
BEGIN
  blackberry.init;
  l := blackberry.probe(pin);
  Out.Int(l,0); Out.Ln;
  Out.String(pin); Out.Ln;
(*  fname := "inky";
  lname := "from the tape";
  email := "norayr@arnet.am";
  phone := "322233";
  homephone := "322233";
  mobilephone := "322233";*)
  blackberry.addContact(fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes);
END work;

PROCEDURE checkArgs(VAR fn: ARRAY OF CHAR);
BEGIN
  IF Args.argc = 2 THEN
    Args.Get(1, fn);
  ELSE
    Out.String("no address book csv to open"); Out.Ln;
    Out.String("first parameter - path to csv file"); Out.Ln;
    Out.Ln;
    HALT(1);
  END;
END checkArgs;

PROCEDURE readAB;
VAR 
  fn: ARRAY 32 OF CHAR;
  fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes: ARRAY 128 OF CHAR;
  b: BOOLEAN;
BEGIN
 checkArgs(fn);
 outlookCSV.Open(fn);
 REPEAT
   b := outlookCSV.getLine(fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes);
   IF (fname[0] # 0X) & ((phone[0] # 0X) OR (homephone[0] # 0X) OR (mobilephone[0] # 0X)) THEN
     Out.String("first name: "); Out.String(fname); Out.Ln;
     Out.String(" last name: "); Out.String(lname); Out.Ln;
     Out.String("     email: "); Out.String(email); Out.Ln;
     Out.String("     phone: "); Out.String(phone); Out.Ln;
     Out.String("home phone: "); Out.String(homephone); Out.Ln;
     Out.String("    mobile: "); Out.String(mobilephone); Out.Ln;
     Out.String("      work: "); Out.String(workphone); Out.Ln;
     Out.String("       fax: "); Out.String(fax); Out.Ln;
     Out.String("     notes: "); Out.String(notes); Out.Ln;
     Out.String("--------------------------------------------------------"); Out.Ln;
     work(fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes);
   END;  
 UNTIL ~b;
END readAB;

BEGIN
  readAB;
END test.
