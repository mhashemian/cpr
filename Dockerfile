FROM ubuntu

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install -y wget gcc clang make cmake git vi
RUN git clone https://github.com/mhashemian/cpr.git

