Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2613FD5E79
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 11:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfJNJRp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 05:17:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730797AbfJNJRo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 05:17:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B41D4B974;
        Mon, 14 Oct 2019 09:17:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA99DDA7E3; Mon, 14 Oct 2019 11:16:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ebiggers@google.com, ard.biesheuvel@linaro.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 0/2]  BLAKE2b generic implementation
Date:   Mon, 14 Oct 2019 11:16:42 +0200
Message-Id: <cover.1571043883.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The patchset adds blake2b refrerence implementation and test vectors.

V5:

- removed return 0 and switched to void in blake2 functions
- reordered shash_alg definition so that .base.* are first (this seems
  to be the preferred ordering from what I saw in recent patches in the
  mailinglist)
- added note to blake2b_generic.c about changes made for kernel
  inclusion
- test vectors reworked so that key length and input length are
  distributed over all digest sizes

Tested on x86_64 with KASAN and SLUB_DEBUG.

V1: https://lore.kernel.org/linux-crypto/cover.1569849051.git.dsterba@suse.com/
V2: https://lore.kernel.org/linux-crypto/e31c2030fcfa7f409b2c81adf8f179a8a55a584a.1570184333.git.dsterba@suse.com/
V3: https://lore.kernel.org/linux-crypto/e7f46def436c2c705c0b2cac3324f817efa4717d.1570715842.git.dsterba@suse.com/
V4: https://lore.kernel.org/linux-crypto/cover.1570812094.git.dsterba@suse.com/

David Sterba (2):
  crypto: add blake2b generic implementation
  crypto: add test vectors for blake2b

 crypto/Kconfig           |  17 +
 crypto/Makefile          |   1 +
 crypto/blake2b_generic.c | 413 ++++++++++++++++++++++
 crypto/testmgr.c         |  28 ++
 crypto/testmgr.h         | 719 +++++++++++++++++++++++++++++++++++++++
 include/crypto/blake2b.h |  46 +++
 6 files changed, 1224 insertions(+)
 create mode 100644 crypto/blake2b_generic.c
 create mode 100644 include/crypto/blake2b.h

-- 
2.23.0

