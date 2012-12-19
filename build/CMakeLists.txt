set(lib_name things)
#######################################
# include directories
include_directories(../include)
#######################################
# library sources
########################
# source
set(things_srcs
  ../src/block.cpp
  ../src/bmpcombo.cpp
  ../src/dropdown.cpp
  ../src/filebrws.cpp
  ../src/genergdi.cpp
  ../src/geometry.cpp
  ../src/menubtn.cpp
  ../src/optvalue.cpp
  ../src/range.cpp
  ../src/spinctld.cpp
  ../src/toggle.cpp
  )
list(APPEND ${lib_name}_libsrcs ${things_srcs})
########################
# headers
set(things_hdrs
  ../include/wx/things/block.h
  ../include/wx/things/bmpcombo.h
  ../include/wx/things/dropdown.h
  ../include/wx/things/filebrws.h
  ../include/wx/things/genergdi.h
  ../include/wx/things/geometry.h
  ../include/wx/things/medsort.h
  ../include/wx/things/menubtn.h
  ../include/wx/things/optvalue.h
  ../include/wx/things/range.h
  ../include/wx/things/spinctld.h
  ../include/wx/things/thingdef.h
  ../include/wx/things/toggle.h
  )
list(APPEND ${lib_name}_libsrcs ${things_hdrs})
#######################################
# library
add_library(${lib_name} STATIC ${${lib_name}_libsrcs})
set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME ${wxbasename}_${lib_name}-${wxversion})
#######################################
# install
install(TARGETS ${lib_name} DESTINATION lib${NUMBITS})
install(FILES ${things_hdrs} DESTINATION include/wx/things)
