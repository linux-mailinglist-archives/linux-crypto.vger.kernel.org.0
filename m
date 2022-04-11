Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB94FBA01
	for <lists+linux-crypto@lfdr.de>; Mon, 11 Apr 2022 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiDKKtm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 11 Apr 2022 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiDKKtf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 11 Apr 2022 06:49:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FB43EE7
        for <linux-crypto@vger.kernel.org>; Mon, 11 Apr 2022 03:47:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so13183029pjb.2
        for <linux-crypto@vger.kernel.org>; Mon, 11 Apr 2022 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWVLLL75305PEMMlh9Ha+LztksnTi4oO/fMo8+IqEcs=;
        b=630NriGzjnYeE+2JXYRMJDWEq0rN1V9lXQbjZbzBV55NqmeBbce0Qm16Aj4X2trlti
         1W2Og8EPpOx4PBggROFVsUM2Tm4ENAAwdy7hZvqfnn4edVR7xP3AfpfNBFd4ECdVarM0
         twMYsUMq/AbJw1AMgWxmGlYLeCXIm5iDoIOZ8QzV2uGRKmT5cA8xOxKYao5DvTRaRsER
         8X1zu/ixvJ3Id7Z5YZwrYRksqA98eZwNUM5lGdEgjyE/JX8NK8sos1HReDR/1J/m3Nw1
         WMGZlngWi7brRQatsM4oamzsYG8j0qlWiVBqMb1MsU79pyd0L3OnMTFO7/oOAJ8Z41pU
         WcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWVLLL75305PEMMlh9Ha+LztksnTi4oO/fMo8+IqEcs=;
        b=AiReZ3SUKw54Od/8cIf7OKL1UT7cQvUsTJfITIvqyOcli++CeCPJtEpGLaLvcrC+ln
         wvpg2VOVcs/cc97ln7fI33Q4G87wRzo/LLc3aTO1grZFgbU+HjenQNektR+nSqeckBZA
         k21tFCa0jG/7RQTseCYE1ZdjVGjxdxvDu6WWEb9XnPEI8ZOOSPwTz3UmULQsTP3dciQ0
         AQXgL/YGfSh6appT856zQ/8QppYTx3hpbloOI4Q8mYvU3U85MN1GXpQlrrmFpAkyZYwz
         5lwPJV8hed1BMaGGBSN61RpGeDiGgaW6OSwbZ5BwmqxRrdxckH6YLOYGeYNnobJBlSsT
         Ctvw==
X-Gm-Message-State: AOAM532JqKORPhUyTijB4HZj/twymDVUIGT5WMu5Y1ZsG/AE5brPxXn4
        UAO1/oN+2lkxLD1BQcv86JuF6A==
X-Google-Smtp-Source: ABdhPJwOtfpy8uM52zjJo+wVxs1FiSNLctloDYSl8Cufy+I0UYJkARvUFuchKS8WDsVpp2Ntr6s1AA==
X-Received: by 2002:a17:90b:164b:b0:1cb:61c8:afeb with SMTP id il11-20020a17090b164b00b001cb61c8afebmr12321298pjb.91.1649674039306;
        Mon, 11 Apr 2022 03:47:19 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id d8-20020a636808000000b00398e9c7049bsm27541649pgc.31.2022.04.11.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:47:18 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, berrange@redhat.com, arei.gonglei@huawei.com
Cc:     qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        cohuck@redhat.com, jasowang@redhat.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 3/8] crypto: Introduce akcipher crypto class
Date:   Mon, 11 Apr 2022 18:43:22 +0800
Message-Id: <20220411104327.197048-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411104327.197048-1-pizhenwei@bytedance.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Support basic asymmetric operations: encrypt, decrypt, sign and
verify.

Co-developed-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 crypto/akcipher.c         | 102 +++++++++++++++++++++++++
 crypto/akcipherpriv.h     |  43 +++++++++++
 crypto/meson.build        |   1 +
 include/crypto/akcipher.h | 151 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 crypto/akcipher.c
 create mode 100644 crypto/akcipherpriv.h
 create mode 100644 include/crypto/akcipher.h

diff --git a/crypto/akcipher.c b/crypto/akcipher.c
new file mode 100644
index 0000000000..7323a48073
--- /dev/null
+++ b/crypto/akcipher.c
@@ -0,0 +1,102 @@
+/*
+ * QEMU Crypto akcipher algorithms
+ *
+ * Copyright (c) 2022 Bytedance
+ * Author: zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/akcipher.h"
+#include "akcipherpriv.h"
+
+QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
+                                      QCryptoAkCipherKeyType type,
+                                      const uint8_t *key, size_t keylen,
+                                      Error **errp)
+{
+    QCryptoAkCipher *akcipher = NULL;
+
+    return akcipher;
+}
+
+bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
+{
+    return false;
+}
+
+int qcrypto_akcipher_encrypt(QCryptoAkCipher *akcipher,
+                             const void *in, size_t in_len,
+                             void *out, size_t out_len, Error **errp)
+{
+    const QCryptoAkCipherDriver *drv = akcipher->driver;
+
+    return drv->encrypt(akcipher, in, in_len, out, out_len, errp);
+}
+
+int qcrypto_akcipher_decrypt(QCryptoAkCipher *akcipher,
+                             const void *in, size_t in_len,
+                             void *out, size_t out_len, Error **errp)
+{
+    const QCryptoAkCipherDriver *drv = akcipher->driver;
+
+    return drv->decrypt(akcipher, in, in_len, out, out_len, errp);
+}
+
+int qcrypto_akcipher_sign(QCryptoAkCipher *akcipher,
+                          const void *in, size_t in_len,
+                          void *out, size_t out_len, Error **errp)
+{
+    const QCryptoAkCipherDriver *drv = akcipher->driver;
+
+    return drv->sign(akcipher, in, in_len, out, out_len, errp);
+}
+
+int qcrypto_akcipher_verify(QCryptoAkCipher *akcipher,
+                            const void *in, size_t in_len,
+                            const void *in2, size_t in2_len, Error **errp)
+{
+    const QCryptoAkCipherDriver *drv = akcipher->driver;
+
+    return drv->verify(akcipher, in, in_len, in2, in2_len, errp);
+}
+
+int qcrypto_akcipher_max_plaintext_len(QCryptoAkCipher *akcipher)
+{
+    return akcipher->max_plaintext_len;
+}
+
+int qcrypto_akcipher_max_ciphertext_len(QCryptoAkCipher *akcipher)
+{
+    return akcipher->max_ciphertext_len;
+}
+
+int qcrypto_akcipher_max_signature_len(QCryptoAkCipher *akcipher)
+{
+    return akcipher->max_signature_len;
+}
+
+int qcrypto_akcipher_max_dgst_len(QCryptoAkCipher *akcipher)
+{
+    return akcipher->max_dgst_len;
+}
+
+int qcrypto_akcipher_free(QCryptoAkCipher *akcipher, Error **errp)
+{
+    const QCryptoAkCipherDriver *drv = akcipher->driver;
+
+    return drv->free(akcipher, errp);
+}
diff --git a/crypto/akcipherpriv.h b/crypto/akcipherpriv.h
new file mode 100644
index 0000000000..da9e54a796
--- /dev/null
+++ b/crypto/akcipherpriv.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Crypto asymmetric algorithms
+ *
+ * Copyright (c) 2022 Bytedance
+ * Author: zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QCRYPTO_AKCIPHERPRIV_H
+#define QCRYPTO_AKCIPHERPRIV_H
+
+#include "qapi/qapi-types-crypto.h"
+
+struct QCryptoAkCipherDriver {
+    int (*encrypt)(QCryptoAkCipher *akcipher,
+                   const void *in, size_t in_len,
+                   void *out, size_t out_len, Error **errp);
+    int (*decrypt)(QCryptoAkCipher *akcipher,
+                   const void *out, size_t out_len,
+                   void *in, size_t in_len, Error **errp);
+    int (*sign)(QCryptoAkCipher *akcipher,
+                const void *in, size_t in_len,
+                void *out, size_t out_len, Error **errp);
+    int (*verify)(QCryptoAkCipher *akcipher,
+                  const void *in, size_t in_len,
+                  const void *in2, size_t in2_len, Error **errp);
+    int (*free)(QCryptoAkCipher *akcipher, Error **errp);
+};
+
+#endif /* QCRYPTO_AKCIPHER_H */
diff --git a/crypto/meson.build b/crypto/meson.build
index 19c44bea89..7647d5e243 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,6 +1,7 @@
 crypto_ss.add(genh)
 crypto_ss.add(files(
   'afsplit.c',
+  'akcipher.c',
   'block-luks.c',
   'block-qcow.c',
   'block.c',
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
new file mode 100644
index 0000000000..c1970b3b3b
--- /dev/null
+++ b/include/crypto/akcipher.h
@@ -0,0 +1,151 @@
+/*
+ * QEMU Crypto asymmetric algorithms
+ *
+ * Copyright (c) 2022 Bytedance
+ * Author: zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QCRYPTO_AKCIPHER_H
+#define QCRYPTO_AKCIPHER_H
+
+#include "qapi/qapi-types-crypto.h"
+
+typedef struct QCryptoAkCipher QCryptoAkCipher;
+typedef struct QCryptoAkCipherDriver QCryptoAkCipherDriver;
+
+struct QCryptoAkCipher {
+    QCryptoAkCipherAlgorithm alg;
+    QCryptoAkCipherKeyType type;
+    int max_plaintext_len;
+    int max_ciphertext_len;
+    int max_signature_len;
+    int max_dgst_len;
+    QCryptoAkCipherDriver *driver;
+};
+
+/**
+ * qcrypto_akcipher_supports:
+ * @opts: the asymmetric key algorithm and related options
+ *
+ * Determine if asymmetric key cipher decribed with @opts is
+ * supported by the current configured build
+ *
+ * Returns: true if it is supported, false otherwise.
+ */
+bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts);
+
+/**
+ * qcrypto_akcipher_new:
+ * @opts: specify the algorithm and the related arguments
+ * @type: private or public key type
+ * @key: buffer to store the key
+ * @key_len: the length of key buffer
+ * @errp: error pointer
+ *
+ * Create akcipher context
+ *
+ * Returns: On success, a new QCryptoAkCipher initialized with @opt
+ * is created and returned, otherwise NULL is returned.
+ */
+
+QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
+                                      QCryptoAkCipherKeyType type,
+                                      const uint8_t *key, size_t key_len,
+                                      Error **errp);
+
+/**
+ * qcrypto_akcipher_encrypt:
+ * @akcipher: akcipher context
+ * @in: plaintext pending to be encrypted
+ * @in_len: length of the plaintext, MUST less or equal to max_plaintext_len
+ * @out: buffer to store the ciphertext
+ * @out_len: the length of ciphertext buffer, usually equals to
+ *           max_ciphertext_len
+ * @errp: error pointer
+ *
+ * Encrypt data and write ciphertext into out
+ *
+ * Returns: length of ciphertext if encrypt succeed, otherwise -1 is returned
+ */
+int qcrypto_akcipher_encrypt(QCryptoAkCipher *akcipher,
+                             const void *in, size_t in_len,
+                             void *out, size_t out_len, Error **errp);
+
+/**
+ * qcrypto_akcipher_decrypt:
+ * @akcipher: akcipher context
+ * @in: ciphertext to be decrypted
+ * @in_len: the length of ciphertext
+ * @out: buffer to store the plaintext
+ * @out_len: length of the plaintext buffer, usually less or equals to
+ *           max_plaintext_len
+ * @errp: error pointer
+ *
+ * Decrypt ciphertext and write plaintext into out
+ *
+ * Returns: length of plaintext if decrypt succeed, otherwise -1 is returned
+ */
+int qcrypto_akcipher_decrypt(QCryptoAkCipher *akcipher,
+                             const void *in, size_t in_len,
+                             void *out, size_t out_len, Error **errp);
+
+/**
+ * qcrypto_akcipher_sign:
+ * @akcipher: akcipher context
+ * @in: data to be signed
+ * @in_len: the length of data
+ * @out: buffer to store the signature
+ * @out_len: length of the signature buffer, usually equals to max_signature_len
+ * @errp: error pointer
+ *
+ * Generate signature for data using akcipher
+ *
+ * Returns: length of signature if succeed, otherwise -1 is returned
+ */
+int qcrypto_akcipher_sign(QCryptoAkCipher *akcipher,
+                          const void *in, size_t in_len,
+                          void *out, size_t out_len, Error **errp);
+
+/**
+ * qcrypto_akcipher_verify:
+ * @akcipher: akcipher used to do verifycation
+ * @in: pointer to the signature
+ * @in_len: length of the signature
+ * @in2: pointer to original data
+ * @in2_len: the length of original data
+ * @errp: error pointer
+ *
+ * Verify the signature and the data match or not
+ *
+ * Returns: 0 for succeed, otherwise -1 is returned
+ */
+int qcrypto_akcipher_verify(QCryptoAkCipher *akcipher,
+                            const void *in, size_t in_len,
+                            const void *in2, size_t in2_len, Error **errp);
+
+int qcrypto_akcipher_max_plaintext_len(QCryptoAkCipher *akcipher);
+
+int qcrypto_akcipher_max_ciphertext_len(QCryptoAkCipher *akcipher);
+
+int qcrypto_akcipher_max_signature_len(QCryptoAkCipher *akcipher);
+
+int qcrypto_akcipher_max_dgst_len(QCryptoAkCipher *akcipher);
+
+int qcrypto_akcipher_free(QCryptoAkCipher *akcipher, Error **errp);
+
+
+#endif /* QCRYPTO_AKCIPHER_H */
-- 
2.20.1

