# PICT Container Image
A container image for PICT (https://github.com/microsoft/pict).

## Usage

Execute with a local model

    podman run -it --rm -v ./models:/var/pict:Z quay.io/apodhrad/pict:latest example.txt

with output

    TYPE	SIZE	FSYSTEM	CLUSTER	COMPRESSION
    Stripe	40000	NTFS	65536	off
    RAID-5	10	FAT	32768	off
    Span	40000	NTFS	8192	off
    Mirror	1000	FAT32	4096	off
    Single	5000	NTFS	1024	off
    Single	5000	NTFS	1024	on

More details can be found at https://github.com/Microsoft/pict/blob/main/doc/pict.md

## Building

Simple `make` usage

    make build

then you can the container

    make run-bash

or execute an example

    make run-example

