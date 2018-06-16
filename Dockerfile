FROM golang:1.10.3

ENV TF_TYPE "cpu"
ENV TARGET_DIRECTORY '/usr/local'
RUN apt-get install git curl
RUN curl --silent -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-${TF_TYPE}-$(go env GOOS)-x86_64-1.8.0.tar.gz" | tar -C $TARGET_DIRECTORY -xz
RUN ldconfig
RUN mkdir -p /tmp/tensor/img
RUN curl --silent -o /tmp/tensor/img/demo.jpg 'https://www.jetbrains.com/idea/whatsnew/img/2017.2/image20.jpg'
ADD . /go/src/mytensor

RUN go get mytensor/...

CMD ["/go/bin/mytensor", "-dir", "/tmp/tensor/data", "-image", "/tmp/tensor/img/demo.jpg"]
