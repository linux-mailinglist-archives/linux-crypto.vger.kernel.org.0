Return-Path: <linux-crypto+bounces-23839-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qExvN1Ve/WlWbgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23839-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 05:53:57 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FFD4F14C3
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 05:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558663019B8C
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7731E849;
	Fri,  8 May 2026 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GUryWDoq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CA155757;
	Fri,  8 May 2026 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212182; cv=none; b=uj2YSwm1SbTDUmH4Poef2GmJHNz34EqmkWsDC3kcj99YXC0U65ft/dGw8gsHcAPElM+GB8cIFIwzvxPkGJINr/1Zu+7btrNNTjEh1Uwl0g0H3gLX1UrM333nTD03uhoYvZ/Z7z/iGq4QzSBQ+rpsAnIhtFhK6f6e2xODYW/Vh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212182; c=relaxed/simple;
	bh=GNiaMGYE4dBVY4/4xbXo67oxqDypq66Fiv8HnCVyQYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MgXOTshUQwuCjXwO8lVX5C1Ejcthx2a8WeRKzrQ/YNu7QIFGqLoyFtTZ+Jox1uFfi9WP2jR3R0jm5EDcAdOVBxueQZDXMA+XI7IrgbpqbWUPjfeGqa70YetLTxst7hNEU/H8aPz7+31lKeVRCIPbZTTTDdJlS2AaQTbAZWdb05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GUryWDoq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hJ
	YJHhnbM9+n6PfPUg9Pab7ckJ84rm0ujgzU6aJxi/M=; b=GUryWDoqBRIDwLjH+1
	xgNc4LTGR906jMREFFprUYQe0U/tTVewejXbrE9ogV2boWqwToRvgkup7yFuwhTw
	/FIrjZGXMtG1a1Xnmr8UyJ4LRcF66TLPSsKlRzwpJlIcrvObY9NAH66wbHjxtVaf
	m/61x2dXBOdEpY0lUeCirVJvk=
Received: from wmy.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHNvYdXf1p1mxHCw--.12153S2;
	Fri, 08 May 2026 11:48:56 +0800 (CST)
From: w15303746062@163.com
To: giovanni.cabiddu@intel.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: thorsten.blum@linux.dev,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] crypto: qat - remove noisy error prints in ioctl paths to prevent DoS
Date: Fri,  8 May 2026 11:48:41 +0800
Message-Id: <20260508034841.256794-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHNvYdXf1p1mxHCw--.12153S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1rAr1rJw43Zr18uw47CFg_yoW5Kw43pr
	yrK34xtryDJwsrK3Wq93y8Za4F934qg3yYkF9rGa4fu3ZFgry8Ca13Ka4ayFW8CFyxuFW2
	qa4jvry2ga1DK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j718PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wg7H2n9XShVOgAA3B
X-Rspamd-Queue-Id: 60FFD4F14C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23839-lists,linux-crypto=lfdr.de];
	R_DKIM_ALLOW(0.00)[163.com:s=s110527];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.342];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A Local Denial of Service (DoS) vulnerability was observed in the QAT
driver. A malicious user or a fuzzing tool can repeatedly issue various
QAT ioctls with invalid user-space pointers or unknown commands.

Currently, failures in memdup_user() and copy_from_user() trigger
unconditional pr_err() and dev_err() messages. Similarly, invalid
ioctl commands trigger an unconditional print. In environments
with slow serial consoles (e.g., console=ttyS0), this creates a massive
printk storm. This forces the CPU into a lengthy spin with interrupts
disabled, leading to RCU stalls, multi-core soft lockups, and ultimately
triggering the system watchdog panic.

It is a well-known kernel anti-pattern to allow user-space to spam the
kernel log buffer simply by passing invalid arguments to an ioctl.

Fix this by removing these useless error prints from the user-copy
failure paths and the default ioctl switch case. The kernel correctly
returns -EFAULT or -ENOTTY, which is entirely sufficient for user-space
to understand the failure, without exhausting kernel logging resources.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
index c2e6f0cb7480..546ef1ac82dc 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
@@ -94,8 +94,6 @@ static struct adf_user_cfg_ctl_data *adf_ctl_alloc_resources(unsigned long arg)
 	struct adf_user_cfg_ctl_data *cfg_data;
 
 	cfg_data = memdup_user((void __user *)arg, sizeof(*cfg_data));
-	if (IS_ERR(cfg_data))
-		pr_err("QAT: failed to copy from user cfg_data.\n");
 	return cfg_data;
 }
 
@@ -139,8 +137,6 @@ static int adf_copy_key_value_data(struct adf_accel_dev *accel_dev,
 	for (i = 0; section_head && i < ADF_CFG_MAX_SECTION; i++) {
 		if (copy_from_user(&section, (void __user *)section_head,
 				   sizeof(*section_head))) {
-			dev_err(&GET_DEV(accel_dev),
-				"failed to copy section info\n");
 			goto out_err;
 		}
 
@@ -155,8 +151,6 @@ static int adf_copy_key_value_data(struct adf_accel_dev *accel_dev,
 		for (j = 0; params_head && j < ADF_CFG_MAX_KEY_VAL; j++) {
 			if (copy_from_user(&key_val, (void __user *)params_head,
 					   sizeof(key_val))) {
-				dev_err(&GET_DEV(accel_dev),
-					"Failed to copy keyvalue.\n");
 				goto out_err;
 			}
 			if (adf_add_key_value_data(accel_dev, section.name,
@@ -335,7 +329,6 @@ static int adf_ctl_ioctl_get_status(struct file *fp, unsigned int cmd,
 
 	if (copy_from_user(&dev_info, (void __user *)arg,
 			   sizeof(struct adf_dev_status_info))) {
-		pr_err("QAT: failed to copy from user.\n");
 		return -EFAULT;
 	}
 
@@ -359,7 +352,6 @@ static int adf_ctl_ioctl_get_status(struct file *fp, unsigned int cmd,
 
 	if (copy_to_user((void __user *)arg, &dev_info,
 			 sizeof(struct adf_dev_status_info))) {
-		dev_err(&GET_DEV(accel_dev), "failed to copy status.\n");
 		return -EFAULT;
 	}
 	return 0;
@@ -393,8 +385,7 @@ static long adf_ctl_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		ret = adf_ctl_ioctl_get_status(fp, cmd, arg);
 		break;
 	default:
-		pr_err_ratelimited("QAT: Invalid ioctl %d\n", cmd);
-		ret = -EFAULT;
+		ret = -ENOTTY; /* ENOTTY is the standard POSIX error for invalid ioctls */
 		break;
 	}
 	mutex_unlock(&adf_ctl_lock);
-- 
2.34.1


