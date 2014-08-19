FROM ubuntu:14.04

RUN dpkg --add-architecture i386

RUN apt-get update
RUN apt-get -y install software-properties-common

RUN add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update
RUN apt-get -y install wine1.7

RUN apt-get -y install xvfb 

ADD . /app

EXPOSE 9100
EXPOSE 5009

WORKDIR /app

CMD ["/app/run-iqfeed"]
