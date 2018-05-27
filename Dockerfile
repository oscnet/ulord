FROM centos

RUN mkdir -p /ulord
COPY ./config.json /ulord
COPY ./ulordrig /ulord

WORKDIR /ulord

CMD ["/ulord/ulordrig"]


