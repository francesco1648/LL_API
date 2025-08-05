cmake_minimum_required(VERSION 3.12)

include(pico_sdk_import.cmake)

get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)

project(${PROJECT_NAME} C CXX ASM)

pico_sdk_init()

# Trova ricorsivamente tutti i .c in library/
file(GLOB_RECURSE LIBRARY_SOURCES "library/*.c")
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


pico_add_extra_outputs(${PROJECT_NAME})




target_link_libraries(${PROJECT_NAME}
    pico_stdlib
    pico_stdio_usb
    hardware_gpio
    hardware_adc
    hardware_i2c
    hardware_spi
    hardware_pwm
)


if (PICO_CYW43_SUPPORTED)
    target_link_libraries(mio_progetto pico_cyw43_arch_none)
endif()

