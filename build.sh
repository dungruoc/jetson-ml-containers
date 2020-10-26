ARM_UBUNTU_IMG=arm64v8/ubuntu:18.04
L4T_SKIMAGE_IMG=l4t-skimage:latest
L4T_SKIMAGE_CUDA_IMG=l4t-skimage-cuda:latest
L4T_SKIMAGE_CUDA_TORCH_IMG=l4t-skimage-cuda-torch:latest
L4T_SKIMAGE_CUDA_GST_OPENCV_IMG=l4t-skimage-cuda-gst-opencv:latest
JP_VERSION=44
L4T_SKIMAGE_CUDA_TF_IMG=l4t-skimage-cuda-tf:latest

docker build -t $L4T_SKIMAGE_IMG --build-arg "BASE_IMAGE=${ARM_UBUNTU_IMG}" -f Dockerfile.skimage .

docker build -t $L4T_SKIMAGE_CUDA_IMG --build-arg "BASE_IMAGE=${L4T_SKIMAGE_IMG}" -f Dockerfile.cuda .

docker build -t ${L4T_SKIMAGE_CUDA_TORCH_IMG} --build-arg "BASE_IMAGE=${L4T_SKIMAGE_CUDA_IMG}" -f Dockerfile.pytorch .

docker build -t ${L4T_SKIMAGE_CUDA_GST_OPENCV_IMG} --build-arg "BASE_IMAGE=${L4T_SKIMAGE_CUDA_IMG}" -f Dockerfile.gstreamer-opencv .

docker build -t ${L4T_SKIMAGE_CUDA_TF_IMG} --build-arg "BASE_IMAGE=${L4T_SKIMAGE_CUDA_IMG}" --build-arg "JP_VERSION=${JP_VERSION}" -f Dockerfile.tf .
