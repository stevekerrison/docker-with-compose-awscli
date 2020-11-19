FROM docker:19.03
LABEL maintainer="Steve Kerrison <steve@usec.io>"

# We build/fetch python3 versions of docker-compose and awscli.
# A bunch of dev packages are needed for this, which we try to clean out in the
# same RUN step.
RUN \
    apk update --no-cache \
    && apk add --no-cache python3 libffi groff less mailcap \
    && apk add --no-cache python3-dev libffi-dev openssl-dev gcc libc-dev make \
    && python3 -m ensurepip \
    && pip3 install --no-cache-dir --upgrade pip setuptools docker-compose awscli \
    && apk del python3-dev libffi-dev openssl-dev gcc libc-dev make

# We don't modify the RUN or ENTRYPOINT of the parent container
