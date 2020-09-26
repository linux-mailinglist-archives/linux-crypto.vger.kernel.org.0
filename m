Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F7279863
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Sep 2020 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIZK05 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 26 Sep 2020 06:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZK05 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 26 Sep 2020 06:26:57 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA66238E2;
        Sat, 26 Sep 2020 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601116017;
        bh=xqiPUAST54JTB0j3DmJS5nGLUhpSj79eXiwW+1nWHWw=;
        h=From:To:Cc:Subject:Date:From;
        b=U0uU0PUF2upCmLHhsB5yH6QwoxiAfG+rgxZPDSpNWxj3fdI94gGUI8vawYu4uWp32
         ft9JtTLBjhKie24JOviTP/WFaKutRSq+ZjKQPIL9E5ER8UM3KSNXcRrNYZSq1EQgNw
         6zPVcJNxejg+wu7iYvsu7ItttVBLOVNHpHRx3wqE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Laight <David.Laight@aculab.com>
Subject: [PATCH v2 0/2] crypto: xor - defer and optimize boot time benchmark
Date:   Sat, 26 Sep 2020 12:26:49 +0200
Message-Id: <20200926102651.31598-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Doug reports [0] that the XOR boot time benchmark takes more time than
necessary, and runs at a time when there is little room for other
boot time tasks to run concurrently.

Let's fix this by #1 deferring the benchmark, and #2 uses a faster
implementation.

Changes since v2:
- incorporate Doug's review feedback re coarse clocks and the use of pr_info
- add Doug's ack to #1

[0] https://lore.kernel.org/linux-arm-kernel/20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid/

Cc: Douglas Anderson <dianders@chromium.org>
Cc: David Laight <David.Laight@aculab.com>

Ard Biesheuvel (2):
  crypto: xor - defer load time benchmark to a later time
  crypto: xor - use ktime for template benchmarking

 crypto/xor.c | 67 +++++++++++++-------
 1 file changed, 44 insertions(+), 23 deletions(-)

-- 
2.17.1

