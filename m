Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F8271CC0
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Sep 2020 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIUIBc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Sep 2020 04:01:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgIUH7j (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 874A5B52A;
        Mon, 21 Sep 2020 08:00:06 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Petr Tesarik <ptesarik@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH 30/41] random: add a queued_entropy instance to struct fast_pool
Date:   Mon, 21 Sep 2020 09:58:46 +0200
Message-Id: <20200921075857.4424-31-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When health tests are introduced with upcoming patches, it will become
necessary to keep entropy queued across add_interrupt_randomness()
invocations for later dispatch to the global balance.

Prepare for this by adding a struct queued_entropy member to the per-CPU
fast_pool. Use it in place of that queue with automatic storage duration
in add_interrupt_randomness().

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 55e784a5a2ec..37746df53acf 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -885,6 +885,7 @@ struct fast_pool {
 	unsigned short	reg_idx;
 	unsigned char	count;
 	int		event_entropy_shift;
+	struct queued_entropy	q;
 };
 
 /*
@@ -1655,7 +1656,7 @@ void add_interrupt_randomness(int irq, int irq_flags)
 	__u32			c_high, j_high;
 	__u64			ip;
 	bool			reseed;
-	struct queued_entropy	q = { 0 };
+	struct queued_entropy	*q = &fast_pool->q;
 	unsigned int		nfrac;
 
 	if (cycles == 0)
@@ -1700,9 +1701,9 @@ void add_interrupt_randomness(int irq, int irq_flags)
 		nfrac = fast_pool_entropy(fast_pool->count,
 					  fast_pool->event_entropy_shift);
 	}
-	__queue_entropy(r, &q, nfrac);
+	__queue_entropy(r, q, nfrac);
 	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
-	reseed = __dispatch_queued_entropy_fast(r, &q);
+	reseed = __dispatch_queued_entropy_fast(r, q);
 	spin_unlock(&r->lock);
 
 	fast_pool->last = now;
-- 
2.26.2

