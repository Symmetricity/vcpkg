vcpkg_download_distfile(ARCHIVE
    URLS "https://gitlab.com/eidheim/Simple-Web-Server/-/archive/v3.1.1/Simple-Web-Server-v3.1.1.tar.gz"
    FILENAME "simple-web-server-v3.1.1.tar.gz"
    SHA512 1cd24b6fa43fc7ea3628749368b60c9e6e457c8a1d4cd4fb5074601f05cf1777361c4c661746d7752bfb9585b45007d741a46b06d4b65d45564bf84be1cc41fb
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

file(INSTALL
    "${SOURCE_PATH}/asio_compatibility.hpp"
    "${SOURCE_PATH}/client_http.hpp"
    "${SOURCE_PATH}/client_https.hpp"
    "${SOURCE_PATH}/crypto.hpp"
    "${SOURCE_PATH}/mutex.hpp"
    "${SOURCE_PATH}/server_http.hpp"
    "${SOURCE_PATH}/server_https.hpp"
    "${SOURCE_PATH}/status_code.hpp"
    "${SOURCE_PATH}/utility.hpp"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include/simple-web-server"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
