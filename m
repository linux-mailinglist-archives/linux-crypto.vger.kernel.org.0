Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50389561DD4
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jun 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiF3OXC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Jun 2022 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiF3OWK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Jun 2022 10:22:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30256B82E
        for <linux-crypto@vger.kernel.org>; Thu, 30 Jun 2022 07:05:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k22so27472731wrd.6
        for <linux-crypto@vger.kernel.org>; Thu, 30 Jun 2022 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVyHdZovYzB+QbFMpM5WNXufFkH2qFtY3hMiPHkkV+4=;
        b=acQZgo3eKsuY28gr9Q60mxoBXYHZQ/uSOsPgyh/YxefLfNxsfrntA+cUKjiK8+XiWn
         8DsNWDZqZTVA54lsUkAYldk6f263MH10Vhf4VWARISEs88AGtptxMdtDqGJaUKmnzjjv
         dcgjeWz0U2M2LyknEdg69rMv5wcDsOrCJiawo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVyHdZovYzB+QbFMpM5WNXufFkH2qFtY3hMiPHkkV+4=;
        b=iIzYfP7huo+b8J/RC+tccXlL2NHAJVT6OL1GnwVMYw5Mo/ABpUiu0VJBvAgknKVAiI
         CgJ0ZV9YmeBnXkIGrd4zPuWuYmp8x1Y/A0dW3ij9sBdaPM+xU+Hh02nhhRbuj8CnL0mY
         inOSbW8XACp//MbOO+Dy85l4JA2jif3SyjYTOx28hCW+JUeCqS5evBIBWknIeVaok0+a
         aTxl3TevklmLFDgpj8S6pIn4EeRBl5DRkC3x2jf/21v7dsFhBVc3AKD9CGoyIgrJMUfu
         1W65zZDr+IPBD9nJw576ZiETdRipws08JkU7+edelFqberAQY6HZicmoFeviPidEBFVO
         hZyg==
X-Gm-Message-State: AJIora/hc/s1tBKmMUbsiU0TzmSCK3tds0O+7ZFALlzJt7rDAW+0RdPf
        safit6xot8lG+UG1v8rsjp6krw==
X-Google-Smtp-Source: AGRyM1ukTdnSHc4nfeUk2ODIEmUj+m0lzU+04nNdvTZP4W/IPX0GJ0AtE+Q+W9h4mx76C2O6W0vzOw==
X-Received: by 2002:a5d:456e:0:b0:21b:9219:b28a with SMTP id a14-20020a5d456e000000b0021b9219b28amr8645038wrc.497.1656597925115;
        Thu, 30 Jun 2022 07:05:25 -0700 (PDT)
Received: from localhost.localdomain (33F1330b.skybroadband.com. [51.241.51.11])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm6790292wmq.1.2022.06.30.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:05:24 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Eric Biggers <ebiggers@kernel.org>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [PATCH] crypto: testmgr - populate RSA CRT parameters in RSA test vectors
Date:   Thu, 30 Jun 2022 15:05:06 +0100
Message-Id: <20220630140506.904-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster
private key operations") we have started to use the additional primes and
coefficients for RSA private key operations. However, these additional
parameters are not present (defined as 0 integers) in the RSA test vectors.

Some parameters were borrowed from OpenSSL, so I was able to find the source.
I could not find the public source for 1 vector though, so had to recover the
parameters by implementing Appendix C from [1].

[1]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Br1.pdf

Fixes: f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster private key operations")
Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 crypto/testmgr.h | 121 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 21 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 8e2dce86dd48..7d503b4e1e41 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -185,7 +185,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	{
 #ifndef CONFIG_CRYPTO_FIPS
 	.key =
-	"\x30\x81\x9A" /* sequence of 154 bytes */
+	"\x30\x82\x01\x38" /* sequence of 312 bytes */
 	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x41" /* modulus - integer of 65 bytes */
 	"\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
@@ -199,23 +199,36 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\xC2\xCD\x2D\xFF\x43\x40\x98\xCD\x20\xD8\xA1\x38\xD0\x90\xBF\x64"
 	"\x79\x7C\x3F\xA7\xA2\xCD\xCB\x3C\xD1\xE0\xBD\xBA\x26\x54\xB4\xF9"
 	"\xDF\x8E\x8A\xE5\x9D\x73\x3D\x9F\x33\xB3\x01\x62\x4A\xFD\x1D\x51"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
+	"\x02\x21" /* prime1 - integer of 33 bytes */
+	"\x00\xD8\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
+    "\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x12"
+    "\x0D"
+	"\x02\x21" /* prime2 - integer of 33 bytes */
+	"\x00\xC9\x7F\xB1\xF0\x27\xF4\x53\xF6\x34\x12\x33\xEA\xAA\xD1\xD9"
+    "\x35\x3F\x6C\x42\xD0\x88\x66\xB1\xD0\x5A\x0F\x20\x35\x02\x8B\x9D"
+    "\x89"
+	"\x02\x20" /* exponent1 - integer of 32 bytes */
+	"\x59\x0B\x95\x72\xA2\xC2\xA9\xC4\x06\x05\x9D\xC2\xAB\x2F\x1D\xAF"
+    "\xEB\x7E\x8B\x4F\x10\xA7\x54\x9E\x8E\xED\xF5\xB4\xFC\xE0\x9E\x05"
+	"\x02\x21" /* exponent2 - integer of 33 bytes */
+	"\x00\x8E\x3C\x05\x21\xFE\x15\xE0\xEA\x06\xA3\x6F\xF0\xF1\x0C\x99"
+    "\x52\xC3\x5B\x7A\x75\x14\xFD\x32\x38\xB8\x0A\xAD\x52\x98\x62\x8D"
+    "\x51"
+	"\x02\x20" /* coefficient - integer of 32 bytes */
+	"\x36\x3F\xF7\x18\x9D\xA8\xE9\x0B\x1D\x34\x1F\x71\xD0\x9B\x76\xA8"
+    "\xA9\x43\xE1\x1D\x10\xB2\x4D\x24\x9F\x2D\xEA\xFE\xF8\x0C\x18\x26",
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\x63\x1c\xcd\x7b\xe1\x7e\xe4\xde\xc9\xa8\x89\xa1\x74\xcb\x3c\x63"
 	"\x7d\x24\xec\x83\xc3\x15\xe4\x7f\x73\x05\x34\xd1\xec\x22\xbb\x8a"
 	"\x5e\x32\x39\x6d\xc1\x1d\x7d\x50\x3b\x9f\x7a\xad\xf0\x2e\x25\x53"
 	"\x9f\x6e\xbd\x4c\x55\x84\x0c\x9b\xcf\x1a\x4b\x51\x1e\x9e\x0c\x06",
-	.key_len = 157,
+	.key_len = 316,
 	.m_size = 8,
 	.c_size = 64,
 	}, {
 	.key =
-	"\x30\x82\x01\x1D" /* sequence of 285 bytes */
+	"\x30\x82\x02\x5B" /* sequence of 603 bytes */
 	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x81\x81" /* modulus - integer of 129 bytes */
 	"\x00\xBB\xF8\x2F\x09\x06\x82\xCE\x9C\x23\x38\xAC\x2B\x9D\xA8\x71"
@@ -238,12 +251,35 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\x93\x99\x26\xED\x4F\x74\xA1\x3E\xDD\xFB\xE1\xA1\xCE\xCC\x48\x94"
 	"\xAF\x94\x28\xC2\xB7\xB8\x88\x3F\xE4\x46\x3A\x4B\xC8\x5B\x1C\xB3"
 	"\xC1"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
-	.key_len = 289,
+	"\x02\x41" /* prime1 - integer of 65 bytes */
+	"\x00\xEE\xCF\xAE\x81\xB1\xB9\xB3\xC9\x08\x81\x0B\x10\xA1\xB5\x60"
+    "\x01\x99\xEB\x9F\x44\xAE\xF4\xFD\xA4\x93\xB8\x1A\x9E\x3D\x84\xF6"
+    "\x32\x12\x4E\xF0\x23\x6E\x5D\x1E\x3B\x7E\x28\xFA\xE7\xAA\x04\x0A"
+    "\x2D\x5B\x25\x21\x76\x45\x9D\x1F\x39\x75\x41\xBA\x2A\x58\xFB\x65"
+    "\x99"
+	"\x02\x41" /* prime2 - integer of 65 bytes */
+	"\x00\xC9\x7F\xB1\xF0\x27\xF4\x53\xF6\x34\x12\x33\xEA\xAA\xD1\xD9"
+    "\x35\x3F\x6C\x42\xD0\x88\x66\xB1\xD0\x5A\x0F\x20\x35\x02\x8B\x9D"
+    "\x86\x98\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
+    "\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x15"
+    "\x03"
+	"\x02\x40" /* exponent1 - integer of 64 bytes */
+	"\x54\x49\x4C\xA6\x3E\xBA\x03\x37\xE4\xE2\x40\x23\xFC\xD6\x9A\x5A"
+    "\xEB\x07\xDD\xDC\x01\x83\xA4\xD0\xAC\x9B\x54\xB0\x51\xF2\xB1\x3E"
+    "\xD9\x49\x09\x75\xEA\xB7\x74\x14\xFF\x59\xC1\xF7\x69\x2E\x9A\x2E"
+    "\x20\x2B\x38\xFC\x91\x0A\x47\x41\x74\xAD\xC9\x3C\x1F\x67\xC9\x81"
+	"\x02\x40" /* exponent2 - integer of 64 bytes */
+	"\x47\x1E\x02\x90\xFF\x0A\xF0\x75\x03\x51\xB7\xF8\x78\x86\x4C\xA9"
+    "\x61\xAD\xBD\x3A\x8A\x7E\x99\x1C\x5C\x05\x56\xA9\x4C\x31\x46\xA7"
+    "\xF9\x80\x3F\x8F\x6F\x8A\xE3\x42\xE9\x31\xFD\x8A\xE4\x7A\x22\x0D"
+    "\x1B\x99\xA4\x95\x84\x98\x07\xFE\x39\xF9\x24\x5A\x98\x36\xDA\x3D"
+	"\x02\x41", /* coefficient - integer of 65 bytes */
+	"\x00\xB0\x6C\x4F\xDA\xBB\x63\x01\x19\x8D\x26\x5B\xDB\xAE\x94\x23"
+    "\xB3\x80\xF2\x71\xF7\x34\x53\x88\x50\x93\x07\x7F\xCD\x39\xE2\x11"
+    "\x9F\xC9\x86\x32\x15\x4F\x58\x83\xB1\x67\xA9\x67\xBF\x40\x2B\x4E"
+    "\x9E\x2E\x0F\x96\x56\xE6\x98\xEA\x36\x66\xED\xFB\x25\x79\x80\x39"
+    "\xF7",
+	.key_len = 607,
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\x74\x1b\x55\xac\x47\xb5\x08\x0a\x6e\x2b\x2d\xf7\x94\xb8\x8a\x95"
@@ -259,7 +295,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}, {
 #endif
 	.key =
-	"\x30\x82\x02\x20" /* sequence of 544 bytes */
+	"\x30\x82\x04\xA3" /* sequence of 1187 bytes */
 	"\x02\x01\x00" /* version - integer of 1 byte */
 	"\x02\x82\x01\x01\x00" /* modulus - integer of 256 bytes */
 	"\xDB\x10\x1A\xC2\xA3\xF1\xDC\xFF\x13\x6B\xED\x44\xDF\xF0\x02\x6D"
@@ -296,12 +332,55 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	"\x62\xFF\xE9\x46\xB8\xD8\x44\xDB\xA5\xCC\x31\x54\x34\xCE\x3E\x82"
 	"\xD6\xBF\x7A\x0B\x64\x21\x6D\x88\x7E\x5B\x45\x12\x1E\x63\x8D\x49"
 	"\xA7\x1D\xD9\x1E\x06\xCD\xE8\xBA\x2C\x8C\x69\x32\xEA\xBE\x60\x71"
-	"\x02\x01\x00" /* prime1 - integer of 1 byte */
-	"\x02\x01\x00" /* prime2 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
-	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
-	"\x02\x01\x00", /* coefficient - integer of 1 byte */
-	.key_len = 548,
+	"\x02\x81\x81" /* prime1 - integer of 129 bytes */
+	"\x00\xFA\xAC\xE1\x37\x5E\x32\x11\x34\xC6\x72\x58\x2D\x91\x06\x3E"
+	"\x77\xE7\x11\x21\xCD\x4A\xF8\xA4\x3F\x0F\xEF\x31\xE3\xF3\x55\xA0"
+	"\xB9\xAC\xB6\xCB\xBB\x41\xD0\x32\x81\x9A\x8F\x7A\x99\x30\x77\x6C"
+	"\x68\x27\xE2\x96\xB5\x72\xC9\xC3\xD4\x42\xAA\xAA\xCA\x95\x8F\xFF"
+	"\xC9\x9B\x52\x34\x30\x1D\xCF\xFE\xCF\x3C\x56\x68\x6E\xEF\xE7\x6C"
+	"\xD7\xFB\x99\xF5\x4A\xA5\x21\x1F\x2B\xEA\x93\xE8\x98\x26\xC4\x6E"
+	"\x42\x21\x5E\xA0\xA1\x2A\x58\x35\xBB\x10\xE7\xBA\x27\x0A\x3B\xB3"
+	"\xAF\xE2\x75\x36\x04\xAC\x56\xA0\xAB\x52\xDE\xCE\xDD\x2C\x28\x77"
+	"\x03"
+	"\x02\x81\x81" /* prime2 - integer of 129 bytes */
+	"\x00\xDF\xB7\x52\xB6\xD7\xC0\xE2\x96\xE7\xC9\xFE\x5D\x71\x5A\xC4"
+	"\x40\x96\x2F\xE5\x87\xEA\xF3\xA5\x77\x11\x67\x3C\x8D\x56\x08\xA7"
+	"\xB5\x67\xFA\x37\xA8\xB8\xCF\x61\xE8\x63\xD8\x38\x06\x21\x2B\x92"
+	"\x09\xA6\x39\x3A\xEA\xA8\xB4\x45\x4B\x36\x10\x4C\xE4\x00\x66\x71"
+	"\x65\xF8\x0B\x94\x59\x4F\x8C\xFD\xD5\x34\xA2\xE7\x62\x84\x0A\xA7"
+	"\xBB\xDB\xD9\x8A\xCD\x05\xE1\xCC\x57\x7B\xF1\xF1\x1F\x11\x9D\xBA"
+	"\x3E\x45\x18\x99\x1B\x41\x64\x43\xEE\x97\x5D\x77\x13\x5B\x74\x69"
+	"\x73\x87\x95\x05\x07\xBE\x45\x07\x17\x7E\x4A\x69\x22\xF3\xDB\x05"
+	"\x39"
+	"\x02\x81\x80" /* exponent1 - integer of 128 bytes */
+	"\x5E\xD8\xDC\xDA\x53\x44\xC4\x67\xE0\x92\x51\x34\xE4\x83\xA5\x4D"
+	"\x3E\xDB\xA7\x9B\x82\xBB\x73\x81\xFC\xE8\x77\x4B\x15\xBE\x17\x73"
+	"\x49\x9B\x5C\x98\xBC\xBD\x26\xEF\x0C\xE9\x2E\xED\x19\x7E\x86\x41"
+	"\x1E\x9E\x48\x81\xDD\x2D\xE4\x6F\xC2\xCD\xCA\x93\x9E\x65\x7E\xD5"
+	"\xEC\x73\xFD\x15\x1B\xA2\xA0\x7A\x0F\x0D\x6E\xB4\x53\x07\x90\x92"
+	"\x64\x3B\x8B\xA9\x33\xB3\xC5\x94\x9B\x4C\x5D\x9C\x7C\x46\xA4\xA5"
+	"\x56\xF4\xF3\xF8\x27\x0A\x7B\x42\x0D\x92\x70\x47\xE7\x42\x51\xA9"
+	"\xC2\x18\xB1\x58\xB1\x50\x91\xB8\x61\x41\xB6\xA9\xCE\xD4\x7C\xBB"
+	"\x02\x81\x80" /* exponent2 - integer of 128 bytes */
+	"\x54\x09\x1F\x0F\x03\xD8\xB6\xC5\x0C\xE8\xB9\x9E\x0C\x38\x96\x43"
+	"\xD4\xA6\xC5\x47\xDB\x20\x0E\xE5\xBD\x29\xD4\x7B\x1A\xF8\x41\x57"
+	"\x49\x69\x9A\x82\xCC\x79\x4A\x43\xEB\x4D\x8B\x2D\xF2\x43\xD5\xA5"
+	"\xBE\x44\xFD\x36\xAC\x8C\x9B\x02\xF7\x9A\x03\xE8\x19\xA6\x61\xAE"
+	"\x76\x10\x93\x77\x41\x04\xAB\x4C\xED\x6A\xCC\x14\x1B\x99\x8D\x0C"
+	"\x6A\x37\x3B\x86\x6C\x51\x37\x5B\x1D\x79\xF2\xA3\x43\x10\xC6\xA7"
+	"\x21\x79\x6D\xF9\xE9\x04\x6A\xE8\x32\xFF\xAE\xFD\x1C\x7B\x8C\x29"
+	"\x13\xA3\x0C\xB2\xAD\xEC\x6C\x0F\x8D\x27\x12\x7B\x48\xB2\xDB\x31"
+	"\x02\x81\x81", /* coefficient - integer of 129 bytes */
+	"\x00\x8D\x1B\x05\xCA\x24\x1F\x0C\x53\x19\x52\x74\x63\x21\xFA\x78"
+	"\x46\x79\xAF\x5C\xDE\x30\xA4\x6C\x20\x38\xE6\x97\x39\xB8\x7A\x70"
+	"\x0D\x8B\x6C\x6D\x13\x74\xD5\x1C\xDE\xA9\xF4\x60\x37\xFE\x68\x77"
+	"\x5E\x0B\x4E\x5E\x03\x31\x30\xDF\xD6\xAE\x85\xD0\x81\xBB\x61\xC7"
+	"\xB1\x04\x5A\xC4\x6D\x56\x1C\xD9\x64\xE7\x85\x7F\x88\x91\xC9\x60"
+	"\x28\x05\xE2\xC6\x24\x8F\xDD\x61\x64\xD8\x09\xDE\x7E\xD3\x4A\x61"
+	"\x1A\xD3\x73\x58\x4B\xD8\xA0\x54\x25\x48\x83\x6F\x82\x6C\xAF\x36"
+	"\x51\x2A\x5D\x14\x2F\x41\x25\x00\xDD\xF8\xF3\x95\xFE\x31\x25\x50"
+	"\x12",
+	.key_len = 1191,
 	.m = "\x54\x85\x9b\x34\x2c\x49\xea\x2a",
 	.c =
 	"\xb2\x97\x76\xb4\xae\x3e\x38\x3c\x7e\x64\x1f\xcc\xa2\x7f\xf6\xbe"
--
2.36.1

