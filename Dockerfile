FROM python:3.6-alpine

# install system requirements
RUN apk add --update --no-cache --virtual=build-dependencies \
    antiword \
    build-base \
    curl \
    jpeg-dev \
    libxml2-dev libxml2 \
    libxslt-dev libxslt \
    libstdc++ \
    libpq \
    python3-dev postgresql-dev
RUN apk --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --update add leveldb leveldb-dev
RUN pip install psycopg2 datapackage-pipelines-github lxml datapackage-pipelines[speedup]

ENV PYTHONUNBUFFERED 1

RUN mkdir /knesset
WORKDIR /knesset
ADD . /knesset/

RUN pip install -e /knesset

ENTRYPOINT ["/knesset/docker-run.sh"]