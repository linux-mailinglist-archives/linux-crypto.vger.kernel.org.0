Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC724C533
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHTSVX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 14:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgHTSVS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 14:21:18 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F7E208E4;
        Thu, 20 Aug 2020 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597947677;
        bh=3aYHNG2HuqdhvavloLqNptJ3Ruqd8JnmWbP5SYLc6Wc=;
        h=From:To:Cc:Subject:Date:From;
        b=uLbZnRzDri2ck4cV0adxN47EiNtKH10LxcAg+L4o3DpW8Kj/NijZd/jZBa4UlZ3Pi
         zIZOJpTBqilKf/I5oe3iMvRIjevANsfw8V7byWoGUax55oZnyunjrzxGfhfaazdRYr
         PHUdbhdPuhePfCOfOvHnT06KrjkBV3QCFAhSZV+o=
From:   Eric Biggers <ebiggers@kernel.org>
To:     ltp@lists.linux.it
Cc:     linux-crypto@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [LTP PATCH 0/2] ltp: fix af_alg02 to specify control data
Date:   Thu, 20 Aug 2020 11:19:16 -0700
Message-Id: <20200820181918.404758-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

It isn't clearly defined what happens if you read from an AF_ALG request
socket without previously sending the control data to begin an
encryption or decryption operation.  On some kernels the read will
return 0, while on others it will block.

Testing this corner case isn't the purpose of af_alg02; it just wants to
try to encrypt a zero-length message.  So, change it to explicitly send
a zero-length message with control data.

This fixes the test failure reported at
https://lkml.kernel.org/r/CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com

Fixing the test in this way was also previously suggested at
https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au

Note, this patch doesn't change the fact that the read() still blocks on
pre-4.14 kernels (which is a kernel bug), and thus the timeout logic in
the test is still needed.

Eric Biggers (2):
  lib/tst_af_alg: add tst_alg_sendmsg()
  crypto/af_alg02: send message with control data before reading

 include/tst_af_alg.h               | 32 +++++++++++++++
 lib/tst_af_alg.c                   | 64 ++++++++++++++++++++++++++++++
 testcases/kernel/crypto/af_alg02.c | 21 ++++++++--
 3 files changed, 114 insertions(+), 3 deletions(-)

-- 
2.28.0

