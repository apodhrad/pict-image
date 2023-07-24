#  ____        _ _     _           
# | __ ) _   _(_) | __| | ___ _ __ 
# |  _ \| | | | | |/ _` |/ _ \ '__|
# | |_) | |_| | | | (_| |  __/ |   
# |____/ \__,_|_|_|\__,_|\___|_|   
#                                  
FROM registry.access.redhat.com/ubi9/toolbox:9.2 as builder

RUN dnf install -y cmake g++

RUN cd /tmp && \
    git clone https://github.com/microsoft/pict.git && \
    cd pict && \
    cmake -DCMAKE_BUILD_TYPE=Release -S . -B build && \
    cmake --build build

#  __  __       _       
# |  \/  | __ _(_)_ __  
# | |\/| |/ _` | | '_ \ 
# | |  | | (_| | | | | |
# |_|  |_|\__,_|_|_| |_|
#
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.2

RUN microdnf install --nodocs -y g++ shadow-utils &&\
    microdnf clean all

COPY --from=builder /tmp/pict/build/cli/pict /usr/local/bin/

VOLUME /var/pict

WORKDIR /var/pict

RUN useradd -M pict

USER pict

ENTRYPOINT ["pict"]
