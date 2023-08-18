# CMakeList.txt: log4cxx0.10.0에 대한 CMake 프로젝트, 여기에 소스를 포함하고
# 프로젝트 특정 논리를 정의합니다.
#
cmake_minimum_required(VERSION 3.22)

project("log4cxx0.10.0")

# 개별적으로 스태틱 라이브러리 링크
add_executable(${PROJECT_NAME} "main.cpp")

target_include_directories(${PROJECT_NAME}
PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Extern/log4cxx/include
)

target_link_directories(${PROJECT_NAME}
PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Extern/log4cxx/lib
    ${CMAKE_CURRENT_SOURCE_DIR}/Extern/log4cxx/apr/lib
)

target_link_libraries(${PROJECT_NAME}
PRIVATE
    liblog4cxx.a 
    libapr-1.a 
    libaprutil-1.a 
    libexpat.a
)

# 통합된 스태틱 라이브러리 하나만 링크
set(PROJECT_NAME_2 "log4cxx0.10.0-2")
find_package(PkgConfig REQUIRED)
pkg_check_modules(LOG4CXX liblog4cxx REQUIRED)

add_executable(${PROJECT_NAME_2} "main.cpp")

target_link_options(${PROJECT_NAME_2} 
PRIVATE 
    -L${LOG4CXX_LIBDIR}
)

target_link_libraries(${PROJECT_NAME_2}
PRIVATE
    ${LOG4CXX_LIBRARIES}
)
