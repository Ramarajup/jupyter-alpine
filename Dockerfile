# minimal Jumyter image 

FROM alpine:latest
MAINTAINER Ramaraju (Ramaraju.p@gmail.com)

RUN apk update \
&& apk add \
    ca-certificates \
    libstdc++ \
    python3 \
&& apk add --virtual=build_dependencies \
    cmake \
    gcc \
    g++ \
    make \
    musl-dev \
    python3-dev \
    freetype-dev \
    libpng-dev \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& python3 -m pip --no-cache-dir install \
    cufflinks \
    ipywidgets \
    networkx \
    notebook \
    numpy \
    pandas \
    plotly \
    requests \
    matplotlib \
    sympy \
&& jupyter nbextension enable --py widgetsnbextension \
&& apk del --purge -r build_dependencies \
&& rm -rf /var/cache/apk/* \
&& mkdir /notebooks

VOLUME /notebooks
ENTRYPOINT /usr/bin/jupyter-notebook --no-browser --ip=0.0.0.0 --notebook-dir=/notebooks --allow-root
EXPOSE 8888
