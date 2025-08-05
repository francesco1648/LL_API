cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)

get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${PROJECT_NAME} C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

# Trova ricorsivamente tutti i .c in library/
file(GLOB_RECURSE LIBRARY_SOURCES "library/*.c")

# Trova tutte le sottocartelle di library/ e le aggiunge alle include
file(GLOB_RECURSE LIBRARY_INCLUDES RELATIVE ${CMAKE_SOURCE_DIR} "library/*")
foreach(dir ${LIBRARY_INCLUDES})
    if(IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${dir}")
        include_directories("${CMAKE_SOURCE_DIR}/${dir}")
    endif()
endforeach()

add_executable(${PROJECT_NAME}
    main.c
    ${LIBRARY_SOURCES}
)

target_link_libraries(${PROJECT_NAME}
    pico_stdlib
    pico_stdio_usb
    pico_cyw43_arch_lwip_threadsafe_background  # per API WiFi in background
)


# Abilita solo USB stdio, disabilita UART stdio
pico_enable_stdio_usb(${PROJECT_NAME} 1)
pico_enable_stdio_uart(${PROJECT_NAME} 0)

pico_add_extra_outputs(${PROJECT_NAME})

include_directories(config)
