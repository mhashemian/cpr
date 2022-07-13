FROM ubuntu

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y wget gcc g++ clang make cmake git libcurl4-openssl-dev
RUN git clone https://github.com/mhashemian/cpr.git
WORKDIR cpr
RUN sed -i 's/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." ON)/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." OFF)/g' /cpr/CMakeLists.txt
RUN cmake .
RUN make
ENV PATH=$PATH:/cpr/include:/cpr/lib

RUN echo '#include <cpr/cpr.h> \n\
\
int main(int argc, char** argv) {\
#    cpr::Response r = cpr::Get(cpr::Url{"https://api.github.com/repos/whoshuu/cpr/contributors"},\
     printf("argv[1]: %s\n", argv[1]);\
     cpr::Response r = cpr::Get(cpr::Url{argv[1]},\
                      cpr::Authentication{"user", "pass", cpr::AuthMode::BASIC},\
                      cpr::Parameters{{"anon", "true"}, {"key", "value"}});\
    r.status_code;                  \
    r.header["content-type"];       \
    r.text;                         \
    return 0;\
}' > example.cpp

RUN touch include/cpr/cprver.h
RUN g++ example.cpp -Iinclude -Llib -lcpr
ENV LD_LIBRARY_PATH=/cpr/lib
RUN export LD_LIBRARY_PATH
