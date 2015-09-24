TEMPLATE = app

QT += qml quick

SOURCES += src/c++/main.cpp \
    src/c++/note.cpp \
    src/qml/desktop/pathresolver.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/c++/note.h \
    src/qml/desktop/pathresolver.h
