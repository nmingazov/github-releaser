FROM ubuntu:16.04
MAINTAINER nmingazov "nicrotek547@gmail.com"

RUN apt-get update && apt-get install -y \
  npm \ 
  nodejs-legacy \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g github-changes

ADD runner.sh runner.sh

ENTRYPOINT ["./runner.sh"] 
