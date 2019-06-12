Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5A427A5
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439468AbfFLNdd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 09:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406669AbfFLNdY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 09:33:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E57C3079B8E;
        Wed, 12 Jun 2019 13:33:24 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33495756EA;
        Wed, 12 Jun 2019 13:33:21 +0000 (UTC)
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
Subject: [PATCH v3 4/4] s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP
Date:   Wed, 12 Jun 2019 15:33:06 +0200
Message-Id: <20190612133306.10231-5-david@redhat.com>
In-Reply-To: <20190612133306.10231-1-david@redhat.com>
References: <20190612133306.10231-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 12 Jun 2019 13:33:24 +0000 (UTC)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Let's use the error value that is typically used if HW support is not
available when trying to load a module - this is also what systemd's
systemd-modules-load.service expects.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/crypto/sha1_s390.c   | 2 +-
 arch/s390/crypto/sha256_s390.c | 2 +-
 arch/s390/crypto/sha512_s390.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index 009572e8276d..7c15542d3685 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -86,7 +86,7 @@ static struct shash_alg alg = {
 static int __init sha1_s390_init(void)
 {
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_1))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	return crypto_register_shash(&alg);
 }
 
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
index 62833a1d8724..af7505148f80 100644
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -117,7 +117,7 @@ static int __init sha256_s390_init(void)
 	int ret;
 
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_256))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	ret = crypto_register_shash(&sha256_alg);
 	if (ret < 0)
 		goto out;
diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
index be589c340d15..ad29db085a18 100644
--- a/arch/s390/crypto/sha512_s390.c
+++ b/arch/s390/crypto/sha512_s390.c
@@ -127,7 +127,7 @@ static int __init init(void)
 	int ret;
 
 	if (!cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_512))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	if ((ret = crypto_register_shash(&sha512_alg)) < 0)
 		goto out;
 	if ((ret = crypto_register_shash(&sha384_alg)) < 0)
-- 
2.21.0

