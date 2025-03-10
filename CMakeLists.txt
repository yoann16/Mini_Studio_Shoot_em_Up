cmake_minimum_required(VERSION 3.14)
project(ShootemUp VERSION 2.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Utiliser directement le vcpkg local du projet
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake" 
    CACHE STRING "Vcpkg toolchain file")

message(STATUS "Using project vcpkg toolchain: ${CMAKE_TOOLCHAIN_FILE}")

# Recherche de SFML suivant les recommandations de vcpkg
set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/installed/x64-windows/share/sfml")
find_package(SFML COMPONENTS System Window Graphics Audio Network CONFIG REQUIRED)

# Afficher la version de SFML trouvée
if(SFML_FOUND)
    message(STATUS "Found SFML ${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR}.${SFML_VERSION_PATCH}")
else()
    message(FATAL_ERROR "Could not find SFML")
endif()

#Project Settings
file(GLOB SOURCES 
    "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

file(GLOB HEADERS
    "${PROJECT_SOURCE_DIR}/include/*.h"
)

add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

source_group("Source Files" FILES ${SOURCES})
source_group("Header Files" FILES ${HEADERS})

# Inclure les répertoires d'en-têtes
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

# Lier SFML à l'exécutable avec la syntaxe correcte pour SFML 3.0
target_link_libraries(${PROJECT_NAME} PRIVATE
    SFML::System
    SFML::Window
    SFML::Graphics
    SFML::Audio
    SFML::Network
)

# Options de compilation
if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4)
else()
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra)
endif()

# Copier les ressources dans le répertoire de sortie
if(WIN32)
    # Copier le dossier des ressources
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/resources $<TARGET_FILE_DIR:${PROJECT_NAME}>/resources
    )
endif()

# Copier les DLLs de SFML depuis vcpkg
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/installed/x64-windows/$<$<CONFIG:Debug>:debug/>bin"
    $<TARGET_FILE_DIR:${PROJECT_NAME}>
)