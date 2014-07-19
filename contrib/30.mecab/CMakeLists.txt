# mecab
find_package(MECAB)

if (MECAB_FOUND)
  add_definitions(${MECAB_DEFINITIONS})
  include_directories(${MECAB_INCLUDE_DIR})

  file(GLOB PICRIN_MECAB_SOURCES ${PROJECT_SOURCE_DIR}/contrib/30.mecab/src/*.c)

  list(APPEND PICRIN_CONTRIB_INITS "void pic_init_mecab(pic_state *)\; pic_init_mecab(pic)\;")
  list(APPEND PICRIN_CONTRIB_LIBRARIES ${MECAB_LIBRARIES})
  list(APPEND PICRIN_CONTRIB_SOURCES ${PICRIN_MECAB_SOURCES})
endif()
