Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EE2DBF1E
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Dec 2020 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLPLAW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Dec 2020 06:00:22 -0500
Received: from inet10.abb.com ([138.225.1.74]:36128 "EHLO inet10.abb.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgLPLAT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Dec 2020 06:00:19 -0500
Received: from gitsiv.ch.abb.com (gitsiv.keymile.net [10.41.156.251])
        by inet10.abb.com (8.14.7/8.14.7) with SMTP id 0BGAxHjs013605;
        Wed, 16 Dec 2020 11:59:17 +0100
Received: from ch900154.keymile.net (ch900154.keymile.net [172.31.40.201])
        by gitsiv.ch.abb.com (Postfix) with ESMTP id 5DD7461088F1;
        Wed, 16 Dec 2020 11:59:17 +0100 (CET)
From:   Luca Dariz <luca.dariz@hitachi-powergrids.com>
To:     linux-crypto@vger.kernel.org
Cc:     Luca Dariz <luca.dariz@hitachi-powergrids.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Holger Brunck <holger.brunck@hitachi-powergrids.com>,
        Valentin Longchamp <valentin.longchamp@hitachi-powergrids.com>
Subject: [PATCH v2] hwrng: fix khwrng lifecycle
Date:   Wed, 16 Dec 2020 11:59:06 +0100
Message-Id: <20201216105906.6607-1-luca.dariz@hitachi-powergrids.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

There are two issues with the management of the kernel thread to gather
entropy:
* it can terminate also if the rng is removed, and in this case it doesn'=
t
  synchronize with kthread_should_stop(), but it directly sets hwrng_fill
  to NULL. If this happens after the NULL check but before kthread_stop()
  is called, we'll have a NULL pointer dereference.
* if we have a register/unregister too fast, it can happen that the kthre=
ad
  is not yet started when kthread_stop is called, and this seems to leave=
 a
  corrupted or uninitialized kthread struct. This is detected by the
  WARN_ON at kernel/kthread.c:75 and later causes a page domain fault.

CC: Matt Mackall <mpm@selenic.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Colin Ian King <colin.king@canonical.com>
CC: Holger Brunck <holger.brunck@hitachi-powergrids.com>
CC: Valentin Longchamp <valentin.longchamp@hitachi-powergrids.com>
Signed-off-by: Luca Dariz <luca.dariz@hitachi-powergrids.com>
---
v2:
* reduced sleep from 10s to 10ms in case there is no rng; the termination
  should be faster in this case as it could block a pending register or
  unregister.

 drivers/char/hw_random/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.=
c
index 8c1c47dd9f46..367b122c1d70 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -31,6 +31,7 @@ static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
 static struct task_struct *hwrng_fill;
+static struct completion hwrng_started =3D COMPLETION_INITIALIZER(hwrng_=
started);
 /* list of registered rngs, sorted decending by quality */
 static LIST_HEAD(rng_list);
 /* Protects rng_list and current_rng */
@@ -432,12 +433,15 @@ static int hwrng_fillfn(void *unused)
 {
 	long rc;
=20
+	complete(&hwrng_started);
 	while (!kthread_should_stop()) {
 		struct hwrng *rng;
=20
 		rng =3D get_current_rng();
-		if (IS_ERR(rng) || !rng)
-			break;
+		if (IS_ERR(rng) || !rng) {
+			msleep_interruptible(10);
+			continue;
+		}
 		mutex_lock(&reading_mutex);
 		rc =3D rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
@@ -462,6 +466,8 @@ static void start_khwrngd(void)
 	if (IS_ERR(hwrng_fill)) {
 		pr_err("hwrng_fill thread creation failed\n");
 		hwrng_fill =3D NULL;
+	} else {
+		wait_for_completion(&hwrng_started);
 	}
 }
=20
--=20
2.24.3

