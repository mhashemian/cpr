#include <iostream>
#include <cpr/cpr.h>

int main(int argc, char** argv) {
#    cpr::Response r = cpr::Get(cpr::Url{"https://api.github.com/repos/whoshuu/cpr/contributors"},\
     std::cout << argv[1] << std::endl;
     cpr::Response r = cpr::Get(cpr::Url{argv[1]},
                      cpr::Authentication{"user", "pass", cpr::AuthMode::BASIC},
                      cpr::Parameters{{"anon", "true"}, {"key", "value"}});
    r.status_code;                  
    r.header["content-type"];       
    r.text;                         
    return 0;
}
