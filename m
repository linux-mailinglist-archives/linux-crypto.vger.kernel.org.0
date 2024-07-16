Return-Path: <linux-crypto+bounces-5614-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D18B9321D4
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jul 2024 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094212827D8
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jul 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118F2145FF4;
	Tue, 16 Jul 2024 08:29:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414155894;
	Tue, 16 Jul 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118552; cv=none; b=Qa8zscGwwa1JORZE1TlalXGN8xd20xU2MypPfrvyraEkcBnuwPcheCqxFTug852gLc5TiuX8hoh9zNdRQf3qONaRg26UllEIgFic3flWbWhXHVI3UiOIeX62URl1bXzLdEI6DqWZ/YHkvfvu8nXO6CPI2/6q2keI03EfwwgBOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118552; c=relaxed/simple;
	bh=k5rauxJZxRMqIwamxiJQ/u3NdfbdkSgq9d419Vy+jBM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hl4SowgcF28MBnFdj4i7gNFCWaXP2tFTGiAXG+bRsZfjSWEeYEePib+jtn2NkeBJVsHMhpv8RRY3v4OXdtkfYU/QqnKP814pJunjeVsywITDkRg+aEfCXu49sgJI/yO9xmEOtX4SsNlGzbB/TfEDehtv8KUOMdtF6fr6RzGGvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jul
 2024 11:28:54 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>
CC: Roman Smirnov <r.smirnov@omp.ru>, Mimi Zohar <zohar@linux.ibm.com>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] crypto: mpi: add NULL checks to mpi_normalize().
Date: Tue, 16 Jul 2024 11:28:25 +0300
Message-ID: <20240716082825.65219-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/16/2024 07:59:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186530 [Jul 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/16/2024 08:05:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/16/2024 7:02:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

If a->d is NULL, the NULL pointer will be dereferenced. It
is necessary to prevent this case. There is at least one call
stack that can lead to it:

    mpi_ec_curve_point()
      ec_pow2()
        ec_mulm()
          ec_mod()
            mpi_mod()
              mpi_fdiv_r()
                mpi_tdiv_r()
                  mpi_tdiv_qr()
                    mpi_resize()
                      kcalloc()

mpi_resize can return -ENOMEM, but this case is not handled in any way.

Next, dereferencing takes place:

    mpi_ec_curve_point()
      mpi_cmp()
        do_mpi_cmp()
          mpi_normalize()

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 lib/crypto/mpi/mpi-bit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/mpi/mpi-bit.c b/lib/crypto/mpi/mpi-bit.c
index 070ba784c9f1..d7420bdb4ff2 100644
--- a/lib/crypto/mpi/mpi-bit.c
+++ b/lib/crypto/mpi/mpi-bit.c
@@ -29,6 +29,9 @@
  */
 void mpi_normalize(MPI a)
 {
+	if (!a || !a->d)
+		return;
+
 	for (; a->nlimbs && !a->d[a->nlimbs - 1]; a->nlimbs--)
 		;
 }
-- 
2.34.1


