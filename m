Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6445A2C8
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Nov 2021 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhKWMl2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 23 Nov 2021 07:41:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38878 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhKWMlY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 23 Nov 2021 07:41:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 387671FD5D;
        Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637671094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zO5hnc5dIji667T7k/l6MVfHZSI2894+ADHKOmEkynY=;
        b=j8oAk0QGw/VXJTcAsCf/Oxr6qrGLBL+y1PNfZ7B/b0QDFDgiRb9BQ4JUP0x9yQxQRprbGN
        I4eBt/l3+wUyHW6fWKH6jeqsNmvFhkoCCoBwLDa1B326s0M28gkOTdE85EWG82+ZUnYERt
        Ielutb5nyl4/l/MagMOAfg9hWwubbIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637671094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zO5hnc5dIji667T7k/l6MVfHZSI2894+ADHKOmEkynY=;
        b=4GDNO1UaedmNLgdnkEsg7ZvSKJaidllE993JO7WSSEMOCPdFzfvbNcdYl7JSt/IsrHgjmU
        +F3VCV41QtHbPEAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D52C4A3B8C;
        Tue, 23 Nov 2021 12:38:12 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9CE8051918C0; Tue, 23 Nov 2021 13:38:12 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.org>,
        linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 03/12] crypto/ffdhe: Finite Field DH Ephemeral Parameters
Date:   Tue, 23 Nov 2021 13:37:52 +0100
Message-Id: <20211123123801.73197-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123123801.73197-1-hare@suse.de>
References: <20211123123801.73197-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add helper functions to generaten Finite Field DH Ephemeral Parameters as
specified in RFC 7919.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 crypto/Kconfig         |   8 +
 crypto/Makefile        |   1 +
 crypto/ffdhe_helper.c  | 880 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/ffdhe.h |  24 ++
 4 files changed, 913 insertions(+)
 create mode 100644 crypto/ffdhe_helper.c
 create mode 100644 include/crypto/ffdhe.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 285f82647d2b..0181d2a2982c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -231,6 +231,14 @@ config CRYPTO_DH
 	help
 	  Generic implementation of the Diffie-Hellman algorithm.
 
+config CRYPTO_FFDHE
+	tristate "Finite Field DH (RFC 7919) ephemeral parameters"
+	select CRYPTO_DH
+	select CRYPTO_KPP
+	select CRYPTO_RNG_DEFAULT
+	help
+	  Generic implementation of the Finite Field DH algorithm
+
 config CRYPTO_ECC
 	tristate
 	select CRYPTO_RNG_DEFAULT
diff --git a/crypto/Makefile b/crypto/Makefile
index 429c4d57458c..2c4049ec12fc 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -178,6 +178,7 @@ obj-$(CONFIG_CRYPTO_OFB) += ofb.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
 obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 obj-$(CONFIG_CRYPTO_CURVE25519) += curve25519-generic.o
+obj-$(CONFIG_CRYPTO_FFDHE) += ffdhe_helper.o
 
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
diff --git a/crypto/ffdhe_helper.c b/crypto/ffdhe_helper.c
new file mode 100644
index 000000000000..5d8da1291252
--- /dev/null
+++ b/crypto/ffdhe_helper.c
@@ -0,0 +1,880 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Finite Field DH Ephemeral Parameters
+ * Values are taken from RFC 7919 Appendix A
+ *
+ * Copyright (c) 2021, Hannes Reinecke, SUSE Software Products
+ */
+
+#include <linux/module.h>
+#include <crypto/internal/kpp.h>
+#include <crypto/kpp.h>
+#include <crypto/dh.h>
+#include <crypto/ffdhe.h>
+#include <linux/mpi.h>
+/*
+ * ffdhe2048 generator (g), modulus (p) and group size (q)
+ */
+static const u8 ffdhe2048_g[] = { 0x02 };
+
+static const u8 ffdhe2048_p[] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xad,0xf8,0x54,0x58,0xa2,0xbb,0x4a,0x9a,
+	0xaf,0xdc,0x56,0x20,0x27,0x3d,0x3c,0xf1,
+	0xd8,0xb9,0xc5,0x83,0xce,0x2d,0x36,0x95,
+	0xa9,0xe1,0x36,0x41,0x14,0x64,0x33,0xfb,
+	0xcc,0x93,0x9d,0xce,0x24,0x9b,0x3e,0xf9,
+	0x7d,0x2f,0xe3,0x63,0x63,0x0c,0x75,0xd8,
+	0xf6,0x81,0xb2,0x02,0xae,0xc4,0x61,0x7a,
+	0xd3,0xdf,0x1e,0xd5,0xd5,0xfd,0x65,0x61,
+	0x24,0x33,0xf5,0x1f,0x5f,0x06,0x6e,0xd0,
+	0x85,0x63,0x65,0x55,0x3d,0xed,0x1a,0xf3,
+	0xb5,0x57,0x13,0x5e,0x7f,0x57,0xc9,0x35,
+	0x98,0x4f,0x0c,0x70,0xe0,0xe6,0x8b,0x77,
+	0xe2,0xa6,0x89,0xda,0xf3,0xef,0xe8,0x72,
+	0x1d,0xf1,0x58,0xa1,0x36,0xad,0xe7,0x35,
+	0x30,0xac,0xca,0x4f,0x48,0x3a,0x79,0x7a,
+	0xbc,0x0a,0xb1,0x82,0xb3,0x24,0xfb,0x61,
+	0xd1,0x08,0xa9,0x4b,0xb2,0xc8,0xe3,0xfb,
+	0xb9,0x6a,0xda,0xb7,0x60,0xd7,0xf4,0x68,
+	0x1d,0x4f,0x42,0xa3,0xde,0x39,0x4d,0xf4,
+	0xae,0x56,0xed,0xe7,0x63,0x72,0xbb,0x19,
+	0x0b,0x07,0xa7,0xc8,0xee,0x0a,0x6d,0x70,
+	0x9e,0x02,0xfc,0xe1,0xcd,0xf7,0xe2,0xec,
+	0xc0,0x34,0x04,0xcd,0x28,0x34,0x2f,0x61,
+	0x91,0x72,0xfe,0x9c,0xe9,0x85,0x83,0xff,
+	0x8e,0x4f,0x12,0x32,0xee,0xf2,0x81,0x83,
+	0xc3,0xfe,0x3b,0x1b,0x4c,0x6f,0xad,0x73,
+	0x3b,0xb5,0xfc,0xbc,0x2e,0xc2,0x20,0x05,
+	0xc5,0x8e,0xf1,0x83,0x7d,0x16,0x83,0xb2,
+	0xc6,0xf3,0x4a,0x26,0xc1,0xb2,0xef,0xfa,
+	0x88,0x6b,0x42,0x38,0x61,0x28,0x5c,0x97,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+static const u8 ffdhe2048_q[] = {
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xd6,0xfc,0x2a,0x2c,0x51,0x5d,0xa5,0x4d,
+	0x57,0xee,0x2b,0x10,0x13,0x9e,0x9e,0x78,
+	0xec,0x5c,0xe2,0xc1,0xe7,0x16,0x9b,0x4a,
+	0xd4,0xf0,0x9b,0x20,0x8a,0x32,0x19,0xfd,
+	0xe6,0x49,0xce,0xe7,0x12,0x4d,0x9f,0x7c,
+	0xbe,0x97,0xf1,0xb1,0xb1,0x86,0x3a,0xec,
+	0x7b,0x40,0xd9,0x01,0x57,0x62,0x30,0xbd,
+	0x69,0xef,0x8f,0x6a,0xea,0xfe,0xb2,0xb0,
+	0x92,0x19,0xfa,0x8f,0xaf,0x83,0x37,0x68,
+	0x42,0xb1,0xb2,0xaa,0x9e,0xf6,0x8d,0x79,
+	0xda,0xab,0x89,0xaf,0x3f,0xab,0xe4,0x9a,
+	0xcc,0x27,0x86,0x38,0x70,0x73,0x45,0xbb,
+	0xf1,0x53,0x44,0xed,0x79,0xf7,0xf4,0x39,
+	0x0e,0xf8,0xac,0x50,0x9b,0x56,0xf3,0x9a,
+	0x98,0x56,0x65,0x27,0xa4,0x1d,0x3c,0xbd,
+	0x5e,0x05,0x58,0xc1,0x59,0x92,0x7d,0xb0,
+	0xe8,0x84,0x54,0xa5,0xd9,0x64,0x71,0xfd,
+	0xdc,0xb5,0x6d,0x5b,0xb0,0x6b,0xfa,0x34,
+	0x0e,0xa7,0xa1,0x51,0xef,0x1c,0xa6,0xfa,
+	0x57,0x2b,0x76,0xf3,0xb1,0xb9,0x5d,0x8c,
+	0x85,0x83,0xd3,0xe4,0x77,0x05,0x36,0xb8,
+	0x4f,0x01,0x7e,0x70,0xe6,0xfb,0xf1,0x76,
+	0x60,0x1a,0x02,0x66,0x94,0x1a,0x17,0xb0,
+	0xc8,0xb9,0x7f,0x4e,0x74,0xc2,0xc1,0xff,
+	0xc7,0x27,0x89,0x19,0x77,0x79,0x40,0xc1,
+	0xe1,0xff,0x1d,0x8d,0xa6,0x37,0xd6,0xb9,
+	0x9d,0xda,0xfe,0x5e,0x17,0x61,0x10,0x02,
+	0xe2,0xc7,0x78,0xc1,0xbe,0x8b,0x41,0xd9,
+	0x63,0x79,0xa5,0x13,0x60,0xd9,0x77,0xfd,
+	0x44,0x35,0xa1,0x1c,0x30,0x94,0x2e,0x4b,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+/*
+ * ffdhe3072 generator (g), modulus (p) and group size (q)
+ */
+
+static const u8 ffdhe3072_g[] = { 0x02 };
+
+static const u8 ffdhe3072_p[] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xad,0xf8,0x54,0x58,0xa2,0xbb,0x4a,0x9a,
+	0xaf,0xdc,0x56,0x20,0x27,0x3d,0x3c,0xf1,
+	0xd8,0xb9,0xc5,0x83,0xce,0x2d,0x36,0x95,
+	0xa9,0xe1,0x36,0x41,0x14,0x64,0x33,0xfb,
+	0xcc,0x93,0x9d,0xce,0x24,0x9b,0x3e,0xf9,
+	0x7d,0x2f,0xe3,0x63,0x63,0x0c,0x75,0xd8,
+	0xf6,0x81,0xb2,0x02,0xae,0xc4,0x61,0x7a,
+	0xd3,0xdf,0x1e,0xd5,0xd5,0xfd,0x65,0x61,
+	0x24,0x33,0xf5,0x1f,0x5f,0x06,0x6e,0xd0,
+	0x85,0x63,0x65,0x55,0x3d,0xed,0x1a,0xf3,
+	0xb5,0x57,0x13,0x5e,0x7f,0x57,0xc9,0x35,
+	0x98,0x4f,0x0c,0x70,0xe0,0xe6,0x8b,0x77,
+	0xe2,0xa6,0x89,0xda,0xf3,0xef,0xe8,0x72,
+	0x1d,0xf1,0x58,0xa1,0x36,0xad,0xe7,0x35,
+	0x30,0xac,0xca,0x4f,0x48,0x3a,0x79,0x7a,
+	0xbc,0x0a,0xb1,0x82,0xb3,0x24,0xfb,0x61,
+	0xd1,0x08,0xa9,0x4b,0xb2,0xc8,0xe3,0xfb,
+	0xb9,0x6a,0xda,0xb7,0x60,0xd7,0xf4,0x68,
+	0x1d,0x4f,0x42,0xa3,0xde,0x39,0x4d,0xf4,
+	0xae,0x56,0xed,0xe7,0x63,0x72,0xbb,0x19,
+	0x0b,0x07,0xa7,0xc8,0xee,0x0a,0x6d,0x70,
+	0x9e,0x02,0xfc,0xe1,0xcd,0xf7,0xe2,0xec,
+	0xc0,0x34,0x04,0xcd,0x28,0x34,0x2f,0x61,
+	0x91,0x72,0xfe,0x9c,0xe9,0x85,0x83,0xff,
+	0x8e,0x4f,0x12,0x32,0xee,0xf2,0x81,0x83,
+	0xc3,0xfe,0x3b,0x1b,0x4c,0x6f,0xad,0x73,
+	0x3b,0xb5,0xfc,0xbc,0x2e,0xc2,0x20,0x05,
+	0xc5,0x8e,0xf1,0x83,0x7d,0x16,0x83,0xb2,
+	0xc6,0xf3,0x4a,0x26,0xc1,0xb2,0xef,0xfa,
+	0x88,0x6b,0x42,0x38,0x61,0x1f,0xcf,0xdc,
+	0xde,0x35,0x5b,0x3b,0x65,0x19,0x03,0x5b,
+	0xbc,0x34,0xf4,0xde,0xf9,0x9c,0x02,0x38,
+	0x61,0xb4,0x6f,0xc9,0xd6,0xe6,0xc9,0x07,
+	0x7a,0xd9,0x1d,0x26,0x91,0xf7,0xf7,0xee,
+	0x59,0x8c,0xb0,0xfa,0xc1,0x86,0xd9,0x1c,
+	0xae,0xfe,0x13,0x09,0x85,0x13,0x92,0x70,
+	0xb4,0x13,0x0c,0x93,0xbc,0x43,0x79,0x44,
+	0xf4,0xfd,0x44,0x52,0xe2,0xd7,0x4d,0xd3,
+	0x64,0xf2,0xe2,0x1e,0x71,0xf5,0x4b,0xff,
+	0x5c,0xae,0x82,0xab,0x9c,0x9d,0xf6,0x9e,
+	0xe8,0x6d,0x2b,0xc5,0x22,0x36,0x3a,0x0d,
+	0xab,0xc5,0x21,0x97,0x9b,0x0d,0xea,0xda,
+	0x1d,0xbf,0x9a,0x42,0xd5,0xc4,0x48,0x4e,
+	0x0a,0xbc,0xd0,0x6b,0xfa,0x53,0xdd,0xef,
+	0x3c,0x1b,0x20,0xee,0x3f,0xd5,0x9d,0x7c,
+	0x25,0xe4,0x1d,0x2b,0x66,0xc6,0x2e,0x37,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+static const u8 ffdhe3072_q[] = {
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xd6,0xfc,0x2a,0x2c,0x51,0x5d,0xa5,0x4d,
+	0x57,0xee,0x2b,0x10,0x13,0x9e,0x9e,0x78,
+	0xec,0x5c,0xe2,0xc1,0xe7,0x16,0x9b,0x4a,
+	0xd4,0xf0,0x9b,0x20,0x8a,0x32,0x19,0xfd,
+	0xe6,0x49,0xce,0xe7,0x12,0x4d,0x9f,0x7c,
+	0xbe,0x97,0xf1,0xb1,0xb1,0x86,0x3a,0xec,
+	0x7b,0x40,0xd9,0x01,0x57,0x62,0x30,0xbd,
+	0x69,0xef,0x8f,0x6a,0xea,0xfe,0xb2,0xb0,
+	0x92,0x19,0xfa,0x8f,0xaf,0x83,0x37,0x68,
+	0x42,0xb1,0xb2,0xaa,0x9e,0xf6,0x8d,0x79,
+	0xda,0xab,0x89,0xaf,0x3f,0xab,0xe4,0x9a,
+	0xcc,0x27,0x86,0x38,0x70,0x73,0x45,0xbb,
+	0xf1,0x53,0x44,0xed,0x79,0xf7,0xf4,0x39,
+	0x0e,0xf8,0xac,0x50,0x9b,0x56,0xf3,0x9a,
+	0x98,0x56,0x65,0x27,0xa4,0x1d,0x3c,0xbd,
+	0x5e,0x05,0x58,0xc1,0x59,0x92,0x7d,0xb0,
+	0xe8,0x84,0x54,0xa5,0xd9,0x64,0x71,0xfd,
+	0xdc,0xb5,0x6d,0x5b,0xb0,0x6b,0xfa,0x34,
+	0x0e,0xa7,0xa1,0x51,0xef,0x1c,0xa6,0xfa,
+	0x57,0x2b,0x76,0xf3,0xb1,0xb9,0x5d,0x8c,
+	0x85,0x83,0xd3,0xe4,0x77,0x05,0x36,0xb8,
+	0x4f,0x01,0x7e,0x70,0xe6,0xfb,0xf1,0x76,
+	0x60,0x1a,0x02,0x66,0x94,0x1a,0x17,0xb0,
+	0xc8,0xb9,0x7f,0x4e,0x74,0xc2,0xc1,0xff,
+	0xc7,0x27,0x89,0x19,0x77,0x79,0x40,0xc1,
+	0xe1,0xff,0x1d,0x8d,0xa6,0x37,0xd6,0xb9,
+	0x9d,0xda,0xfe,0x5e,0x17,0x61,0x10,0x02,
+	0xe2,0xc7,0x78,0xc1,0xbe,0x8b,0x41,0xd9,
+	0x63,0x79,0xa5,0x13,0x60,0xd9,0x77,0xfd,
+	0x44,0x35,0xa1,0x1c,0x30,0x8f,0xe7,0xee,
+	0x6f,0x1a,0xad,0x9d,0xb2,0x8c,0x81,0xad,
+	0xde,0x1a,0x7a,0x6f,0x7c,0xce,0x01,0x1c,
+	0x30,0xda,0x37,0xe4,0xeb,0x73,0x64,0x83,
+	0xbd,0x6c,0x8e,0x93,0x48,0xfb,0xfb,0xf7,
+	0x2c,0xc6,0x58,0x7d,0x60,0xc3,0x6c,0x8e,
+	0x57,0x7f,0x09,0x84,0xc2,0x89,0xc9,0x38,
+	0x5a,0x09,0x86,0x49,0xde,0x21,0xbc,0xa2,
+	0x7a,0x7e,0xa2,0x29,0x71,0x6b,0xa6,0xe9,
+	0xb2,0x79,0x71,0x0f,0x38,0xfa,0xa5,0xff,
+	0xae,0x57,0x41,0x55,0xce,0x4e,0xfb,0x4f,
+	0x74,0x36,0x95,0xe2,0x91,0x1b,0x1d,0x06,
+	0xd5,0xe2,0x90,0xcb,0xcd,0x86,0xf5,0x6d,
+	0x0e,0xdf,0xcd,0x21,0x6a,0xe2,0x24,0x27,
+	0x05,0x5e,0x68,0x35,0xfd,0x29,0xee,0xf7,
+	0x9e,0x0d,0x90,0x77,0x1f,0xea,0xce,0xbe,
+	0x12,0xf2,0x0e,0x95,0xb3,0x63,0x17,0x1b,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+/*
+ * ffdhe4096 generator (g), modulus (p) and group size (q)
+ */
+
+static const u8 ffdhe4096_g[] = { 0x02 };
+
+static const u8 ffdhe4096_p[] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xad,0xf8,0x54,0x58,0xa2,0xbb,0x4a,0x9a,
+	0xaf,0xdc,0x56,0x20,0x27,0x3d,0x3c,0xf1,
+	0xd8,0xb9,0xc5,0x83,0xce,0x2d,0x36,0x95,
+	0xa9,0xe1,0x36,0x41,0x14,0x64,0x33,0xfb,
+	0xcc,0x93,0x9d,0xce,0x24,0x9b,0x3e,0xf9,
+	0x7d,0x2f,0xe3,0x63,0x63,0x0c,0x75,0xd8,
+	0xf6,0x81,0xb2,0x02,0xae,0xc4,0x61,0x7a,
+	0xd3,0xdf,0x1e,0xd5,0xd5,0xfd,0x65,0x61,
+	0x24,0x33,0xf5,0x1f,0x5f,0x06,0x6e,0xd0,
+	0x85,0x63,0x65,0x55,0x3d,0xed,0x1a,0xf3,
+	0xb5,0x57,0x13,0x5e,0x7f,0x57,0xc9,0x35,
+	0x98,0x4f,0x0c,0x70,0xe0,0xe6,0x8b,0x77,
+	0xe2,0xa6,0x89,0xda,0xf3,0xef,0xe8,0x72,
+	0x1d,0xf1,0x58,0xa1,0x36,0xad,0xe7,0x35,
+	0x30,0xac,0xca,0x4f,0x48,0x3a,0x79,0x7a,
+	0xbc,0x0a,0xb1,0x82,0xb3,0x24,0xfb,0x61,
+	0xd1,0x08,0xa9,0x4b,0xb2,0xc8,0xe3,0xfb,
+	0xb9,0x6a,0xda,0xb7,0x60,0xd7,0xf4,0x68,
+	0x1d,0x4f,0x42,0xa3,0xde,0x39,0x4d,0xf4,
+	0xae,0x56,0xed,0xe7,0x63,0x72,0xbb,0x19,
+	0x0b,0x07,0xa7,0xc8,0xee,0x0a,0x6d,0x70,
+	0x9e,0x02,0xfc,0xe1,0xcd,0xf7,0xe2,0xec,
+	0xc0,0x34,0x04,0xcd,0x28,0x34,0x2f,0x61,
+	0x91,0x72,0xfe,0x9c,0xe9,0x85,0x83,0xff,
+	0x8e,0x4f,0x12,0x32,0xee,0xf2,0x81,0x83,
+	0xc3,0xfe,0x3b,0x1b,0x4c,0x6f,0xad,0x73,
+	0x3b,0xb5,0xfc,0xbc,0x2e,0xc2,0x20,0x05,
+	0xc5,0x8e,0xf1,0x83,0x7d,0x16,0x83,0xb2,
+	0xc6,0xf3,0x4a,0x26,0xc1,0xb2,0xef,0xfa,
+	0x88,0x6b,0x42,0x38,0x61,0x1f,0xcf,0xdc,
+	0xde,0x35,0x5b,0x3b,0x65,0x19,0x03,0x5b,
+	0xbc,0x34,0xf4,0xde,0xf9,0x9c,0x02,0x38,
+	0x61,0xb4,0x6f,0xc9,0xd6,0xe6,0xc9,0x07,
+	0x7a,0xd9,0x1d,0x26,0x91,0xf7,0xf7,0xee,
+	0x59,0x8c,0xb0,0xfa,0xc1,0x86,0xd9,0x1c,
+	0xae,0xfe,0x13,0x09,0x85,0x13,0x92,0x70,
+	0xb4,0x13,0x0c,0x93,0xbc,0x43,0x79,0x44,
+	0xf4,0xfd,0x44,0x52,0xe2,0xd7,0x4d,0xd3,
+	0x64,0xf2,0xe2,0x1e,0x71,0xf5,0x4b,0xff,
+	0x5c,0xae,0x82,0xab,0x9c,0x9d,0xf6,0x9e,
+	0xe8,0x6d,0x2b,0xc5,0x22,0x36,0x3a,0x0d,
+	0xab,0xc5,0x21,0x97,0x9b,0x0d,0xea,0xda,
+	0x1d,0xbf,0x9a,0x42,0xd5,0xc4,0x48,0x4e,
+	0x0a,0xbc,0xd0,0x6b,0xfa,0x53,0xdd,0xef,
+	0x3c,0x1b,0x20,0xee,0x3f,0xd5,0x9d,0x7c,
+	0x25,0xe4,0x1d,0x2b,0x66,0x9e,0x1e,0xf1,
+	0x6e,0x6f,0x52,0xc3,0x16,0x4d,0xf4,0xfb,
+	0x79,0x30,0xe9,0xe4,0xe5,0x88,0x57,0xb6,
+	0xac,0x7d,0x5f,0x42,0xd6,0x9f,0x6d,0x18,
+	0x77,0x63,0xcf,0x1d,0x55,0x03,0x40,0x04,
+	0x87,0xf5,0x5b,0xa5,0x7e,0x31,0xcc,0x7a,
+	0x71,0x35,0xc8,0x86,0xef,0xb4,0x31,0x8a,
+	0xed,0x6a,0x1e,0x01,0x2d,0x9e,0x68,0x32,
+	0xa9,0x07,0x60,0x0a,0x91,0x81,0x30,0xc4,
+	0x6d,0xc7,0x78,0xf9,0x71,0xad,0x00,0x38,
+	0x09,0x29,0x99,0xa3,0x33,0xcb,0x8b,0x7a,
+	0x1a,0x1d,0xb9,0x3d,0x71,0x40,0x00,0x3c,
+	0x2a,0x4e,0xce,0xa9,0xf9,0x8d,0x0a,0xcc,
+	0x0a,0x82,0x91,0xcd,0xce,0xc9,0x7d,0xcf,
+	0x8e,0xc9,0xb5,0x5a,0x7f,0x88,0xa4,0x6b,
+	0x4d,0xb5,0xa8,0x51,0xf4,0x41,0x82,0xe1,
+	0xc6,0x8a,0x00,0x7e,0x5e,0x65,0x5f,0x6a,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+static const u8 ffdhe4096_q[] = {
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xd6,0xfc,0x2a,0x2c,0x51,0x5d,0xa5,0x4d,
+	0x57,0xee,0x2b,0x10,0x13,0x9e,0x9e,0x78,
+	0xec,0x5c,0xe2,0xc1,0xe7,0x16,0x9b,0x4a,
+	0xd4,0xf0,0x9b,0x20,0x8a,0x32,0x19,0xfd,
+	0xe6,0x49,0xce,0xe7,0x12,0x4d,0x9f,0x7c,
+	0xbe,0x97,0xf1,0xb1,0xb1,0x86,0x3a,0xec,
+	0x7b,0x40,0xd9,0x01,0x57,0x62,0x30,0xbd,
+	0x69,0xef,0x8f,0x6a,0xea,0xfe,0xb2,0xb0,
+	0x92,0x19,0xfa,0x8f,0xaf,0x83,0x37,0x68,
+	0x42,0xb1,0xb2,0xaa,0x9e,0xf6,0x8d,0x79,
+	0xda,0xab,0x89,0xaf,0x3f,0xab,0xe4,0x9a,
+	0xcc,0x27,0x86,0x38,0x70,0x73,0x45,0xbb,
+	0xf1,0x53,0x44,0xed,0x79,0xf7,0xf4,0x39,
+	0x0e,0xf8,0xac,0x50,0x9b,0x56,0xf3,0x9a,
+	0x98,0x56,0x65,0x27,0xa4,0x1d,0x3c,0xbd,
+	0x5e,0x05,0x58,0xc1,0x59,0x92,0x7d,0xb0,
+	0xe8,0x84,0x54,0xa5,0xd9,0x64,0x71,0xfd,
+	0xdc,0xb5,0x6d,0x5b,0xb0,0x6b,0xfa,0x34,
+	0x0e,0xa7,0xa1,0x51,0xef,0x1c,0xa6,0xfa,
+	0x57,0x2b,0x76,0xf3,0xb1,0xb9,0x5d,0x8c,
+	0x85,0x83,0xd3,0xe4,0x77,0x05,0x36,0xb8,
+	0x4f,0x01,0x7e,0x70,0xe6,0xfb,0xf1,0x76,
+	0x60,0x1a,0x02,0x66,0x94,0x1a,0x17,0xb0,
+	0xc8,0xb9,0x7f,0x4e,0x74,0xc2,0xc1,0xff,
+	0xc7,0x27,0x89,0x19,0x77,0x79,0x40,0xc1,
+	0xe1,0xff,0x1d,0x8d,0xa6,0x37,0xd6,0xb9,
+	0x9d,0xda,0xfe,0x5e,0x17,0x61,0x10,0x02,
+	0xe2,0xc7,0x78,0xc1,0xbe,0x8b,0x41,0xd9,
+	0x63,0x79,0xa5,0x13,0x60,0xd9,0x77,0xfd,
+	0x44,0x35,0xa1,0x1c,0x30,0x8f,0xe7,0xee,
+	0x6f,0x1a,0xad,0x9d,0xb2,0x8c,0x81,0xad,
+	0xde,0x1a,0x7a,0x6f,0x7c,0xce,0x01,0x1c,
+	0x30,0xda,0x37,0xe4,0xeb,0x73,0x64,0x83,
+	0xbd,0x6c,0x8e,0x93,0x48,0xfb,0xfb,0xf7,
+	0x2c,0xc6,0x58,0x7d,0x60,0xc3,0x6c,0x8e,
+	0x57,0x7f,0x09,0x84,0xc2,0x89,0xc9,0x38,
+	0x5a,0x09,0x86,0x49,0xde,0x21,0xbc,0xa2,
+	0x7a,0x7e,0xa2,0x29,0x71,0x6b,0xa6,0xe9,
+	0xb2,0x79,0x71,0x0f,0x38,0xfa,0xa5,0xff,
+	0xae,0x57,0x41,0x55,0xce,0x4e,0xfb,0x4f,
+	0x74,0x36,0x95,0xe2,0x91,0x1b,0x1d,0x06,
+	0xd5,0xe2,0x90,0xcb,0xcd,0x86,0xf5,0x6d,
+	0x0e,0xdf,0xcd,0x21,0x6a,0xe2,0x24,0x27,
+	0x05,0x5e,0x68,0x35,0xfd,0x29,0xee,0xf7,
+	0x9e,0x0d,0x90,0x77,0x1f,0xea,0xce,0xbe,
+	0x12,0xf2,0x0e,0x95,0xb3,0x4f,0x0f,0x78,
+	0xb7,0x37,0xa9,0x61,0x8b,0x26,0xfa,0x7d,
+	0xbc,0x98,0x74,0xf2,0x72,0xc4,0x2b,0xdb,
+	0x56,0x3e,0xaf,0xa1,0x6b,0x4f,0xb6,0x8c,
+	0x3b,0xb1,0xe7,0x8e,0xaa,0x81,0xa0,0x02,
+	0x43,0xfa,0xad,0xd2,0xbf,0x18,0xe6,0x3d,
+	0x38,0x9a,0xe4,0x43,0x77,0xda,0x18,0xc5,
+	0x76,0xb5,0x0f,0x00,0x96,0xcf,0x34,0x19,
+	0x54,0x83,0xb0,0x05,0x48,0xc0,0x98,0x62,
+	0x36,0xe3,0xbc,0x7c,0xb8,0xd6,0x80,0x1c,
+	0x04,0x94,0xcc,0xd1,0x99,0xe5,0xc5,0xbd,
+	0x0d,0x0e,0xdc,0x9e,0xb8,0xa0,0x00,0x1e,
+	0x15,0x27,0x67,0x54,0xfc,0xc6,0x85,0x66,
+	0x05,0x41,0x48,0xe6,0xe7,0x64,0xbe,0xe7,
+	0xc7,0x64,0xda,0xad,0x3f,0xc4,0x52,0x35,
+	0xa6,0xda,0xd4,0x28,0xfa,0x20,0xc1,0x70,
+	0xe3,0x45,0x00,0x3f,0x2f,0x32,0xaf,0xb5,
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+/*
+ * ffdhe6144 generator (g), modulus (p) and group size (q)
+ */
+
+static const u8 ffdhe6144_g[] = { 0x02 };
+
+static const u8 ffdhe6144_p[] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xad,0xf8,0x54,0x58,0xa2,0xbb,0x4a,0x9a,
+	0xaf,0xdc,0x56,0x20,0x27,0x3d,0x3c,0xf1,
+	0xd8,0xb9,0xc5,0x83,0xce,0x2d,0x36,0x95,
+	0xa9,0xe1,0x36,0x41,0x14,0x64,0x33,0xfb,
+	0xcc,0x93,0x9d,0xce,0x24,0x9b,0x3e,0xf9,
+	0x7d,0x2f,0xe3,0x63,0x63,0x0c,0x75,0xd8,
+	0xf6,0x81,0xb2,0x02,0xae,0xc4,0x61,0x7a,
+	0xd3,0xdf,0x1e,0xd5,0xd5,0xfd,0x65,0x61,
+	0x24,0x33,0xf5,0x1f,0x5f,0x06,0x6e,0xd0,
+	0x85,0x63,0x65,0x55,0x3d,0xed,0x1a,0xf3,
+	0xb5,0x57,0x13,0x5e,0x7f,0x57,0xc9,0x35,
+	0x98,0x4f,0x0c,0x70,0xe0,0xe6,0x8b,0x77,
+	0xe2,0xa6,0x89,0xda,0xf3,0xef,0xe8,0x72,
+	0x1d,0xf1,0x58,0xa1,0x36,0xad,0xe7,0x35,
+	0x30,0xac,0xca,0x4f,0x48,0x3a,0x79,0x7a,
+	0xbc,0x0a,0xb1,0x82,0xb3,0x24,0xfb,0x61,
+	0xd1,0x08,0xa9,0x4b,0xb2,0xc8,0xe3,0xfb,
+	0xb9,0x6a,0xda,0xb7,0x60,0xd7,0xf4,0x68,
+	0x1d,0x4f,0x42,0xa3,0xde,0x39,0x4d,0xf4,
+	0xae,0x56,0xed,0xe7,0x63,0x72,0xbb,0x19,
+	0x0b,0x07,0xa7,0xc8,0xee,0x0a,0x6d,0x70,
+	0x9e,0x02,0xfc,0xe1,0xcd,0xf7,0xe2,0xec,
+	0xc0,0x34,0x04,0xcd,0x28,0x34,0x2f,0x61,
+	0x91,0x72,0xfe,0x9c,0xe9,0x85,0x83,0xff,
+	0x8e,0x4f,0x12,0x32,0xee,0xf2,0x81,0x83,
+	0xc3,0xfe,0x3b,0x1b,0x4c,0x6f,0xad,0x73,
+	0x3b,0xb5,0xfc,0xbc,0x2e,0xc2,0x20,0x05,
+	0xc5,0x8e,0xf1,0x83,0x7d,0x16,0x83,0xb2,
+	0xc6,0xf3,0x4a,0x26,0xc1,0xb2,0xef,0xfa,
+	0x88,0x6b,0x42,0x38,0x61,0x1f,0xcf,0xdc,
+	0xde,0x35,0x5b,0x3b,0x65,0x19,0x03,0x5b,
+	0xbc,0x34,0xf4,0xde,0xf9,0x9c,0x02,0x38,
+	0x61,0xb4,0x6f,0xc9,0xd6,0xe6,0xc9,0x07,
+	0x7a,0xd9,0x1d,0x26,0x91,0xf7,0xf7,0xee,
+	0x59,0x8c,0xb0,0xfa,0xc1,0x86,0xd9,0x1c,
+	0xae,0xfe,0x13,0x09,0x85,0x13,0x92,0x70,
+	0xb4,0x13,0x0c,0x93,0xbc,0x43,0x79,0x44,
+	0xf4,0xfd,0x44,0x52,0xe2,0xd7,0x4d,0xd3,
+	0x64,0xf2,0xe2,0x1e,0x71,0xf5,0x4b,0xff,
+	0x5c,0xae,0x82,0xab,0x9c,0x9d,0xf6,0x9e,
+	0xe8,0x6d,0x2b,0xc5,0x22,0x36,0x3a,0x0d,
+	0xab,0xc5,0x21,0x97,0x9b,0x0d,0xea,0xda,
+	0x1d,0xbf,0x9a,0x42,0xd5,0xc4,0x48,0x4e,
+	0x0a,0xbc,0xd0,0x6b,0xfa,0x53,0xdd,0xef,
+	0x3c,0x1b,0x20,0xee,0x3f,0xd5,0x9d,0x7c,
+	0x25,0xe4,0x1d,0x2b,0x66,0x9e,0x1e,0xf1,
+	0x6e,0x6f,0x52,0xc3,0x16,0x4d,0xf4,0xfb,
+	0x79,0x30,0xe9,0xe4,0xe5,0x88,0x57,0xb6,
+	0xac,0x7d,0x5f,0x42,0xd6,0x9f,0x6d,0x18,
+	0x77,0x63,0xcf,0x1d,0x55,0x03,0x40,0x04,
+	0x87,0xf5,0x5b,0xa5,0x7e,0x31,0xcc,0x7a,
+	0x71,0x35,0xc8,0x86,0xef,0xb4,0x31,0x8a,
+	0xed,0x6a,0x1e,0x01,0x2d,0x9e,0x68,0x32,
+	0xa9,0x07,0x60,0x0a,0x91,0x81,0x30,0xc4,
+	0x6d,0xc7,0x78,0xf9,0x71,0xad,0x00,0x38,
+	0x09,0x29,0x99,0xa3,0x33,0xcb,0x8b,0x7a,
+	0x1a,0x1d,0xb9,0x3d,0x71,0x40,0x00,0x3c,
+	0x2a,0x4e,0xce,0xa9,0xf9,0x8d,0x0a,0xcc,
+	0x0a,0x82,0x91,0xcd,0xce,0xc9,0x7d,0xcf,
+	0x8e,0xc9,0xb5,0x5a,0x7f,0x88,0xa4,0x6b,
+	0x4d,0xb5,0xa8,0x51,0xf4,0x41,0x82,0xe1,
+	0xc6,0x8a,0x00,0x7e,0x5e,0x0d,0xd9,0x02,
+	0x0b,0xfd,0x64,0xb6,0x45,0x03,0x6c,0x7a,
+	0x4e,0x67,0x7d,0x2c,0x38,0x53,0x2a,0x3a,
+	0x23,0xba,0x44,0x42,0xca,0xf5,0x3e,0xa6,
+	0x3b,0xb4,0x54,0x32,0x9b,0x76,0x24,0xc8,
+	0x91,0x7b,0xdd,0x64,0xb1,0xc0,0xfd,0x4c,
+	0xb3,0x8e,0x8c,0x33,0x4c,0x70,0x1c,0x3a,
+	0xcd,0xad,0x06,0x57,0xfc,0xcf,0xec,0x71,
+	0x9b,0x1f,0x5c,0x3e,0x4e,0x46,0x04,0x1f,
+	0x38,0x81,0x47,0xfb,0x4c,0xfd,0xb4,0x77,
+	0xa5,0x24,0x71,0xf7,0xa9,0xa9,0x69,0x10,
+	0xb8,0x55,0x32,0x2e,0xdb,0x63,0x40,0xd8,
+	0xa0,0x0e,0xf0,0x92,0x35,0x05,0x11,0xe3,
+	0x0a,0xbe,0xc1,0xff,0xf9,0xe3,0xa2,0x6e,
+	0x7f,0xb2,0x9f,0x8c,0x18,0x30,0x23,0xc3,
+	0x58,0x7e,0x38,0xda,0x00,0x77,0xd9,0xb4,
+	0x76,0x3e,0x4e,0x4b,0x94,0xb2,0xbb,0xc1,
+	0x94,0xc6,0x65,0x1e,0x77,0xca,0xf9,0x92,
+	0xee,0xaa,0xc0,0x23,0x2a,0x28,0x1b,0xf6,
+	0xb3,0xa7,0x39,0xc1,0x22,0x61,0x16,0x82,
+	0x0a,0xe8,0xdb,0x58,0x47,0xa6,0x7c,0xbe,
+	0xf9,0xc9,0x09,0x1b,0x46,0x2d,0x53,0x8c,
+	0xd7,0x2b,0x03,0x74,0x6a,0xe7,0x7f,0x5e,
+	0x62,0x29,0x2c,0x31,0x15,0x62,0xa8,0x46,
+	0x50,0x5d,0xc8,0x2d,0xb8,0x54,0x33,0x8a,
+	0xe4,0x9f,0x52,0x35,0xc9,0x5b,0x91,0x17,
+	0x8c,0xcf,0x2d,0xd5,0xca,0xce,0xf4,0x03,
+	0xec,0x9d,0x18,0x10,0xc6,0x27,0x2b,0x04,
+	0x5b,0x3b,0x71,0xf9,0xdc,0x6b,0x80,0xd6,
+	0x3f,0xdd,0x4a,0x8e,0x9a,0xdb,0x1e,0x69,
+	0x62,0xa6,0x95,0x26,0xd4,0x31,0x61,0xc1,
+	0xa4,0x1d,0x57,0x0d,0x79,0x38,0xda,0xd4,
+	0xa4,0x0e,0x32,0x9c,0xd0,0xe4,0x0e,0x65,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+static const u8 ffdhe6144_q[] = {
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xd6,0xfc,0x2a,0x2c,0x51,0x5d,0xa5,0x4d,
+	0x57,0xee,0x2b,0x10,0x13,0x9e,0x9e,0x78,
+	0xec,0x5c,0xe2,0xc1,0xe7,0x16,0x9b,0x4a,
+	0xd4,0xf0,0x9b,0x20,0x8a,0x32,0x19,0xfd,
+	0xe6,0x49,0xce,0xe7,0x12,0x4d,0x9f,0x7c,
+	0xbe,0x97,0xf1,0xb1,0xb1,0x86,0x3a,0xec,
+	0x7b,0x40,0xd9,0x01,0x57,0x62,0x30,0xbd,
+	0x69,0xef,0x8f,0x6a,0xea,0xfe,0xb2,0xb0,
+	0x92,0x19,0xfa,0x8f,0xaf,0x83,0x37,0x68,
+	0x42,0xb1,0xb2,0xaa,0x9e,0xf6,0x8d,0x79,
+	0xda,0xab,0x89,0xaf,0x3f,0xab,0xe4,0x9a,
+	0xcc,0x27,0x86,0x38,0x70,0x73,0x45,0xbb,
+	0xf1,0x53,0x44,0xed,0x79,0xf7,0xf4,0x39,
+	0x0e,0xf8,0xac,0x50,0x9b,0x56,0xf3,0x9a,
+	0x98,0x56,0x65,0x27,0xa4,0x1d,0x3c,0xbd,
+	0x5e,0x05,0x58,0xc1,0x59,0x92,0x7d,0xb0,
+	0xe8,0x84,0x54,0xa5,0xd9,0x64,0x71,0xfd,
+	0xdc,0xb5,0x6d,0x5b,0xb0,0x6b,0xfa,0x34,
+	0x0e,0xa7,0xa1,0x51,0xef,0x1c,0xa6,0xfa,
+	0x57,0x2b,0x76,0xf3,0xb1,0xb9,0x5d,0x8c,
+	0x85,0x83,0xd3,0xe4,0x77,0x05,0x36,0xb8,
+	0x4f,0x01,0x7e,0x70,0xe6,0xfb,0xf1,0x76,
+	0x60,0x1a,0x02,0x66,0x94,0x1a,0x17,0xb0,
+	0xc8,0xb9,0x7f,0x4e,0x74,0xc2,0xc1,0xff,
+	0xc7,0x27,0x89,0x19,0x77,0x79,0x40,0xc1,
+	0xe1,0xff,0x1d,0x8d,0xa6,0x37,0xd6,0xb9,
+	0x9d,0xda,0xfe,0x5e,0x17,0x61,0x10,0x02,
+	0xe2,0xc7,0x78,0xc1,0xbe,0x8b,0x41,0xd9,
+	0x63,0x79,0xa5,0x13,0x60,0xd9,0x77,0xfd,
+	0x44,0x35,0xa1,0x1c,0x30,0x8f,0xe7,0xee,
+	0x6f,0x1a,0xad,0x9d,0xb2,0x8c,0x81,0xad,
+	0xde,0x1a,0x7a,0x6f,0x7c,0xce,0x01,0x1c,
+	0x30,0xda,0x37,0xe4,0xeb,0x73,0x64,0x83,
+	0xbd,0x6c,0x8e,0x93,0x48,0xfb,0xfb,0xf7,
+	0x2c,0xc6,0x58,0x7d,0x60,0xc3,0x6c,0x8e,
+	0x57,0x7f,0x09,0x84,0xc2,0x89,0xc9,0x38,
+	0x5a,0x09,0x86,0x49,0xde,0x21,0xbc,0xa2,
+	0x7a,0x7e,0xa2,0x29,0x71,0x6b,0xa6,0xe9,
+	0xb2,0x79,0x71,0x0f,0x38,0xfa,0xa5,0xff,
+	0xae,0x57,0x41,0x55,0xce,0x4e,0xfb,0x4f,
+	0x74,0x36,0x95,0xe2,0x91,0x1b,0x1d,0x06,
+	0xd5,0xe2,0x90,0xcb,0xcd,0x86,0xf5,0x6d,
+	0x0e,0xdf,0xcd,0x21,0x6a,0xe2,0x24,0x27,
+	0x05,0x5e,0x68,0x35,0xfd,0x29,0xee,0xf7,
+	0x9e,0x0d,0x90,0x77,0x1f,0xea,0xce,0xbe,
+	0x12,0xf2,0x0e,0x95,0xb3,0x4f,0x0f,0x78,
+	0xb7,0x37,0xa9,0x61,0x8b,0x26,0xfa,0x7d,
+	0xbc,0x98,0x74,0xf2,0x72,0xc4,0x2b,0xdb,
+	0x56,0x3e,0xaf,0xa1,0x6b,0x4f,0xb6,0x8c,
+	0x3b,0xb1,0xe7,0x8e,0xaa,0x81,0xa0,0x02,
+	0x43,0xfa,0xad,0xd2,0xbf,0x18,0xe6,0x3d,
+	0x38,0x9a,0xe4,0x43,0x77,0xda,0x18,0xc5,
+	0x76,0xb5,0x0f,0x00,0x96,0xcf,0x34,0x19,
+	0x54,0x83,0xb0,0x05,0x48,0xc0,0x98,0x62,
+	0x36,0xe3,0xbc,0x7c,0xb8,0xd6,0x80,0x1c,
+	0x04,0x94,0xcc,0xd1,0x99,0xe5,0xc5,0xbd,
+	0x0d,0x0e,0xdc,0x9e,0xb8,0xa0,0x00,0x1e,
+	0x15,0x27,0x67,0x54,0xfc,0xc6,0x85,0x66,
+	0x05,0x41,0x48,0xe6,0xe7,0x64,0xbe,0xe7,
+	0xc7,0x64,0xda,0xad,0x3f,0xc4,0x52,0x35,
+	0xa6,0xda,0xd4,0x28,0xfa,0x20,0xc1,0x70,
+	0xe3,0x45,0x00,0x3f,0x2f,0x06,0xec,0x81,
+	0x05,0xfe,0xb2,0x5b,0x22,0x81,0xb6,0x3d,
+	0x27,0x33,0xbe,0x96,0x1c,0x29,0x95,0x1d,
+	0x11,0xdd,0x22,0x21,0x65,0x7a,0x9f,0x53,
+	0x1d,0xda,0x2a,0x19,0x4d,0xbb,0x12,0x64,
+	0x48,0xbd,0xee,0xb2,0x58,0xe0,0x7e,0xa6,
+	0x59,0xc7,0x46,0x19,0xa6,0x38,0x0e,0x1d,
+	0x66,0xd6,0x83,0x2b,0xfe,0x67,0xf6,0x38,
+	0xcd,0x8f,0xae,0x1f,0x27,0x23,0x02,0x0f,
+	0x9c,0x40,0xa3,0xfd,0xa6,0x7e,0xda,0x3b,
+	0xd2,0x92,0x38,0xfb,0xd4,0xd4,0xb4,0x88,
+	0x5c,0x2a,0x99,0x17,0x6d,0xb1,0xa0,0x6c,
+	0x50,0x07,0x78,0x49,0x1a,0x82,0x88,0xf1,
+	0x85,0x5f,0x60,0xff,0xfc,0xf1,0xd1,0x37,
+	0x3f,0xd9,0x4f,0xc6,0x0c,0x18,0x11,0xe1,
+	0xac,0x3f,0x1c,0x6d,0x00,0x3b,0xec,0xda,
+	0x3b,0x1f,0x27,0x25,0xca,0x59,0x5d,0xe0,
+	0xca,0x63,0x32,0x8f,0x3b,0xe5,0x7c,0xc9,
+	0x77,0x55,0x60,0x11,0x95,0x14,0x0d,0xfb,
+	0x59,0xd3,0x9c,0xe0,0x91,0x30,0x8b,0x41,
+	0x05,0x74,0x6d,0xac,0x23,0xd3,0x3e,0x5f,
+	0x7c,0xe4,0x84,0x8d,0xa3,0x16,0xa9,0xc6,
+	0x6b,0x95,0x81,0xba,0x35,0x73,0xbf,0xaf,
+	0x31,0x14,0x96,0x18,0x8a,0xb1,0x54,0x23,
+	0x28,0x2e,0xe4,0x16,0xdc,0x2a,0x19,0xc5,
+	0x72,0x4f,0xa9,0x1a,0xe4,0xad,0xc8,0x8b,
+	0xc6,0x67,0x96,0xea,0xe5,0x67,0x7a,0x01,
+	0xf6,0x4e,0x8c,0x08,0x63,0x13,0x95,0x82,
+	0x2d,0x9d,0xb8,0xfc,0xee,0x35,0xc0,0x6b,
+	0x1f,0xee,0xa5,0x47,0x4d,0x6d,0x8f,0x34,
+	0xb1,0x53,0x4a,0x93,0x6a,0x18,0xb0,0xe0,
+	0xd2,0x0e,0xab,0x86,0xbc,0x9c,0x6d,0x6a,
+	0x52,0x07,0x19,0x4e,0x68,0x72,0x07,0x32,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+/*
+ * ffdhe8192 generator (g), modulus (p) and group size (q)
+ */
+
+static const u8 ffdhe8192_g[] = { 0x02 };
+
+static const u8 ffdhe8192_p[] = {
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xad,0xf8,0x54,0x58,0xa2,0xbb,0x4a,0x9a,
+	0xaf,0xdc,0x56,0x20,0x27,0x3d,0x3c,0xf1,
+	0xd8,0xb9,0xc5,0x83,0xce,0x2d,0x36,0x95,
+	0xa9,0xe1,0x36,0x41,0x14,0x64,0x33,0xfb,
+	0xcc,0x93,0x9d,0xce,0x24,0x9b,0x3e,0xf9,
+	0x7d,0x2f,0xe3,0x63,0x63,0x0c,0x75,0xd8,
+	0xf6,0x81,0xb2,0x02,0xae,0xc4,0x61,0x7a,
+	0xd3,0xdf,0x1e,0xd5,0xd5,0xfd,0x65,0x61,
+	0x24,0x33,0xf5,0x1f,0x5f,0x06,0x6e,0xd0,
+	0x85,0x63,0x65,0x55,0x3d,0xed,0x1a,0xf3,
+	0xb5,0x57,0x13,0x5e,0x7f,0x57,0xc9,0x35,
+	0x98,0x4f,0x0c,0x70,0xe0,0xe6,0x8b,0x77,
+	0xe2,0xa6,0x89,0xda,0xf3,0xef,0xe8,0x72,
+	0x1d,0xf1,0x58,0xa1,0x36,0xad,0xe7,0x35,
+	0x30,0xac,0xca,0x4f,0x48,0x3a,0x79,0x7a,
+	0xbc,0x0a,0xb1,0x82,0xb3,0x24,0xfb,0x61,
+	0xd1,0x08,0xa9,0x4b,0xb2,0xc8,0xe3,0xfb,
+	0xb9,0x6a,0xda,0xb7,0x60,0xd7,0xf4,0x68,
+	0x1d,0x4f,0x42,0xa3,0xde,0x39,0x4d,0xf4,
+	0xae,0x56,0xed,0xe7,0x63,0x72,0xbb,0x19,
+	0x0b,0x07,0xa7,0xc8,0xee,0x0a,0x6d,0x70,
+	0x9e,0x02,0xfc,0xe1,0xcd,0xf7,0xe2,0xec,
+	0xc0,0x34,0x04,0xcd,0x28,0x34,0x2f,0x61,
+	0x91,0x72,0xfe,0x9c,0xe9,0x85,0x83,0xff,
+	0x8e,0x4f,0x12,0x32,0xee,0xf2,0x81,0x83,
+	0xc3,0xfe,0x3b,0x1b,0x4c,0x6f,0xad,0x73,
+	0x3b,0xb5,0xfc,0xbc,0x2e,0xc2,0x20,0x05,
+	0xc5,0x8e,0xf1,0x83,0x7d,0x16,0x83,0xb2,
+	0xc6,0xf3,0x4a,0x26,0xc1,0xb2,0xef,0xfa,
+	0x88,0x6b,0x42,0x38,0x61,0x1f,0xcf,0xdc,
+	0xde,0x35,0x5b,0x3b,0x65,0x19,0x03,0x5b,
+	0xbc,0x34,0xf4,0xde,0xf9,0x9c,0x02,0x38,
+	0x61,0xb4,0x6f,0xc9,0xd6,0xe6,0xc9,0x07,
+	0x7a,0xd9,0x1d,0x26,0x91,0xf7,0xf7,0xee,
+	0x59,0x8c,0xb0,0xfa,0xc1,0x86,0xd9,0x1c,
+	0xae,0xfe,0x13,0x09,0x85,0x13,0x92,0x70,
+	0xb4,0x13,0x0c,0x93,0xbc,0x43,0x79,0x44,
+	0xf4,0xfd,0x44,0x52,0xe2,0xd7,0x4d,0xd3,
+	0x64,0xf2,0xe2,0x1e,0x71,0xf5,0x4b,0xff,
+	0x5c,0xae,0x82,0xab,0x9c,0x9d,0xf6,0x9e,
+	0xe8,0x6d,0x2b,0xc5,0x22,0x36,0x3a,0x0d,
+	0xab,0xc5,0x21,0x97,0x9b,0x0d,0xea,0xda,
+	0x1d,0xbf,0x9a,0x42,0xd5,0xc4,0x48,0x4e,
+	0x0a,0xbc,0xd0,0x6b,0xfa,0x53,0xdd,0xef,
+	0x3c,0x1b,0x20,0xee,0x3f,0xd5,0x9d,0x7c,
+	0x25,0xe4,0x1d,0x2b,0x66,0x9e,0x1e,0xf1,
+	0x6e,0x6f,0x52,0xc3,0x16,0x4d,0xf4,0xfb,
+	0x79,0x30,0xe9,0xe4,0xe5,0x88,0x57,0xb6,
+	0xac,0x7d,0x5f,0x42,0xd6,0x9f,0x6d,0x18,
+	0x77,0x63,0xcf,0x1d,0x55,0x03,0x40,0x04,
+	0x87,0xf5,0x5b,0xa5,0x7e,0x31,0xcc,0x7a,
+	0x71,0x35,0xc8,0x86,0xef,0xb4,0x31,0x8a,
+	0xed,0x6a,0x1e,0x01,0x2d,0x9e,0x68,0x32,
+	0xa9,0x07,0x60,0x0a,0x91,0x81,0x30,0xc4,
+	0x6d,0xc7,0x78,0xf9,0x71,0xad,0x00,0x38,
+	0x09,0x29,0x99,0xa3,0x33,0xcb,0x8b,0x7a,
+	0x1a,0x1d,0xb9,0x3d,0x71,0x40,0x00,0x3c,
+	0x2a,0x4e,0xce,0xa9,0xf9,0x8d,0x0a,0xcc,
+	0x0a,0x82,0x91,0xcd,0xce,0xc9,0x7d,0xcf,
+	0x8e,0xc9,0xb5,0x5a,0x7f,0x88,0xa4,0x6b,
+	0x4d,0xb5,0xa8,0x51,0xf4,0x41,0x82,0xe1,
+	0xc6,0x8a,0x00,0x7e,0x5e,0x0d,0xd9,0x02,
+	0x0b,0xfd,0x64,0xb6,0x45,0x03,0x6c,0x7a,
+	0x4e,0x67,0x7d,0x2c,0x38,0x53,0x2a,0x3a,
+	0x23,0xba,0x44,0x42,0xca,0xf5,0x3e,0xa6,
+	0x3b,0xb4,0x54,0x32,0x9b,0x76,0x24,0xc8,
+	0x91,0x7b,0xdd,0x64,0xb1,0xc0,0xfd,0x4c,
+	0xb3,0x8e,0x8c,0x33,0x4c,0x70,0x1c,0x3a,
+	0xcd,0xad,0x06,0x57,0xfc,0xcf,0xec,0x71,
+	0x9b,0x1f,0x5c,0x3e,0x4e,0x46,0x04,0x1f,
+	0x38,0x81,0x47,0xfb,0x4c,0xfd,0xb4,0x77,
+	0xa5,0x24,0x71,0xf7,0xa9,0xa9,0x69,0x10,
+	0xb8,0x55,0x32,0x2e,0xdb,0x63,0x40,0xd8,
+	0xa0,0x0e,0xf0,0x92,0x35,0x05,0x11,0xe3,
+	0x0a,0xbe,0xc1,0xff,0xf9,0xe3,0xa2,0x6e,
+	0x7f,0xb2,0x9f,0x8c,0x18,0x30,0x23,0xc3,
+	0x58,0x7e,0x38,0xda,0x00,0x77,0xd9,0xb4,
+	0x76,0x3e,0x4e,0x4b,0x94,0xb2,0xbb,0xc1,
+	0x94,0xc6,0x65,0x1e,0x77,0xca,0xf9,0x92,
+	0xee,0xaa,0xc0,0x23,0x2a,0x28,0x1b,0xf6,
+	0xb3,0xa7,0x39,0xc1,0x22,0x61,0x16,0x82,
+	0x0a,0xe8,0xdb,0x58,0x47,0xa6,0x7c,0xbe,
+	0xf9,0xc9,0x09,0x1b,0x46,0x2d,0x53,0x8c,
+	0xd7,0x2b,0x03,0x74,0x6a,0xe7,0x7f,0x5e,
+	0x62,0x29,0x2c,0x31,0x15,0x62,0xa8,0x46,
+	0x50,0x5d,0xc8,0x2d,0xb8,0x54,0x33,0x8a,
+	0xe4,0x9f,0x52,0x35,0xc9,0x5b,0x91,0x17,
+	0x8c,0xcf,0x2d,0xd5,0xca,0xce,0xf4,0x03,
+	0xec,0x9d,0x18,0x10,0xc6,0x27,0x2b,0x04,
+	0x5b,0x3b,0x71,0xf9,0xdc,0x6b,0x80,0xd6,
+	0x3f,0xdd,0x4a,0x8e,0x9a,0xdb,0x1e,0x69,
+	0x62,0xa6,0x95,0x26,0xd4,0x31,0x61,0xc1,
+	0xa4,0x1d,0x57,0x0d,0x79,0x38,0xda,0xd4,
+	0xa4,0x0e,0x32,0x9c,0xcf,0xf4,0x6a,0xaa,
+	0x36,0xad,0x00,0x4c,0xf6,0x00,0xc8,0x38,
+	0x1e,0x42,0x5a,0x31,0xd9,0x51,0xae,0x64,
+	0xfd,0xb2,0x3f,0xce,0xc9,0x50,0x9d,0x43,
+	0x68,0x7f,0xeb,0x69,0xed,0xd1,0xcc,0x5e,
+	0x0b,0x8c,0xc3,0xbd,0xf6,0x4b,0x10,0xef,
+	0x86,0xb6,0x31,0x42,0xa3,0xab,0x88,0x29,
+	0x55,0x5b,0x2f,0x74,0x7c,0x93,0x26,0x65,
+	0xcb,0x2c,0x0f,0x1c,0xc0,0x1b,0xd7,0x02,
+	0x29,0x38,0x88,0x39,0xd2,0xaf,0x05,0xe4,
+	0x54,0x50,0x4a,0xc7,0x8b,0x75,0x82,0x82,
+	0x28,0x46,0xc0,0xba,0x35,0xc3,0x5f,0x5c,
+	0x59,0x16,0x0c,0xc0,0x46,0xfd,0x82,0x51,
+	0x54,0x1f,0xc6,0x8c,0x9c,0x86,0xb0,0x22,
+	0xbb,0x70,0x99,0x87,0x6a,0x46,0x0e,0x74,
+	0x51,0xa8,0xa9,0x31,0x09,0x70,0x3f,0xee,
+	0x1c,0x21,0x7e,0x6c,0x38,0x26,0xe5,0x2c,
+	0x51,0xaa,0x69,0x1e,0x0e,0x42,0x3c,0xfc,
+	0x99,0xe9,0xe3,0x16,0x50,0xc1,0x21,0x7b,
+	0x62,0x48,0x16,0xcd,0xad,0x9a,0x95,0xf9,
+	0xd5,0xb8,0x01,0x94,0x88,0xd9,0xc0,0xa0,
+	0xa1,0xfe,0x30,0x75,0xa5,0x77,0xe2,0x31,
+	0x83,0xf8,0x1d,0x4a,0x3f,0x2f,0xa4,0x57,
+	0x1e,0xfc,0x8c,0xe0,0xba,0x8a,0x4f,0xe8,
+	0xb6,0x85,0x5d,0xfe,0x72,0xb0,0xa6,0x6e,
+	0xde,0xd2,0xfb,0xab,0xfb,0xe5,0x8a,0x30,
+	0xfa,0xfa,0xbe,0x1c,0x5d,0x71,0xa8,0x7e,
+	0x2f,0x74,0x1e,0xf8,0xc1,0xfe,0x86,0xfe,
+	0xa6,0xbb,0xfd,0xe5,0x30,0x67,0x7f,0x0d,
+	0x97,0xd1,0x1d,0x49,0xf7,0xa8,0x44,0x3d,
+	0x08,0x22,0xe5,0x06,0xa9,0xf4,0x61,0x4e,
+	0x01,0x1e,0x2a,0x94,0x83,0x8f,0xf8,0x8c,
+	0xd6,0x8c,0x8b,0xb7,0xc5,0xc6,0x42,0x4c,
+	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+static const u8 ffdhe8192_q[] = {
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+	0xd6,0xfc,0x2a,0x2c,0x51,0x5d,0xa5,0x4d,
+	0x57,0xee,0x2b,0x10,0x13,0x9e,0x9e,0x78,
+	0xec,0x5c,0xe2,0xc1,0xe7,0x16,0x9b,0x4a,
+	0xd4,0xf0,0x9b,0x20,0x8a,0x32,0x19,0xfd,
+	0xe6,0x49,0xce,0xe7,0x12,0x4d,0x9f,0x7c,
+	0xbe,0x97,0xf1,0xb1,0xb1,0x86,0x3a,0xec,
+	0x7b,0x40,0xd9,0x01,0x57,0x62,0x30,0xbd,
+	0x69,0xef,0x8f,0x6a,0xea,0xfe,0xb2,0xb0,
+	0x92,0x19,0xfa,0x8f,0xaf,0x83,0x37,0x68,
+	0x42,0xb1,0xb2,0xaa,0x9e,0xf6,0x8d,0x79,
+	0xda,0xab,0x89,0xaf,0x3f,0xab,0xe4,0x9a,
+	0xcc,0x27,0x86,0x38,0x70,0x73,0x45,0xbb,
+	0xf1,0x53,0x44,0xed,0x79,0xf7,0xf4,0x39,
+	0x0e,0xf8,0xac,0x50,0x9b,0x56,0xf3,0x9a,
+	0x98,0x56,0x65,0x27,0xa4,0x1d,0x3c,0xbd,
+	0x5e,0x05,0x58,0xc1,0x59,0x92,0x7d,0xb0,
+	0xe8,0x84,0x54,0xa5,0xd9,0x64,0x71,0xfd,
+	0xdc,0xb5,0x6d,0x5b,0xb0,0x6b,0xfa,0x34,
+	0x0e,0xa7,0xa1,0x51,0xef,0x1c,0xa6,0xfa,
+	0x57,0x2b,0x76,0xf3,0xb1,0xb9,0x5d,0x8c,
+	0x85,0x83,0xd3,0xe4,0x77,0x05,0x36,0xb8,
+	0x4f,0x01,0x7e,0x70,0xe6,0xfb,0xf1,0x76,
+	0x60,0x1a,0x02,0x66,0x94,0x1a,0x17,0xb0,
+	0xc8,0xb9,0x7f,0x4e,0x74,0xc2,0xc1,0xff,
+	0xc7,0x27,0x89,0x19,0x77,0x79,0x40,0xc1,
+	0xe1,0xff,0x1d,0x8d,0xa6,0x37,0xd6,0xb9,
+	0x9d,0xda,0xfe,0x5e,0x17,0x61,0x10,0x02,
+	0xe2,0xc7,0x78,0xc1,0xbe,0x8b,0x41,0xd9,
+	0x63,0x79,0xa5,0x13,0x60,0xd9,0x77,0xfd,
+	0x44,0x35,0xa1,0x1c,0x30,0x8f,0xe7,0xee,
+	0x6f,0x1a,0xad,0x9d,0xb2,0x8c,0x81,0xad,
+	0xde,0x1a,0x7a,0x6f,0x7c,0xce,0x01,0x1c,
+	0x30,0xda,0x37,0xe4,0xeb,0x73,0x64,0x83,
+	0xbd,0x6c,0x8e,0x93,0x48,0xfb,0xfb,0xf7,
+	0x2c,0xc6,0x58,0x7d,0x60,0xc3,0x6c,0x8e,
+	0x57,0x7f,0x09,0x84,0xc2,0x89,0xc9,0x38,
+	0x5a,0x09,0x86,0x49,0xde,0x21,0xbc,0xa2,
+	0x7a,0x7e,0xa2,0x29,0x71,0x6b,0xa6,0xe9,
+	0xb2,0x79,0x71,0x0f,0x38,0xfa,0xa5,0xff,
+	0xae,0x57,0x41,0x55,0xce,0x4e,0xfb,0x4f,
+	0x74,0x36,0x95,0xe2,0x91,0x1b,0x1d,0x06,
+	0xd5,0xe2,0x90,0xcb,0xcd,0x86,0xf5,0x6d,
+	0x0e,0xdf,0xcd,0x21,0x6a,0xe2,0x24,0x27,
+	0x05,0x5e,0x68,0x35,0xfd,0x29,0xee,0xf7,
+	0x9e,0x0d,0x90,0x77,0x1f,0xea,0xce,0xbe,
+	0x12,0xf2,0x0e,0x95,0xb3,0x4f,0x0f,0x78,
+	0xb7,0x37,0xa9,0x61,0x8b,0x26,0xfa,0x7d,
+	0xbc,0x98,0x74,0xf2,0x72,0xc4,0x2b,0xdb,
+	0x56,0x3e,0xaf,0xa1,0x6b,0x4f,0xb6,0x8c,
+	0x3b,0xb1,0xe7,0x8e,0xaa,0x81,0xa0,0x02,
+	0x43,0xfa,0xad,0xd2,0xbf,0x18,0xe6,0x3d,
+	0x38,0x9a,0xe4,0x43,0x77,0xda,0x18,0xc5,
+	0x76,0xb5,0x0f,0x00,0x96,0xcf,0x34,0x19,
+	0x54,0x83,0xb0,0x05,0x48,0xc0,0x98,0x62,
+	0x36,0xe3,0xbc,0x7c,0xb8,0xd6,0x80,0x1c,
+	0x04,0x94,0xcc,0xd1,0x99,0xe5,0xc5,0xbd,
+	0x0d,0x0e,0xdc,0x9e,0xb8,0xa0,0x00,0x1e,
+	0x15,0x27,0x67,0x54,0xfc,0xc6,0x85,0x66,
+	0x05,0x41,0x48,0xe6,0xe7,0x64,0xbe,0xe7,
+	0xc7,0x64,0xda,0xad,0x3f,0xc4,0x52,0x35,
+	0xa6,0xda,0xd4,0x28,0xfa,0x20,0xc1,0x70,
+	0xe3,0x45,0x00,0x3f,0x2f,0x06,0xec,0x81,
+	0x05,0xfe,0xb2,0x5b,0x22,0x81,0xb6,0x3d,
+	0x27,0x33,0xbe,0x96,0x1c,0x29,0x95,0x1d,
+	0x11,0xdd,0x22,0x21,0x65,0x7a,0x9f,0x53,
+	0x1d,0xda,0x2a,0x19,0x4d,0xbb,0x12,0x64,
+	0x48,0xbd,0xee,0xb2,0x58,0xe0,0x7e,0xa6,
+	0x59,0xc7,0x46,0x19,0xa6,0x38,0x0e,0x1d,
+	0x66,0xd6,0x83,0x2b,0xfe,0x67,0xf6,0x38,
+	0xcd,0x8f,0xae,0x1f,0x27,0x23,0x02,0x0f,
+	0x9c,0x40,0xa3,0xfd,0xa6,0x7e,0xda,0x3b,
+	0xd2,0x92,0x38,0xfb,0xd4,0xd4,0xb4,0x88,
+	0x5c,0x2a,0x99,0x17,0x6d,0xb1,0xa0,0x6c,
+	0x50,0x07,0x78,0x49,0x1a,0x82,0x88,0xf1,
+	0x85,0x5f,0x60,0xff,0xfc,0xf1,0xd1,0x37,
+	0x3f,0xd9,0x4f,0xc6,0x0c,0x18,0x11,0xe1,
+	0xac,0x3f,0x1c,0x6d,0x00,0x3b,0xec,0xda,
+	0x3b,0x1f,0x27,0x25,0xca,0x59,0x5d,0xe0,
+	0xca,0x63,0x32,0x8f,0x3b,0xe5,0x7c,0xc9,
+	0x77,0x55,0x60,0x11,0x95,0x14,0x0d,0xfb,
+	0x59,0xd3,0x9c,0xe0,0x91,0x30,0x8b,0x41,
+	0x05,0x74,0x6d,0xac,0x23,0xd3,0x3e,0x5f,
+	0x7c,0xe4,0x84,0x8d,0xa3,0x16,0xa9,0xc6,
+	0x6b,0x95,0x81,0xba,0x35,0x73,0xbf,0xaf,
+	0x31,0x14,0x96,0x18,0x8a,0xb1,0x54,0x23,
+	0x28,0x2e,0xe4,0x16,0xdc,0x2a,0x19,0xc5,
+	0x72,0x4f,0xa9,0x1a,0xe4,0xad,0xc8,0x8b,
+	0xc6,0x67,0x96,0xea,0xe5,0x67,0x7a,0x01,
+	0xf6,0x4e,0x8c,0x08,0x63,0x13,0x95,0x82,
+	0x2d,0x9d,0xb8,0xfc,0xee,0x35,0xc0,0x6b,
+	0x1f,0xee,0xa5,0x47,0x4d,0x6d,0x8f,0x34,
+	0xb1,0x53,0x4a,0x93,0x6a,0x18,0xb0,0xe0,
+	0xd2,0x0e,0xab,0x86,0xbc,0x9c,0x6d,0x6a,
+	0x52,0x07,0x19,0x4e,0x67,0xfa,0x35,0x55,
+	0x1b,0x56,0x80,0x26,0x7b,0x00,0x64,0x1c,
+	0x0f,0x21,0x2d,0x18,0xec,0xa8,0xd7,0x32,
+	0x7e,0xd9,0x1f,0xe7,0x64,0xa8,0x4e,0xa1,
+	0xb4,0x3f,0xf5,0xb4,0xf6,0xe8,0xe6,0x2f,
+	0x05,0xc6,0x61,0xde,0xfb,0x25,0x88,0x77,
+	0xc3,0x5b,0x18,0xa1,0x51,0xd5,0xc4,0x14,
+	0xaa,0xad,0x97,0xba,0x3e,0x49,0x93,0x32,
+	0xe5,0x96,0x07,0x8e,0x60,0x0d,0xeb,0x81,
+	0x14,0x9c,0x44,0x1c,0xe9,0x57,0x82,0xf2,
+	0x2a,0x28,0x25,0x63,0xc5,0xba,0xc1,0x41,
+	0x14,0x23,0x60,0x5d,0x1a,0xe1,0xaf,0xae,
+	0x2c,0x8b,0x06,0x60,0x23,0x7e,0xc1,0x28,
+	0xaa,0x0f,0xe3,0x46,0x4e,0x43,0x58,0x11,
+	0x5d,0xb8,0x4c,0xc3,0xb5,0x23,0x07,0x3a,
+	0x28,0xd4,0x54,0x98,0x84,0xb8,0x1f,0xf7,
+	0x0e,0x10,0xbf,0x36,0x1c,0x13,0x72,0x96,
+	0x28,0xd5,0x34,0x8f,0x07,0x21,0x1e,0x7e,
+	0x4c,0xf4,0xf1,0x8b,0x28,0x60,0x90,0xbd,
+	0xb1,0x24,0x0b,0x66,0xd6,0xcd,0x4a,0xfc,
+	0xea,0xdc,0x00,0xca,0x44,0x6c,0xe0,0x50,
+	0x50,0xff,0x18,0x3a,0xd2,0xbb,0xf1,0x18,
+	0xc1,0xfc,0x0e,0xa5,0x1f,0x97,0xd2,0x2b,
+	0x8f,0x7e,0x46,0x70,0x5d,0x45,0x27,0xf4,
+	0x5b,0x42,0xae,0xff,0x39,0x58,0x53,0x37,
+	0x6f,0x69,0x7d,0xd5,0xfd,0xf2,0xc5,0x18,
+	0x7d,0x7d,0x5f,0x0e,0x2e,0xb8,0xd4,0x3f,
+	0x17,0xba,0x0f,0x7c,0x60,0xff,0x43,0x7f,
+	0x53,0x5d,0xfe,0xf2,0x98,0x33,0xbf,0x86,
+	0xcb,0xe8,0x8e,0xa4,0xfb,0xd4,0x22,0x1e,
+	0x84,0x11,0x72,0x83,0x54,0xfa,0x30,0xa7,
+	0x00,0x8f,0x15,0x4a,0x41,0xc7,0xfc,0x46,
+	0x6b,0x46,0x45,0xdb,0xe2,0xe3,0x21,0x26,
+	0x7f,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
+};
+
+struct ffdhe_group {
+	int bits;
+	int minsize;
+	const u8 *p;
+	const u8 *q;
+	const u8 *g;
+} ffdhe_group_map[] = {
+	{
+		.bits = 2048,
+		.minsize = 225,
+		.p = ffdhe2048_p,
+		.q = ffdhe2048_q,
+		.g = ffdhe2048_g,
+	},
+	{
+		.bits = 3072,
+		.minsize = 275,
+		.p = ffdhe3072_p,
+		.q = ffdhe3072_q,
+		.g = ffdhe3072_g,
+	},
+	{
+		.bits = 4096,
+		.minsize = 325,
+		.p = ffdhe4096_p,
+		.q = ffdhe4096_q,
+		.g = ffdhe4096_g,
+	},
+	{
+		.bits = 6144,
+		.minsize = 375,
+		.p = ffdhe6144_p,
+		.q = ffdhe6144_q,
+		.g = ffdhe6144_g,
+	},
+	{
+		.bits = 8192,
+		.minsize = 400,
+		.p = ffdhe8192_p,
+		.q = ffdhe8192_q,
+		.g = ffdhe8192_g,
+	},
+};
+
+int crypto_ffdhe_params(struct dh *p, int bits)
+{
+	struct ffdhe_group *grp = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ffdhe_group_map); i++) {
+		if (ffdhe_group_map[i].bits == bits) {
+			grp = &ffdhe_group_map[i];
+			break;
+		}
+	}
+	if (!grp || !p)
+		return -EINVAL;
+
+	p->p_size = grp->bits / 8;
+	p->p = (u8 *)grp->p;
+	p->g_size = 1;
+	p->g = (u8 *)grp->g;
+	p->q_size = grp->bits / 8;
+	p->q = (u8 *)grp->q;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(crypto_ffdhe_params);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("FFDHE ephemeral parameters");
diff --git a/include/crypto/ffdhe.h b/include/crypto/ffdhe.h
new file mode 100644
index 000000000000..6cb9253ddb34
--- /dev/null
+++ b/include/crypto/ffdhe.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Finite-Field Diffie-Hellman definition according to RFC 7919
+ *
+ * Copyright (c) 2021, SUSE Software Products
+ * Authors: Hannes Reinecke <hare@suse.de>
+ */
+#ifndef _CRYPTO_FFDHE_
+#define _CRYPTO_FFDHE_
+
+/**
+ * crypto_ffdhe_params() - Generate FFDHE params
+ * @params: DH params
+ * @bits: Bitsize of the FFDHE parameters
+ *
+ * This functions sets the FFDHE parameter for @bits in @params.
+ * Valid bit sizes are 2048, 3072, 4096, 6144, or 8194.
+ *
+ * Returns: 0 on success, errno on failure.
+ */
+
+int crypto_ffdhe_params(struct dh *p, int bits);
+
+#endif /* _CRYPTO_FFDHE_H */
-- 
2.29.2

