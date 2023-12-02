Return-Path: <linux-crypto+bounces-489-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027ED801A0F
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 03:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8265FB20B81
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016948BE3
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 02:35:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D35B6;
	Fri,  1 Dec 2023 17:01:56 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r9EO9-005zG6-86; Sat, 02 Dec 2023 09:01:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Dec 2023 09:01:54 +0800
Date: Sat, 2 Dec 2023 09:01:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, olivia@selenic.com,
	syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Ian Molton <ian.molton@collabora.co.uk>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] hwrng: core - Fix page fault dead lock on mmap-ed hwrng
Message-ID: <ZWqCAsCUGN1cFIIT@gondor.apana.org.au>
References: <ZWnGV39HJr9uUB2/@gondor.apana.org.au>
 <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>
 <ZWpukgSDlA6UFR6e@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWpukgSDlA6UFR6e@gondor.apana.org.au>

There is a dead-lock in the hwrng device read path.  This triggers
when the user reads from /dev/hwrng into memory also mmap-ed from
/dev/hwrng.  The resulting page fault triggers a recursive read
which then dead-locks.

Fix this by using a stack buffer when calling copy_to_user.

Reported-by: Edward Adam Davis <eadavis@qq.com>
Reported-by: syzbot+c52ab18308964d248092@syzkaller.appspotmail.com
Fixes: 9996508b3353 ("hwrng: core - Replace u32 in driver API with byte array")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 420f155d251f..a3bbdd6e60fc 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -23,10 +23,13 @@
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
+#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+
 static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
@@ -58,7 +61,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 
 static size_t rng_buffer_size(void)
 {
-	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
+	return RNG_BUFFER_SIZE;
 }
 
 static void add_early_randomness(struct hwrng *rng)
@@ -209,6 +212,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			    size_t size, loff_t *offp)
 {
+	u8 buffer[RNG_BUFFER_SIZE];
 	ssize_t ret = 0;
 	int err = 0;
 	int bytes_read, len;
@@ -236,34 +240,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (bytes_read < 0) {
 				err = bytes_read;
 				goto out_unlock_reading;
-			}
-			data_avail = bytes_read;
-		}
-
-		if (!data_avail) {
-			if (filp->f_flags & O_NONBLOCK) {
+			} else if (bytes_read == 0 &&
+				   (filp->f_flags & O_NONBLOCK)) {
 				err = -EAGAIN;
 				goto out_unlock_reading;
 			}
-		} else {
-			len = data_avail;
+
+			data_avail = bytes_read;
+		}
+
+		len = data_avail;
+		if (len) {
 			if (len > size)
 				len = size;
 
 			data_avail -= len;
 
-			if (copy_to_user(buf + ret, rng_buffer + data_avail,
-								len)) {
+			memcpy(buffer, rng_buffer + data_avail, len);
+		}
+		mutex_unlock(&reading_mutex);
+		put_rng(rng);
+
+		if (len) {
+			if (copy_to_user(buf + ret, buffer, len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
 
 		if (need_resched())
 			schedule_timeout_interruptible(1);
@@ -274,6 +281,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		}
 	}
 out:
+	memzero_explicit(buffer, sizeof(buffer));
 	return ret ? : err;
 
 out_unlock_reading:
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

