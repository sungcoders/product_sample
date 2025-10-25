# Toolchain file for ARM cross-compilation
set(TOOLCHAIN_DIR "/workspace/devenv/toolchains/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu/bin")

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
# set(CMAKE_SYSROOT /path/to/sysroot)

set(CMAKE_C_COMPILER ${TOOLCHAIN_DIR}/aarch64-none-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_DIR}/aarch64-none-linux-gnu-g++)
