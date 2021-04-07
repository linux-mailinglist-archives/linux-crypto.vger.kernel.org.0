Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E935622D
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Apr 2021 05:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348520AbhDGDuT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Apr 2021 23:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348490AbhDGDuL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Apr 2021 23:50:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7CC06175F;
        Tue,  6 Apr 2021 20:50:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i190so3672791pfc.12;
        Tue, 06 Apr 2021 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztE8qT8e6O4CDJPAUaT71ExQjqGpntsdd1ACIw09PwM=;
        b=u7dojLC6BwvR6rpG8sT3M3pSM+KS46VjxEMNjlkDDML8jwdrOwcnm+kQJnpF5n2Glw
         XB0zRL7YwQoLUbBy6AcU7+GJj75/0D2ZphK5M+11WpJ+h0nj7ZeK5rzjf2hhgEV7hzdc
         gC6guR0EP5OWfNxdfZct86dqKnTcTh5P0gUCjQhDdADYUy7TWPGUXGaCWz3v7DpxiufG
         1SMENvwp+ljWMyrb3KVYiL1N+MX1iQYv6JcKTGogu4hhSG0dqnn+CWoLF1aTy8JeMD+8
         oG49fh62VhnEJdSriZ9ChulXdnUNcsifHinJo4pLnm2wlidcoRCSeEkn67BMzb1ISFpv
         dpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztE8qT8e6O4CDJPAUaT71ExQjqGpntsdd1ACIw09PwM=;
        b=X+Y3VpjmI3Ok4h9xCTA1wnj6vctAue7azhQ0QGdsxsvJnk3PLjQy19g41Du/DIi8u+
         UZYJLtXTcfHNJiV5n6dyp08P8Qo1B1N9hMrJcQIBUqb0EkbWbIxPedQSO6Zx8oLG1ea7
         lzbXrh6+FQ4G9RAjuuZogEUmm2yRAfG9hKRv58Qzy1IEVjY74S1LOSG03OmsoUDE/RgF
         bG1rC8XXjVHBuErS/61LT5SNxRJjIFt6Gvx7P8B6jjiP2VQ3v5jksYmUs6TgFRxsc5St
         1HyKxbKkova7n3LFQKajs9BvySzEJGdSMTIydNtuqoU1pSZCMkzMfl6TCgzdPTY8o9D1
         atng==
X-Gm-Message-State: AOAM531v8WwaU85YiUK5mp/NtO7qI32RYKvOInxSZU4G5qwW7zSrmkAc
        DnEo9cEzqSV/RiCt/IwEfj4M8/P+V5fusQ==
X-Google-Smtp-Source: ABdhPJx0kN961V5pLhGDiCvGV2ye1kZgG+j8bICMyf4HPZd1FvTQm9tjY1YkW90NqzhG3JfGzuo3oQ==
X-Received: by 2002:a62:7f86:0:b029:20a:a195:bb36 with SMTP id a128-20020a627f860000b029020aa195bb36mr1083799pfd.4.1617767402335;
        Tue, 06 Apr 2021 20:50:02 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s21sm6000922pgl.36.2021.04.06.20.50.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 20:50:01 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v3 3/4] crypto: add rsa pss test vector
Date:   Wed,  7 Apr 2021 11:49:17 +0800
Message-Id: <1617767358-25279-4-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617767358-25279-1-git-send-email-herbert.tencent@gmail.com>
References: <1617767358-25279-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds the test vector for rsa with pss encoding.

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 crypto/testmgr.c |  7 +++++
 crypto/testmgr.h | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 10c5b3b..2b07fdb 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5216,6 +5216,13 @@ static int alg_test_null(const struct alg_test_desc *desc,
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
+		.alg = "psspad(rsa)",
+		.test = alg_test_akcipher,
+		.fips_allowed = 1,
+		.suite = {
+			.akcipher = __VECS(psspad_rsa_tv_template)
+		}
+	}, {
 		.alg = "poly1305",
 		.test = alg_test_hash,
 		.suite = {
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 34e4a3d..0402db5 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1239,6 +1239,96 @@ struct kpp_testvec {
 	}
 };
 
+/*
+ * RSA PSS test vectors. Obtained from 186-3rsatestvectors.zip
+ */
+static const struct akcipher_testvec psspad_rsa_tv_template[] = {
+	{
+	.key =
+	/* Sequence of n , e */
+	"\x30\x82\x02\x09"
+	/* n */
+	"\x02\x82\x01\x01\x00"
+	"\xc5\x06\x2b\x58\xd8\x53\x9c\x76\x5e\x1e\x5d\xba\xf1\x4c\xf7\x5d"
+	"\xd5\x6c\x2e\x13\x10\x5f\xec\xfd\x1a\x93\x0b\xbb\x59\x48\xff\x32"
+	"\x8f\x12\x6a\xbe\x77\x93\x59\xca\x59\xbc\xa7\x52\xc3\x08\xd2\x81"
+	"\x57\x3b\xc6\x17\x8b\x6c\x0f\xef\x7d\xc4\x45\xe4\xf8\x26\x43\x04"
+	"\x37\xb9\xf9\xd7\x90\x58\x1d\xe5\x74\x9c\x2c\xb9\xcb\x26\xd4\x2b"
+	"\x2f\xee\x15\xb6\xb2\x6f\x09\xc9\x96\x70\x33\x64\x23\xb8\x6b\xc5"
+	"\xbe\xc7\x11\x13\x15\x7b\xe2\xd9\x44\xd7\xff\x3e\xeb\xff\xb2\x84"
+	"\x13\x14\x3e\xa3\x67\x55\xdb\x0a\xe6\x2f\xf5\xb7\x24\xee\xcb\x3d"
+	"\x31\x6b\x6b\xac\x67\xe8\x9c\xac\xd8\x17\x19\x37\xe2\xab\x19\xbd"
+	"\x35\x3a\x89\xac\xea\x8c\x36\xf8\x1c\x89\xa6\x20\xd5\xfd\x2e\xff"
+	"\xea\x89\x66\x01\xc7\xf9\xda\xca\x7f\x03\x3f\x63\x5a\x3a\x94\x33"
+	"\x31\xd1\xb1\xb4\xf5\x28\x87\x90\xb5\x3a\xf3\x52\xf1\x12\x1c\xa1"
+	"\xbe\xf2\x05\xf4\x0d\xc0\x12\xc4\x12\xb4\x0b\xdd\x27\x58\x5b\x94"
+	"\x64\x66\xd7\x5f\x7e\xe0\xa7\xf9\xd5\x49\xb4\xbe\xce\x6f\x43\xac"
+	"\x3e\xe6\x5f\xe7\xfd\x37\x12\x33\x59\xd9\xf1\xa8\x50\xad\x45\x0a"
+	"\xaf\x5c\x94\xeb\x11\xde\xa3\xfc\x0f\xc6\xe9\x85\x6b\x18\x05\xef"
+	/* e */
+	"\x02\x82\x01\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+	"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xc9\x4f",
+	.key_len = 525,
+	.params =
+	"\x30\x30"
+	"\xa0\x0d\x30\x0b\x06\x09\x60\x86\x48\x01\x65\x03\x04\x02\x01\xa1"
+	"\x1a\x30\x18\x06\x09\x2a\x86\x48\x86\xf7\x0d\x01\x01\x08\x30\x0b"
+	"\x06\x09\x60\x86\x48\x01\x65\x03\x04\x02\x01\xa2\x03\x02\x01\x20",
+	.param_len = 50,
+	/*
+	 * m is SHA256 hash of following message:
+	 * "\xdf\xc2\x26\x04\xb9\x5d\x15\x32\x80\x59\x74\x5c\x6c\x98\xeb"
+	 * "\x9d\xfb\x34\x7c\xf9\xf1\x70\xaf\xf1\x9d\xee\xec\x55\x5f\x22"
+	 * "\x28\x5a\x67\x06\xc4\xec\xbf\x0f\xb1\x45\x8c\x60\xd9\xbf\x91"
+	 * "\x3f\xba\xe6\xf4\xc5\x54\xd2\x45\xd9\x46\xb4\xbc\x5f\x34\xae"
+	 * "\xc2\xac\x6b\xe8\xb3\x3d\xc8\xe0\xe3\xa9\xd6\x01\xdf\xd5\x36"
+	 * "\x78\xf5\x67\x44\x43\xf6\x7d\xf7\x8a\x3a\x9e\x09\x33\xe5\xf1"
+	 * "\x58\xb1\x69\xac\x8d\x1c\x4c\xd0\xfb\x87\x2c\x14\xca\x8e\x00"
+	 * "\x1e\x54\x2e\xa0\xf9\xcf\xda\x88\xc4\x2d\xca\xd8\xa7\x40\x97"
+	 * "\xa0\x0c\x22\x05\x5b\x0b\xd4\x1f"
+	 */
+	.m =
+	"\xb9\x8a\x0d\x22\xe8\x37\xb1\x01\x87\x4a\x5f\x0d\x7a\xd4\x98\x36"
+	"\xe6\x27\x3f\xc7\x5c\xd2\xd0\x73\xdc\x81\xd9\x6f\x05\xf5\x8f\x3c",
+	.m_size = 32,
+	.c =
+	"\x8b\x46\xf2\xc8\x89\xd8\x19\xf8\x60\xaf\x0a\x6c\x4c\x88\x9e\x4d"
+	"\x14\x36\xc6\xca\x17\x44\x64\xd2\x2a\xe1\x1b\x9c\xcc\x26\x5d\x74"
+	"\x3c\x67\xe5\x69\xac\xcb\xc5\xa8\x0d\x4d\xd5\xf1\xbf\x40\x39\xe2"
+	"\x3d\xe5\x2a\xec\xe4\x02\x91\xc7\x5f\x89\x36\xc5\x8c\x9a\x2f\x77"
+	"\xa7\x80\xbb\xe7\xad\x31\xeb\x76\x74\x2f\x7b\x2b\x8b\x14\xca\x1a"
+	"\x71\x96\xaf\x7e\x67\x3a\x3c\xfc\x23\x7d\x50\xf6\x15\xb7\x5c\xf4"
+	"\xa7\xea\x78\xa9\x48\xbe\xda\xf9\x24\x24\x94\xb4\x1e\x1d\xb5\x1f"
+	"\x43\x7f\x15\xfd\x25\x51\xbb\x5d\x24\xee\xfb\x1c\x3e\x60\xf0\x36"
+	"\x94\xd0\x03\x3a\x1e\x0a\x9b\x9f\x5e\x4a\xb9\x7d\x45\x7d\xff\x9b"
+	"\x9d\xa5\x16\xdc\x22\x6d\x6d\x65\x29\x50\x03\x08\xed\x74\xa2\xe6"
+	"\xd9\xf3\xc1\x05\x95\x78\x8a\x52\xa1\xbc\x06\x64\xae\xdf\x33\xef"
+	"\xc8\xba\xdd\x03\x7e\xb7\xb8\x80\x77\x2b\xdb\x04\xa6\x04\x6e\x9e"
+	"\xde\xee\x41\x97\xc2\x55\x07\xfb\x0f\x11\xab\x1c\x9f\x63\xf5\x3c"
+	"\x88\x20\xea\x84\x05\xcf\xd7\x72\x16\x92\x47\x5b\x4d\x72\x35\x5f"
+	"\xa9\xa3\x80\x4f\x29\xe6\xb6\xa7\xb0\x59\xc4\x44\x1d\x54\xb2\x8e"
+	"\x4e\xed\x25\x29\xc6\x10\x3b\x54\x32\xc7\x13\x32\xce\x74\x2b\xcc",
+	.c_size = 256,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}
+};
+
 static const struct kpp_testvec dh_tv_template[] = {
 	{
 	.secret =
-- 
1.8.3.1

