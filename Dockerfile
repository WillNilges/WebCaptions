#FROM debian
FROM docker.io/nvidia/cuda:11.4.1-cudnn8-devel-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install git ffmpeg python3-pip python3

RUN pip install git+https://github.com/openai/whisper.git
