get_filename_component(_STREAMVBYTE_PREFIX "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

find_path(STREAMVBYTE_INCLUDE_DIR
    NAMES
        "streamvbyte.h"
    PATHS "${_STREAMVBYTE_PREFIX}/include"
    NO_DEFAULT_PATH
)
if(NOT STREAMVBYTE_INCLUDE_DIR)
    message(FATAL_ERROR "streamvbyte headers not found")
endif()

find_library(STREAMVBYTE_LIBRARY_RELEASE
    NAMES
        "streamvbyte"
    PATHS "${_STREAMVBYTE_PREFIX}/lib"
    NO_DEFAULT_PATH
)
find_library(STREAMVBYTE_LIBRARY_DEBUG
    NAMES
        "streamvbyte"
    PATHS "${_STREAMVBYTE_PREFIX}/debug/lib"
    NO_DEFAULT_PATH
)
if(NOT STREAMVBYTE_LIBRARY_RELEASE AND NOT STREAMVBYTE_LIBRARY_DEBUG)
    message(FATAL_ERROR "streamvbyte library not found")
endif()

if(NOT TARGET streamvbyte::streamvbyte)
    add_library(streamvbyte::streamvbyte UNKNOWN IMPORTED)
    set_target_properties(streamvbyte::streamvbyte PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${STREAMVBYTE_INCLUDE_DIR}"
    )
    if(STREAMVBYTE_LIBRARY_RELEASE)
        set_property(TARGET streamvbyte::streamvbyte APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(streamvbyte::streamvbyte PROPERTIES
            IMPORTED_LOCATION "${STREAMVBYTE_LIBRARY_RELEASE}"
            IMPORTED_LOCATION_RELEASE "${STREAMVBYTE_LIBRARY_RELEASE}"
            MAP_IMPORTED_CONFIG_MINSIZEREL RELEASE
            MAP_IMPORTED_CONFIG_RELWITHDEBINFO RELEASE
        )
    endif()
    if(STREAMVBYTE_LIBRARY_DEBUG)
        set_property(TARGET streamvbyte::streamvbyte APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(streamvbyte::streamvbyte PROPERTIES
            IMPORTED_LOCATION_DEBUG "${STREAMVBYTE_LIBRARY_DEBUG}"
        )
    endif()
    if(NOT STREAMVBYTE_LIBRARY_RELEASE AND STREAMVBYTE_LIBRARY_DEBUG)
        set_target_properties(streamvbyte::streamvbyte PROPERTIES IMPORTED_LOCATION "${STREAMVBYTE_LIBRARY_DEBUG}")
    endif()
endif()
