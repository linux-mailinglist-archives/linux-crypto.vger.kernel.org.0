Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26FF271C79
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Sep 2020 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUH7W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Sep 2020 03:59:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIUH7T (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DDF8B503;
        Mon, 21 Sep 2020 07:59:53 +0000 (UTC)
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
Subject: [RFC PATCH 07/41] random: let pool_entropy_delta() take nbits in units of 2^-ENTROPY_SHIFT
Date:   Mon, 21 Sep 2020 09:58:23 +0200
Message-Id: <20200921075857.4424-8-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently pool_entropy_delta() expects its nbits argument to be given in
units of integral bits. Using fractional bits for processing intermediate
entropy counts consistently throughout the code will facilitate upcoming
changes to the entropy accounting logic in add_interrupt_randomness().
Replace pool_entropy_delta()'s nbits argument with nfrac, which used to be
a local variable and is expected to be given in units of 2^-ENTROPY_SHIFT.
Adapt the single caller, credit_entropy_bits(), accordingly.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 15dd22d74029..08caa7a691a5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -655,21 +655,20 @@ static void process_random_ready_list(void)
 
 /*
  * Based on the pool's current entropy fill level, specified as
- * base_entropy_count, and the number of new entropy bits to add,
- * return the amount of new entropy to credit. If the 'fast'
- * parameter is set to true, the calculation will be guaranteed to
- * terminate quickly, but this comes at the expense of capping
- * nbits to one half of the pool size.
+ * base_entropy_count, and the number of new entropy bits in units of
+ * 2^-ENTROPY_SHIFT to add, return the amount of new entropy to
+ * credit. If the 'fast' parameter is set to true, the calculation
+ * will be guaranteed to terminate quickly, but this comes at the
+ * expense of capping nbits to one half of the pool size.
  */
 static unsigned int pool_entropy_delta(struct entropy_store *r,
 				       int base_entropy_count,
-				       int nbits, bool fast)
+				       int nfrac, bool fast)
 {
 	const int pool_size = r->poolinfo->poolfracbits;
 	int entropy_count = base_entropy_count;
-	int nfrac = nbits << ENTROPY_SHIFT;
 
-	if (!nbits)
+	if (!nfrac)
 		return 0;
 
 	/*
@@ -729,7 +728,9 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 retry:
 	orig = READ_ONCE(r->entropy_count);
-	entropy_count = orig + pool_entropy_delta(r, orig, nbits, false);
+	entropy_count = orig + pool_entropy_delta(r, orig,
+						  nbits << ENTROPY_SHIFT,
+						  false);
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-- 
2.26.2

