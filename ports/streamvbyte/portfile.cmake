vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fast-pack/streamvbyte
    REF "v3.0.0"
    SHA512 ada2783173a3218fceaf02b7e64892c9f4446e6e23e3f53a2b4112fe44785be2bd2a90b15bf5432433d3daea52616cca965cde087a0529111677b4cbf996c462
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSTREAMVBYTE_ENABLE_EXAMPLES=OFF
        -DSTREAMVBYTE_ENABLE_TESTS=OFF
        -DSTREAMVBYTE_WALL=OFF
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Generated CMake package config install begin
file(INSTALL
    "${CMAKE_CURRENT_LIST_DIR}/streamvbyteConfig.cmake"
    "${CMAKE_CURRENT_LIST_DIR}/usage"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
)
# Generated CMake package config install end
