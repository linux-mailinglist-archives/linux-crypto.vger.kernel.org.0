Return-Path: <linux-crypto+bounces-10428-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13127A4E7C1
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C3018971D6
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Mar 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9A27F4D2;
	Tue,  4 Mar 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xmh2yriG"
X-Original-To: linux-crypto@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261B27D78A
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106482; cv=fail; b=pDomI3fiwCVq5zdpyBm4st+WfJUw4kba/sRwLigLpxB6T+Dv8Syxvi1Clzhw5mOS9qz66NlqduEkbYc9I9yffjdcC/hm5Ls5r8DFTPi9ARLvcfXH+dEsk5EYWMHtl7L8wfa00DNXL0vPGq25C9FVya0YhuudUcejNeJIeL6wcCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106482; c=relaxed/simple;
	bh=LVabYZomEpnCbYbmFgXGyXraMnw5YSX2oabMVB8A8Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdDfAw7P6pnG1761YigcVP26ZBY5JWaTiDH4yFtdkAqBJd5CFJWrNX/hzeYKlZdabwhoySznc1QuvXbfXnQjBm2jH/CfZXxO7cERyhVmra+miUfSHoscG4/WM4EQ85R9bV+VaXmKBo28SHSqsKqObdY4dcypLxBvlwtL+eGiTLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xmh2yriG reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 2461B4089531
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 19:41:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xmh2yriG
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hGM6zqTzG3lQ
	for <linux-crypto@vger.kernel.org>; Tue,  4 Mar 2025 19:39:07 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 53C7E4276B; Tue,  4 Mar 2025 19:38:53 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xmh2yriG
X-Envelope-From: <linux-kernel+bounces-541195-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xmh2yriG
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id E52B542891
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:51:49 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7AA3A2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:51:49 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EB13AAEF5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E591F419E;
	Mon,  3 Mar 2025 08:47:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6D1F237A;
	Mon,  3 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991662; cv=none; b=hOUOxfYL6a6J1YhCui4S66mnW9BMlsSyHTGsr68YQYcdVNSaP2FpSKDVt3tBWbg+XcqChfDFB5GelNxRXc6KE4PixdlXXIMo9zfvCyUx+kxvATfgIVMKe4PFvwtXRySIGWikkVpNUHDdGVVVKdzt8FoH2oxp6kleK/jvD0nyqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991662; c=relaxed/simple;
	bh=nu1yNk8S8EgSrO+ZHhQ4Hl0iMXbUsnYxF38CaLmoAAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgTGFxuMEZWaM5SevubScAIvw4nG369C/CGnuZGO0k4fVtUR01/PJn7xJquauIiitxGaWhMFs1IWr2bytXbMxTvQ68Mskrlv1ttPqtVLyN1mt8aaEkHggmOsWEXcJrt34DZmDHZVhr/44KMiJrWvxpp/986FlHpS4u+iLP2oa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xmh2yriG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740991661; x=1772527661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nu1yNk8S8EgSrO+ZHhQ4Hl0iMXbUsnYxF38CaLmoAAI=;
  b=Xmh2yriGF7OjL/FJ2HoQZA3h45RXDKYzh1gfHn1lE26hllCvmEEf+nph
   oCYSmkl2VAZU1X9/D9U+4JTM9Bt7dMwxN/QBnEQ9H+hOqfvCXi11s8qiv
   B9GHn1d7kNnBn0M23imNcbGcjvm2w0lr3L11OfDfRf7ZGdL1yBRlSzu6Z
   NWowBC74Q5+nyzhXAac6Vsnc1h1vgliWZA/Ft81kNo9UYk4dIBf8UQuWz
   5fdbu0Cpc4XqPnbBjneT/FYitPxg8KluYbk8tvg5mbt5+oKIUpXswxIki
   z6MgVi+LqDoalg8jJcgWpyw3xY+ZR6LG7f0RG6jYBQyIcBWuQ89NgAJT8
   g==;
X-CSE-ConnectionGUID: Ln02oyqhQBSt7iOCzC1ARg==
X-CSE-MsgGUID: IbQV5mGvSaqHL/dNgajwmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42111991"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42111991"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:47:39 -0800
X-CSE-ConnectionGUID: RcBRVQJHThmfzPKoFFz43Q==
X-CSE-MsgGUID: Mf9Syfb0RG6aEdF/ZVQZAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118426822"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 00:47:36 -0800
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
Subject: [PATCH v8 11/14] crypto: iaa - Fix for "deflate_generic_tfm" global being accessed without locks.
Date: Mon,  3 Mar 2025 00:47:21 -0800
Message-Id: <20250303084724.6490-12-kanchana.p.sridhar@intel.com>
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
X-ITU-Libra-ESVA-ID: 4Z6hGM6zqTzG3lQ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711150.49767@xhdWQr9st2EbAsLw5rRZiA
X-ITU-MailScanner-SpamCheck: not spam

The mainline implementation of "deflate_generic_decompress" has a bug in
the usage of this global variable:

static struct crypto_comp *deflate_generic_tfm;

The "deflate_generic_tfm" is allocated at module init time, and freed
during module cleanup. Any calls to software decompress, for instance, if
descriptor allocation fails or job submission fails, will trigger this bu=
g
in the deflate_generic_decompress() procedure. The problem is the
unprotected access of "deflate_generic_tfm" in this procedure. While
stress testing workloads under high memory pressure, with 1 IAA device
and "deflate-iaa" as the compressor, the descriptor allocation times out
and the software fallback route is taken. With multiple processes calling=
:

        ret =3D crypto_comp_decompress(deflate_generic_tfm,
                                     src, req->slen, dst, &req->dlen);

we end up with data corruption, that results in req->dlen being larger
than PAGE_SIZE. zswap_decompress() subsequently raises a kernel bug.

This bug can manifest under high contention and memory pressure situation=
s
with high likelihood. This has been resolved by adding a mutex, which is
locked before accessing "deflate_generic_tfm" and unlocked after the
crypto_comp call is done.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
index 7503fafca279..2a994f307679 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -105,6 +105,7 @@ static struct iaa_compression_mode *iaa_compression_m=
odes[IAA_COMP_MODES_MAX];
=20
 LIST_HEAD(iaa_devices);
 DEFINE_MUTEX(iaa_devices_lock);
+DEFINE_MUTEX(deflate_generic_tfm_lock);
=20
 /* If enabled, IAA hw crypto algos are registered, unavailable otherwise=
 */
 static bool iaa_crypto_enabled;
@@ -1407,6 +1408,9 @@ static int deflate_generic_decompress(struct acomp_=
req *req)
 	int ret;
=20
 	req->dlen =3D PAGE_SIZE;
+
+	mutex_lock(&deflate_generic_tfm_lock);
+
 	src =3D kmap_local_page(sg_page(req->src)) + req->src->offset;
 	dst =3D kmap_local_page(sg_page(req->dst)) + req->dst->offset;
=20
@@ -1416,6 +1420,8 @@ static int deflate_generic_decompress(struct acomp_=
req *req)
 	kunmap_local(src);
 	kunmap_local(dst);
=20
+	mutex_unlock(&deflate_generic_tfm_lock);
+
 	update_total_sw_decomp_calls();
=20
 	return ret;
--=20
2.27.0



