#include <barry/barry.h>
#include <iostream>
#include <fstream>
#include <iomanip>

using namespace std;
using namespace Barry;

extern "C" void Barry_Init()
{
   Barry::Init();
}


extern "C" int Barry_Probe()
{
  Barry::Probe probe;
  if ( probe.GetCount() == 0 )
  {
     cout << "No Blackberry found!" << endl;
     return 1;
  }
  else
  {
     cout << "Using PIN: "
          << probe.Get(0).m_pin.Str() << endl;
          return 0;
  }
}


