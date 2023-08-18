# CMakeList.txt: log4cxx0.10.0에 대한 CMake 프로젝트, 여기에 소스를 포함하고
# 프로젝트 특정 논리를 정의합니다.
#

project("log4cxx0.10.0")
message(STATUS "\${PROJECT_NAME} = ${PROJECT_NAME}")

find_package(PkgConfig REQUIRED)
pkg_check_modules(LOG4CXX liblog4cxx REQUIRED)

add_executable(${PROJECT_NAME} "main.cpp")

target_link_options(${PROJECT_NAME} 
PRIVATE 
    -L${LOG4CXX_LIBDIR}
)

target_link_libraries(${PROJECT_NAME}
PRIVATE
    ${LOG4CXX_LIBRARIES}
)
