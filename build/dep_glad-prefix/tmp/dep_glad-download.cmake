# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

set(quiet "")
set(script_dir "C:/Users/HP/share/cmake-3.20/Modules/ExternalProject")
include(${script_dir}/captured_process_setup.cmake)

if(EXISTS "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad-stamp/dep_glad-download-lastrun.txt" AND EXISTS "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/tmp/dep_glad-download-repoinfo.txt" AND
   "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad-stamp/dep_glad-download-lastrun.txt" IS_NEWER_THAN "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/tmp/dep_glad-download-repoinfo.txt")
  if(NOT quiet)
    message(STATUS
      "Avoiding repeated git clone, stamp file is up to date: "
      "'C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad-stamp/dep_glad-download-lastrun.txt'"
    )
  endif()
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad"
  RESULT_VARIABLE error_code
  ${capture_output}
)
_ep_command_check_result(
  error_code "Failed to remove directory: 'C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad'"
)

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  # If you are seeing the following call hang and you have QUIET enabled, try
  # turning QUIET off to show any output immediately. The command may be
  # blocking while waiting for user input (e.g. a password to a SSH key).
  execute_process(
    COMMAND "C:/Users/HP/Git/cmd/git.exe" 
            clone --no-checkout --depth 1 --no-single-branch --config "advice.detachedHead=false" "https://github.com/Dav1dde/glad" "dep_glad"
    WORKING_DIRECTORY "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src"
    RESULT_VARIABLE error_code
    ${capture_output}
  )
  if(NOT "${out_var}" STREQUAL "")
    string(APPEND accumulated_output "${out_var}\n")
  endif()
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  set(msg "Had to git clone more than once: ${number_of_tries} times.")
  if(quiet)
    string(APPEND accumulated_output "${msg}\n")
  else()
    message(STATUS "${msg}")
  endif()
endif()
_ep_command_check_result(
  error_code "Failed to clone repository: 'https://github.com/Dav1dde/glad'"
)

execute_process(
  COMMAND "C:/Users/HP/Git/cmd/git.exe" 
          checkout "v0.1.34" --
  WORKING_DIRECTORY "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad"
  RESULT_VARIABLE error_code
  ${capture_output}
)
_ep_command_check_result(error_code "Failed to checkout tag: 'v0.1.34'")

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "C:/Users/HP/Git/cmd/git.exe" 
            submodule update --recursive --init 
    WORKING_DIRECTORY "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad"
    RESULT_VARIABLE error_code
    ${capture_output}
  )
  _ep_command_check_result(
    error_code "Failed to update submodules in: 'C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad'"
  )
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/tmp/dep_glad-download-repoinfo.txt" "C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad-stamp/dep_glad-download-lastrun.txt"
  RESULT_VARIABLE error_code
  ${capture_output}
)
_ep_command_check_result(
  error_code "Failed to copy script-last-run stamp file: 'C:/Users/HP/OneDrive/바탕 화면/CODE/opengl_example/build/dep_glad-prefix/src/dep_glad-stamp/dep_glad-download-lastrun.txt'"
)
