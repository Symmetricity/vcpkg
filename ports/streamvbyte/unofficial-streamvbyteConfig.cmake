get_filename_component(_UNOFFICIAL_STREAMVBYTE_PREFIX "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

find_path(UNOFFICIAL_STREAMVBYTE_INCLUDE_DIR
    NAMES
        "streamvbyte.h"
    PATHS "${_UNOFFICIAL_STREAMVBYTE_PREFIX}/include"
    NO_DEFAULT_PATH
)
if(NOT UNOFFICIAL_STREAMVBYTE_INCLUDE_DIR)
    message(FATAL_ERROR "unofficial-streamvbyte headers not found")
endif()

find_library(UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE
    NAMES
        "streamvbyte"
    PATHS "${_UNOFFICIAL_STREAMVBYTE_PREFIX}/lib"
    NO_DEFAULT_PATH
)
find_library(UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG
    NAMES
        "streamvbyte"
    PATHS "${_UNOFFICIAL_STREAMVBYTE_PREFIX}/debug/lib"
    NO_DEFAULT_PATH
)
if(NOT UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE AND NOT UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG)
    message(FATAL_ERROR "unofficial-streamvbyte library not found")
endif()

if(NOT TARGET unofficial::streamvbyte::streamvbyte)
    add_library(unofficial::streamvbyte::streamvbyte UNKNOWN IMPORTED)
    set_target_properties(unofficial::streamvbyte::streamvbyte PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${UNOFFICIAL_STREAMVBYTE_INCLUDE_DIR}"
    )
    if(UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE)
        set_property(TARGET unofficial::streamvbyte::streamvbyte APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(unofficial::streamvbyte::streamvbyte PROPERTIES
            IMPORTED_LOCATION "${UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE}"
            IMPORTED_LOCATION_RELEASE "${UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE}"
            MAP_IMPORTED_CONFIG_MINSIZEREL RELEASE
            MAP_IMPORTED_CONFIG_RELWITHDEBINFO RELEASE
        )
    endif()
    if(UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG)
        set_property(TARGET unofficial::streamvbyte::streamvbyte APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(unofficial::streamvbyte::streamvbyte PROPERTIES
            IMPORTED_LOCATION_DEBUG "${UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG}"
        )
    endif()
    if(NOT UNOFFICIAL_STREAMVBYTE_LIBRARY_RELEASE AND UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG)
        set_target_properties(unofficial::streamvbyte::streamvbyte PROPERTIES IMPORTED_LOCATION "${UNOFFICIAL_STREAMVBYTE_LIBRARY_DEBUG}")
    endif()
endif()
