Return-Path: <linux-crypto+bounces-20278-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KIpOXDscmn7rAAAu9opvQ
	(envelope-from <linux-crypto+bounces-20278-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:35:12 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D236070244
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 009E23006099
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 03:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CB347BA3;
	Fri, 23 Jan 2026 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX73hJTl"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AD2E5427
	for <linux-crypto@vger.kernel.org>; Fri, 23 Jan 2026 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139305; cv=none; b=cPqMXnYPBtlr4i4csZNpJyJpQUJNCmR2EO474j19JSFnjDbnU1SY2fm8AxlejvHIW2bQjCqRP5WZyE/8uq4Km0TGircxMT6uu4tCWnmZgOrDaXQw1I6wPEx+AEmYdpooQCFlT6JjG23a7civMU2/TXJAyFBrIdkf+K0tjkQpeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139305; c=relaxed/simple;
	bh=3yyx7QWX05nNRX/rjYbNqk6AglVOYO0tzJkWAwS+c34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzVA8/W+SUS3tTYPOtK0o68Bx4/S+7s7ScFFgb1/qUCRCtm1gs1+BSV9sEvZdSQ5MFa3f79jPw9kDCfoEzYr1ulPO5Cr6Qsw8uQ6Wc+G8OD1V5OM58k0YaBSgj6FvvOmTkgZ1S/V8Ee4CZy9vXrBoPkuxbIu3AZYzUw4VZE8Jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX73hJTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F809C4CEF1;
	Fri, 23 Jan 2026 03:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769139304;
	bh=3yyx7QWX05nNRX/rjYbNqk6AglVOYO0tzJkWAwS+c34=;
	h=From:To:Cc:Subject:Date:From;
	b=pX73hJTlIOgz0ZsdnlJYWGVdS1/B05tuFRgwMZVVkcHp1nqvNWirKbXSX4CZeiuIi
	 qgXRr/ZiIIMlOaFDeRep7yIpwLzVrqxXJK9d5PI2FpPmyvSytsNmGB2pRtwKel4Vqq
	 fVyZgcGhSqfzXkxar+rDuURRP1lSd8A6T9wjjVQL9Lp57FRFv9hQdkApSQ//HmNsL4
	 xMlx5ClIRMAO9GF41xTLwhURlO7aW+xlMBBlDYYRvPtgyIJwdcfxrX8JxSDfOT/bet
	 fmvf87Ob3ZbVkO6iBPcOUq7Y7FB1JJo9s1DfGSRvkIorFORzFvBKmuwVxlDBP+p+Ui
	 Za4kH93iqK5YQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: ccp - Add sysfs attribute for boot integrity
Date: Thu, 22 Jan 2026 21:34:53 -0600
Message-ID: <20260123033457.645189-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20278-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,squebb.ca:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D236070244
X-Rspamd-Action: no action

From: Mario Limonciello <mario.limonciello@amd.com>

The boot integrity attribute represents that the CPU or APU is used for the
hardware root of trust in the boot process.  This bit only represents the
CPU/APU and some vendors have other hardware root of trust implementations
specific to their designs.

Link: https://github.com/fwupd/fwupd/pull/9825
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-driver-ccp | 15 +++++++++++++++
 drivers/crypto/ccp/hsti.c                  |  3 +++
 drivers/crypto/ccp/psp-dev.h               |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
index ee6b787eee7a0..6ec74b9a292a7 100644
--- a/Documentation/ABI/testing/sysfs-driver-ccp
+++ b/Documentation/ABI/testing/sysfs-driver-ccp
@@ -8,6 +8,21 @@ Description:
 		0: Not fused
 		1: Fused
 
+What:		/sys/bus/pci/devices/<BDF>/boot_integrity
+Date:		April 2026
+KernelVersion:	6.20
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/boot_integrity reports
+		whether the AMD CPU or APU is used for a hardware root of trust
+		during the boot process.
+		Possible values:
+		0: Not hardware root of trust.
+		1: Hardware root of trust
+
+		NOTE: Vendors may provide design specific alternative hardware
+		root of trust implementations.
+
 What:		/sys/bus/pci/devices/<BDF>/debug_lock_on
 Date:		June 2022
 KernelVersion:	5.19
diff --git a/drivers/crypto/ccp/hsti.c b/drivers/crypto/ccp/hsti.c
index c29c6a9c0f3f9..4b44729a019ea 100644
--- a/drivers/crypto/ccp/hsti.c
+++ b/drivers/crypto/ccp/hsti.c
@@ -30,6 +30,8 @@ static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
 
 security_attribute_show(fused_part)
 static DEVICE_ATTR_RO(fused_part);
+security_attribute_show(boot_integrity)
+static DEVICE_ATTR_RO(boot_integrity);
 security_attribute_show(debug_lock_on)
 static DEVICE_ATTR_RO(debug_lock_on);
 security_attribute_show(tsme_status)
@@ -47,6 +49,7 @@ static DEVICE_ATTR_RO(rom_armor_enforced);
 
 static struct attribute *psp_security_attrs[] = {
 	&dev_attr_fused_part.attr,
+	&dev_attr_boot_integrity.attr,
 	&dev_attr_debug_lock_on.attr,
 	&dev_attr_tsme_status.attr,
 	&dev_attr_anti_rollback_status.attr,
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 268c83f298cb0..4e370e76b6ca5 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -36,7 +36,7 @@ union psp_cap_register {
 			     rsvd1			:3,
 			     security_reporting		:1,
 			     fused_part			:1,
-			     rsvd2			:1,
+			     boot_integrity		:1,
 			     debug_lock_on		:1,
 			     rsvd3			:2,
 			     tsme_status		:1,
-- 
2.43.0


