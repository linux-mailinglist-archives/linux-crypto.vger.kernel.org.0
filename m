Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5889E0EF9
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Oct 2019 02:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfJWAMc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 20:12:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732131AbfJWAMb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 20:12:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65727B03D;
        Wed, 23 Oct 2019 00:12:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67B81DA734; Wed, 23 Oct 2019 02:12:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, ebiggers@kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v6 0/2]  BLAKE2b generic implementation
Date:   Wed, 23 Oct 2019 02:12:38 +0200
Message-Id: <cover.1571788861.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The patchset adds blake2b reference implementation and test vectors.

V6:

Patch 2/2: test vectors fixed to actually match the proposed table of
key and plaintext combinations. I shamelessly copied the test vector
value format that Ard uses for the blake2s test vectors. The array
blake2b_ordered_sequence can be shared between 2s and 2b but as the
patchsets go separate, unification would have to happen once both
are merged.

Tested on x86_64 with KASAN and SLUB_DEBUG.

V1: https://lore.kernel.org/linux-crypto/cover.1569849051.git.dsterba@suse.com/
V2: https://lore.kernel.org/linux-crypto/e31c2030fcfa7f409b2c81adf8f179a8a55a584a.1570184333.git.dsterba@suse.com/
V3: https://lore.kernel.org/linux-crypto/e7f46def436c2c705c0b2cac3324f817efa4717d.1570715842.git.dsterba@suse.com/
V4: https://lore.kernel.org/linux-crypto/cover.1570812094.git.dsterba@suse.com/
V5: https://lore.kernel.org/linux-crypto/cover.1571043883.git.dsterba@suse.com/

David Sterba (2):
  crypto: add blake2b generic implementation
  crypto: add test vectors for blake2b

 crypto/Kconfig           |  17 ++
 crypto/Makefile          |   1 +
 crypto/blake2b_generic.c | 413 +++++++++++++++++++++++++++++++++++++++
 crypto/testmgr.c         |  28 +++
 crypto/testmgr.h         | 307 +++++++++++++++++++++++++++++
 include/crypto/blake2b.h |  46 +++++
 6 files changed, 812 insertions(+)
 create mode 100644 crypto/blake2b_generic.c
 create mode 100644 include/crypto/blake2b.h

-- 
2.23.0

