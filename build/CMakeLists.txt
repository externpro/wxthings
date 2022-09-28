set(lib_name things)
#######################################
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
add_library(${lib_name} STATIC ${${lib_name}_libsrcs})
target_include_directories(${lib_name} PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
  )
target_link_libraries(${lib_name} PUBLIC wx::core)
list(TRANSFORM WXX_OUTPUT_NAME REPLACE "@TARGET@" "${lib_name}")
set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME ${WXX_OUTPUT_NAME})
#######################################
install(TARGETS ${lib_name} EXPORT ${targetsFile}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
install(FILES ${things_hdrs} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/wx/${lib_name})
#######################################
set(samples_filebrws_srcs
  ../samples/filebrws/wxfilebrowser.cpp
  ../samples/filebrws/wxfilebrowser.rc
  )
set(samples_things_srcs
  ../samples/things/thingsdemo.cpp
  ../samples/things/thingsdemo.rc
  )
foreach(sample
  samples_filebrws
  samples_things
  )
  add_executable(${sample} WIN32 ${${sample}_srcs})
  target_link_libraries(${sample} PRIVATE ${lib_name})
endforeach()
