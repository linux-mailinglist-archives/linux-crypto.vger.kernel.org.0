Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8142258
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfFLKW5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 06:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFLKW5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 06:22:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E25D30821AE;
        Wed, 12 Jun 2019 10:22:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6E1060CCC;
        Wed, 12 Jun 2019 10:22:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 2/4] s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
Date:   Wed, 12 Jun 2019 12:22:46 +0200
Message-Id: <20190612102248.18903-3-david@redhat.com>
In-Reply-To: <20190612102248.18903-1-david@redhat.com>
References: <20190612102248.18903-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 10:22:57 +0000 (UTC)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Let's use the error value that is typically used if HW support is not
available when trying to load a module - this is also what systemd's
systemd-modules-load.service expects.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/crypto/ghash_s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/crypto/ghash_s390.c b/arch/s390/crypto/ghash_s390.c
index 86aed30fad3a..eeeb6a7737a4 100644
--- a/arch/s390/crypto/ghash_s390.c
+++ b/arch/s390/crypto/ghash_s390.c
@@ -137,7 +137,7 @@ static struct shash_alg ghash_alg = {
 static int __init ghash_mod_init(void)
 {
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_GHASH))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	return crypto_register_shash(&ghash_alg);
 }
-- 
2.21.0

