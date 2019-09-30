Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D04C2187
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2019 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfI3NMt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Sep 2019 09:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728214AbfI3NMt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Sep 2019 09:12:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6B5DACA5;
        Mon, 30 Sep 2019 13:12:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22972DA88C; Mon, 30 Sep 2019 15:13:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/1] BLAKE2
Date:   Mon, 30 Sep 2019 15:13:05 +0200
Message-Id: <cover.1569849051.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

there's another implementation of blake2s in the list from today, I was waiting
with my patches post rc1 so I'm sending it as it was. My usecase is for 'BLAKE2b'.

---

The patch brings support of several BLAKE2 algorithms (2b, 2s, various digest
lengths). The in-tree user will be btrfs (for checksumming), we're going to use
the BLAKE2b-256 variant. It would be ideal if the patches get merged to 5.5,
thats our target to release the support of new hashes.

The code is reference implementation taken from the official sources and
slightly modified only in terms of kernel coding style (whitespace, comments,
uintXX_t -> uXX types, removed unused prototypes and #ifdefs, removed testing
code, changed secure_zero_memory -> memzero_explicit).

The crypto API definitions have been copied from sha3_generic.c, so there's
list of the digests as shown in RFC 7693 (while BLAKE2 supports 1-32 or 1-64
respectively).

I'm not sure about the licensing, so I'd appreaciate a review here. The blake2
code is CC0 or OpenSSL or Apache 2.0, the last one being in linux/LICENSES, so
I picked that one. For the other code it's GPL2-only, as other code I write for
kernel. The SPDX string is "SPDX-License-Identifier: (GPL-2.0-only OR Apache-2.0)".

Remaining items:

- add test vectors (available in official sources)
- add optimized versions for x86_64 and ARM (dtto)

Other than that, I tried to keep the style of the sources close to what I read
elsewhere in crypto/, but please let me know about things to fix up or update
or if it's preferred to split the patch.

d.

David Sterba (1):
  crypto: blake2s reference implementation

 crypto/Kconfig           |  35 +++
 crypto/Makefile          |   2 +
 crypto/blake2-impl.h     | 145 +++++++++++++
 crypto/blake2.h          | 143 +++++++++++++
 crypto/blake2b_generic.c | 445 ++++++++++++++++++++++++++++++++++++++
 crypto/blake2s_generic.c | 446 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 1216 insertions(+)
 create mode 100644 crypto/blake2-impl.h
 create mode 100644 crypto/blake2.h
 create mode 100644 crypto/blake2b_generic.c
 create mode 100644 crypto/blake2s_generic.c

-- 
2.23.0

