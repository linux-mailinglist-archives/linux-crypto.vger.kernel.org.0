Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C246298223
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Oct 2020 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416754AbgJYObb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 25 Oct 2020 10:31:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40859 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416752AbgJYOba (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 25 Oct 2020 10:31:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id h140so6049522qke.7;
        Sun, 25 Oct 2020 07:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2UMZm4fcybM+vIIp7oarjvWnFnvnqafI+zu+Zq1CF8=;
        b=CByY9S5eChDUvReJ8HF4vtDOzK9ugiI2BDLU/wTQwlHPdU7EnCjBf9jEIUq3L/iCrH
         JkUR0zwURpR8llp5WwRZk4eg/ktKF2mbwdA0EPAgHay5t0hpeT8Pa0gGenhFVfCeCC46
         MgOmdV+yfvuT2ODbAdRvq5hqbBBh+QZtiWBcj+8zRjHQPMo8JUejRlrEEI4edMx5aVIG
         UHQtLFOJp7rFHn4swbCqVjHfVHbHAD801WjoCYIt7qTfwN47YG6KIHnanTvBubtmFrmO
         +GKCfKrFq4MZfrhcryYD0PcL8/2gzf7KZz2kLmNinuo0MQug2P7JITXegHRr9ewIVs5u
         Aqjg==
X-Gm-Message-State: AOAM5319/1Avqa2sd5g8Q3J2wUSLqGaO0breg8CUq/ouwitiJmwj5Doh
        18q+W4ULbERu8EQYAC4KaolM0HhQVLHNgg==
X-Google-Smtp-Source: ABdhPJw10C/oZFL0qO/mz2dWvCyInZZwaHLUbNWqaIcyU4bXqKKyKpVCWOIhjtZYT3CzjtqlzBos0Q==
X-Received: by 2002:a05:620a:21d1:: with SMTP id h17mr13082876qka.368.1603636282234;
        Sun, 25 Oct 2020 07:31:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s73sm4740898qke.71.2020.10.25.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 07:31:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] crypto: lib/sha256 - cleanup/optimization
Date:   Sun, 25 Oct 2020 10:31:13 -0400
Message-Id: <20201025143119.1054168-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Patch 1/2 -- Use memzero_explicit() instead of structure assignment/plain
memset() to clear sensitive state.

Patch 3 -- Currently the temporary variables used in the generic sha256
implementation are cleared, but the clearing is optimized away due to
lack of compiler barriers. Drop the clearing.

The last three patches are optimizations for generic sha256.

v4:
- Split the first patch into two, the first one just does
  lib/crypto/sha256.c, so that the second one can be applied or dropped
  depending on the outcome of the discussion between Herbert/Eric.

v3:
- Add some more files to patch 1
- Reword commit message for patch 2
- Reformat SHA256_K array
- Drop v2 patch combining K and W arrays

v2:
- Add patch to combine K and W arrays, suggested by David
- Reformat SHA256_ROUND() macro a little

Arvind Sankar (6):
  crypto: lib/sha256 - Use memzero_explicit() for clearing state
  crypto: Use memzero_explicit() for clearing state
  crypto: lib/sha256 - Don't clear temporary variables
  crypto: lib/sha256 - Clear W[] in sha256_update() instead of
    sha256_transform()
  crypto: lib/sha256 - Unroll SHA256 loop 8 times intead of 64
  crypto: lib/sha256 - Unroll LOAD and BLEND loops

 arch/arm64/crypto/ghash-ce-glue.c |   2 +-
 arch/arm64/crypto/poly1305-glue.c |   2 +-
 arch/arm64/crypto/sha3-ce-glue.c  |   2 +-
 arch/x86/crypto/poly1305_glue.c   |   2 +-
 include/crypto/sha1_base.h        |   3 +-
 include/crypto/sha256_base.h      |   3 +-
 include/crypto/sha512_base.h      |   3 +-
 include/crypto/sm3_base.h         |   3 +-
 lib/crypto/sha256.c               | 212 +++++++++---------------------
 9 files changed, 76 insertions(+), 156 deletions(-)

-- 
2.26.2

