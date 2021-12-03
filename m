Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524D54679A8
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Dec 2021 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381572AbhLCOuT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Dec 2021 09:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381595AbhLCOuJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Dec 2021 09:50:09 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C07BC061D5F
        for <linux-crypto@vger.kernel.org>; Fri,  3 Dec 2021 06:46:45 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id ay10-20020a5d9d8a000000b005e238eaeaa9so2419916iob.12
        for <linux-crypto@vger.kernel.org>; Fri, 03 Dec 2021 06:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QsxayFD0kSuupxPAlrDY1PLwKJKslxAp42nuzbNIjyc=;
        b=S37/Z/1EV8P8Kr2/jN4oC0OACqVv3Rq2r/TMoUbyRT95hskGw5Ac/BA/osek4vqjBG
         aPd1B8nkUo0WwdGAD/s5OBU0zquwpdRcvxkvXSYZR5KHCIl99GPFB9/xBsHpXgqdFAu+
         V4rPu6u4+NBAunYs/yitmqd3ImOA7NS/myakKDTSs6xzHux9PPzlrryyMERfNhdqAWKV
         RpguqkpdastYUc6rn75OmVnUu9F5j05N24VzHWi3fk+0opswkX46Ax7pJrD91eDnOMDS
         hqkoPr4xANSvt7oMryhKVX9d7qTJmFisEfg8fiQka/BMOwqHNTyrvLFEe4TC62d8AZ+R
         eCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QsxayFD0kSuupxPAlrDY1PLwKJKslxAp42nuzbNIjyc=;
        b=GJePId1wSp3YAJr03z5u58zmJp5AJW6e0iUCS5Bf+UVcC+3PDDnmdsLiZ2CxX0rVKQ
         S1SidCOX/fEDSevuQ6HQupCAoCBAFYN6BUIrwcvMEGpaLWGxeLZiuY8b66oktqKJR7Xx
         ACZzMsozhjJXwPXJIsDi5rNZRIGtDGTr5A5aKgww5+SHQVME2cBXN8yQcMddGh5dPMTE
         f5ATwvnXIA2IMAA8g33QchKTkBFnt9rRDyp4Qz+Covfga9AtFxjBBdtVMZHIZWsxXSSr
         iJ39Eb3qjkTUoDyTIIQHelh3h6MFxKUtBtBhyvg2CLAkZ8Ju/D2uqCPie5iJjlrJidmJ
         1rRg==
X-Gm-Message-State: AOAM533qnXWhHoACuJnBdBOUwFMJA9JJ7b+G0fI57hCZvSIzCevZoum+
        yzn/nzg0Zb2UJLQiP3ncJtXPfMUI0A0=
X-Google-Smtp-Source: ABdhPJyOGt4g5EWzqW6UP63ydOdGYyK8gCrTK1Rv8b5hydUWnUdaHl+T7HfnSIcyYEnbmy+3lFBGAA0orjw=
X-Received: from pgonda2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:ac9])
 (user=pgonda job=sendgmr) by 2002:a05:6638:1311:: with SMTP id
 r17mr24842979jad.69.1638542804473; Fri, 03 Dec 2021 06:46:44 -0800 (PST)
Date:   Fri,  3 Dec 2021 14:46:37 +0000
Message-Id: <20211203144642.3460447-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH V5 0/5] Add SEV_INIT_EX support
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SEV_INIT requires users to unlock their SPI bus for the PSP's non
volatile (NV) storage. Users may wish to lock their SPI bus for numerous
reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
allows the firmware to use a region of memory for its NV storage leaving
the kernel responsible for actually storing the data in a persistent
way. This series adds a new module parameter to ccp allowing users to
specify a path to a file for use as the PSP's NV storage. The ccp driver
then reads the file into memory for the PSP to use and is responsible
for writing the file whenever the PSP modifies the memory region.

V4
* Fix make C=1 W=1 warnings.

V3
* Add another module parameter 'psp_init_on_probe' to allow for skipping
  PSP init on module init.
* Fixes review comments from Sean.
* Fixes missing error checking with file reading.
* Removed setting 'error' to a set value in patch 1.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

David Rientjes (1):
  crypto: ccp - Add SEV_INIT_EX support

Peter Gonda (4):
  crypto: ccp - Add SEV_INIT rc error logging on init
  crypto: ccp - Move SEV_INIT retry for corrupted data
  crypto: ccp - Refactor out sev_fw_alloc()
  crypto: ccp - Add psp_init_on_probe module parameter

 .../virt/kvm/amd-memory-encryption.rst        |   6 +
 drivers/crypto/ccp/sev-dev.c                  | 258 +++++++++++++++---
 include/linux/psp-sev.h                       |  21 ++
 3 files changed, 245 insertions(+), 40 deletions(-)

-- 
2.34.0.384.gca35af8252-goog

