Return-Path: <linux-crypto+bounces-10421-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F549A4E1F8
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DBC3AAF19
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80125D915;
	Tue,  4 Mar 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gan4tHSV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21D20AF87
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099402; cv=fail; b=guBPjkdQmjqGKV/w/l747+lQ0r7ZCPuRxcMOwoxNvrN9ONVljnpztBJ46dRTrv9x7Hn4dqaSmCpZUftAGSmBGslj45teGno01frsBWoo6iby97QLm5xNyz26n9B7KUl3djY7edDn7OVwH8QztTgSIVrfxTYt/1ptr3UtcruWcac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099402; c=relaxed/simple;
	bh=y6dWDKGFeKZwmZeh3ujFYEjNRFAP6fclRPV3N/W/44I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POgQvnkkiM1vcyw5UuWJGKCsh2oEWjRlRZvRv2m69VUJA/N62YFMj/ytb2sSDRaP+5zNDD9IUajwlTXy9tulM8ubnbCq6Y8veZWQT7C2TZ+nTR5Jzc/9NvzhnDY/dGJIRocZ/ck4SKGIy3vh2o6h+SPufIHBxqI189ushLimIf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gan4tHSV reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 06D3C40D0C8F
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 17:43:19 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gan4tHSV
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dfm4DTbzFxMR
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 17:41:36 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 87D3242736; Tue,  4 Mar 2025 17:41:19 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gan4tHSV
X-Envelope-From: <linux-kernel+bounces-541187-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gan4tHSV
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 29B3342106
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:13 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D3A693063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:12 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46161611ED
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591D1F1307;
	Mon,  3 Mar 2025 08:47:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BC1EE00F;
	Mon,  3 Mar 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991654; cv=none; b=e5AuKdHOJgFVLzcQIDtTK/iiZXp1bHEFwwiluLIySDcABfASFFESXmXjGDxsMHJUhqTSlRdu7e/yvSXQoQQVW6LFrgMrONlTk5O8jkczJ3vE+n2FOo4iTiyFeIqnOMQ/mGYv92AY20/ys3rwRuFYfPKl/rCFUBptStSzQ7Yp8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991654; c=relaxed/simple;
	bh=8AO2hJSnLaCRd/8HtMcdHOYwB/zSpBOSifH5FW9w0Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD4aeToMkDrhgxT6FCVdYBxdAMWAWoo+ARpT2QXoYcnpVeO4GcShktLUN/O7aonXnAh+EItv0ViaBXtmsCkIvjn1hSL7pE3a4sA4EfKEp3iGU+skVTJAWOZxipaUXoUL9AW7q5Zd/tJML6L7Q9nFmsM1Ivn5ok+xF3WH6xPoELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gan4tHSV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991653; x=1772527653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AO2hJSnLaCRd/8HtMcdHOYwB/zSpBOSifH5FW9w0Ms=;
  b=gan4tHSVnCuj8lqnKmX5E/1n3my8hT0Zw5/bADXPkrUryoDavj6WLCOI
   mbVa9tmuKD0GaSJC2veKaU6DsbhzFNJHyk/RDIgTbfVA4x59f5h1luenD
   XjezXiC46RX1JLtJU/8werS9emAtE336PO96o8kuyGeY/9Hm1lGJVE8XW
   xao8UyK9xbXGxZBtkTglN9iyufUA4ath69zbLrgNZSLA7iGR0/gHo6YIB
   VT+Htil/Qe2WB3GnYybofwUHb5a7HvCibiVtsohmBybK0dubU+bP+9JXf
   RZSlvXMU5+HA3wxvjf2k+ZEc1x8ohO+KrAl+75C5k2LSLsRrVbbzEddQ9
   A==;
X-CSE-ConnectionGUID: KmQn2fHnSh+jqrjvkhzpiQ==
X-CSE-MsgGUID: QjfLb+f3TPqFcO0lrNIlTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42111881"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42111881"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:29 -0800
X-CSE-ConnectionGUID: SLQFcck9SfqnDM3/EV2iXg==
X-CSE-MsgGUID: STpS0GyCTU2r/TCFjJpTcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426771"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:27 -0800
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
Subject: [PATCH v8 03/14] crypto: iaa - Add an acomp_req flag CRYPTO_ACOMP_REQ_POLL to enable async mode.
Date: Mon,  3 Mar 2025 00:47:13 -0800
Message-Id: <20250303084724.6490-4-kanchana.p.sridhar@intel.com>
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
X-ITU-Libra-ESVA-ID: 4Z6dfm4DTbzFxMR
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704097.07468@oHJc+EkbHBWoRW/3Jmh5BA
X-ITU-MailScanner-SpamCheck: not spam

If the iaa_crypto driver has async_mode set to true, and use_irq set to
false, it can still be forced to use synchronous mode by turning off the
CRYPTO_ACOMP_REQ_POLL flag in req->flags.

In other words, all three of the following need to be true for a request
to be processed in fully async poll mode:

 1) async_mode should be "true"
 2) use_irq should be "false"
 3) req->flags & CRYPTO_ACOMP_REQ_POLL should be "true"

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 11 ++++++++++-
 include/crypto/acompress.h                 |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
index c3776b0de51d..d7983ab3c34a 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1520,6 +1520,10 @@ static int iaa_comp_acompress(struct acomp_req *re=
q)
 		return -EINVAL;
 	}
=20
+	/* If the caller has requested no polling, disable async. */
+	if (!(req->flags & CRYPTO_ACOMP_REQ_POLL))
+		disable_async =3D true;
+
 	cpu =3D get_cpu();
 	wq =3D wq_table_next_wq(cpu);
 	put_cpu();
@@ -1712,6 +1716,7 @@ static int iaa_comp_adecompress(struct acomp_req *r=
eq)
 {
 	struct crypto_tfm *tfm =3D req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
+	bool disable_async =3D false;
 	int nr_sgs, cpu, ret =3D 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
@@ -1727,6 +1732,10 @@ static int iaa_comp_adecompress(struct acomp_req *=
req)
 		return -EINVAL;
 	}
=20
+	/* If the caller has requested no polling, disable async. */
+	if (!(req->flags & CRYPTO_ACOMP_REQ_POLL))
+		disable_async =3D true;
+
 	if (!req->dst)
 		return iaa_comp_adecompress_alloc_dest(req);
=20
@@ -1775,7 +1784,7 @@ static int iaa_comp_adecompress(struct acomp_req *r=
eq)
 		req->dst, req->dlen, sg_dma_len(req->dst));
=20
 	ret =3D iaa_decompress(tfm, req, wq, src_addr, req->slen,
-			     dst_addr, &req->dlen, false);
+			     dst_addr, &req->dlen, disable_async);
 	if (ret =3D=3D -EINPROGRESS)
 		return ret;
=20
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 147f184b6bea..afadf84f236d 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -14,6 +14,11 @@
 #include <linux/crypto.h>
=20
 #define CRYPTO_ACOMP_ALLOC_OUTPUT	0x00000001
+/*
+ * If set, the driver must have a way to submit the req, then
+ * poll its completion status for success/error.
+ */
+#define CRYPTO_ACOMP_REQ_POLL		0x00000002
 #define CRYPTO_ACOMP_DST_MAX		131072
=20
 /**
--=20
2.27.0



