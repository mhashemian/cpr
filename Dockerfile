FROM ubuntu

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y wget gcc g++ clang make cmake git
#RUN git clone https://github.com/mhashemian/cpr.git
RUN cd cpr
RUN sed -i 's/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." ON)/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." OFF)/g' /cpr/CMakeLists.txt
RUN cmake .
RUN make
RUN export PATH=$PATH:/cpr/include:/cpr/lib
RUN echo '#include <cpr/cpr.h> \
\
int main(int argc, char** argv) {\
    cpr::Response r = cpr::Get(cpr::Url{"https://api.github.com/repos/whoshuu/cpr/contributors"},\
                      cpr::Authentication{"user", "pass", cpr::AuthMode::BASIC},\
                      cpr::Parameters{{"anon", "true"}, {"key", "value"}});\
    r.status_code;                  \
    r.header["content-type"];       \
    r.text;                         \
    return 0;\
}' > example.c
