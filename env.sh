# The directory depmake is installed in
export DM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# The parent directory, which should have a 'packets' and 'build' dir, private
DM_DEPS_DIR="$( dirname ${DM_DIR} )"
# The directory containing the packet install bash scripts
export DM_PACKETS_DIR="${DM_DEPS_DIR}/packets"
# The directory where we build / install our packets
export DM_BUILD_DIR="${DM_DEPS_DIR}/build"
# The directory where the stack will be linked into
export DM_STACK_DIR="${DM_ROOT_DIR}/stack"
# The number of cpu cores on this machine
export DM_CPU_CORES=`getconf _NPROCESSORS_ONLN`

# The $PATH before it was manipulated by depmake
export DM_ORIGINAL_PATH=${DM_ORIGINAL_PATH:-$PATH}
# Add our stack/bin dir to the $PATH
export PATH="${DM_STACK_DIR}/bin:${DM_STACK_DIR}/sbin:${DM_ORIGINAL_PATH}"
# Set other paths that impact builds and shared library loading
export LD_LIBRARY_PATH="${DM_STACK_DIR}/lib"
export CPPFLAGS="-I${DM_STACK_DIR}/include"
export LDFLAGS="-L${DM_STACK_DIR}/lib"
export PKG_CONFIG_PATH="${DM_STACK_DIR}/lib/pkgconfig"
