ARG BASE_IMAGE
ARG JP_VERSION

FROM ${BASE_IMAGE}

ARG JP_VERSION

LABEL maintainer "dungruoc"

RUN apt-get update -y \
  && apt-get install -y libhdf5-serial-dev pkg-config libhdf5-100 hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

RUN pip3 install -U pip testresources setuptools \
  && pip3 install -U future mock h5py keras preprocessing gast futures protobuf pybind11

RUN pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v${JP_VERSION} tensorflow

