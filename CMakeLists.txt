cmake_minimum_required(VERSION 3.12)

include(pico_sdk_import.cmake)

project(mio_progetto)

pico_sdk_init()

add_executable(mio_progetto
    main.c
)

pico_add_extra_outputs(mio_progetto)

target_link_libraries(mio_progetto pico_stdlib)

if (PICO_CYW43_SUPPORTED)
    target_link_libraries(mio_progetto pico_cyw43_arch_none)
endif()
