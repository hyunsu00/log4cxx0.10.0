#!/usr/bin/env bash

# 필요패키지 (시간측정용)
# bc 패키지가 설치되어 있는지 확인
bc_path=$(which bc)
if [ -z "$bc_path" ]; then
    echo -e "명령어 'bc' 을(를) 찾을 수 없습니다. 그러나 다음을 통해 설치할 수 있습니다:\nsudo apt install -y bc"
    echo -e "시간측정은 무시 됩니다."
    sleep 2s
fi

# 시간측정
start_time=`date +%s.%N`
start_time_string=`date`

# 0. 쉘파일 경로로 이동
cd $(dirname "$0")

# 1. 빌드관련 폴더 삭제
rm -rfv log4cxx \
&& rm -rfv apr-1.5.2 \
&& rm -rfv apr-util-1.5.4 \
&& rm -rfv apache-log4cxx-0.10.0

# 2. apr(Apache Portable Runtime) 빌드
tar -xvzf apr-1.5.2.tar.gz \
&& cd apr-1.5.2 \
&& ./configure --prefix=$(pwd)/../log4cxx/apr --enable-static=yes --enable-shared=no \
&& make \
&& make install

# 3. apr-util 다운로드 및 빌드
cd .. \
&& tar -xvzf apr-util-1.5.4.tar.gz \
&& cd apr-util-1.5.4 \
&& ./configure --prefix=$(pwd)/../log4cxx/apr --with-expat=builtin --with-apr=$(pwd)/../log4cxx/apr \
&& make \
&& make install
 
# 4. log4cxx 다운로드 및 빌드
cd .. \
&& tar -xvzf apache-log4cxx-0.10.0.tar.gz \
&& tar -zxvf patch.tar.gz -C ./apache-log4cxx-0.10.0 \
&& cd apache-log4cxx-0.10.0 \
&& ./configure --prefix=$(pwd)/../log4cxx --enable-static=yes --enable-shared=no --with-apr=$(pwd)/../log4cxx/apr --with-apr-util=$(pwd)/../log4cxx/apr \
&& make \
&& make install

# 5. liblog4cxx.a로 스택틱 라이브러리 병합
cd .. \
&& ar -M < liblog4cxx.mri \
&& mv -fv ./liblog4cxx.a ./log4cxx/liblog4cxx.a

# 6. 정리작업
rm -rfv apr-1.5.2 \
&& rm -rfv apr-util-1.5.4 \
&& rm -rfv apache-log4cxx-0.10.0

# # 시간측정
end_time=`date +%s.%N`
end_time_string=`date`
#elapsed_time=`echo "$end_time - $start_time" | bc`
elapsed_time=$(echo "$end_time - $start_time" | bc)
htime=`echo "$elapsed_time/3600" | bc` 
mtime=`echo "($elapsed_time/60) - ($htime * 60)" | bc` 
stime=`echo "$elapsed_time - (($elapsed_time/60) * 60)" | bc` 

echo -e "\n\n=============================================="
echo "시작시간 : $start_time_string"
echo "종료시간 : $end_time_string"
echo "걸린시간 : ${htime} H ${mtime} M ${stime} S"
echo "=============================================="
