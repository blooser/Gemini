find_package (Qt5 ${QT_MIN_VERSION} COMPONENTS Core Quick Qml QuickTest)

set(TEST_FILES
    ${PROJECT_SOURCE_DIR}/gemini/common/enums.h
    ${PROJECT_SOURCE_DIR}/gemini/controllers/objectcontroller.h
    ${PROJECT_SOURCE_DIR}/gemini/controllers/objectcontroller.cpp
)

add_executable (tst_objectcontrollertest tst_objectcontrollertest.cpp ${TEST_FILES})
qt5_use_modules (tst_objectcontrollertest Core Quick Qml QuickTest)
add_test (NAME ObjectController COMMAND tst_objectcontrollertest)
