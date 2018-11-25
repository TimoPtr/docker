FROM alpine:latest


# Create python User
RUN mkdir -p /opt/python-home \
  && addgroup python -g 111 \
  && adduser python -D -G python -h /opt/python-home -u 106


# Create android User
RUN mkdir -p /opt/python-home/python-workdir

COPY requirements.txt /opt/python-home/python-workdir/requirements.txt

RUN apk -U update && apk -U add \
  bash \
  ca-certificates \
  curl \
  zip \
  unzip \
  wget \
  build-base \
  python3 \
  python3-dev \
  libxml2-dev \
  libxslt-dev \
  && pip3 install --no-cache-dir --upgrade pip \
  && pip3 install -r /opt/python-home/python-workdir/requirements.txt \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/*

USER python
WORKDIR /opt/python-home/python-workdir