Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F953526E9C
	for <lists+linux-crypto@lfdr.de>; Sat, 14 May 2022 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiENCxn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 May 2022 22:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiENCxd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 May 2022 22:53:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE935DCB8
        for <linux-crypto@vger.kernel.org>; Fri, 13 May 2022 17:59:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 204so9097096pfx.3
        for <linux-crypto@vger.kernel.org>; Fri, 13 May 2022 17:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIJSWXum182XvEL2ia4jQ4QciU62+avYX3pAPB8sVlc=;
        b=IryO49kj83IsngKODwb2QQE43kbM6CxwrtkR5hv5k75x61n3rnyay1Z8WWQ6mZmlM1
         wHCl8m1PqSne67EvD6W0i75wypL6EPCIXTG2nEUWefDBT0lvrOoJupW/Juqwv+rJ9i0B
         yU4kjssNc5iZQL1eUwTRkGPvIjH/fMU7QHLSPh2IRH0LCmCTZ3WapcSapn2mR7EHT0yt
         VXfmQ4N/OvsJI+cm/9/KFWrp9dQHAMoS7UYWYru106IeCZ1GMnMnXPAo/RQjjbLYgpzx
         9i47IHuP2Znoc4jZgjNAqOZlCGs7miKawn6roR5q2d5yGv+pY+VaUwyE1SHpOeu/S+0/
         mMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIJSWXum182XvEL2ia4jQ4QciU62+avYX3pAPB8sVlc=;
        b=mNNsOEEZSqo6pC20CIY+SJY59wK0ZtxAABCi4/lY90sEkfcNazDAVFbMmpMpqBbd61
         a5lAjsky2TRXU1sx7ZGIwpeYsUlnFcglJQrJd2wc8Zam/DmIwcbi5pZjzi6NfnFxMgJW
         7GJjSAS0aM7R7KsETu38WAY3qugBOg52J6dXBSXJPkBK2d40AXs9wyr8WmbKcxYFGjUR
         RqiwL1Ea0nI6mNZOoreELsNqdKF3QQ+Ss7bQW+JUlHifQ86MquhzK4/DtcUH8S6t4+gK
         rzPV4bkyrJtN4B15/5IjJlHI6GpOUAptkdK4A9xmdalkp7tE3PIG8EUtPaHdWomF4vey
         Vn8Q==
X-Gm-Message-State: AOAM530R/0rtzmO/kL3RUd3DkHQinw5BPhaPtOzz0xmNnN7rYf/ZRFRR
        bGzVOr+QmzvustSXys750OlQ1Q==
X-Google-Smtp-Source: ABdhPJyQy0hm4e6qkkbTmYRLJcEYNki8m5v6GckSrokR5ARC1yQJD3M7q2U8kcjyXWa5PpG+NFNn4w==
X-Received: by 2002:a05:6a00:a1e:b0:50d:bb0c:2e27 with SMTP id p30-20020a056a000a1e00b0050dbb0c2e27mr6878561pfh.49.1652489961560;
        Fri, 13 May 2022 17:59:21 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id t24-20020a170902b21800b0015e8d4eb1dbsm2466125plr.37.2022.05.13.17.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 17:59:20 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, arei.gonglei@huawei.com, berrange@redhat.com
Cc:     qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        jasowang@redhat.com, pizhenwei@bytedance.com, cohuck@redhat.com
Subject: [PATCH v6 1/9] virtio-crypto: header update
Date:   Sat, 14 May 2022 08:54:56 +0800
Message-Id: <20220514005504.1042884-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514005504.1042884-1-pizhenwei@bytedance.com>
References: <20220514005504.1042884-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Update header from linux, support akcipher service.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../standard-headers/linux/virtio_crypto.h    | 82 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4ee59..68066dafb6 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -37,6 +37,7 @@
 #define VIRTIO_CRYPTO_SERVICE_HASH   1
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
@@ -57,6 +58,10 @@ struct virtio_crypto_ctrl_header {
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
+#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
 	uint32_t opcode;
 	uint32_t algo;
 	uint32_t flag;
@@ -180,6 +185,58 @@ struct virtio_crypto_aead_create_session_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	uint32_t padding_algo;
+
+#define VIRTIO_CRYPTO_RSA_NO_HASH   0
+#define VIRTIO_CRYPTO_RSA_MD2       1
+#define VIRTIO_CRYPTO_RSA_MD3       2
+#define VIRTIO_CRYPTO_RSA_MD4       3
+#define VIRTIO_CRYPTO_RSA_MD5       4
+#define VIRTIO_CRYPTO_RSA_SHA1      5
+#define VIRTIO_CRYPTO_RSA_SHA256    6
+#define VIRTIO_CRYPTO_RSA_SHA384    7
+#define VIRTIO_CRYPTO_RSA_SHA512    8
+#define VIRTIO_CRYPTO_RSA_SHA224    9
+	uint32_t hash_algo;
+};
+
+struct virtio_crypto_ecdsa_session_para {
+#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
+#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
+#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
+#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
+#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
+#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
+	uint32_t curve_id;
+	uint32_t padding;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
+	uint32_t algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	uint32_t keytype;
+	uint32_t keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+		struct virtio_crypto_ecdsa_session_para ecdsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	uint8_t padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -247,6 +304,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		uint8_t padding[56];
@@ -266,6 +325,14 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
+#define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_SIGN \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
+#define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
 	uint32_t opcode;
 	/* algo should be service-specific algorithms */
 	uint32_t algo;
@@ -390,6 +457,16 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	uint32_t src_data_len;
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	uint8_t padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -399,6 +476,7 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		uint8_t padding[48];
 	} u;
 };
@@ -408,6 +486,8 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED 6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
@@ -438,7 +518,7 @@ struct virtio_crypto_config {
 	uint32_t max_cipher_key_len;
 	/* Maximum length of authenticated key */
 	uint32_t max_auth_key_len;
-	uint32_t reserve;
+	uint32_t akcipher_algo;
 	/* Maximum size of each crypto request's content */
 	uint64_t max_size;
 };
-- 
2.20.1

