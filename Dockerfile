FROM alpine

#更换国内源
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update

RUN apk add autoconf automake ccache cmake coreutils gcc gcc-objc g++ make nasm pkgconfig yasm \
    && cd /usr/local && wget https://github.com/opencv/opencv/archive/4.0.1.tar.gz -O opencv-4.0.1.tar.gz \
    && tar zxvf opencv-4.0.1.tar.gz \
    && mkdir opencv-4.0.1/build && cd opencv-4.0.1/build \
    #&& sed -i 's/https:\/\/raw.githubusercontent.com\/opencv\/opencv_3rdparty\/${IPPICV_COMMIT}\/ippicv\//file:\/\/\/usr\/local\//' /usr/local/opencv-4.0.1/3rdparty/ippicv/ippicv.cmake \
    && sed -i 's/#  include <linux\/auxvec.h>/\/\/#  include <linux\/auxvec.h>/' /usr/local/opencv-4.0.1/modules/core/src/system.cpp \
    && cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=ON -D CMAKE_INSTALL_PREFIX=/usr/local .. \
    && make -j7 && make install && rm -rf /usr/local/opencv-4.0.1.tar.gz /usr/local/opencv-4.0.1
