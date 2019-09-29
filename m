Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE9C178F
	for <lists+linux-crypto@lfdr.de>; Sun, 29 Sep 2019 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfI2Ri7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 29 Sep 2019 13:38:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53203 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbfI2Ri7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 29 Sep 2019 13:38:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so10756327wmh.2
        for <linux-crypto@vger.kernel.org>; Sun, 29 Sep 2019 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVmeJVcyAv5FivCJe4Ho+3eNCzy/y0ab/TB7w9rUAN0=;
        b=wq7V+9PUtOB7d/V5MmO+V3l0NMsLZxE6O1DzfPfvq/jYkzo8hRWRYna+xFrt/bMC2U
         X9VBR/cknKMYxzzdh0FsmR0Zdcsci2e1o2xoFmg6hDadLDxf/kXW/SkNumxubq0x2MuI
         ph+hLbFu6iqTzDjIsi/WWpJFidHNJ27Jhh7CVXx2ahg87kEYXiFnFdMknLPagT0m5RUV
         PRmwPy/y9l2u+0EYEJ3MEVSwRXftkTUM5hUUjUWEPjF95AJv1dV431bGGc2O/SoJUKCx
         ttYKUXca3vHq9M9QluAN7rPLJ2s6ZBeXknYzFZIr4jRKVStWL0tQ6T3wnvCnegXo8tJd
         os9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVmeJVcyAv5FivCJe4Ho+3eNCzy/y0ab/TB7w9rUAN0=;
        b=L5YHjwH0H+p+waOcVKIrY7E7OFOaUS0iFxRhhIhi5vPfTWu2iFnUpQ189XjmMmkSXx
         a4uK0hpXQxRIUf97QCDdmboHQ2zx3mzRIrgjdWoDW9aYpk3MalgElbJU5MG58vD4QMOV
         nYnz7pChhBC0cvGJkM8FSIgRIuqHiiz5J+eZKnscjcdWlITKrN6wiMZC0rEv0K385uHI
         krtFkGuxsn+z3dXBi248NATMANIkggQxTl5IFdzJBqdMUXlKQ1nYx0AgCbOnRxSNCQjz
         w0+mgbxKw8BUa6y0su6WTnTCKLX9aGGhKiEwYirrXgsok1BUpLbsfJh6hjwZXwvA/i/0
         DVMw==
X-Gm-Message-State: APjAAAXq7EoV7SwHBbqxTAnkNjmd0Hyosm6YRvCtapiC1Fczzfdk3Cp0
        SaZ3Mb0X8ZbPcX4c8bmPE1FzqQjmSYu2YDS9
X-Google-Smtp-Source: APXvYqzQ7UAyHPKCcemCW5D4+H/064n2+GRcKAP8QB6AA0lA7PEFDoUodArOscNVVmf9GN5csusnQg==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr14421967wme.152.1569778736774;
        Sun, 29 Sep 2019 10:38:56 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (bar06-5-82-246-156-241.fbx.proxad.net. [82.246.156.241])
        by smtp.gmail.com with ESMTPSA id q192sm17339779wme.23.2019.09.29.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 10:38:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Willi <martin@strongswan.org>
Subject: [RFC PATCH 00/20] crypto: wireguard with crypto API library interface
Date:   Sun, 29 Sep 2019 19:38:30 +0200
Message-Id: <20190929173850.26055-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This is a follow-up to 'crypto: wireguard using the existing crypto API'.
Linus has made it abundantly clear that using the abstract AEAD interface
is not acceptable for instantiating a transformation that is known at compile
time, so I will abandon that approach for the time being. If anyone turns up
with appropriate h/w to run WireGuard in async mode, we might revisit this,
but for sync s/w algorithms, a concrete library interface is clearly preferred.

Therefore, I dropped the AEAD changes, and instead, moved to a true library
interface a la Zinc, but with the warts removed:
- no extensive #ifdef'ery, no static inline stub functions in .c files, or
  inclusion of .c files in other .c files - instead, we use Kconfig constraints
  and Kbuild rules which are much more idiomatic for the kernel
- no big pile of code for all architectures in lib/zinc, but generic library
  code in lib/crypto and per-arch code in arch/*/crypto, as we are used to for
  crypto API drivers
- reuse existing implementations of ChaCha20 and Poly1305 instead of replacing
  everything wholesale without proper motivation.

This now includes all the accelerated code contributed by Jason except for
the MIPS changes, but these should be trivial to port once we agree that this
approach is acceptable.

Patches #1 .. #8 refactor the chacha and poly1305 code so we can expose the
existing accelerated implementations via the library interface, as well as
two new Poly1305 implementations for ARM and arm64 taken from the OpenSSL/
Cryptogams project.

Patches #9 .. #16 incorporate the Zinc libraries for blake2s and curve25519,
as well as the plain VA versions of the ChaCha20Poly1305 construction.

Patch #17 reimplements the scatterlist interface of ChaCha20Poly1305 without
relying on the crypto API's blkcipher walk API. (The original implementation
had a rather nasty hack to be able to call into it from non-crypto API code,
but it was ugly and it doesn't look to me like it is guaranteed to work as
expected in cases where the scatterlist is fragmented into chunks that are
not aligned to the chacha block size)

Patch #18 is the same WireGuard patch as in the previous series, with patches
#19 and #20 being the deltas that need to be applied on top to get the code
to build.

Patches can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=wireguard-crypto-library-api

Cc: Herbert Xu <herbert@gondor.apana.org.au> 
Cc: David Miller <davem@davemloft.net>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Samuel Neves <sneves@dei.uc.pt>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Martin Willi <martin@strongswan.org>

[0] https://lore.kernel.org/linux-crypto/20190925161255.1871-1-ard.biesheuvel@linaro.org/

Ard Biesheuvel (13):
  crypto: chacha - move existing library code into lib/crypto
  crypto: x86/chacha - expose SIMD ChaCha routine as library function
  crypto: arm64/chacha - expose arm64 ChaCha routine as library function
  crypto: arm/chacha - expose ARM ChaCha routine as library function
  crypto: poly1305 - move into lib/crypto and refactor into library
  crypto: x86/poly1305 - expose existing driver as poly1305 library
  crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON
    implementation
  crypto: arm/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON
    implementation
  int128: move __uint128_t compiler test to Kconfig
  crypto: chacha20poly1305 - import construction and selftest from Zinc
  crypto: lib/chacha20poly1305 - reimplement crypt_from_sg() routine
  netlink: use new strict length types in policy for 5.2
  wg switch to lib/crypto algos

Jason A. Donenfeld (7):
  crypto: BLAKE2s - generic C library implementation and selftest
  crypto: BLAKE2s - x86_64 implementation
  crypto: Curve25519 - generic C library implementations and selftest
  crypto: Curve25519 - x86_64 library implementation
  crypto: arm - import Bernstein and Schwabe's Curve25519 ARM
    implementation
  crypto: arm/Curve25519 - wire up NEON implementation
  net: WireGuard secure network tunnel

 MAINTAINERS                                  |    8 +
 arch/arm/crypto/Kconfig                      |   11 +
 arch/arm/crypto/Makefile                     |    9 +-
 arch/arm/crypto/chacha-neon-glue.c           |   21 +-
 arch/arm/crypto/curve25519-core.S            | 2062 +++++
 arch/arm/crypto/curve25519-glue.c            |   45 +
 arch/arm/crypto/poly1305-armv4.pl            | 1236 +++
 arch/arm/crypto/poly1305-core.S_shipped      | 1158 +++
 arch/arm/crypto/poly1305-glue.c              |  271 +
 arch/arm64/Kconfig                           |    2 +-
 arch/arm64/crypto/Kconfig                    |    6 +
 arch/arm64/crypto/Makefile                   |   10 +-
 arch/arm64/crypto/chacha-neon-glue.c         |   14 +-
 arch/arm64/crypto/poly1305-armv8.pl          |  913 +++
 arch/arm64/crypto/poly1305-core.S_shipped    |  835 ++
 arch/arm64/crypto/poly1305-glue.c            |  227 +
 arch/riscv/Kconfig                           |    2 +-
 arch/x86/Kconfig                             |    2 +-
 arch/x86/crypto/Makefile                     |    3 +
 arch/x86/crypto/blake2s-core.S               |  685 ++
 arch/x86/crypto/blake2s-glue.c               |   73 +
 arch/x86/crypto/chacha_glue.c                |   16 +-
 arch/x86/crypto/curve25519-x86_64.c          | 2379 ++++++
 arch/x86/crypto/poly1305_glue.c              |  148 +-
 crypto/Kconfig                               |   59 +
 crypto/adiantum.c                            |    5 +-
 crypto/chacha_generic.c                      |   44 +-
 crypto/ecc.c                                 |    2 +-
 crypto/nhpoly1305.c                          |    3 +-
 crypto/poly1305_generic.c                    |  196 +-
 drivers/net/Kconfig                          |   30 +
 drivers/net/Makefile                         |    1 +
 drivers/net/wireguard/Makefile               |   18 +
 drivers/net/wireguard/allowedips.c           |  377 +
 drivers/net/wireguard/allowedips.h           |   59 +
 drivers/net/wireguard/cookie.c               |  236 +
 drivers/net/wireguard/cookie.h               |   59 +
 drivers/net/wireguard/device.c               |  460 ++
 drivers/net/wireguard/device.h               |   65 +
 drivers/net/wireguard/main.c                 |   64 +
 drivers/net/wireguard/messages.h             |  128 +
 drivers/net/wireguard/netlink.c              |  621 ++
 drivers/net/wireguard/netlink.h              |   12 +
 drivers/net/wireguard/noise.c                |  807 ++
 drivers/net/wireguard/noise.h                |  131 +
 drivers/net/wireguard/peer.c                 |  239 +
 drivers/net/wireguard/peer.h                 |   83 +
 drivers/net/wireguard/peerlookup.c           |  221 +
 drivers/net/wireguard/peerlookup.h           |   64 +
 drivers/net/wireguard/queueing.c             |   53 +
 drivers/net/wireguard/queueing.h             |  198 +
 drivers/net/wireguard/ratelimiter.c          |  223 +
 drivers/net/wireguard/ratelimiter.h          |   19 +
 drivers/net/wireguard/receive.c              |  595 ++
 drivers/net/wireguard/selftest/allowedips.c  |  682 ++
 drivers/net/wireguard/selftest/counter.c     |  104 +
 drivers/net/wireguard/selftest/ratelimiter.c |  226 +
 drivers/net/wireguard/send.c                 |  424 +
 drivers/net/wireguard/socket.c               |  433 +
 drivers/net/wireguard/socket.h               |   44 +
 drivers/net/wireguard/timers.c               |  241 +
 drivers/net/wireguard/timers.h               |   31 +
 drivers/net/wireguard/version.h              |    1 +
 include/crypto/blake2s.h                     |   56 +
 include/crypto/chacha.h                      |   58 +-
 include/crypto/chacha20poly1305.h            |   48 +
 include/crypto/curve25519.h                  |   28 +
 include/crypto/internal/chacha.h             |   25 +
 include/crypto/internal/poly1305.h           |   45 +
 include/crypto/poly1305.h                    |   43 +-
 include/uapi/linux/wireguard.h               |  190 +
 init/Kconfig                                 |    4 +
 lib/Makefile                                 |    3 +-
 lib/crypto/Makefile                          |   39 +-
 lib/crypto/blake2s-selftest.c                | 2093 +++++
 lib/crypto/blake2s.c                         |  281 +
 lib/{ => crypto}/chacha.c                    |   37 +-
 lib/crypto/chacha20poly1305-selftest.c       | 7394 ++++++++++++++++++
 lib/crypto/chacha20poly1305.c                |  370 +
 lib/crypto/curve25519-fiat32.c               |  864 ++
 lib/crypto/curve25519-hacl64.c               |  788 ++
 lib/crypto/curve25519-selftest.c             | 1321 ++++
 lib/crypto/curve25519.c                      |   86 +
 lib/crypto/poly1305.c                        |  247 +
 lib/ubsan.c                                  |    2 +-
 lib/ubsan.h                                  |    2 +-
 tools/testing/selftests/wireguard/netns.sh   |  503 ++
 87 files changed, 31549 insertions(+), 372 deletions(-)
 create mode 100644 arch/arm/crypto/curve25519-core.S
 create mode 100644 arch/arm/crypto/curve25519-glue.c
 create mode 100644 arch/arm/crypto/poly1305-armv4.pl
 create mode 100644 arch/arm/crypto/poly1305-core.S_shipped
 create mode 100644 arch/arm/crypto/poly1305-glue.c
 create mode 100644 arch/arm64/crypto/poly1305-armv8.pl
 create mode 100644 arch/arm64/crypto/poly1305-core.S_shipped
 create mode 100644 arch/arm64/crypto/poly1305-glue.c
 create mode 100644 arch/x86/crypto/blake2s-core.S
 create mode 100644 arch/x86/crypto/blake2s-glue.c
 create mode 100644 arch/x86/crypto/curve25519-x86_64.c
 create mode 100644 drivers/net/wireguard/Makefile
 create mode 100644 drivers/net/wireguard/allowedips.c
 create mode 100644 drivers/net/wireguard/allowedips.h
 create mode 100644 drivers/net/wireguard/cookie.c
 create mode 100644 drivers/net/wireguard/cookie.h
 create mode 100644 drivers/net/wireguard/device.c
 create mode 100644 drivers/net/wireguard/device.h
 create mode 100644 drivers/net/wireguard/main.c
 create mode 100644 drivers/net/wireguard/messages.h
 create mode 100644 drivers/net/wireguard/netlink.c
 create mode 100644 drivers/net/wireguard/netlink.h
 create mode 100644 drivers/net/wireguard/noise.c
 create mode 100644 drivers/net/wireguard/noise.h
 create mode 100644 drivers/net/wireguard/peer.c
 create mode 100644 drivers/net/wireguard/peer.h
 create mode 100644 drivers/net/wireguard/peerlookup.c
 create mode 100644 drivers/net/wireguard/peerlookup.h
 create mode 100644 drivers/net/wireguard/queueing.c
 create mode 100644 drivers/net/wireguard/queueing.h
 create mode 100644 drivers/net/wireguard/ratelimiter.c
 create mode 100644 drivers/net/wireguard/ratelimiter.h
 create mode 100644 drivers/net/wireguard/receive.c
 create mode 100644 drivers/net/wireguard/selftest/allowedips.c
 create mode 100644 drivers/net/wireguard/selftest/counter.c
 create mode 100644 drivers/net/wireguard/selftest/ratelimiter.c
 create mode 100644 drivers/net/wireguard/send.c
 create mode 100644 drivers/net/wireguard/socket.c
 create mode 100644 drivers/net/wireguard/socket.h
 create mode 100644 drivers/net/wireguard/timers.c
 create mode 100644 drivers/net/wireguard/timers.h
 create mode 100644 drivers/net/wireguard/version.h
 create mode 100644 include/crypto/blake2s.h
 create mode 100644 include/crypto/chacha20poly1305.h
 create mode 100644 include/crypto/curve25519.h
 create mode 100644 include/crypto/internal/chacha.h
 create mode 100644 include/crypto/internal/poly1305.h
 create mode 100644 include/uapi/linux/wireguard.h
 create mode 100644 lib/crypto/blake2s-selftest.c
 create mode 100644 lib/crypto/blake2s.c
 rename lib/{ => crypto}/chacha.c (76%)
 create mode 100644 lib/crypto/chacha20poly1305-selftest.c
 create mode 100644 lib/crypto/chacha20poly1305.c
 create mode 100644 lib/crypto/curve25519-fiat32.c
 create mode 100644 lib/crypto/curve25519-hacl64.c
 create mode 100644 lib/crypto/curve25519-selftest.c
 create mode 100644 lib/crypto/curve25519.c
 create mode 100644 lib/crypto/poly1305.c
 create mode 100755 tools/testing/selftests/wireguard/netns.sh

-- 
2.17.1

