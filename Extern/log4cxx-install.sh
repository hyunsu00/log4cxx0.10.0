#!/usr/bin/env bash

# 0. 쉘파일 경로로 이동
cd $(dirname "$0")

# 1. log4cxx 인스톨
cp -r -v ./log4cxx/include/log4cxx /usr/local/include/log4cxx \
&& cp ./log4cxx/liblog4cxx.a /usr/local/lib/liblog4cxx.a \
&& mkdir -p /usr/local/lib/pkgconfig \
&& cp ./liblog4cxx.pc /usr/local/lib/pkgconfig/liblog4cxx.pc
