Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727995192AB
	for <lists+linux-crypto@lfdr.de>; Wed,  4 May 2022 02:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiEDAWQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 May 2022 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiEDAWN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 May 2022 20:22:13 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B242A0F
        for <linux-crypto@vger.kernel.org>; Tue,  3 May 2022 17:18:38 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id s14-20020ab02bce000000b0035d45862725so8103154uar.22
        for <linux-crypto@vger.kernel.org>; Tue, 03 May 2022 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DgHePJs3al550iCDd6W73SXVaCnh7nqtddV5mM8TZ+o=;
        b=rt3ihxyLOJHiV+JkPu3Og5UYSsiD3y9SgrQ4XLtio9YyUaxMj1sn1RjCPFHkwheHJ9
         aN0Ioy9QxXeDj/FHWa00iqCR44peJo0HbsfcpZ0hfOVNdHhocxeLEC2xNGECXlnmEQok
         GTOqcNnGYoDl8/5bHaCJ5glPSWa5KVj70lsxmZad8I1ec/cOGXQtugYRnIWzDDxn+hGc
         pBepCNYC3j5Qjumr9Li12tlxdZYNvqoMfqJFteIERyuOD/YXIxQBwmymjF56EpTd2XAE
         /aKCV5nhXWwEC63Q4zoJ7PA/ytBJCJ1Gxj1R6R03E8VLvv4ulD1K5HzYaQgH/eLDPs54
         Uucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DgHePJs3al550iCDd6W73SXVaCnh7nqtddV5mM8TZ+o=;
        b=6O5aNpmelSKRB5w8yBm4PzYv+qnkrLoG1HN2UjP5bFZgbXdOHPc0wmXuBtn/pfoUeg
         +sRrY6pGNJZOJkni2eD874pQDaA4CLOdWhxx8Wgn9B2ffEbqoQGP5X5DSTZ7XvyAuBRQ
         WwEknMR6xzMyD+W85KGGLWSKY09kNLzl7DpA/C7avAWkPO4klWlQyk74QAGfA50ea6sI
         wdveZKBv2M/hFgvy0Dtm2khOi8i16H7sb3zU2xfQiaCpNzqanGw+UlTavvoZgrYkXYLt
         oM8I2oxxiz9UxTMpcs48mBevHYOBGjSVP0N0dpSyfkFhrwre+jK3eGWXpW/S8/gFuclJ
         gAtw==
X-Gm-Message-State: AOAM5300knY+oYQPEd0la9WQlPxLdzCY1XVTB4+g6VlxyR9L+fbBXGCI
        5PbPLCM3o7KQKZhgZfZGZSZt9CSNX+LL04GRHC3HKFI7azTx3CLBc80ei0Biu+cXkP5cUjkVctE
        Dpc2bW3Z11+QFDp6Q3mpEm7ez3EWiAHANuoE3asQsr1KZBdLUpJHqySdJt0oJtxakywk=
X-Google-Smtp-Source: ABdhPJxdagmNEO9ITbOZVoVTbrUEvTbRHPphgTnmlNNybFmtgXG0X1g6KePa6KG+RFHwH41syLtEmGmSAQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a1f:300b:0:b0:349:7d46:3ca4 with SMTP id
 w11-20020a1f300b000000b003497d463ca4mr5812183vkw.10.1651623517421; Tue, 03
 May 2022 17:18:37 -0700 (PDT)
Date:   Wed,  4 May 2022 00:18:15 +0000
In-Reply-To: <20220504001823.2483834-1-nhuck@google.com>
Message-Id: <20220504001823.2483834-2-nhuck@google.com>
Mime-Version: 1.0
References: <20220504001823.2483834-1-nhuck@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 1/9] crypto: xctr - Add XCTR support
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Paul Crowley <paulcrowley@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add a generic implementation of XCTR mode as a template.  XCTR is a
blockcipher mode similar to CTR mode.  XCTR uses XORs and little-endian
addition rather than big-endian arithmetic which has two advantages:  It
is slightly faster on little-endian CPUs and it is less likely to be
implemented incorrect since integer overflows are not possible on
practical input sizes.  XCTR is used as a component to implement HCTR2.

More information on XCTR mode can be found in the HCTR2 paper:
https://eprint.iacr.org/2021/1441.pdf

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/Kconfig   |   9 +
 crypto/Makefile  |   1 +
 crypto/tcrypt.c  |   1 +
 crypto/testmgr.c |   6 +
 crypto/testmgr.h | 693 +++++++++++++++++++++++++++++++++++++++++++++++
 crypto/xctr.c    | 191 +++++++++++++
 6 files changed, 901 insertions(+)
 create mode 100644 crypto/xctr.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index d6d7e84bb7f8..47752aaa16ff 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -460,6 +460,15 @@ config CRYPTO_PCBC
 	  PCBC: Propagating Cipher Block Chaining mode
 	  This block cipher algorithm is required for RxRPC.
 
+config CRYPTO_XCTR
+	tristate
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
+	help
+	  XCTR: XOR Counter mode. This blockcipher mode is a variant of CTR mode
+	  using XORs and little-endian addition rather than big-endian arithmetic.
+	  XCTR mode is used to implement HCTR2.
+
 config CRYPTO_XTS
 	tristate "XTS support"
 	select CRYPTO_SKCIPHER
diff --git a/crypto/Makefile b/crypto/Makefile
index d76bff8d0ffd..6b3fe3df1489 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_CRYPTO_CTS) += cts.o
 obj-$(CONFIG_CRYPTO_LRW) += lrw.o
 obj-$(CONFIG_CRYPTO_XTS) += xts.o
 obj-$(CONFIG_CRYPTO_CTR) += ctr.o
+obj-$(CONFIG_CRYPTO_XCTR) += xctr.o
 obj-$(CONFIG_CRYPTO_KEYWRAP) += keywrap.o
 obj-$(CONFIG_CRYPTO_ADIANTUM) += adiantum.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305) += nhpoly1305.o
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 2bacf8384f59..fd671d0e2012 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1556,6 +1556,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("rfc3686(ctr(aes))");
 		ret += tcrypt_test("ofb(aes)");
 		ret += tcrypt_test("cfb(aes)");
+		ret += tcrypt_test("xctr(aes)");
 		break;
 
 	case 11:
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 2d632a285869..fbb12d7d78af 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5490,6 +5490,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.cipher = __VECS(xchacha20_tv_template)
 		},
+	}, {
+		.alg = "xctr(aes)",
+		.test = alg_test_skcipher,
+		.suite = {
+			.cipher = __VECS(aes_xctr_tv_template)
+		}
 	}, {
 		.alg = "xts(aes)",
 		.generic_driver = "xts(ecb(aes-generic))",
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index d1aa90993bbd..bf4ff97eeb37 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34236,4 +34236,697 @@ static const struct hash_testvec blakes2s_256_tv_template[] = {{
 			  0xd5, 0x06, 0xb5, 0x3a, 0x7c, 0x7a, 0x65, 0x1d, },
 }};
 
+/*
+ * Test vectors generated using https://github.com/google/hctr2
+ */
+static const struct cipher_testvec aes_xctr_tv_template[] = {
+	{
+		.key	= "\x9c\x8d\xc4\xbd\x71\x36\xdc\x82"
+			  "\x7c\xa1\xca\xa3\x23\x5a\xdb\xa4",
+		.iv	= "\x8d\xe7\xa5\x6a\x95\x86\x42\xde"
+			  "\xba\xea\x6e\x69\x03\x33\x86\x0f",
+		.ptext	= "\xbd",
+		.ctext	= "\xb9",
+		.klen	= 16,
+		.len	= 1,
+	},
+	{
+		.key	= "\xbc\x1b\x12\x0c\x3f\x18\xcc\x1f"
+			  "\x5a\x1d\xab\x81\xa8\x68\x7c\x63",
+		.iv	= "\x22\xc1\xdd\x25\x0b\x18\xcb\xa5"
+			  "\x4a\xda\x15\x07\x73\xd9\x88\x10",
+		.ptext	= "\x24\x6e\x64\xc6\x15\x26\x9c\xda"
+			  "\x2a\x4b\x57\x12\xff\x7c\xd6\xb5",
+		.ctext	= "\xd6\x47\x8d\x58\x92\xb2\x84\xf9"
+			  "\xb7\xee\x0d\x98\xa1\x39\x4d\x8f",
+		.klen	= 16,
+		.len	= 16,
+	},
+	{
+		.key	= "\x44\x03\xbf\x4c\x30\xf0\xa7\xd6"
+			  "\xbd\x54\xbb\x66\x8e\xa6\x0e\x8a",
+		.iv	= "\xe6\xf7\x26\xdf\x8c\x3c\xaa\x88"
+			  "\xce\xc1\xbd\x43\x3b\x09\x62\xad",
+		.ptext	= "\x3c\xe3\x46\xb9\x8f\x9d\x3f\x8d"
+			  "\xef\xf2\x53\xab\x24\xe2\x29\x08"
+			  "\xf8\x7e\x1d\xa6\x6d\x86\x7d\x60"
+			  "\x97\x63\x93\x29\x71\x94\xb4",
+		.ctext	= "\xd4\xa3\xc6\xb8\xc1\x6f\x70\x1a"
+			  "\x52\x0c\xed\x4c\xaf\x51\x56\x23"
+			  "\x48\x45\x07\x10\x34\xc5\xba\x71"
+			  "\xe5\xf8\x1e\xd8\xcb\xa6\xe7",
+		.klen	= 16,
+		.len	= 31,
+	},
+	{
+		.key	= "\x5b\x17\x30\x94\x19\x31\xa1\xae"
+			  "\x24\x8e\x42\x1e\x82\xe6\xec\xb8",
+		.iv	= "\xd1\x2e\xb9\xb8\xf8\x49\xeb\x68"
+			  "\x06\xeb\x65\x33\x34\xa2\xeb\xf0",
+		.ptext	= "\x19\x75\xec\x59\x60\x1b\x7a\x3e"
+			  "\x62\x46\x87\xf0\xde\xab\x81\x36"
+			  "\x63\x53\x11\xa0\x1f\xce\x25\x85"
+			  "\x49\x6b\x28\xfa\x1c\x92\xe5\x18"
+			  "\x38\x14\x00\x79\xf2\x9e\xeb\xfc"
+			  "\x36\xa7\x6b\xe1\xe5\xcf\x04\x48"
+			  "\x44\x6d\xbd\x64\xb3\xcb\x78\x05"
+			  "\x8d\x7f\x9a\xaf\x3c\xcf\x6c\x45"
+			  "\x6c\x7c\x46\x4c\xa8\xc0\x1e\xe4"
+			  "\x33\xa5\x7b\xbb\x26\xd9\xc0\x32"
+			  "\x9d\x8a\xb3\xf3\x3d\x52\xe6\x48"
+			  "\x4c\x9b\x4c\x6e\xa4\xa3\xad\x66"
+			  "\x56\x48\xd5\x98\x3a\x93\xc4\x85"
+			  "\xe9\x89\xca\xa6\xc1\xc8\xe7\xf8"
+			  "\xc3\xe9\xef\xbe\x77\xe6\xd1\x3a"
+			  "\xa6\x99\xc8\x2d\xdf\x40\x0f\x44",
+		.ctext	= "\xc6\x1a\x01\x1a\x00\xba\x04\xff"
+			  "\x10\xd1\x7e\x5d\xad\x91\xde\x8c"
+			  "\x08\x55\x95\xae\xd7\x22\x77\x40"
+			  "\xf0\x33\x1b\x51\xef\xfe\x3d\x67"
+			  "\xdf\xc4\x9f\x39\x47\x67\x93\xab"
+			  "\xaa\x37\x55\xfe\x41\xe0\xba\xcd"
+			  "\x25\x02\x7c\x61\x51\xa1\xcc\x72"
+			  "\x7a\x20\x26\xb9\x06\x68\xbd\x19"
+			  "\xc5\x2e\x1b\x75\x4a\x40\xb2\xd2"
+			  "\xc4\xee\xd8\x5b\xa4\x55\x7d\x25"
+			  "\xfc\x01\x4d\x6f\x0a\xfd\x37\x5d"
+			  "\x3e\x67\xc0\x35\x72\x53\x7b\xe2"
+			  "\xd6\x19\x5b\x92\x6c\x3a\x8c\x2a"
+			  "\xe2\xc2\xa2\x4f\x2a\xf2\xb5\x15"
+			  "\x65\xc5\x8d\x97\xf9\xbf\x8c\x98"
+			  "\xe4\x50\x1a\xf2\x76\x55\x07\x49",
+		.klen	= 16,
+		.len	= 128,
+	},
+	{
+		.key	= "\x17\xa6\x01\x3d\x5d\xd6\xef\x2d"
+			  "\x69\x8f\x4c\x54\x5b\xae\x43\xf0",
+		.iv	= "\xa9\x1b\x47\x60\x26\x82\xf7\x1c"
+			  "\x80\xf8\x88\xdd\xfb\x44\xd9\xda",
+		.ptext	= "\xf7\x67\xcd\xa6\x04\x65\x53\x99"
+			  "\x90\x5c\xa2\x56\x74\xd7\x9d\xf2"
+			  "\x0b\x03\x7f\x4e\xa7\x84\x72\x2b"
+			  "\xf0\xa5\xbf\xe6\x9a\x62\x3a\xfe"
+			  "\x69\x5c\x93\x79\x23\x86\x64\x85"
+			  "\xeb\x13\xb1\x5a\xd5\x48\x39\xa0"
+			  "\x70\xfb\x06\x9a\xd7\x12\x5a\xb9"
+			  "\xbe\xed\x2c\x81\x64\xf7\xcf\x80"
+			  "\xee\xe6\x28\x32\x2d\x37\x4c\x32"
+			  "\xf4\x1f\x23\x21\xe9\xc8\xc9\xbf"
+			  "\x54\xbc\xcf\xb4\xc2\x65\x39\xdf"
+			  "\xa5\xfb\x14\x11\xed\x62\x38\xcf"
+			  "\x9b\x58\x11\xdd\xe9\xbd\x37\x57"
+			  "\x75\x4c\x9e\xd5\x67\x0a\x48\xc6"
+			  "\x0d\x05\x4e\xb1\x06\xd7\xec\x2e"
+			  "\x9e\x59\xde\x4f\xab\x38\xbb\xe5"
+			  "\x87\x04\x5a\x2c\x2a\xa2\x8f\x3c"
+			  "\xe7\xe1\x46\xa9\x49\x9f\x24\xad"
+			  "\x2d\xb0\x55\x40\x64\xd5\xda\x7e"
+			  "\x1e\x77\xb8\x29\x72\x73\xc3\x84"
+			  "\xcd\xf3\x94\x90\x58\x76\xc9\x2c"
+			  "\x2a\xad\x56\xde\x33\x18\xb6\x3b"
+			  "\x10\xe9\xe9\x8d\xf0\xa9\x7f\x05"
+			  "\xf7\xb5\x8c\x13\x7e\x11\x3d\x1e"
+			  "\x02\xbb\x5b\xea\x69\xff\x85\xcf"
+			  "\x6a\x18\x97\x45\xe3\x96\xba\x4d"
+			  "\x2d\x7a\x70\x78\x15\x2c\xe9\xdc"
+			  "\x4e\x09\x92\x57\x04\xd8\x0b\xa6"
+			  "\x20\x71\x76\x47\x76\x96\x89\xa0"
+			  "\xd9\x29\xa2\x5a\x06\xdb\x56\x39"
+			  "\x60\x33\x59\x04\x95\x89\xf6\x18"
+			  "\x1d\x70\x75\x85\x3a\xb7\x6e",
+		.ctext	= "\xe1\xe7\x3f\xd3\x6a\xb9\x2f\x64"
+			  "\x37\xc5\xa4\xe9\xca\x0a\xa1\xd6"
+			  "\xea\x7d\x39\xe5\xe6\xcc\x80\x54"
+			  "\x74\x31\x2a\x04\x33\x79\x8c\x8e"
+			  "\x4d\x47\x84\x28\x27\x9b\x3c\x58"
+			  "\x54\x58\x20\x4f\x70\x01\x52\x5b"
+			  "\xac\x95\x61\x49\x5f\xef\xba\xce"
+			  "\xd7\x74\x56\xe7\xbb\xe0\x3c\xd0"
+			  "\x7f\xa9\x23\x57\x33\x2a\xf6\xcb"
+			  "\xbe\x42\x14\x95\xa8\xf9\x7a\x7e"
+			  "\x12\x53\x3a\xe2\x13\xfe\x2d\x89"
+			  "\xeb\xac\xd7\xa8\xa5\xf8\x27\xf3"
+			  "\x74\x9a\x65\x63\xd1\x98\x3a\x7e"
+			  "\x27\x7b\xc0\x20\x00\x4d\xf4\xe5"
+			  "\x7b\x69\xa6\xa8\x06\x50\x85\xb6"
+			  "\x7f\xac\x7f\xda\x1f\xf5\x37\x56"
+			  "\x9b\x2f\xd3\x86\x6b\x70\xbd\x0e"
+			  "\x55\x9a\x9d\x4b\x08\xb5\x5b\x7b"
+			  "\xd4\x7c\xb4\x71\x49\x92\x4a\x1e"
+			  "\xed\x6d\x11\x09\x47\x72\x32\x6a"
+			  "\x97\x53\x36\xaf\xf3\x06\x06\x2c"
+			  "\x69\xf1\x59\x00\x36\x95\x28\x2a"
+			  "\xb6\xcd\x10\x21\x84\x73\x5c\x96"
+			  "\x86\x14\x2c\x3d\x02\xdb\x53\x9a"
+			  "\x61\xde\xea\x99\x84\x7a\x27\xf6"
+			  "\xf7\xc8\x49\x73\x4b\xb8\xeb\xd3"
+			  "\x41\x33\xdd\x09\x68\xe2\x64\xb8"
+			  "\x5f\x75\x74\x97\x91\x54\xda\xc2"
+			  "\x73\x2c\x1e\x5a\x84\x48\x01\x1a"
+			  "\x0d\x8b\x0a\xdf\x07\x2e\xee\x77"
+			  "\x1d\x17\x41\x7a\xc9\x33\x63\xfa"
+			  "\x9f\xc3\x74\x57\x5f\x03\x4c",
+		.klen	= 16,
+		.len	= 255,
+	},
+	{
+		.key	= "\xe5\xf1\x48\x2e\x88\xdb\xc7\x28"
+			  "\xa2\x55\x5d\x2f\x90\x02\xdc\xd3"
+			  "\xf5\xd3\x9e\x87\xd5\x58\x30\x4a",
+		.iv	= "\xa6\x40\x39\xf9\x63\x6c\x2d\xd4"
+			  "\x1b\x71\x05\xa4\x88\x86\x11\xd3",
+		.ptext	= "\xb6\x06\xae\x15\x11\x96\xc1\x44"
+			  "\x44\xc2\x98\xf9\xa8\x0a\x0b",
+		.ctext	= "\x27\x3b\x68\x40\xa9\x5e\x74\x6b"
+			  "\x74\x67\x18\xf9\x37\xed\xed",
+		.klen	= 24,
+		.len	= 15,
+	},
+	{
+		.key	= "\xc8\xa0\x27\x67\x04\x3f\xed\xa5"
+			  "\xb4\x0c\x51\x91\x2d\x27\x77\x33"
+			  "\xa5\xfc\x2a\x9f\x78\xd8\x1c\x68",
+		.iv	= "\x83\x99\x1a\xe2\x84\xca\xa9\x16"
+			  "\x8d\xc4\x2d\x1b\x67\xc8\x86\x21",
+		.ptext	= "\xd6\x22\x85\xb8\x5d\x7e\x26\x2e"
+			  "\xbe\x04\x9d\x0c\x03\x91\x45\x4a"
+			  "\x36",
+		.ctext	= "\x0f\x44\xa9\x62\x72\xec\x12\x26"
+			  "\x3a\xc6\x83\x26\x62\x5e\xb7\x13"
+			  "\x05",
+		.klen	= 24,
+		.len	= 17,
+	},
+	{
+		.key	= "\xc5\x87\x18\x09\x0a\x4e\x66\x3e"
+			  "\x50\x90\x19\x93\xc0\x33\xcf\x80"
+			  "\x3a\x36\x6b\x6c\x43\xd7\xe4\x93",
+		.iv	= "\xdd\x0b\x75\x1f\xee\x2f\xb4\x52"
+			  "\x10\x82\x1f\x79\x8a\xa4\x9b\x87",
+		.ptext	= "\x56\xf9\x13\xce\x9f\x30\x10\x11"
+			  "\x1b\x59\xfd\x39\x5a\x29\xa3\x44"
+			  "\x78\x97\x8c\xf6\x99\x6d\x26\xf1"
+			  "\x32\x60\x6a\xeb\x04\x47\x29\x4c"
+			  "\x7e\x14\xef\x4d\x55\x29\xfe\x36"
+			  "\x37\xcf\x0b\x6e\xf3\xce\x15\xd2",
+		.ctext	= "\x8f\x98\xe1\x5a\x7f\xfe\xc7\x05"
+			  "\x76\xb0\xd5\xde\x90\x52\x2b\xa8"
+			  "\xf3\x6e\x3c\x77\xa5\x33\x63\xdd"
+			  "\x6f\x62\x12\xb0\x80\x10\xc1\x28"
+			  "\x58\xe5\xd6\x24\x44\x04\x55\xf3"
+			  "\x6d\x94\xcb\x2c\x7e\x7a\x85\x79",
+		.klen	= 24,
+		.len	= 48,
+	},
+	{
+		.key	= "\x84\x9b\xe8\x10\x4c\xb3\xd1\x7a"
+			  "\xb3\xab\x4e\x6f\x90\x12\x07\xf8"
+			  "\xef\xde\x42\x09\xbf\x34\x95\xb2",
+		.iv	= "\x66\x62\xf9\x48\x9d\x17\xf7\xdf"
+			  "\x06\x67\xf4\x6d\xf2\xbc\xa2\xe5",
+		.ptext	= "\x2f\xd6\x16\x6b\xf9\x4b\x44\x14"
+			  "\x90\x93\xe5\xfd\x05\xaa\x00\x26"
+			  "\xbd\xab\x11\xb8\xf0\xcb\x11\x72"
+			  "\xdd\xc5\x15\x4f\x4e\x1b\xf8\xc9"
+			  "\x8f\x4a\xd5\x69\xf8\x9e\xfb\x05"
+			  "\x8a\x37\x46\xfe\xfa\x58\x9b\x0e"
+			  "\x72\x90\x9a\x06\xa5\x42\xf4\x7c"
+			  "\x35\xd5\x64\x70\x72\x67\xfc\x8b"
+			  "\xab\x5a\x2f\x64\x9b\xa1\xec\xe7"
+			  "\xe6\x92\x69\xdb\x62\xa4\xe7\x44"
+			  "\x88\x28\xd4\x52\x64\x19\xa9\xd7"
+			  "\x0c\x00\xe6\xe7\xc1\x28\xc1\xf5"
+			  "\x72\xc5\xfa\x09\x22\x2e\xf4\x82"
+			  "\xa3\xdc\xc1\x68\xf9\x29\x55\x8d"
+			  "\x04\x67\x13\xa6\x52\x04\x3c\x0c"
+			  "\x14\xf2\x87\x23\x61\xab\x82\xcb"
+			  "\x49\x5b\x6b\xd4\x4f\x0d\xd4\x95"
+			  "\x82\xcd\xe3\x69\x47\x1b\x31\x73"
+			  "\x73\x77\xc1\x53\x7d\x43\x5e\x4a"
+			  "\x80\x3a\xca\x9c\xc7\x04\x1a\x31"
+			  "\x8e\xe6\x76\x7f\xe1\xb3\xd0\x57"
+			  "\xa2\xb2\xf6\x09\x51\xc9\x6d\xbc"
+			  "\x79\xed\x57\x50\x36\xd2\x93\xa4"
+			  "\x40\x5d\xac\x3a\x3b\xb6\x2d\x89"
+			  "\x78\xa2\xbd\x23\xec\x35\x06\xf0"
+			  "\xa8\xc8\xc9\xb0\xe3\x28\x2b\xba"
+			  "\x70\xa0\xfe\xed\x13\xc4\xd7\x90"
+			  "\xb1\x6a\xe0\xe1\x30\x71\x15\xd0"
+			  "\xe2\xb3\xa6\x4e\xb0\x01\xf9\xe7"
+			  "\x59\xc6\x1e\xed\x46\x2b\xe3\xa8"
+			  "\x22\xeb\x7f\x1c\xd9\xcd\xe0\xa6"
+			  "\x72\x42\x2c\x06\x75\xbb\xb7\x6b"
+			  "\xca\x49\x5e\xa1\x47\x8d\x9e\xfe"
+			  "\x60\xcc\x34\x95\x8e\xfa\x1e\x3e"
+			  "\x85\x4b\x03\x54\xea\x34\x1c\x41"
+			  "\x90\x45\xa6\xbe\xcf\x58\x4f\xca"
+			  "\x2c\x79\xc0\x3e\x8f\xd7\x3b\xd4"
+			  "\x55\x74\xa8\xe1\x57\x09\xbf\xab"
+			  "\x2c\xf9\xe4\xdd\x17\x99\x57\x60"
+			  "\x4b\x88\x2a\x7f\x43\x86\xb9\x9a"
+			  "\x60\xbf\x4c\xcf\x9b\x41\xb8\x99"
+			  "\x69\x15\x4f\x91\x4d\xeb\xdf\x6f"
+			  "\xcc\x4c\xf9\x6f\xf2\x33\x23\xe7"
+			  "\x02\x44\xaa\xa2\xfa\xb1\x39\xa5"
+			  "\xff\x88\xf5\x37\x02\x33\x24\xfc"
+			  "\x79\x11\x4c\x94\xc2\x31\x87\x9c"
+			  "\x53\x19\x99\x32\xe4\xde\x18\xf4"
+			  "\x8f\xe2\xe8\xa3\xfb\x0b\xaa\x7c"
+			  "\xdb\x83\x0f\xf6\xc0\x8a\x9b\xcd"
+			  "\x7b\x16\x05\x5b\xe4\xb4\x34\x03"
+			  "\xe3\x8f\xc9\x4b\x56\x84\x2a\x4c"
+			  "\x36\x72\x3c\x84\x4f\xba\xa2\x7f"
+			  "\xf7\x1b\xba\x4d\x8a\xb8\x5d\x51"
+			  "\x36\xfb\xef\x23\x18\x6f\x33\x2d"
+			  "\xbb\x06\x24\x8e\x33\x98\x6e\xcd"
+			  "\x63\x11\x18\x6b\xcc\x1b\x66\xb9"
+			  "\x38\x8d\x06\x8d\x98\x1a\xef\xaa"
+			  "\x35\x4a\x90\xfa\xb1\xd3\xcc\x11"
+			  "\x50\x4c\x54\x18\x60\x5d\xe4\x11"
+			  "\xfc\x19\xe1\x53\x20\x5c\xe7\xef"
+			  "\x8a\x2b\xa8\x82\x51\x5f\x5d\x43"
+			  "\x34\xe5\xcf\x7b\x1b\x6f\x81\x19"
+			  "\xb7\xdf\xa8\x9e\x81\x89\x5f\x33"
+			  "\x69\xaf\xde\x89\x68\x88\xf0\x71",
+		.ctext	= "\xab\x15\x46\x5b\xed\x4f\xa8\xac"
+			  "\xbf\x31\x30\x84\x55\xa4\xb8\x98"
+			  "\x79\xba\xa0\x15\xa4\x55\x20\xec"
+			  "\xf9\x94\x71\xe6\x6a\x6f\xee\x87"
+			  "\x2e\x3a\xa2\x95\xae\x6e\x56\x09"
+			  "\xe9\xc0\x0f\xe2\xc6\xb7\x30\xa9"
+			  "\x73\x8e\x59\x7c\xfd\xe3\x71\xf7"
+			  "\xae\x8b\x91\xab\x5e\x36\xe9\xa8"
+			  "\xff\x17\xfa\xa2\x94\x93\x11\x42"
+			  "\x67\x96\x99\xc5\xf0\xad\x2a\x57"
+			  "\xf9\xa6\x70\x4a\xdf\x71\xff\xc0"
+			  "\xe2\xaf\x9a\xae\x57\x58\x13\x3b"
+			  "\x2d\xf1\xc7\x8f\xdb\x8a\xcc\xce"
+			  "\x53\x1a\x69\x55\x39\xc8\xbe\xc3"
+			  "\x2d\xb1\x03\xd9\xa3\x99\xf4\x8d"
+			  "\xd9\x2d\x27\xae\xa5\xe7\x77\x7f"
+			  "\xbb\x88\x84\xea\xfa\x19\x3f\x44"
+			  "\x61\x21\x8a\x1f\xbe\xac\x60\xb4"
+			  "\xaf\xe9\x00\xab\xef\x3c\x53\x56"
+			  "\xcd\x4b\x53\xd8\x9b\xfe\x88\x23"
+			  "\x5b\x85\x76\x08\xec\xd1\x6e\x4a"
+			  "\x87\xa4\x7d\x29\x4e\x4f\x3f\xc9"
+			  "\xa4\xab\x63\xea\xdd\xef\x9f\x79"
+			  "\x38\x18\x7d\x90\x90\xf9\x12\x57"
+			  "\x1d\x89\xea\xfe\xd4\x47\x45\x32"
+			  "\x6a\xf6\xe7\xde\x22\x7e\xee\xc1"
+			  "\xbc\x2d\xc3\xbb\xe5\xd4\x13\xac"
+			  "\x63\xff\x5b\xb1\x05\x96\xd5\xf3"
+			  "\x07\x9a\x62\xb6\x30\xea\x7d\x1e"
+			  "\xee\x75\x0a\x1b\xcc\x6e\x4d\xa7"
+			  "\xf7\x4d\x74\xd8\x60\x32\x5e\xd0"
+			  "\x93\xd7\x19\x90\x4e\x26\xdb\xe4"
+			  "\x5e\xd4\xa8\xb9\x76\xba\x56\x91"
+			  "\xc4\x75\x04\x1e\xc2\x77\x24\x6f"
+			  "\xf9\xe8\x4a\xec\x7f\x86\x95\xb3"
+			  "\x5c\x2c\x97\xab\xf0\xf7\x74\x5b"
+			  "\x0b\xc2\xda\x42\x40\x34\x16\xed"
+			  "\x06\xc1\x25\x53\x17\x0d\x81\x4e"
+			  "\xe6\xf2\x0f\x6d\x94\x3c\x90\x7a"
+			  "\xae\x20\xe9\x3f\xf8\x18\x67\x6a"
+			  "\x49\x1e\x41\xb6\x46\xab\xc8\xa7"
+			  "\xcb\x19\x96\xf5\x99\xc0\x66\x3e"
+			  "\x77\xcf\x73\x52\x83\x2a\xe2\x48"
+			  "\x27\x6c\xeb\xe7\xe7\xc4\xd5\x6a"
+			  "\x40\x67\xbc\xbf\x6b\x3c\xf3\xbb"
+			  "\x51\x5e\x31\xac\x03\x81\xab\x61"
+			  "\xfa\xa5\xa6\x7d\x8b\xc3\x8a\x75"
+			  "\x28\x7a\x71\x9c\xac\x8f\x76\xfc"
+			  "\xf9\x6c\x5d\x9b\xd7\xf6\x36\x2d"
+			  "\x61\xd5\x61\xaa\xdd\x01\xfc\x57"
+			  "\x91\x10\xcd\xcd\x6d\x27\x63\x24"
+			  "\x67\x46\x7a\xbb\x61\x56\x39\xb1"
+			  "\xd6\x79\xfe\x77\xca\xd6\x73\x59"
+			  "\x6e\x58\x11\x90\x03\x26\x74\x2a"
+			  "\xfa\x52\x12\x47\xfb\x12\xeb\x3e"
+			  "\x88\xf0\x52\x6c\xc0\x54\x7a\x88"
+			  "\x8c\xe5\xde\x9e\xba\xb9\xf2\xe1"
+			  "\x97\x2e\x5c\xbd\xf4\x13\x7e\xf3"
+			  "\xc4\xe1\x87\xa5\x35\xfa\x7c\x71"
+			  "\x1a\xc9\xf4\xa8\x57\xe2\x5a\x6b"
+			  "\x14\xe0\x73\xaf\x56\x6b\xa0\x00"
+			  "\x9e\x5f\x64\xac\x00\xfb\xc4\x92"
+			  "\xe5\xe2\x8a\xb2\x9e\x75\x49\x85"
+			  "\x25\x66\xa5\x1a\xf9\x7d\x1d\x60",
+		.klen	= 24,
+		.len	= 512,
+	},
+	{
+		.key	= "\x05\x60\x3a\x7e\x60\x90\x46\x18"
+			  "\x6c\x60\xba\xeb\x12\xd7\xbe\xd1"
+			  "\xd3\xf6\x10\x46\x9d\xf1\x0c\xb4"
+			  "\x73\xe3\x93\x27\xa8\x2c\x13\xaa",
+		.iv	= "\xf5\x96\xd1\xb6\xcb\x44\xd8\xd0"
+			  "\x3e\xdb\x92\x80\x08\x94\xcd\xd3",
+		.ptext	= "\x78",
+		.ctext	= "\xc5",
+		.klen	= 32,
+		.len	= 1,
+	},
+	{
+		.key	= "\x35\xca\x38\xf3\xd9\xd6\x34\xef"
+			  "\xcd\xee\xa3\x26\x86\xba\xfb\x45"
+			  "\x01\xfa\x52\x67\xff\xc5\x9d\xaa"
+			  "\x64\x9a\x05\xbb\x85\x20\xa7\xf2",
+		.iv	= "\xe3\xda\xf5\xff\x42\x59\x87\x86"
+			  "\xee\x7b\xd6\xb4\x6a\x25\x44\xff",
+		.ptext	= "\x44\x67\x1e\x04\x53\xd2\x4b\xd9"
+			  "\x96\x33\x07\x54\xe4\x8e\x20",
+		.ctext	= "\xcc\x55\x40\x79\x47\x5c\x8b\xa6"
+			  "\xca\x7b\x9f\x50\xe3\x21\xea",
+		.klen	= 32,
+		.len	= 15,
+	},
+	{
+		.key	= "\xaf\xd9\x14\x14\xd5\xdb\xc9\xce"
+			  "\x76\x5c\x5a\xbf\x43\x05\x29\x24"
+			  "\xc4\x13\x68\xcc\xe8\x37\xbd\xb9"
+			  "\x41\x20\xf5\x53\x48\xd0\xa2\xd6",
+		.iv	= "\xa7\xb4\x00\x08\x79\x10\xae\xf5"
+			  "\x02\xbf\x85\xb2\x69\x4c\xc6\x04",
+		.ptext	= "\xac\x6a\xa8\x0c\xb0\x84\xbf\x4c"
+			  "\xae\x94\x20\x58\x7e\x00\x93\x89",
+		.ctext	= "\xd5\xaa\xe2\xe9\x86\x4c\x95\x4e"
+			  "\xde\xb6\x15\xcb\xdc\x1f\x13\x38",
+		.klen	= 32,
+		.len	= 16,
+	},
+	{
+		.key	= "\xed\xe3\x8b\xe7\x1c\x17\xbf\x4a"
+			  "\x02\xe2\xfc\x76\xac\xf5\x3c\x00"
+			  "\x5d\xdc\xfc\x83\xeb\x45\xb4\xcb"
+			  "\x59\x62\x60\xec\x69\x9c\x16\x45",
+		.iv	= "\xe4\x0e\x2b\x90\xd2\xfa\x94\x2e"
+			  "\x10\xe5\x64\x2b\x97\x28\x15\xc7",
+		.ptext	= "\xe6\x53\xff\x60\x0e\xc4\x51\xe4"
+			  "\x93\x4d\xe5\x55\xc5\xd9\xad\x48"
+			  "\x52",
+		.ctext	= "\xba\x25\x28\xf5\xcf\x31\x91\x80"
+			  "\xda\x2b\x95\x5f\x20\xcb\xfb\x9f"
+			  "\xc6",
+		.klen	= 32,
+		.len	= 17,
+	},
+	{
+		.key	= "\x77\x5c\xc0\x73\x9a\x64\x97\x91"
+			  "\x2f\xee\xe0\x20\xc2\x04\x59\x2e"
+			  "\x97\xd2\xa7\x70\xb3\xb0\x21\x6b"
+			  "\x8f\xbf\xb8\x51\xa8\xea\x0f\x62",
+		.iv	= "\x31\x8e\x1f\xcd\xfd\x23\xeb\x7f"
+			  "\x8a\x1f\x1b\x23\x53\x27\x44\xe5",
+		.ptext	= "\xcd\xff\x8c\x9b\x94\x5a\x51\x3f"
+			  "\x40\x93\x56\x93\x66\x39\x63\x1f"
+			  "\xbf\xe6\xa4\xfa\xbe\x79\x93\x03"
+			  "\xf5\x66\x74\x16\xfc\xe4\xce",
+		.ctext	= "\x8b\xd3\xc3\xce\x66\xf8\x66\x4c"
+			  "\xad\xd6\xf5\x0f\xd8\x99\x5a\x75"
+			  "\xa1\x3c\xab\x0b\x21\x36\x57\x72"
+			  "\x88\x29\xe9\xea\x4a\x8d\xe9",
+		.klen	= 32,
+		.len	= 31,
+	},
+	{
+		.key	= "\xa1\x2f\x4d\xde\xfe\xa1\xff\xa8"
+			  "\x73\xdd\xe3\xe2\x95\xfc\xea\x9c"
+			  "\xd0\x80\x42\x0c\xb8\x43\x3e\x99"
+			  "\x39\x38\x0a\x8c\xe8\x45\x3a\x7b",
+		.iv	= "\x32\xc4\x6f\xb1\x14\x43\xd1\x87"
+			  "\xe2\x6f\x5a\x58\x02\x36\x7e\x2a",
+		.ptext	= "\x9e\x5c\x1e\xf1\xd6\x7d\x09\x57"
+			  "\x18\x48\x55\xda\x7d\x44\xf9\x6d"
+			  "\xac\xcd\x59\xbb\x10\xa2\x94\x67"
+			  "\xd1\x6f\xfe\x6b\x4a\x11\xe8\x04"
+			  "\x09\x26\x4f\x8d\x5d\xa1\x7b\x42"
+			  "\xf9\x4b\x66\x76\x38\x12\xfe\xfe",
+		.ctext	= "\x42\xbc\xa7\x64\x15\x9a\x04\x71"
+			  "\x2c\x5f\x94\xba\x89\x3a\xad\xbc"
+			  "\x87\xb3\xf4\x09\x4f\x57\x06\x18"
+			  "\xdc\x84\x20\xf7\x64\x85\xca\x3b"
+			  "\xab\xe6\x33\x56\x34\x60\x5d\x4b"
+			  "\x2e\x16\x13\xd4\x77\xde\x2d\x2b",
+		.klen	= 32,
+		.len	= 48,
+	},
+	{
+		.key	= "\xfb\xf5\xb7\x3d\xa6\x95\x42\xbf"
+			  "\xd2\x94\x6c\x74\x0f\xbc\x5a\x28"
+			  "\x35\x3c\x51\x58\x84\xfb\x7d\x11"
+			  "\x16\x1e\x00\x97\x37\x08\xb7\x16",
+		.iv	= "\x9b\x53\x57\x40\xe6\xd9\xa7\x27"
+			  "\x78\xd4\x9b\xd2\x29\x1d\x24\xa9",
+		.ptext	= "\x8b\x02\x60\x0a\x3e\xb7\x10\x59"
+			  "\xc3\xac\xd5\x2a\x75\x81\xf2\xdb"
+			  "\x55\xca\x65\x86\x44\xfb\xfe\x91"
+			  "\x26\xbb\x45\xb2\x46\x22\x3e\x08"
+			  "\xa2\xbf\x46\xcb\x68\x7d\x45\x7b"
+			  "\xa1\x6a\x3c\x6e\x25\xeb\xed\x31"
+			  "\x7a\x8b\x47\xf9\xde\xec\x3d\x87"
+			  "\x09\x20\x2e\xfa\xba\x8b\x9b\xc5"
+			  "\x6c\x25\x9c\x9d\x2a\xe8\xab\x90"
+			  "\x3f\x86\xee\x61\x13\x21\xd4\xde"
+			  "\xe1\x0c\x95\xfc\x5c\x8a\x6e\x0a"
+			  "\x73\xcf\x08\x69\x44\x4e\xde\x25"
+			  "\xaf\xaa\x56\x04\xc4\xb3\x60\x44"
+			  "\x3b\x8b\x3d\xee\xae\x42\x4b\xd2"
+			  "\x9a\x6c\xa0\x8e\x52\x06\xb2\xd1"
+			  "\x5d\x38\x30\x6d\x27\x9b\x1a\xd8",
+		.ctext	= "\xa3\x78\x33\x78\x95\x95\x97\x07"
+			  "\x53\xa3\xa1\x5b\x18\x32\x27\xf7"
+			  "\x09\x12\x53\x70\x83\xb5\x6a\x9f"
+			  "\x26\x6d\x10\x0d\xe0\x1c\xe6\x2b"
+			  "\x70\x00\xdc\xa1\x60\xef\x1b\xee"
+			  "\xc5\xa5\x51\x17\xae\xcc\xf2\xed"
+			  "\xc4\x60\x07\xdf\xd5\x7a\xe9\x90"
+			  "\x3c\x9f\x96\x5d\x72\x65\x5d\xef"
+			  "\xd0\x94\x32\xc4\x85\x90\x78\xa1"
+			  "\x2e\x64\xf6\xee\x8e\x74\x3f\x20"
+			  "\x2f\x12\x3b\x3d\xd5\x39\x8e\x5a"
+			  "\xf9\x8f\xce\x94\x5d\x82\x18\x66"
+			  "\x14\xaf\x4c\xfe\xe0\x91\xc3\x4a"
+			  "\x85\xcf\xe7\xe8\xf7\xcb\xf0\x31"
+			  "\x88\x7d\xc9\x5b\x71\x9d\x5f\xd2"
+			  "\xfa\xed\xa6\x24\xda\xbb\xb1\x84",
+		.klen	= 32,
+		.len	= 128,
+	},
+	{
+		.key	= "\x32\x37\x2b\x8f\x7b\xb1\x23\x79"
+			  "\x05\x52\xde\x05\xf1\x68\x3f\x6c"
+			  "\xa4\xae\xbc\x21\xc2\xc6\xf0\xbd"
+			  "\x0f\x20\xb7\xa4\xc5\x05\x7b\x64",
+		.iv	= "\xff\x26\x4e\x67\x48\xdd\xcf\xfe"
+			  "\x42\x09\x04\x98\x5f\x1e\xfa\x80",
+		.ptext	= "\x99\xdc\x3b\x19\x41\xf9\xff\x6e"
+			  "\x76\xb5\x03\xfa\x61\xed\xf8\x44"
+			  "\x70\xb9\xf0\x83\x80\x6e\x31\x77"
+			  "\x77\xe4\xc7\xb4\x77\x02\xab\x91"
+			  "\x82\xc6\xf8\x7c\x46\x61\x03\x69"
+			  "\x09\xa0\xf7\x12\xb7\x81\x6c\xa9"
+			  "\x10\x5c\xbb\x55\xb3\x44\xed\xb5"
+			  "\xa2\x52\x48\x71\x90\x5d\xda\x40"
+			  "\x0b\x7f\x4a\x11\x6d\xa7\x3d\x8e"
+			  "\x1b\xcd\x9d\x4e\x75\x8b\x7d\x87"
+			  "\xe5\x39\x34\x32\x1e\xe6\x8d\x51"
+			  "\xd4\x1f\xe3\x1d\x50\xa0\x22\x37"
+			  "\x7c\xb0\xd9\xfb\xb6\xb2\x16\xf6"
+			  "\x6d\x26\xa0\x4e\x8c\x6a\xe6\xb6"
+			  "\xbe\x4c\x7c\xe3\x88\x10\x18\x90"
+			  "\x11\x50\x19\x90\xe7\x19\x3f\xd0"
+			  "\x31\x15\x0f\x06\x96\xfe\xa7\x7b"
+			  "\xc3\x32\x88\x69\xa4\x12\xe3\x64"
+			  "\x02\x30\x17\x74\x6c\x88\x7c\x9b"
+			  "\xd6\x6d\x75\xdf\x11\x86\x70\x79"
+			  "\x48\x7d\x34\x3e\x33\x58\x07\x8b"
+			  "\xd2\x50\xac\x35\x15\x45\x05\xb4"
+			  "\x4d\x31\x97\x19\x87\x23\x4b\x87"
+			  "\x53\xdc\xa9\x19\x78\xf1\xbf\x35"
+			  "\x30\x04\x14\xd4\xcf\xb2\x8c\x87"
+			  "\x7d\xdb\x69\xc9\xcd\xfe\x40\x3e"
+			  "\x8d\x66\x5b\x61\xe5\xf0\x2d\x87"
+			  "\x93\x3a\x0c\x2b\x04\x98\x05\xc2"
+			  "\x56\x4d\xc4\x6c\xcd\x7a\x98\x7e"
+			  "\xe2\x2d\x79\x07\x91\x9f\xdf\x2f"
+			  "\x72\xc9\x8f\xcb\x0b\x87\x1b\xb7"
+			  "\x04\x86\xcb\x47\xfa\x5d\x03",
+		.ctext	= "\x0b\x00\xf7\xf2\xc8\x6a\xba\x9a"
+			  "\x0a\x97\x18\x7a\x00\xa0\xdb\xf4"
+			  "\x5e\x8e\x4a\xb7\xe0\x51\xf1\x75"
+			  "\x17\x8b\xb4\xf1\x56\x11\x05\x9f"
+			  "\x2f\x2e\xba\x67\x04\xe1\xb4\xa5"
+			  "\xfc\x7c\x8c\xad\xc6\xb9\xd1\x64"
+			  "\xca\xbd\x5d\xaf\xdb\x65\x48\x4f"
+			  "\x1b\xb3\x94\x5c\x0b\xd0\xee\xcd"
+			  "\xb5\x7f\x43\x8a\xd8\x8b\x66\xde"
+			  "\xd2\x9c\x13\x65\xa4\x47\xa7\x03"
+			  "\xc5\xa1\x46\x8f\x2f\x84\xbc\xef"
+			  "\x48\x9d\x9d\xb5\xbd\x43\xff\xd2"
+			  "\xd2\x7a\x5a\x13\xbf\xb4\xf6\x05"
+			  "\x17\xcd\x01\x12\xf0\x35\x27\x96"
+			  "\xf4\xc1\x65\xf7\x69\xef\x64\x1b"
+			  "\x6e\x4a\xe8\x77\xce\x83\x01\xb7"
+			  "\x60\xe6\x45\x2a\xcd\x41\x4a\xb5"
+			  "\x8e\xcc\x45\x93\xf1\xd6\x64\x5f"
+			  "\x32\x60\xe4\x29\x4a\x82\x6c\x86"
+			  "\x16\xe4\xcc\xdb\x5f\xc8\x11\xa6"
+			  "\xfe\x88\xd6\xc3\xe5\x5c\xbb\x67"
+			  "\xec\xa5\x7b\xf5\xa8\x4f\x77\x25"
+			  "\x5d\x0c\x2a\x99\xf9\xb9\xd1\xae"
+			  "\x3c\x83\x2a\x93\x9b\x66\xec\x68"
+			  "\x2c\x93\x02\x8a\x8a\x1e\x2f\x50"
+			  "\x09\x37\x19\x5c\x2a\x3a\xc2\xcb"
+			  "\xcb\x89\x82\x81\xb7\xbb\xef\x73"
+			  "\x8b\xc9\xae\x42\x96\xef\x70\xc0"
+			  "\x89\xc7\x3e\x6a\x26\xc3\xe4\x39"
+			  "\x53\xa9\xcf\x63\x7d\x05\xf3\xff"
+			  "\x52\x04\xf6\x7f\x23\x96\xe9\xf7"
+			  "\xff\xd6\x50\xa3\x0e\x20\x71",
+		.klen	= 32,
+		.len	= 255,
+	},
+	{
+		.key	= "\x39\x5f\xf4\x9c\x90\x3a\x9a\x25"
+			  "\x15\x11\x79\x39\xed\x26\x5e\xf6"
+			  "\xda\xcf\x33\x4f\x82\x97\xab\x10"
+			  "\xc1\x55\x48\x82\x80\xa8\x02\xb2",
+		.iv	= "\x82\x60\xd9\x06\xeb\x40\x99\x76"
+			  "\x08\xc5\xa4\x83\x45\xb8\x38\x5a",
+		.ptext	= "\xa1\xa8\xac\xac\x08\xaf\x8f\x84"
+			  "\xbf\xcc\x79\x31\x5e\x61\x01\xd1"
+			  "\x4d\x5f\x9b\xcd\x91\x92\x9a\xa1"
+			  "\x99\x0d\x49\xb2\xd7\xfd\x25\x93"
+			  "\x51\x96\xbd\x91\x8b\x08\xf1\xc6"
+			  "\x0d\x17\xf6\xef\xfd\xd2\x78\x16"
+			  "\xc8\x08\x27\x7b\xca\x98\xc6\x12"
+			  "\x86\x11\xdb\xd5\x08\x3d\x5a\x2c"
+			  "\xcf\x15\x0e\x9b\x42\x78\xeb\x1f"
+			  "\x52\xbc\xd7\x5a\x8a\x33\x6c\x14"
+			  "\xfc\x61\xad\x2e\x1e\x03\x66\xea"
+			  "\x79\x0e\x88\x88\xde\x93\xe3\x81"
+			  "\xb5\xc4\x1c\xe6\x9c\x08\x18\x8e"
+			  "\xa0\x87\xda\xe6\xf8\xcb\x30\x44"
+			  "\x2d\x4e\xc0\xa3\x60\xf9\x62\x7b"
+			  "\x4b\xd5\x61\x6d\xe2\x67\x95\x54"
+			  "\x10\xd1\xca\x22\xe8\xb6\xb1\x3a"
+			  "\x2d\xd7\x35\x5b\x22\x88\x55\x67"
+			  "\x3d\x83\x8f\x07\x98\xa8\xf2\xcf"
+			  "\x04\xb7\x9e\x52\xca\xe0\x98\x72"
+			  "\x5c\xc1\x00\xd4\x1f\x2c\x61\xf3"
+			  "\xe8\x40\xaf\x4a\xee\x66\x41\xa0"
+			  "\x02\x77\x29\x30\x65\x59\x4b\x20"
+			  "\x7b\x0d\x80\x97\x27\x7f\xd5\x90"
+			  "\xbb\x9d\x76\x90\xe5\x43\x43\x72"
+			  "\xd0\xd4\x14\x75\x66\xb3\xb6\xaf"
+			  "\x09\xe4\x23\xb0\x62\xad\x17\x28"
+			  "\x39\x26\xab\xf5\xf7\x5c\xb6\x33"
+			  "\xbd\x27\x09\x5b\x29\xe4\x40\x0b"
+			  "\xc1\x26\x32\xdb\x9a\xdf\xf9\x5a"
+			  "\xae\x03\x2c\xa4\x40\x84\x9a\xb7"
+			  "\x4e\x47\xa8\x0f\x23\xc7\xbb\xcf"
+			  "\x2b\xf2\x32\x6c\x35\x6a\x91\xba"
+			  "\x0e\xea\xa2\x8b\x2f\xbd\xb5\xea"
+			  "\x6e\xbc\xb5\x4b\x03\xb3\x86\xe0"
+			  "\x86\xcf\xba\xcb\x38\x2c\x32\xa6"
+			  "\x6d\xe5\x28\xa6\xad\xd2\x7f\x73"
+			  "\x43\x14\xf8\xb1\x99\x12\x2d\x2b"
+			  "\xdf\xcd\xf2\x81\x43\x94\xdf\xb1"
+			  "\x17\xc9\x33\xa6\x3d\xef\x96\xb8"
+			  "\xd6\x0d\x00\xec\x49\x66\x85\x5d"
+			  "\x44\x62\x12\x04\x55\x5c\x48\xd3"
+			  "\xbd\x73\xac\x54\x8f\xbf\x97\x8e"
+			  "\x85\xfd\xc2\xa1\x25\x32\x38\x6a"
+			  "\x1f\xac\x57\x3c\x4f\x56\x73\xf2"
+			  "\x1d\xb6\x48\x68\xc7\x0c\xe7\x60"
+			  "\xd2\x8e\x4d\xfb\xc7\x20\x7b\xb7"
+			  "\x45\x28\x12\xc6\x26\xae\xea\x7c"
+			  "\x5d\xe2\x46\xb5\xae\xe1\xc3\x98"
+			  "\x6f\x72\xd5\xa2\xfd\xed\x40\xfd"
+			  "\xf9\xdf\x61\xec\x45\x2c\x15\xe0"
+			  "\x1e\xbb\xde\x71\x37\x5f\x73\xc2"
+			  "\x11\xcc\x6e\x6d\xe1\xb5\x1b\xd2"
+			  "\x2a\xdd\x19\x8a\xc2\xe1\xa0\xa4"
+			  "\x26\xeb\xb2\x2c\x4f\x77\x52\xf1"
+			  "\x42\x72\x6c\xad\xd7\x78\x5d\x72"
+			  "\xc9\x16\x26\x25\x1b\x4c\xe6\x58"
+			  "\x79\x57\xb5\x06\x15\x4f\xe5\xba"
+			  "\xa2\x7f\x2d\x5b\x87\x8a\x44\x70"
+			  "\xec\xc7\xef\x84\xae\x60\xa2\x61"
+			  "\x86\xe9\x18\xcd\x28\xc4\xa4\xf5"
+			  "\xbc\x84\xb8\x86\xa0\xba\xf1\xf1"
+			  "\x08\x3b\x32\x75\x35\x22\x7a\x65"
+			  "\xca\x48\xe8\xef\x6e\xe2\x8e\x00",
+		.ctext	= "\x2f\xae\xd8\x67\xeb\x15\xde\x75"
+			  "\x53\xa3\x0e\x5a\xcf\x1c\xbe\xea"
+			  "\xde\xf9\xcf\xc2\x9f\xfd\x0f\x44"
+			  "\xc0\xe0\x7a\x76\x1d\xcb\x4a\xf8"
+			  "\x35\xd6\xe3\x95\x98\x6b\x3f\x89"
+			  "\xc4\xe6\xb6\x6f\xe1\x8b\x39\x4b"
+			  "\x1c\x6c\x77\xe4\xe1\x8a\xbc\x61"
+			  "\x00\x6a\xb1\x37\x2f\x45\xe6\x04"
+			  "\x52\x0b\xfc\x1e\x32\xc1\xd8\x9d"
+			  "\xfa\xdd\x67\x5c\xe0\x75\x83\xd0"
+			  "\x21\x9e\x02\xea\xc0\x7f\xc0\x29"
+			  "\xb3\x6c\xa5\x97\xb3\x29\x82\x1a"
+			  "\x94\xa5\xb4\xb6\x49\xe5\xa5\xad"
+			  "\x95\x40\x52\x7c\x84\x88\xa4\xa8"
+			  "\x26\xe4\xd9\x5d\x41\xf2\x93\x7b"
+			  "\xa4\x48\x1b\x66\x91\xb9\x7c\xc2"
+			  "\x99\x29\xdf\xd8\x30\xac\xd4\x47"
+			  "\x42\xa0\x14\x87\x67\xb8\xfd\x0b"
+			  "\x1e\xcb\x5e\x5c\x9a\xc2\x04\x8b"
+			  "\x17\x29\x9d\x99\x7f\x86\x4c\xe2"
+			  "\x5c\x96\xa6\x0f\xb6\x47\x33\x5c"
+			  "\xe4\x50\x49\xd5\x4f\x92\x0b\x9a"
+			  "\xbc\x52\x4c\x41\xf5\xc9\x3e\x76"
+			  "\x55\x55\xd4\xdc\x71\x14\x23\xfc"
+			  "\x5f\xd5\x08\xde\xa0\xf7\x28\xc0"
+			  "\xe1\x61\xac\x64\x66\xf6\xd1\x31"
+			  "\xe4\xa4\xa9\xed\xbc\xad\x4f\x3b"
+			  "\x59\xb9\x48\x1b\xe7\xb1\x6f\xc6"
+			  "\xba\x40\x1c\x0b\xe7\x2f\x31\x65"
+			  "\x85\xf5\xe9\x14\x0a\x31\xf5\xf3"
+			  "\xc0\x1c\x20\x35\x73\x38\x0f\x8e"
+			  "\x39\xf0\x68\xae\x08\x9c\x87\x4b"
+			  "\x42\xfc\x22\x17\xee\x96\x51\x2a"
+			  "\xd8\x57\x5a\x35\xea\x72\x74\xfc"
+			  "\xb3\x0e\x69\x9a\xe1\x4f\x24\x90"
+			  "\xc5\x4b\xe5\xd7\xe3\x82\x2f\xc5"
+			  "\x62\x46\x3e\xab\x72\x4e\xe0\xf3"
+			  "\x90\x09\x4c\xb2\xe1\xe8\xa0\xf5"
+			  "\x46\x40\x2b\x47\x85\x3c\x21\x90"
+			  "\x3d\xad\x25\x5a\x36\xdf\xe5\xbc"
+			  "\x7e\x80\x4d\x53\x77\xf1\x79\xa6"
+			  "\xec\x22\x80\x88\x68\xd6\x2d\x8b"
+			  "\x3e\xf7\x52\xc7\x2a\x20\x42\x5c"
+			  "\xed\x99\x4f\x32\x80\x00\x7e\x73"
+			  "\xd7\x6d\x7f\x7d\x42\x54\x4a\xfe"
+			  "\xff\x6f\x61\xca\x2a\xbb\x4f\xeb"
+			  "\x4f\xe4\x4e\xaf\x2c\x4f\x82\xcd"
+			  "\xa1\xa7\x11\xb3\x34\x33\xcf\x32"
+			  "\x63\x0e\x24\x3a\x35\xbe\x06\xd5"
+			  "\x17\xcb\x02\x30\x33\x6e\x8c\x49"
+			  "\x40\x6e\x34\x8c\x07\xd4\x3e\xe6"
+			  "\xaf\x78\x6d\x8c\x10\x5f\x21\x58"
+			  "\x49\x26\xc5\xaf\x0d\x7d\xd4\xaf"
+			  "\xcd\x5b\xa1\xe3\xf6\x39\x1c\x9b"
+			  "\x8e\x00\xa1\xa7\x9e\x17\x4a\xc0"
+			  "\x54\x56\x9e\xcf\xcf\x88\x79\x8d"
+			  "\x50\xf7\x56\x8e\x0a\x73\x46\x6b"
+			  "\xc3\xb9\x9b\x6c\x7d\xc4\xc8\xb6"
+			  "\x03\x5f\x30\x62\x7d\xe6\xdb\x15"
+			  "\xe1\x39\x02\x8c\xff\xda\xc8\x43"
+			  "\xf2\xa9\xbf\x00\xe7\x3a\x61\x89"
+			  "\xdf\xb0\xca\x7d\x8c\x8a\x6a\x9f"
+			  "\x18\x89\x3d\x39\xac\x36\x6f\x05"
+			  "\x1f\xb5\xda\x00\xea\xe1\x51\x21",
+		.klen	= 32,
+		.len	= 512,
+	},
+
+};
+
 #endif	/* _CRYPTO_TESTMGR_H */
diff --git a/crypto/xctr.c b/crypto/xctr.c
new file mode 100644
index 000000000000..5c00147e8ec4
--- /dev/null
+++ b/crypto/xctr.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * XCTR: XOR Counter mode - Adapted from ctr.c
+ *
+ * (C) Copyright IBM Corp. 2007 - Joy Latten <latten@us.ibm.com>
+ * Copyright 2021 Google LLC
+ */
+
+/*
+ * XCTR mode is a blockcipher mode of operation used to implement HCTR2. XCTR is
+ * closely related to the CTR mode of operation; the main difference is that CTR
+ * generates the keystream using E(CTR + IV) whereas XCTR generates the
+ * keystream using E(CTR ^ IV). This allows implementations to avoid dealing
+ * with multi-limb integers (as is required in CTR mode). XCTR is also specified
+ * using little-endian arithmetic which makes it slightly faster on LE machines.
+ *
+ * See the HCTR2 paper for more details:
+ *	Length-preserving encryption with HCTR2
+ *      (https://eprint.iacr.org/2021/1441.pdf)
+ */
+
+#include <crypto/algapi.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+/* For now this implementation is limited to 16-byte blocks for simplicity */
+#define XCTR_BLOCKSIZE 16
+
+static void crypto_xctr_crypt_final(struct skcipher_walk *walk,
+				   struct crypto_cipher *tfm, u32 byte_ctr)
+{
+	u8 keystream[XCTR_BLOCKSIZE];
+	const u8 *src = walk->src.virt.addr;
+	u8 *dst = walk->dst.virt.addr;
+	unsigned int nbytes = walk->nbytes;
+	__le32 ctr32 = cpu_to_le32(byte_ctr / XCTR_BLOCKSIZE + 1);
+
+	crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+	crypto_cipher_encrypt_one(tfm, keystream, walk->iv);
+	crypto_xor_cpy(dst, keystream, src, nbytes);
+	crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+}
+
+static int crypto_xctr_crypt_segment(struct skcipher_walk *walk,
+				    struct crypto_cipher *tfm, u32 byte_ctr)
+{
+	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) =
+		   crypto_cipher_alg(tfm)->cia_encrypt;
+	const u8 *src = walk->src.virt.addr;
+	u8 *dst = walk->dst.virt.addr;
+	unsigned int nbytes = walk->nbytes;
+	__le32 ctr32 = cpu_to_le32(byte_ctr / XCTR_BLOCKSIZE + 1);
+
+	do {
+		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+		fn(crypto_cipher_tfm(tfm), dst, walk->iv);
+		crypto_xor(dst, src, XCTR_BLOCKSIZE);
+		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+
+		le32_add_cpu(&ctr32, 1);
+
+		src += XCTR_BLOCKSIZE;
+		dst += XCTR_BLOCKSIZE;
+	} while ((nbytes -= XCTR_BLOCKSIZE) >= XCTR_BLOCKSIZE);
+
+	return nbytes;
+}
+
+static int crypto_xctr_crypt_inplace(struct skcipher_walk *walk,
+				    struct crypto_cipher *tfm, u32 byte_ctr)
+{
+	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) =
+		   crypto_cipher_alg(tfm)->cia_encrypt;
+	unsigned long alignmask = crypto_cipher_alignmask(tfm);
+	unsigned int nbytes = walk->nbytes;
+	u8 *data = walk->src.virt.addr;
+	u8 tmp[XCTR_BLOCKSIZE + MAX_CIPHER_ALIGNMASK];
+	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
+	__le32 ctr32 = cpu_to_le32(byte_ctr / XCTR_BLOCKSIZE + 1);
+
+	do {
+		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+		fn(crypto_cipher_tfm(tfm), keystream, walk->iv);
+		crypto_xor(data, keystream, XCTR_BLOCKSIZE);
+		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
+
+		le32_add_cpu(&ctr32, 1);
+
+		data += XCTR_BLOCKSIZE;
+	} while ((nbytes -= XCTR_BLOCKSIZE) >= XCTR_BLOCKSIZE);
+
+	return nbytes;
+}
+
+static int crypto_xctr_crypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_cipher *cipher = skcipher_cipher_simple(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+	u32 byte_ctr = 0;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while (walk.nbytes >= XCTR_BLOCKSIZE) {
+		if (walk.src.virt.addr == walk.dst.virt.addr)
+			nbytes = crypto_xctr_crypt_inplace(&walk, cipher,
+							   byte_ctr);
+		else
+			nbytes = crypto_xctr_crypt_segment(&walk, cipher,
+							   byte_ctr);
+
+		byte_ctr += walk.nbytes - nbytes;
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	if (walk.nbytes) {
+		crypto_xctr_crypt_final(&walk, cipher, byte_ctr);
+		err = skcipher_walk_done(&walk, 0);
+	}
+
+	return err;
+}
+
+static int crypto_xctr_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	struct skcipher_instance *inst;
+	struct crypto_alg *alg;
+	int err;
+
+	inst = skcipher_alloc_instance_simple(tmpl, tb);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	alg = skcipher_ialg_simple(inst);
+
+	/* Block size must be 16 bytes. */
+	err = -EINVAL;
+	if (alg->cra_blocksize != XCTR_BLOCKSIZE)
+		goto out_free_inst;
+
+	/* XCTR mode is a stream cipher. */
+	inst->alg.base.cra_blocksize = 1;
+
+	/*
+	 * To simplify the implementation, configure the skcipher walk to only
+	 * give a partial block at the very end, never earlier.
+	 */
+	inst->alg.chunksize = alg->cra_blocksize;
+
+	inst->alg.encrypt = crypto_xctr_crypt;
+	inst->alg.decrypt = crypto_xctr_crypt;
+
+	err = skcipher_register_instance(tmpl, inst);
+	if (err) {
+out_free_inst:
+		inst->free(inst);
+	}
+
+	return err;
+}
+
+static struct crypto_template crypto_xctr_tmpl = {
+	.name = "xctr",
+	.create = crypto_xctr_create,
+	.module = THIS_MODULE,
+};
+
+static int __init crypto_xctr_module_init(void)
+{
+	return crypto_register_template(&crypto_xctr_tmpl);
+}
+
+static void __exit crypto_xctr_module_exit(void)
+{
+	crypto_unregister_template(&crypto_xctr_tmpl);
+}
+
+subsys_initcall(crypto_xctr_module_init);
+module_exit(crypto_xctr_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("XCTR block cipher mode of operation");
+MODULE_ALIAS_CRYPTO("xctr");
+MODULE_IMPORT_NS(CRYPTO_INTERNAL);
-- 
2.36.0.464.gb9c8b46e94-goog

