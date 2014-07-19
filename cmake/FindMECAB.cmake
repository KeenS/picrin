#                                               -*- cmake -*-
#
#  FindRegex.cmake: Try to find Regex
#
#  Copyright (C) 2014-     Yuichi Nishiwaki
#  Copyright (C) 2005-2013 EDF-EADS-Phimeca
#
#  This library is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  along with this library.  If not, see <http://www.gnu.org/licenses/>.
#
#  @author dutka
#  @date   2010-02-04 16:44:49 +0100 (Thu, 04 Feb 2010)
#
# - Try to find Regex
# Once done this will define
#
#  REGEX_FOUND - System has Regex
#  REGEX_INCLUDE_DIR - The Regex include directory
#  REGEX_LIBRARIES - The libraries needed to use Regex
#  REGEX_DEFINITIONS - Compiler switches required for using Regex
#
#
#  ChangeLogs:
#
#  2014/05/07 - Yuichi Nishiwaki
#    On Mac, it finds /System/Library/Frameworks/Ruby.framework/Headers/regex.h,
#   which was a part of superold version of glibc when POSIX standard didn't exist.
#   To avoid this behavior, we call find_path twice, searching /usr/include and
#   /usr/local/include first and if nothing was found then searching $PATH in the
#   second stage.
#

IF (MECAB_INCLUDE_DIR AND MECAB_LIBRARIES)
   # in cache already
   SET(Regex_FIND_QUIETLY TRUE)
ENDIF (MECAB_INCLUDE_DIR AND MECAB_LIBRARIES)

#IF (NOT WIN32)
#   # use pkg-config to get the directories and then use these values
#   # in the FIND_PATH() and FIND_LIBRARY() calls
#   FIND_PACKAGE(PkgConfig)
#   PKG_CHECK_MODULES(PC_REGEX regex)
#   SET(REGEX_DEFINITIONS ${PC_REGEX_CFLAGS_OTHER})
#ENDIF (NOT WIN32)

FIND_PATH(MECAB_INCLUDE_DIR mecab.h
  PATHS /usr/include /usr/local/include
  NO_DEFAULT_PATH
  )

IF (NOT MECAB_INCLUDE_DIR)
  FIND_PATH(MECAB_INCLUDE_DIR mecab.h
    HINTS
    ${MECAB_INCLUDEDIR}
    ${PC_LIBXML_INCLUDE_DIRS}
    PATH_SUFFIXES mecab
    )
ENDIF()

FIND_LIBRARY(MECAB_LIBRARIES NAMES c mecab
   HINTS
   ${PC_MECAB_LIBDIR}
   ${PC_MECAB_LIBRARY_DIRS}
   )

INCLUDE(FindPackageHandleStandardArgs)

# handle the QUIETLY and REQUIRED arguments and set REGEX_FOUND to TRUE if
# all listed variables are TRUE

FIND_PACKAGE_HANDLE_STANDARD_ARGS(Mecab DEFAULT_MSG MECAB_LIBRARIES MECAB_INCLUDE_DIR)

MARK_AS_ADVANCED(MECAB_INCLUDE_DIR MECAB_LIBRARIES)
