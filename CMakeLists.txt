# CMakeList.txt: log4cxx0.10.0에 대한 CMake 프로젝트, 여기에 소스를 포함하고
# 프로젝트 특정 논리를 정의합니다.
#

project("log4cxx0.10.0")
message(STATUS "\${PROJECT_NAME} = ${PROJECT_NAME}")

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
