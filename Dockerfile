FROM ubuntu

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y wget gcc g++ clang make cmake git libcurl4-openssl-dev
RUN git clone https://github.com/mhashemian/cpr.git
WORKDIR cpr
RUN sed -i 's/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." ON)/cpr_option(CPR_ENABLE_SSL "Enables or disables the SSL backend. Required to perform HTTPS requests." OFF)/g' /cpr/CMakeLists.txt
RUN cmake .
RUN make
ENV PATH=$PATH:/cpr/include:/cpr/lib
RUN touch include/cpr/cprver.h
RUN g++ example.cpp -Iinclude -Llib -lcpr
ENV LD_LIBRARY_PATH=/cpr/lib
RUN export LD_LIBRARY_PATH
