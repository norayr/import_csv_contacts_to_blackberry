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

#define barrydev Barry::ProbeResult

//c++ to c string conversion
void convert_to_cstring(string name, char * str)
{
  const char * tmp;
  tmp = name.c_str();
  for (int index = 0; index < name.length(); index++)
  {
    str[index] = tmp[index];
  }
  str[name.length()] = '\0';
}

//c to c++ string conversion
void convert_to_cppstring(char * str, string &name)
{
  string s(str);
  name = s;
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
     convert_to_cstring(pin, pin_string);
     //printf ("%s\n", pin_string);
     return 1;
  }
}

void Upload(const Barry::ProbeResult &device, const Barry::Contact &contact)
{
 // connect to address book
 Controller con(device);
 Mode::Desktop desktop(con);
 desktop.Open();
 unsigned int id = desktop.GetDBID("Address Book");

 // find out what records are already there, and make new record ID
 RecordStateTable table;
 desktop.GetRecordStateTable(id, table);
 uint32_t recordId = table.MakeNewRecordId();

 // add it
 desktop.AddRecordByType(recordId, contact);
 cout << "Added successfully." << endl;
}

extern "C" int Barry_addContact(char * fname, char * lname, char * email, char * phone, char * homePhone, char * mobilePhone, char * workPhone, char * fax, char * notes)
{
  Barry::Contact contact;
  Barry::Probe probe;
  convert_to_cppstring(fname, contact.FirstName);
  convert_to_cppstring(lname, contact.LastName);
  string mail(email);
  contact.EmailAddresses.push_back(mail);
  convert_to_cppstring(phone, contact.Phone);
  convert_to_cppstring(homePhone, contact.HomePhone);
  convert_to_cppstring(mobilePhone, contact.MobilePhone);
  convert_to_cppstring(workPhone, contact.WorkPhone);
  convert_to_cppstring(fax, contact.Fax);
  convert_to_cppstring(notes, contact.Notes);

   Upload(probe.Get(0), contact);
}
