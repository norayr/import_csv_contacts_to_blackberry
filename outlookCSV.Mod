MODULE outlookCSV;
IMPORT Files;

CONST
  lnameOffset = 1;
  notesOffset = 10;
  phoneOffset = 2;
  mobileOffset = 1;
  workOffset = 17;
  faxOffset = 19;
  quote = 34;
  comma = 44;
  eol   = 10;

VAR F : Files.File;
    R : Files.Rider;

PROCEDURE Open*(VAR fn: ARRAY OF CHAR);
VAR x: SHORTINT;
BEGIN
  F := Files.Old(fn);
  Files.Set(R, F, 0);
  REPEAT (* skip first line *)
    Files.Read(R, x);
  UNTIL x = eol;
END Open;

PROCEDURE skipFields(r: INTEGER);
VAR
  x: SHORTINT;
  i: INTEGER;
BEGIN
  i := 0;
  REPEAT
    Files.Read(R, x);
    IF x = comma THEN INC(i) END
  UNTIL i = r;
END skipFields;

PROCEDURE getField(VAR line: ARRAY OF CHAR): BOOLEAN;
VAR 
  x: SHORTINT;
  b: BOOLEAN;
  i: SHORTINT;
BEGIN
  i := 0;
  REPEAT
    Files.Read(R, x);
    IF (x # comma) (*& (x # eol)*) THEN
      IF (x > 31) & (x < 127) & (x # quote) THEN
        line[i] := CHR(x);
        INC(i)
      END
    ELSE
      line[i] := 0X
    END
  UNTIL (*(x = eol) OR*) (x = comma) OR R.eof;
  IF R.eof THEN
    RETURN FALSE
  ELSE
    (*skipFields(1); *)
    RETURN TRUE
  END
END getField;

PROCEDURE skipTillEOL(): BOOLEAN;
VAR
  x: SHORTINT;
  b: BOOLEAN;
BEGIN
  REPEAT
    Files.Read(R, x);
  UNTIL (x = eol) OR R.eof;
  IF R.eof THEN RETURN FALSE ELSE RETURN TRUE END
END skipTillEOL;

PROCEDURE getLine*(VAR fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes: ARRAY OF CHAR): BOOLEAN;
VAR
  b: BOOLEAN;
BEGIN
  b := getField(fname);            IF ~b THEN RETURN FALSE END;
  skipFields(lnameOffset);
  b := getField(lname);
  skipFields(notesOffset); 
  b := getField(notes);
  b := getField(email);
  skipFields(phoneOffset);
  b := getField(phone);
  b := getField(homephone);
  skipFields(mobileOffset);
  b := getField(mobilephone);
  skipFields(workOffset);
  b := getField(workphone);
  skipFields(faxOffset);
  b := getField(fax);
  b := skipTillEOL();                    IF ~b THEN RETURN FALSE END;
  RETURN TRUE
END getLine;

END outlookCSV.
