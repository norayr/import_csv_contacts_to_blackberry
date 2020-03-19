#include <barry/barry.h>
#include <iostream>
#include <fstream>
#include <iomanip>

//for c++ to c string conversion
#include <string>
#include <vector>
#include <cstring>

#include <stdio.h>

using namespace std;
using namespace Barry;

//c++ to c string conversion
void convert(string name, char * str)
{
  //std::string name = "apple";
  //new char[name.length()];
  const char * tmp;
  tmp = name.c_str();
  //printf("%c%c%c\n", tmp[0], tmp[1], tmp[2]);
  for (int index = 0; index < name.length(); index++)
  {
    str[index] = tmp[index];
  }
  str[name.length()] = '\0';
  //printf("%c\n", str[0]);
  //str[0]='q';
  //printf("%s\n", tmp);
  //printf("%s\n", str);
}


extern "C" void Barry_Init()
{
   Barry::Init();
}


extern "C" int Barry_Probe(char * pin_string)
{
  Barry::Probe probe;
  if ( probe.GetCount() == 0 )
  {
     //No Blackberry found
     *pin_string = '\0';
     return 0;
  }
  else
  {
     std::string pin;
     pin = probe.Get(0).m_pin.Str();
     convert(pin, pin_string);
     //printf ("%s\n", pin_string);
     return 1;
  }
}


