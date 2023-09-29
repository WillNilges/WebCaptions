#FROM debian
FROM docker.io/nvidia/cuda:11.4.3-cudnn8-devel-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install git ffmpeg python3-pip python3

RUN pip install git+https://github.com/openai/whisper.git


WORKDIR /workdir

ENTRYPOINT whisper $WHISPER_VIDEO_PATH
