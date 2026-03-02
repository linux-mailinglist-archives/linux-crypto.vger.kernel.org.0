Return-Path: <linux-crypto+bounces-21356-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD3RJiVFpWkl7gUAu9opvQ
	(envelope-from <linux-crypto+bounces-21356-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 09:07:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 548031D4668
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 09:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA7030312D2
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85A38E5C7;
	Mon,  2 Mar 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueWLGJKO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13738D00D;
	Mon,  2 Mar 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438484; cv=none; b=btouZEgK+1pB52RCOxAnRrIdatqAfvspxQtBPLIsZIFKsGukAqzKthaVVaVYUufCS110Bcolow6VHUTF2wGVLkZxJRsZ8nLxLCqzyBGsmJdMwAiDGhlCbAUw8P4WxJX7UxDfiiAs+4ROivX5IVCOK5gTqYGOsSI2RJ9MLw1cvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438484; c=relaxed/simple;
	bh=lXlkUJdiAWtnaXpdI44zQecmTOJvKYo7/F2Z3GU+sz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhCSpByhPl8nxlKgGLlIgk9Mg7/yD3ouhoUb6H7fTf1LMGmskWUbRjq933iSx51UwQjm/uh4wF949fjjKhkcZm/U8HMJmQc6Wnk3RrwIHJf4CUp6ODZ91+lsTcUOedFp9PeuRZfSDyKzliBV96IEsjpsgimVMDj3/sFbiBpL26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueWLGJKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF2C2BCB8;
	Mon,  2 Mar 2026 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438484;
	bh=lXlkUJdiAWtnaXpdI44zQecmTOJvKYo7/F2Z3GU+sz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueWLGJKOb5YFmXqQljaBuCRnZ/UhnHyPhE+hHyhNla2yUob0k4dkfm5U4aQ+5OzNn
	 5/jyiy+wtgMAmuIii6u5kgQL4eAfDXPUgkXe2mFNocix55a8VjMQTCq8hv/6ywYnFP
	 miQKajYhXcxYh4s2vSFciXgnqayNzIXzlUpCmX/PcKpB0u0uZ2xBV6JXg9j8CJiY2t
	 FMYkJbHrjSBx/GqbQSiTFNmmaYaKUx4hUoNtWL31AyGFwMIZ/rugogFAbf56LoHOk+
	 /0Jr2d3T5ExqKrpnBB2KPzw9lUX/c5O10rq+E4wy0nJL9Rw5d291I1h4kpu6E21lvF
	 ZLAJ+Sjkm8MJg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 10/21] nvme-auth: common: use crypto library in nvme_auth_generate_psk()
Date: Sun,  1 Mar 2026 23:59:48 -0800
Message-ID: <20260302075959.338638-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21356-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 548031D4668
X-Rspamd-Action: no action

For the HMAC computation in nvme_auth_generate_psk(), use the crypto
library instead of crypto_shash.  This is simpler, faster, and more
reliable.  Notably, this eliminates the crypto transformation object
allocation for every call, which was very slow.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 63 +++++++++-----------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index be5bc5fcafc63..781d1d5d46dd3 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -495,67 +495,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_parse_key);
  */
 int nvme_auth_generate_psk(u8 hmac_id, const u8 *skey, size_t skey_len,
 			   const u8 *c1, const u8 *c2, size_t hash_len,
 			   u8 **ret_psk, size_t *ret_len)
 {
-	struct crypto_shash *tfm;
-	SHASH_DESC_ON_STACK(shash, tfm);
+	size_t psk_len = nvme_auth_hmac_hash_len(hmac_id);
+	struct nvme_auth_hmac_ctx hmac;
 	u8 *psk;
-	const char *hmac_name;
-	int ret, psk_len;
+	int ret;
 
 	if (!c1 || !c2)
 		return -EINVAL;
 
-	hmac_name = nvme_auth_hmac_name(hmac_id);
-	if (!hmac_name) {
-		pr_warn("%s: invalid hash algorithm %d\n",
-			__func__, hmac_id);
-		return -EINVAL;
-	}
-
-	tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	psk_len = crypto_shash_digestsize(tfm);
+	ret = nvme_auth_hmac_init(&hmac, hmac_id, skey, skey_len);
+	if (ret)
+		return ret;
 	psk = kzalloc(psk_len, GFP_KERNEL);
 	if (!psk) {
-		ret = -ENOMEM;
-		goto out_free_tfm;
-	}
-
-	shash->tfm = tfm;
-	ret = crypto_shash_setkey(tfm, skey, skey_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_init(shash);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_update(shash, c1, hash_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_update(shash, c2, hash_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_final(shash, psk);
-	if (!ret) {
-		*ret_psk = psk;
-		*ret_len = psk_len;
+		memzero_explicit(&hmac, sizeof(hmac));
+		return -ENOMEM;
 	}
-
-out_free_psk:
-	if (ret)
-		kfree_sensitive(psk);
-out_free_tfm:
-	crypto_free_shash(tfm);
-
-	return ret;
+	nvme_auth_hmac_update(&hmac, c1, hash_len);
+	nvme_auth_hmac_update(&hmac, c2, hash_len);
+	nvme_auth_hmac_final(&hmac, psk);
+	*ret_psk = psk;
+	*ret_len = psk_len;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
 
 /**
  * nvme_auth_generate_digest - Generate TLS PSK digest
-- 
2.53.0


