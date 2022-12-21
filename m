Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED20653375
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Dec 2022 16:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiLUPfO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 21 Dec 2022 10:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiLUPeo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 21 Dec 2022 10:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D228709
        for <linux-crypto@vger.kernel.org>; Wed, 21 Dec 2022 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671636579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RL570OHmPW201fZSHberCpl3hdNr7vUODND47Csuw3k=;
        b=NMw2sZSP+aInZof8SANEooHW5CrABQwFUlpxSBVsUM/qXP1QFIyZ2i3OM/tUm/xVoYahRF
        fA2F+wzl2+GV2FeAP5eWeF0b55kN4KjBvxIaQvAzMuNKo42WGuzB12+qEYjPUWWjrxVAal
        IPQc8yAWikWJw7KLhQGNflx7fy2PEOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-kk_9dkzeN8exWPYguzi-Cg-1; Wed, 21 Dec 2022 10:26:28 -0500
X-MC-Unique: kk_9dkzeN8exWPYguzi-Cg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F47D18A64E0;
        Wed, 21 Dec 2022 15:26:28 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-25.brq.redhat.com [10.40.208.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E12340C2064;
        Wed, 21 Dec 2022 15:26:26 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     nstange@suse.de
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de, vdronov@redhat.com
Subject: [PATCH 6/6] crypto: xts - drop redundant xts key check
Date:   Wed, 21 Dec 2022 16:26:13 +0100
Message-Id: <20221221152613.8655-1-vdronov@redhat.com>
In-Reply-To: <20221108142025.13461-1-nstange@suse.de>
References: <20221108142025.13461-1-nstange@suse.de>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

xts_fallback_setkey() in xts_aes_set_key() will now enforce key size
rule in FIPS mode when setting up the fallback algorithm keys, which
makes the check in xts_aes_set_key() redundant or unreachable. So just
drop this check.

xts_fallback_setkey() now makes a key size check in xts_verify_key():

xts_fallback_setkey()
  crypto_skcipher_setkey() [ skcipher_setkey_unaligned() ]
    cipher->setkey() { .setkey = xts_setkey }
      xts_setkey()
        xts_verify_key()

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 arch/s390/crypto/aes_s390.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 526c3f40f6a2..c773820e4af9 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -398,10 +398,6 @@ static int xts_aes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
 	if (err)
 		return err;
 
-	/* In fips mode only 128 bit or 256 bit keys are valid */
-	if (fips_enabled && key_len != 32 && key_len != 64)
-		return -EINVAL;
-
 	/* Pick the correct function code based on the key length */
 	fc = (key_len == 32) ? CPACF_KM_XTS_128 :
 	     (key_len == 64) ? CPACF_KM_XTS_256 : 0;
-- 
2.37.2

