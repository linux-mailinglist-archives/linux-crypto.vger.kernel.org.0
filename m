Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F07271C7C
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Sep 2020 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIUH7X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Sep 2020 03:59:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIUH7T (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E94C1B4FD;
        Mon, 21 Sep 2020 07:59:51 +0000 (UTC)
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
Subject: [RFC PATCH 05/41] random: don't reset entropy to zero on overflow
Date:   Mon, 21 Sep 2020 09:58:21 +0200
Message-Id: <20200921075857.4424-6-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

credit_entropy_bits() adds one or more positive values to the signed
entropy_count and checks if the result is negative afterwards. Note that
because the initial value of entropy_count is positive, a negative result
can happen only on overflow.

However, if the final entropy_count is found to have overflown, a WARN()
is emitted and the entropy_store's entropy count reset to zero. Even
though this case should never happen, it is better to retain previously
available entropy as this will facilitate a future change factoring out
that approximation of the exponential.

Make credit_entropy_bits() tp reset entropy_count to the original value
rather than zero on overflow.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 35e381be20fe..6adac462aa0d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -706,7 +706,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (WARN_ON(entropy_count < 0)) {
 		pr_warn("negative entropy/overflow: pool %s count %d\n",
 			r->name, entropy_count);
-		entropy_count = 0;
+		entropy_count = orig;
 	} else if (entropy_count > pool_size)
 		entropy_count = pool_size;
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
-- 
2.26.2

