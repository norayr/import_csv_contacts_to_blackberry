MODULE blackberry;
IMPORT SYSTEM;

PROCEDURE -AincludeBarry
   '#include "barrywrapper.h"';

PROCEDURE -init*
  "Barry_Init()";

PROCEDURE -probe*(): LONGINT
  "(LONGINT)Barry_Probe()";

END blackberry.
