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
target_include_directories(${lib_name} PUBLIC $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${wxInc}>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
  )
target_link_libraries(${lib_name} PUBLIC wx::core)
list(TRANSFORM WXX_OUTPUT_NAME REPLACE "@TARGET@" "${lib_name}")
set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME ${WXX_OUTPUT_NAME})
#######################################
install(TARGETS ${lib_name} EXPORT ${targetsFile}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )
install(FILES ${things_hdrs} DESTINATION ${wxInc}/wx/${lib_name})
if(DEFINED XP_NAMESPACE)
  set(nameSpace NAMESPACE ${XP_NAMESPACE}::)
endif()
install(EXPORT ${targetsFile} DESTINATION lib/cmake ${nameSpace})
