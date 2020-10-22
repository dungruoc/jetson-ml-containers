docker build -t l4t-skimage:latest -f Dockerfile.skimage .

docker build -t l4t-skimage-cuda:latest -f Dockerfile.skimage-cuda .

docker build -t l4t-skimage-cuda-torch -f Dockerfile.skimage-cuda-pytorch .
