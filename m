Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCF46E4F3
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Dec 2021 10:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhLIJIQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Dec 2021 04:08:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhLIJIG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF351210FE;
        Thu,  9 Dec 2021 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1S8Kd+vBb14mUMdF3f8a+NXZImSG3nDtoXeQ5pX4P50=;
        b=x0G5RYQiaN78yFKFby5FrEL+NzEFHC4uWrMNgEGiTA7i06ggtwXY095L26Thw7YIFHNELt
        v/x+62RSNCUR77UuZfQ9Cl/izc13JqmY3uyHhnmyeDX+vN1R51MSJA/vXBq3i0ja3G1YNM
        AbMCZMIkvuke+6Sfay9DRnbu01lKVSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1S8Kd+vBb14mUMdF3f8a+NXZImSG3nDtoXeQ5pX4P50=;
        b=qa7nvJs1/KMnQTkpC99ZhkpWPDPFNlq+nlen3sWrWrQRiV2yvV7w/fqHM3t8dswjtgOGBO
        xHEy3ZxJoMaOYrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97AB113A86;
        Thu,  9 Dec 2021 09:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FdIYI5/GsWHGaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:31 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH v2 12/18] crypto: dh - introduce support for ephemeral key generation to qat driver
Date:   Thu,  9 Dec 2021 10:03:52 +0100
Message-Id: <20211209090358.28231-13-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A previous patch made the dh-generic implementation's ->set_secret() to
generate an ephemeral key in case the input ->key_size is zero, just in
analogy with ecdh. Make the qat crypto driver's DH implementation to
behave consistently by doing the same.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index b0b78445418b..e0d3a70fa6b1 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -441,11 +441,20 @@ static int qat_dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct device *dev = &GET_DEV(ctx->inst->accel_dev);
 	struct dh params;
+	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
 	int ret;
 
 	if (crypto_dh_decode_key(buf, len, &params) < 0)
 		return -EINVAL;
 
+	if (!params.key_size) {
+		ret = crypto_dh_gen_privkey(params.group_id, key,
+					    &params.key_size);
+		if (ret)
+			return ret;
+		params.key = key;
+	}
+
 	/* Free old secret if any */
 	qat_dh_clear_ctx(dev, ctx);
 
-- 
2.26.2

