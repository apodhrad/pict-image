#  ____        _ _     _           
# | __ ) _   _(_) | __| | ___ _ __ 
# |  _ \| | | | | |/ _` |/ _ \ '__|
# | |_) | |_| | | | (_| |  __/ |   
# |____/ \__,_|_|_|\__,_|\___|_|   
#                                  
FROM registry.access.redhat.com/ubi9/toolbox:9.2 as builder

RUN dnf install -y cmake g++

RUN dnf --installroot=/tmp/dnf \
        --nodocs --setopt=install_weak_deps=False \
        install -y \
        g++ shadow-utils && \
    dnf --installroot=/tmp/dnf \
        clean all

RUN cd /tmp && \
    git clone https://github.com/microsoft/pict.git && \
    cd pict && \
    cmake -DCMAKE_BUILD_TYPE=Release -S . -B build && \
    cmake --build build

RUN cp /tmp/pict/build/cli/pict /tmp/dnf/usr/local/bin/

#  __  __       _       
# |  \/  | __ _(_)_ __  
# | |\/| |/ _` | | '_ \ 
# | |  | | (_| | | | | |
# |_|  |_|\__,_|_|_| |_|
#
FROM registry.access.redhat.com/ubi9/ubi-micro:9.2

COPY --from=builder /tmp/dnf/ /

VOLUME /var/pict

WORKDIR /var/pict

RUN useradd -M pict

USER pict

ENTRYPOINT ["pict"]
