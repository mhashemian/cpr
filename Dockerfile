FROM ubuntu

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y wget gcc g++ clang make cmake git
RUN git clone https://github.com/mhashemian/cpr.git
CMD sed -i 's/CPR_ENABLE_SSL:BOOL=ON/CPR_ENABLE_SSL:BOOL=OFF/g' CMakeCache.txt
CMD cd cpr
CMD cmake .
CMD make
CMD export PATH=$PATH:/cpr/include:/cpr/lib
CMD echo '#include <cpr/cpr.h> \
\
int main(int argc, char** argv) {\
    cpr::Response r = cpr::Get(cpr::Url{"https://api.github.com/repos/whoshuu/cpr/contributors"},\
                      cpr::Authentication{"user", "pass", cpr::AuthMode::BASIC},\
                      cpr::Parameters{{"anon", "true"}, {"key", "value"}});\
    r.status_code;                  \
    r.header["content-type"];       \
    r.text;                         \
    return 0;\
}' > text.cpp
