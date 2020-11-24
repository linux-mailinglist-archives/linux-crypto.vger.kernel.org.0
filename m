Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6048D2C2B63
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Nov 2020 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgKXPdI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 24 Nov 2020 10:33:08 -0500
Received: from novek.ru ([213.148.174.62]:47476 "EHLO novek.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389662AbgKXPdH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 24 Nov 2020 10:33:07 -0500
Received: from nat1.ooonet.ru (gw.zelenaya.net [91.207.137.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by novek.ru (Postfix) with ESMTPSA id C90E35030C8;
        Tue, 24 Nov 2020 18:25:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru C90E35030C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
        t=1606231533; bh=7QInkW/Oq3shx84L/3laQQ6VwguvjNXZ8FcFLS5fzv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC8BNMsIpMof43AK8eFWJSfjEU6KZVOQDf/LnaxWhLtzlqXr+EgsQgIlMasXU6Msb
         xO7O9YmJcTP0kuk3ZidFYMpCQoYArtGBI2RzuhCOeSLrnZ6EyY1vvfEhz3+0Cwbb3R
         CH2Q6MUnYmephjYJ3Yc8Y14/r/v7TfNU9+CeX/D4=
From:   Vadim Fedorenko <vfedorenko@novek.ru>
To:     Jakub Kicinski <kuba@kernel.org>,
        Boris Pismenny <borisp@nvidia.com>,
        Aviad Yehezkel <aviadye@nvidia.com>
Cc:     Vadim Fedorenko <vfedorenko@novek.ru>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [net-next v2 3/5] net/tls: add CHACHA20-POLY1305 specific behavior
Date:   Tue, 24 Nov 2020 18:24:48 +0300
Message-Id: <1606231490-653-4-git-send-email-vfedorenko@novek.ru>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606231490-653-1-git-send-email-vfedorenko@novek.ru>
References: <1606231490-653-1-git-send-email-vfedorenko@novek.ru>
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gate.novek.ru
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

RFC 7905 defines special behavior for ChaCha-Poly TLS sessions.
The differences are in the calculation of nonce and the absence
of explicit IV. This behavior is like TLSv1.3 partly.

Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
---
 include/net/tls.h | 9 ++++++---
 net/tls/tls_sw.c  | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e4e9c2a..b2637ed 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -502,7 +502,8 @@ static inline void tls_advance_record_sn(struct sock *sk,
 	if (tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size))
 		tls_err_abort(sk, EBADMSG);
 
-	if (prot->version != TLS_1_3_VERSION)
+	if (prot->version != TLS_1_3_VERSION &&
+	    prot->cipher_type != TLS_CIPHER_CHACHA20_POLY1305)
 		tls_bigint_increment(ctx->iv + prot->salt_size,
 				     prot->iv_size);
 }
@@ -516,7 +517,8 @@ static inline void tls_fill_prepend(struct tls_context *ctx,
 	size_t pkt_len, iv_size = prot->iv_size;
 
 	pkt_len = plaintext_len + prot->tag_size;
-	if (prot->version != TLS_1_3_VERSION) {
+	if (prot->version != TLS_1_3_VERSION &&
+	    prot->cipher_type != TLS_CIPHER_CHACHA20_POLY1305) {
 		pkt_len += iv_size;
 
 		memcpy(buf + TLS_NONCE_OFFSET,
@@ -561,7 +563,8 @@ static inline void xor_iv_with_seq(struct tls_prot_info *prot, char *iv, char *s
 {
 	int i;
 
-	if (prot->version == TLS_1_3_VERSION) {
+	if (prot->version == TLS_1_3_VERSION ||
+	    prot->cipher_type == TLS_CIPHER_CHACHA20_POLY1305) {
 		for (i = 0; i < 8; i++)
 			iv[i + 4] ^= seq[i];
 	}
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6bc757a..b4eefdb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1464,7 +1464,8 @@ static int decrypt_internal(struct sock *sk, struct sk_buff *skb,
 		kfree(mem);
 		return err;
 	}
-	if (prot->version == TLS_1_3_VERSION)
+	if (prot->version == TLS_1_3_VERSION ||
+	    prot->cipher_type == TLS_CIPHER_CHACHA20_POLY1305)
 		memcpy(iv + iv_offset, tls_ctx->rx.iv,
 		       crypto_aead_ivsize(ctx->aead_recv));
 	else
@@ -2068,7 +2069,8 @@ static int tls_read_size(struct strparser *strp, struct sk_buff *skb)
 	data_len = ((header[4] & 0xFF) | (header[3] << 8));
 
 	cipher_overhead = prot->tag_size;
-	if (prot->version != TLS_1_3_VERSION)
+	if (prot->version != TLS_1_3_VERSION &&
+	    prot->cipher_type != TLS_CIPHER_CHACHA20_POLY1305)
 		cipher_overhead += prot->iv_size;
 
 	if (data_len > TLS_MAX_PAYLOAD_SIZE + cipher_overhead +
-- 
1.8.3.1

