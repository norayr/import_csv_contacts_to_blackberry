MODULE blackberry;
IMPORT SYSTEM;

PROCEDURE -AincludeBarry
   '#include "barrywrapper.h"';

PROCEDURE -init*
  "Barry_Init()";

PROCEDURE -probe*(VAR pin: ARRAY OF CHAR): LONGINT
  "(LONGINT)Barry_Probe((char*)pin)";

END blackberry.
