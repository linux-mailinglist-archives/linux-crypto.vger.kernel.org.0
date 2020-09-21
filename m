Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98287271CA3
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Sep 2020 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIUIA1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Sep 2020 04:00:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgIUH7W (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82889B505;
        Mon, 21 Sep 2020 07:59:55 +0000 (UTC)
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
Subject: [RFC PATCH 11/41] random: convert add_timer_randomness() to queued_entropy API
Date:   Mon, 21 Sep 2020 09:58:27 +0200
Message-Id: <20200921075857.4424-12-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In an effort to drop __credit_entropy_bits_fast() in favor of the new
__queue_entropy()/__dispatch_queued_entropy_fast() API, convert
add_timer_randomness() from the former to the latter.

There is no change in functionality at this point, because
__credit_entropy_bits_fast() has already been reimplemented on top of the
new API before.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b91d1fc08ac5..e8c86abde901 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1400,6 +1400,7 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	long delta, delta2, delta3;
 	bool reseed;
 	unsigned long flags;
+	struct queued_entropy q = { 0 };
 
 	sample.jiffies = jiffies;
 	sample.cycles = random_get_entropy();
@@ -1432,13 +1433,14 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 
 	r = &input_pool;
 	spin_lock_irqsave(&r->lock, flags);
-	__mix_pool_bytes(r, &sample, sizeof(sample));
 	/*
 	 * delta is now minimum absolute delta.
 	 * Round down by 1 bit on general principles,
 	 * and limit entropy estimate to 12 bits.
 	 */
-	reseed = __credit_entropy_bits_fast(r, min_t(int, fls(delta>>1), 11));
+	__queue_entropy(r, &q, min_t(int, fls(delta>>1), 11) << ENTROPY_SHIFT);
+	__mix_pool_bytes(r, &sample, sizeof(sample));
+	reseed = __dispatch_queued_entropy_fast(r, &q);
 	spin_unlock_irqrestore(&r->lock, flags);
 	if (reseed)
 		crng_reseed(&primary_crng, r);
-- 
2.26.2

