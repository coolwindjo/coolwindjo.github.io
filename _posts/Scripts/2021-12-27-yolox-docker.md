---
layout: post
categories: Scripts
tags: [dockerfile, yolox]
---

## Reference Links

- [Github - lyyiangang/yolox-dockerfile](<https://github.com/lyyiangang/yolox-dockerfile>){:target="_blank"}

## Dockerfiles

```Dockerfile
# docker build -f ./Dockerfile.txt -t yolox .
FROM nvcr.io/nvidia/pytorch:21.06-py3
# install douban pip source, boost installation
RUN mkdir ~/.pip && echo -e "[global]\nindex-url = https://pypi.doubanio.com/simple\ntrusted-host = pypi.doubanio.com\n" > ~/.pip/pip.conf

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt && pip install cython 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install ffmpeg libsm6 libxext6  -y

# install torch2trt
RUN cd /tmp && git clone https://github.com/NVIDIA-AI-IOT/torch2trt && cd /tmp/torch2trt && python setup.py install && rm -rf /tmp/torch2trt

RUN cd /tmp && git clone https://github.com/NVIDIA/apex && cd apex && pip install -v \
    --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ &&\
    rm /tmp/apex -rf
```