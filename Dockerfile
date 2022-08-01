FROM oasisprotocol/runtime-builder:main

ENV SAPPHIRE_HOME /usr/src/sapphire-paratime
ENV TARGET "x86_64-fortanix-unknown-sgx"
ENV CARGO_TARGET_DIR "/usr/src/sapphire-paratime/target/sgx"
ENV CFLAGS_x86_64_fortanix_unknown_sgx "-isystem/usr/include/x86_64-linux-gnu -mlvi-hardening -mllvm -x86-experimental-lvi-inline-asm-hardening"
ENV CC_x86_64_fortanix_unknown_sgx clang-11

WORKDIR ${SAPPHIRE_HOME}

COPY . .

SHELL ["/bin/bash", "-c"]
RUN set -eux; \
        pushd runtime; \
        cargo build --release --locked --target $TARGET; \
        cargo elf2sgxs --release; \
        popd;
SHELL ["/bin/sh", "-c"]
