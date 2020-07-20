Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF3226CF0
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jul 2020 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGTRKO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jul 2020 13:10:14 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:15566 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgGTRKN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jul 2020 13:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595265011;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rt6PTRApr0yAQz5sJ1wzaRBKf0EMTUCrILlJclvyH1Y=;
        b=qzy0iHNeQCsnAQC/nefzyaWZBRrSo/jUdVa7kTLD5xvpilDu4orioCwtqJnirzSGcn
        NPpN9j/ZMqVPFr/b1GN6o7E9GjyOpOsAhWr7vJi4jnV2CMLImo/wEvlXLJYdbDyOURoT
        zKNjaTLmzsv7iR/POeJpNheSzYLtb/qetVnP27oWaSwMPadG8o3aBSYwCdubz3VKmgTQ
        HlWmF2JJ82Ovu/u6sEDlqAok50gbkxHonOkESmB4o6gfm0ib7HWeTUMV2SwGqCi9ro8E
        PbMitkS7kYuQFyS15v0jaXO2oEJO2RwGyEUV0YMJIeTOFyMr8eolb9lPg7LtHijMt4Db
        3nEg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHiDh"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id y0546bw6KH9uULN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 20 Jul 2020 19:09:56 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        ard.biesheuvel@linaro.org, nhorman@redhat.com, simo@redhat.com
Subject: [PATCH v3 1/5] crypto: ECDH - check validity of Z before export
Date:   Mon, 20 Jul 2020 19:07:48 +0200
Message-ID: <1759349.tdWV9SEqCh@positron.chronox.de>
In-Reply-To: <2544426.mvXUDI8C0e@positron.chronox.de>
References: <2543601.mvXUDI8C0e@positron.chronox.de> <5722559.lOV4Wx5bFT@positron.chronox.de> <2544426.mvXUDI8C0e@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SP800-56A rev3 section 5.7.1.2 step 2 mandates that the validity of the
calculated shared secret is verified before the data is returned to the
caller. Thus, the export function and the validity check functions are
reversed. In addition, the sensitive variables of priv and rand_z are
zeroized.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/ecc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 02d35be7702b..52e2d49262f2 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1495,11 +1495,16 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 
 	ecc_point_mult(product, pk, priv, rand_z, curve, ndigits);
 
-	ecc_swap_digits(product->x, secret, ndigits);
-
-	if (ecc_point_is_zero(product))
+	if (ecc_point_is_zero(product)) {
 		ret = -EFAULT;
+		goto err_validity;
+	}
+
+	ecc_swap_digits(product->x, secret, ndigits);
 
+err_validity:
+	memzero_explicit(priv, sizeof(priv));
+	memzero_explicit(rand_z, sizeof(rand_z));
 	ecc_free_point(product);
 err_alloc_product:
 	ecc_free_point(pk);
-- 
2.26.2




