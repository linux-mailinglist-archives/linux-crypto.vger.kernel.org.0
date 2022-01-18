Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2807F4923C5
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Jan 2022 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiARKcj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Jan 2022 05:32:39 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173]:36931 "EHLO
        smtpout4.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232429AbiARKci (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Jan 2022 05:32:38 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 05:32:38 EST
Received: from mxplan1.mail.ovh.net (unknown [10.109.143.118])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 9F8C7D86FA30;
        Tue, 18 Jan 2022 11:24:01 +0100 (CET)
Received: from bracey.fi (37.59.142.101) by DAG4EX1.mxp1.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 11:24:00 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-101G004290da6c1-15fb-4b26-ad35-75fb0baa088b,
                    D2C519BAB91300E05C7E54B340BF794D215B5709) smtp.auth=kevin@bracey.fi
X-OVh-ClientIp: 82.181.225.135
From:   Kevin Bracey <kevin@bracey.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 2/4] lib/crc32.c: Make crc32_be weak for arch override
Date:   Tue, 18 Jan 2022 12:23:49 +0200
Message-ID: <20220118102351.3356105-3-kevin@bracey.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118102351.3356105-1-kevin@bracey.fi>
References: <20220118102351.3356105-1-kevin@bracey.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG8EX2.mxp1.local (172.16.2.16) To DAG4EX1.mxp1.local
 (172.16.2.7)
X-Ovh-Tracer-GUID: e5a5a691-f0e1-4872-a189-fddfcfb25303
X-Ovh-Tracer-Id: 10754877386249703529
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepmfgvvhhinhcuuehrrggtvgihuceokhgvvhhinhessghrrggtvgihrdhfiheqnecuggftrfgrthhtvghrnhepuddvheelffeuleeugfekgeegffevudehkeefkeettdekffekjedvjeffkeevjeegnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhdurdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepkhgvvhhinhessghrrggtvgihrdhfihdpnhgspghrtghpthhtohepuddprhgtphhtthhopehkvghvihhnsegsrhgrtggvhidrfhhi
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

crc32_le and __crc32c_le can be overridden - extend this to crc32_be.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 lib/crc32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index 7f062a2639df..5649847d0a8d 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -206,6 +206,7 @@ EXPORT_SYMBOL(__crc32c_le);
 
 u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
 u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
+u32 __pure crc32_be_base(u32, unsigned char const *, size_t) __alias(crc32_be);
 
 /*
  * This multiplies the polynomials x and y modulo the given modulus.
@@ -330,12 +331,12 @@ static inline u32 __pure crc32_be_generic(u32 crc, unsigned char const *p,
 }
 
 #if CRC_BE_BITS == 1
-u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_be_generic(crc, p, len, NULL, CRC32_POLY_BE);
 }
 #else
-u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_be_generic(crc, p, len, crc32table_be, CRC32_POLY_BE);
 }
-- 
2.25.1

