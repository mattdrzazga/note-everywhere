TEMPLATE = app

QT += qml quick widgets sql

SOURCES += src/c++/main.cpp \
    src/c++/note.cpp \
    src/c++/pathresolver.cpp \
    src/c++/noteeverywhere.cpp \
    src/c++/notevalues.cpp \
    src/c++/notemodel.cpp \
    src/c++/sqlnoteinterface.cpp \
    src/c++/textformatter.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/c++/note.h \
    src/c++/pathresolver.h \
    src/c++/noteeverywhere.h \
    src/c++/notevalues.h \
    src/c++/notemodel.h \
    src/c++/sqlnoteinterface.h \
    src/c++/textformatter.h
