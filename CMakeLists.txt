cmake_minimum_required(VERSION 3.16)

project(NepaliCalendar VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appNepaliCalendar
    main.cpp
    apimanager.h apimanager.cpp
)

qt_add_qml_module(appNepaliCalendar
    URI NepaliCalendar
    VERSION 1.0
    QML_FILES Main.qml CalendarTemplate.qml EventsTemplate.qml
)

set_target_properties(appNepaliCalendar PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appNepaliCalendar
    PRIVATE Qt6::Quick
)

qt_add_resources(appNepaliCalendar "res" FILES
        "assets/fonts/aakriti_regular.ttf"
        "assets/icons/left_icon.png"
)

install(TARGETS appNepaliCalendar
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
