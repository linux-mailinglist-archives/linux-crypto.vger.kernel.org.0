Return-Path: <linux-crypto+bounces-10431-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF21A4EBA3
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 19:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64F03A583D
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19742E3367;
	Tue,  4 Mar 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0RNCD+V"
X-Original-To: linux-crypto@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B0293444
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109616; cv=fail; b=QXdjOwyoQfAZv5gdxWVhSI/VvZn0WdhG6l4BbXXx62xWXVWi3XEZGXZ9ILWs7v6bHweM1BJrYFEPFJjzcS67Qry6xK9vtZBGmqXTz4qwgyPjGcYr3t2pDyidRp3eYWVazQpvRl0cPcVKo+GWma86rL0jedKFv9qivOjyaOVi8R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109616; c=relaxed/simple;
	bh=DH8Zgr3DThJRh3siZsATRC0Ao4SbBZXYMqL+sQ/9mb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mamNWjZSqYq0M9+IoMaPIPwOaqy1JU2ODAQLjskMqslqFMGeJn2+genUw69jWEcenlBLPDtQv0IM7TISxa+6AfyTV/yvHMqLFw7SurRgv5gP/wvT7nXxdnAC0avim/U5XvBBO2HqvYlec+SrOKlzJeBvSqNF44A1f1PZxyEwB3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0RNCD+V reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 33CDF40CCF24
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 20:33:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0RNCD+V
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gHR4brjzG1J7
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 18:54:59 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A9E1E4273E; Tue,  4 Mar 2025 18:54:39 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0RNCD+V
X-Envelope-From: <linux-kernel+bounces-541188-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0RNCD+V
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9F5C642620
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:33 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 7917E3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BC918917A6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75641F153A;
	Mon,  3 Mar 2025 08:47:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830681F03CA;
	Mon,  3 Mar 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991655; cv=none; b=lDUPlmKzEKZoMMOIKHK12XrA6kefhl8lqA7K8H4uLWIJ62xMqWcplNhr7DBbk75nLK1gPG3U4X7AOkQVVE+d3l6RNi3vPeY4fkRUXeVM2gVStuBjsawAKuYtAFodL3W80SlBFsMfK3ypGmMZuDQWpshN2aXpxcVXD4uD0ZMYHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991655; c=relaxed/simple;
	bh=VRzCnyQyEfhyAHvAPp33ZwaL6nzqmuQ9xsZtH/mrvjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aY5m/nBsjcohsjucNNoU36OzDJoays5otdaHFTW5q1gYVeIPkGejIUp3C+OZ3rSnrItmLB0jHKBckIp9dUomXksbS5iVwofrK3JGyGbO4pb9GtsVjyBfx9a2NfdLnX4y3DQn6hfhznFrWr+EyMHKtgas/1Y6cHeydHFAAT9O+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0RNCD+V; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991654; x=1772527654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VRzCnyQyEfhyAHvAPp33ZwaL6nzqmuQ9xsZtH/mrvjQ=;
  b=F0RNCD+VGLLM2VgqodE5Sg8ZqN/6M4kaVHztsM9J5RAY5y2wtGjd14HI
   fXbhOWCNmfvdFmbibGS3I04YujgSfyhzSk8mSjFP+gKLCRy88ccqyyQSO
   Y+rKfOPDckPyjWrxb4pmoo2BDeiT5YsPUuWNmQg3RBrn0mRAVqP4kTIJA
   jLIrOWAPjHSRABUHwau5NLKCJzT6H0HHz46VUYpNkck+LdAdLCZkZ7mqb
   hsn0BHnb846OLmVRmWwyohClHviVTXSdIKZ+eDLhgqoAwRVCmV1l/toLB
   bDj5xUEldEWsKF5bCNRPMQ9fKlZ+Po1XgpKP2S1ub6LN/IwW2ODr4mx/p
   Q==;
X-CSE-ConnectionGUID: QwpbO6mLRGOQQYwb9dRbzw==
X-CSE-MsgGUID: gbkRVOwcQHy7q1Rk5tbChQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42111907"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42111907"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:31 -0800
X-CSE-ConnectionGUID: I9tMg+h6QkyIP7Qwr363mQ==
X-CSE-MsgGUID: GycSSx/qQvS+RVjpX9aU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426793"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:30 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 05/14] crypto: iaa - Enable async mode and make it the default.
Date: Mon,  3 Mar 2025 00:47:15 -0800
Message-Id: <20250303084724.6490-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
References: <20250303084724.6490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gHR4brjzG1J7
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714294.97116@DdCDETlo0ma3YHJBPYe++w
X-ITU-MailScanner-SpamCheck: not spam

This patch enables the 'async' sync_mode in the driver. Further, it sets
the default sync_mode to 'async', which makes it easier for IAA hardware
acceleration in the iaa_crypto driver to be loaded by default in the most
efficient/recommended 'async' mode for parallel
compressions/decompressions, namely, asynchronous submission of
descriptors, followed by polling for job completions with or without
request chaining. Earlier, the "sync" mode used to be the default.

This way, anyone who wants to use IAA for zswap/zram can do so after
building the kernel, and without having to go through these steps to use
async mode:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo async > /sys/bus/dsa/drivers/crypto/sync_mode
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst | 11 ++---------
 drivers/crypto/intel/iaa/iaa_crypto_main.c         |  4 ++--
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documen=
tation/driver-api/crypto/iaa/iaa-crypto.rst
index 8e50b900d51c..782da5230fcd 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -272,7 +272,7 @@ The available attributes are:
       echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode
=20
     Async mode without interrupts (caller must poll) can be enabled by
-    writing 'async' to it (please see Caveat)::
+    writing 'async' to it::
=20
       echo async > /sys/bus/dsa/drivers/crypto/sync_mode
=20
@@ -281,14 +281,7 @@ The available attributes are:
=20
       echo sync > /sys/bus/dsa/drivers/crypto/sync_mode
=20
-    The default mode is 'sync'.
-
-    Caveat: since the only mechanism that iaa_crypto currently implement=
s
-    for async polling without interrupts is via the 'sync' mode as
-    described earlier, writing 'async' to
-    '/sys/bus/dsa/drivers/crypto/sync_mode' will internally enable the
-    'sync' mode. This is to ensure correct iaa_crypto behavior until tru=
e
-    async polling without interrupts is enabled in iaa_crypto.
+    The default mode is 'async'.
=20
 .. _iaa_default_config:
=20
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
index a9800b8f3575..4dac4852c113 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -153,7 +153,7 @@ static DRIVER_ATTR_RW(verify_compress);
  */
=20
 /* Use async mode */
-static bool async_mode;
+static bool async_mode =3D true;
 /* Use interrupts */
 static bool use_irq;
=20
@@ -173,7 +173,7 @@ static int set_iaa_sync_mode(const char *name)
 		async_mode =3D false;
 		use_irq =3D false;
 	} else if (sysfs_streq(name, "async")) {
-		async_mode =3D false;
+		async_mode =3D true;
 		use_irq =3D false;
 	} else if (sysfs_streq(name, "async_irq")) {
 		async_mode =3D true;
--=20
2.27.0



