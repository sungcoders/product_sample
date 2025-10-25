arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-elf/
├── bin/              # Các binary chính (compiler, linker, objdump, gdb...)
├── aarch64-none-elf/ # Sysroot, include, lib (startup, bare-metal runtime)
├── libexec/          # Các chương trình phụ trợ (cc1, lto1, collect2...)
├── share/            # Tài liệu, license, manpage
└── manifest.txt      # Thông tin release

bin/
    Đây là nơi bạn sẽ gọi lệnh:
        aarch64-none-elf-gcc → compiler
        aarch64-none-elf-as → assembler
        aarch64-none-elf-ld → linker
        aarch64-none-elf-objcopy, aarch64-none-elf-objdump, aarch64-none-elf-size → xử lý file nhị phân
        aarch64-none-elf-gdb → debug bare-metal
aarch64-none-elf/
    include/ → header chuẩn (newlib, stdint.h, stdio.h nếu build có newlib).
    lib/ → thư viện runtime cơ bản (libc, libm, startup files như crt0.o).
    lib/ldscripts/ → các script linker mẫu.
libexec/
    Các chương trình nội bộ mà gcc gọi tới, bạn ít khi chạy trực tiếp.
share/
    Document, license, man pages.
