Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6824F3554A8
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Apr 2021 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbhDFNMZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Apr 2021 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbhDFNMY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D63C06174A;
        Tue,  6 Apr 2021 06:12:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso7639747pjh.2;
        Tue, 06 Apr 2021 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKZxwNoVpzi8McJz1NqdIXiqOabiSFHssDovXMt99mg=;
        b=meqY8OS78nfwZaLi5g6htZRojTP2I/IYJU73zaEj1pdwpVdffsgPcAhkmkzMkzzSLj
         8ux8eoaFp81CB3sOK+NYyMdqKq5CtvMpHtUfkdkUerCNc+3VtkBSIN9fDinEnVzSvVUh
         4BC+Tf73h9Gs4Edzho1W9694F8xJo9XNiA4soqzC5EQUYn8KDnySTD2wSeOIPfnoIqJH
         9lTIzQV7nxd8Vdo8ASrWMGwN+2mbjL5A9QpC/TviXO9+ijeoFO952Ne2tRclZNqbqj4S
         2ceEC46fwjrIqn4LoqFJJBeERO0eRk4DMc4IG593NZ0LZKBDH3KaUEAwN5BwjyuYmiwg
         X4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKZxwNoVpzi8McJz1NqdIXiqOabiSFHssDovXMt99mg=;
        b=F3KNWk2TnTfwRKehlYIN1U5lD+Ti68Dq9KyBYqMEWtP5EnQ3/7pvJHWU4Pznjc/LFC
         4BpxrpVwJL+TF2Qm1JJAs8zGFifyIkSOcxvxcxPZuTKQNE3UZ5ZZeEBRYC7xcxjz/0G9
         9AKSP84Aa7VSXOQ51uSI4DktjNhJlbR7AR5ALi5VcThA3lsJ2AnL8vVYly4rbUzyF0lW
         0+4UaXu//ch5CzFGxCOZ5Y3yB0Rjal+DvBcwcnZX2mT69DEGNXmtB1Y7S0zTPXTjwUck
         9gKlZbKxb2J/HMsFMTnCwhm8Z+m9W68pSxdWq/W21FzY0X2ZHMLyTaWxgO9Az55rx3ng
         PG9A==
X-Gm-Message-State: AOAM532XAhNsLYlPsi2b36YrbNUL8SR5Jl3Rd5H5U9vsYPH24UWrkK8e
        nMvKbingyzE1Ize9zoK8uohh1tW7uueguQ==
X-Google-Smtp-Source: ABdhPJz7eQYi2qzHo5ORlEyYU1O6sPxwzk4YmvcnZzej0wpKV8r8iHQSg7cdg1prE5xWQDy3k5Wknw==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr4365863pjq.141.1617714733729;
        Tue, 06 Apr 2021 06:12:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id i73sm13801351pgc.9.2021.04.06.06.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:12:13 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 3/5] crypto: add rsa pss test vector
Date:   Tue,  6 Apr 2021 21:11:24 +0800
Message-Id: <1617714686-25754-4-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch adds the test vector for rsa with pss encoding.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 crypto/testmgr.c |  7 +++++
 crypto/testmgr.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 9335999..3af3b4f 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5194,6 +5194,13 @@ static int alg_test_null(const struct alg_test_desc *desc,
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
index ced56ea..2f7b252 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -815,6 +815,93 @@ struct kpp_testvec {
 	}
 };
 
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

