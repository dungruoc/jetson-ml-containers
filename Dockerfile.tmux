ARG BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL maintainer "dungruoc"


RUN apt-get update && apt-get install -y tmux

