ARM_UBUNTU_IMG=arm64v8/ubuntu:18.04
JETSON_SKIMAGE_IMG=jetson:skimage

docker build -t $JETSON_SKIMAGE_IMG --build-arg "BASE_IMAGE=${ARM_UBUNTU_IMG}" -f Dockerfile.skimage .

# JETSON pack 4.4 compatible

JP_44_SKIMAGE_CUDA_IMG=jetson44:skimage-cuda
JP_44_SKIMAGE_CUDA_TORCH_IMG=jetson44:skimage-cuda-torch
JP_44_SKIMAGE_CUDA_TORCH_GST_OPENCV_IMG=jetson44:skimage-cuda-torch-gst-opencv
JP_44_SKIMAGE_CUDA_TF_IMG=jetson44:skimage-cuda-tf

docker build -t $JP_44_SKIMAGE_CUDA_IMG --build-arg "BASE_IMAGE=${JETSON_SKIMAGE_IMG}" -f ./4.4/Dockerfile.cuda .
docker build -t $JP_44_SKIMAGE_CUDA_TORCH_IMG --build-arg "BASE_IMAGE=${JP_44_SKIMAGE_CUDA_IMG}" -f ./4.4/Dockerfile.pytorch .
docker build -t ${JP_44_SKIMAGE_CUDA_TORCH_GST_OPENCV_IMG} --build-arg "BASE_IMAGE=${JP_44_SKIMAGE_CUDA_TORCH_IMG}" -f Dockerfile.gstreamer-opencv .
docker build -t ${JP_44_SKIMAGE_CUDA_TF_IMG} --build-arg "BASE_IMAGE=${JP_44_SKIMAGE_CUDA_IMG}" --build-arg "JP_VERSION=44" -f Dockerfile.tf .

JP_43_SKIMAGE_CUDA_IMG=jetson43:skimage-cuda
JP_43_SKIMAGE_CUDA_TORCH_IMG=jetson43:skimage-cuda-torch
JP_43_SKIMAGE_CUDA_TORCH_GST_OPENCV_IMG=jetson43:skimage-cuda-torch-gst-opencv
JP_43_SKIMAGE_CUDA_TORCH_GST_OPENCV_SKLEARN_IMG=jetson43:skimage-cuda-torch-gst-opencv-sklearn
JP_43_SKIMAGE_CUDA_TF_IMG=jetson43:skimage-cuda-tf


docker build -t $JP_43_SKIMAGE_CUDA_IMG --build-arg "BASE_IMAGE=${JETSON_SKIMAGE_IMG}" -f ./4.3/Dockerfile.cuda .
docker build -t $JP_43_SKIMAGE_CUDA_TORCH_IMG --build-arg "BASE_IMAGE=${JP_43_SKIMAGE_CUDA_IMG}" -f ./4.3/Dockerfile.pytorch .
docker build -t ${JP_43_SKIMAGE_CUDA_TORCH_GST_OPENCV_IMG} --build-arg "BASE_IMAGE=${JP_43_SKIMAGE_CUDA_TORCH_IMG}" -f Dockerfile.gstreamer-opencv .
docker build -t ${JP_43_SKIMAGE_CUDA_TORCH_GST_OPENCV_SKLEARN_IMG} --build-arg "BASE_IMAGE=${JP_43_SKIMAGE_CUDA_TORCH_GST_OPENCV_IMG}" -f Dockerfile.sklearn .
docker build -t ${JP_43_SKIMAGE_CUDA_TF_IMG} --build-arg "BASE_IMAGE=${JP_43_SKIMAGE_CUDA_IMG}" --build-arg "JP_VERSION=43" -f Dockerfile.tf .
