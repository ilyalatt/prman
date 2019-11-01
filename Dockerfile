FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:deadsnakes/ppa && \
  apt-get update && \
  apt-get install -y python3.7 python3-pip git snapcraft rsync && \
  pip3 install pipenv

ADD bundle /build/bundle
ADD snapcraft.yaml /build
RUN cd /build/bundle && \
  export LC_ALL=C.UTF-8 && \
  export LANG=C.UTF-8 && \
  ./init.sh && \
  rsync .venv venv_without_symlinks -a --copy-links -v > /dev/null && \
  rm -rf .venv && \
  mv venv_without_symlinks .venv && \
  cd /build && \
  snapcraft && \
  mv *.snap prman.snap
