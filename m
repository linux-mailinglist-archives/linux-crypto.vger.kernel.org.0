Return-Path: <linux-crypto+bounces-18-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD37E4633
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FA1B20A45
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3069347BB
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFlkUy2R"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D99315AB
	for <linux-crypto@vger.kernel.org>; Tue,  7 Nov 2023 15:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E22C4339A;
	Tue,  7 Nov 2023 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372512;
	bh=rN34HJccc0MgnxiL7U+b7CMTWpNgY13wMW9CktmJ3bI=;
	h=From:To:Cc:Subject:Date:From;
	b=DFlkUy2RX3kAUtDXc76yeVcvkDWX1yimD8IhcWFctJ92Coin61EnYdf+bFm5CKmut
	 X1Yahvd5630OLxovMoTu33Toa0sdviSelQQ+1a7AnQeTYBUSP1r+zfrpa68lCJKFhm
	 CwtwTyX4D5mP/7WHdJPuUN84y+AFapnJ/d9EhzNIOtKnqyw14HWY+TAt7sXv5kVzTr
	 0upRfMXGJ0hqs5w8GmPGwQjqQ9lRJXrQyHJMLCMSD+hRqnwmOj+rPzu9RxbM3Lz/kq
	 c7+74Yc0sHHUV6oQ9URfH10zFcUstGTVaflhxBdabSsPu7gUPfzuTc18PN8EmnT1Em
	 S2ck/52HDnK0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Jialin <lujialin4@huawei.com>,
	Guo Zihua <guozihua@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	steffen.klassert@secunet.com,
	davem@davemloft.net,
	daniel.m.jordan@oracle.com,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/9] crypto: pcrypt - Fix hungtask for PADATA_RESET
Date: Tue,  7 Nov 2023 10:54:51 -0500
Message-ID: <20231107155509.3769038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit

From: Lu Jialin <lujialin4@huawei.com>

[ Upstream commit 8f4f68e788c3a7a696546291258bfa5fdb215523 ]

We found a hungtask bug in test_aead_vec_cfg as follows:

INFO: task cryptomgr_test:391009 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Call trace:
 __switch_to+0x98/0xe0
 __schedule+0x6c4/0xf40
 schedule+0xd8/0x1b4
 schedule_timeout+0x474/0x560
 wait_for_common+0x368/0x4e0
 wait_for_completion+0x20/0x30
 wait_for_completion+0x20/0x30
 test_aead_vec_cfg+0xab4/0xd50
 test_aead+0x144/0x1f0
 alg_test_aead+0xd8/0x1e0
 alg_test+0x634/0x890
 cryptomgr_test+0x40/0x70
 kthread+0x1e0/0x220
 ret_from_fork+0x10/0x18
 Kernel panic - not syncing: hung_task: blocked tasks

For padata_do_parallel, when the return err is 0 or -EBUSY, it will call
wait_for_completion(&wait->completion) in test_aead_vec_cfg. In normal
case, aead_request_complete() will be called in pcrypt_aead_serial and the
return err is 0 for padata_do_parallel. But, when pinst->flags is
PADATA_RESET, the return err is -EBUSY for padata_do_parallel, and it
won't call aead_request_complete(). Therefore, test_aead_vec_cfg will
hung at wait_for_completion(&wait->completion), which will cause
hungtask.

The problem comes as following:
(padata_do_parallel)                 |
    rcu_read_lock_bh();              |
    err = -EINVAL;                   |   (padata_replace)
                                     |     pinst->flags |= PADATA_RESET;
    err = -EBUSY                     |
    if (pinst->flags & PADATA_RESET) |
        rcu_read_unlock_bh()         |
        return err

In order to resolve the problem, we replace the return err -EBUSY with
-EAGAIN, which means parallel_data is changing, and the caller should call
it again.

v3:
remove retry and just change the return err.
v2:
introduce padata_try_do_parallel() in pcrypt_aead_encrypt and
pcrypt_aead_decrypt to solve the hungtask.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
Signed-off-by: Guo Zihua <guozihua@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 4 ++++
 kernel/padata.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 62e11835f220e..1e9de81ef84fa 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -174,6 +174,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pencrypt);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
@@ -218,6 +220,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pdecrypt);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
diff --git a/kernel/padata.c b/kernel/padata.c
index f56ec63f60ba8..82f6d5bf5cb45 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -120,7 +120,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 	if (!cpumask_test_cpu(cb_cpu, pd->cpumask.cbcpu))
 		goto out;
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-- 
2.42.0


