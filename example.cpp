#include <iostream>
#include <fstream>
#include <sstream>
#include <cpr/cpr.h>

int main(int argc, char** argv) {
    //std::cout << argv[1] << std::endl;
    
    
    //std::ifstream inFile;
    //inFile.open(argv[1]);

    //std::stringstream strStream;
    //strStream << inFile.rdbuf();
    //std::string str = strStream.str(); //str holds the content of the file

    //std::cout << str << "\n";
    cpr::Response r = cpr::Get(cpr::Url{"127.0.0.1:8080"},
    //cpr::Response r = cpr::Get(cpr::Url{str},
                      cpr::Authentication{"user", "pass", cpr::AuthMode::BASIC},
                      cpr::Parameters{{"anon", "true"}, {"key", "value"}});
    r.status_code;                  
    r.header["content-type"];       
    r.text;
    
    //inFile.close();
    return 0;
}
