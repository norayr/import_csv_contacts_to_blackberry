MODULE blackberry;
IMPORT SYSTEM;
TYPE dev* = SYSTEM.ADDRESS;
PROCEDURE -AincludeBarry
   '#include "barrywrapper.h"';

PROCEDURE -init*
  "Barry_Init()";

PROCEDURE -probe*(VAR pin: ARRAY OF CHAR): LONGINT
  "(LONGINT)Barry_Probe((char*)pin)";

PROCEDURE -addContact*(VAR fname, lname, email, phone, homephone, mobilephone, workphone, fax, notes: ARRAY OF CHAR)
  "Barry_addContact((char*)fname, (char*)lname, (char*)email, (char*)phone, (char*)homephone, (char*)mobilephone), (char*)workphone, (char*)fax, (char*)notes";

END blackberry.
