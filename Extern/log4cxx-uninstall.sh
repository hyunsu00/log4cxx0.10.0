#!/usr/bin/env bash

# 0. 쉘파일 경로로 이동
cd $(dirname "$0")

# 1. log4cxx 언인스톨
rm -rfv /usr/local/include/log4cxx \
&& rm -fv /usr/local/lib/liblog4cxx.a \
&& rm -fv /usr/local/lib/pkgconfig/liblog4cxx.pc
