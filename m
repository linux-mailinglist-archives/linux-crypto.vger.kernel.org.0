Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC21741A895
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Sep 2021 08:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhI1GGo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Sep 2021 02:06:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51566 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbhI1GFs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Sep 2021 02:05:48 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id D36DF2230E;
        Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632809047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0EP0935TsiVOFJw63x4jXshMW5+XeMSrBymfErMZoA=;
        b=QKOmZFSaKkNRMqYgWArR0kZXq3HV4Vc25M/RI5cwrYQQb0OwOVZ0Wf7A4zsA1Y56FVwZ/3
        Q10a2ykXyHv3tgxTkHCmXMxI0vMKjFe5zksGklS2qnaRqbXKu+0tMhrY/b+AWkW6/j3f+0
        Grz5x64bESyA/eE8/nxQ4ut3QnUHQvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632809047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0EP0935TsiVOFJw63x4jXshMW5+XeMSrBymfErMZoA=;
        b=DAK9HhTYriWxR5JM165aDWvSBrU1mLKmSYrGa1ozDlAqdsYU4ckdQLRtuw6Cx1IebQxg1e
        lE5iPN+OgbKZQ9DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay1.suse.de (Postfix) with ESMTP id C346925E6A;
        Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 67E0A518EE2E; Tue, 28 Sep 2021 08:04:06 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/12] nvme-auth: Diffie-Hellman key exchange support
Date:   Tue, 28 Sep 2021 08:03:52 +0200
Message-Id: <20210928060356.27338-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928060356.27338-1-hare@suse.de>
References: <20210928060356.27338-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Implement Diffie-Hellman key exchange using FFDHE groups
for NVMe In-Band Authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/auth.c  | 460 ++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/auth.h  |   8 +
 drivers/nvme/host/core.c  |   6 +-
 4 files changed, 457 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 49269c581ec4..0fab5684feca 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -90,6 +90,7 @@ config NVME_AUTH
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
+	select CRYPTO_FFDHE
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication.
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 6dbd710ed876..f5aa3d2b90d4 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -20,6 +20,7 @@ struct nvme_dhchap_queue_context {
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
+	struct crypto_kpp *dh_tfm;
 	void *buf;
 	size_t buf_size;
 	int qid;
@@ -35,6 +36,12 @@ struct nvme_dhchap_queue_context {
 	u8 c2[64];
 	u8 response[64];
 	u8 *host_response;
+	u8 *ctrl_key;
+	int ctrl_key_len;
+	u8 *host_key;
+	int host_key_len;
+	u8 *sess_key;
+	int sess_key_len;
 };
 
 static struct nvme_auth_dhgroup_map {
@@ -283,6 +290,218 @@ u8 *nvme_auth_transform_key(u8 *key, size_t key_len, u8 key_hash, char *nqn)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
+static int nvme_auth_hash_skey(int hmac_id, u8 *skey, size_t skey_len, u8 *hkey)
+{
+	const char *digest_name;
+	struct crypto_shash *tfm;
+	int ret;
+
+	digest_name = nvme_auth_digest_name(hmac_id);
+	if (!digest_name) {
+		pr_debug("%s: failed to get digest for %d\n", __func__,
+			 hmac_id);
+		return -EINVAL;
+	}
+	tfm = crypto_alloc_shash(digest_name, 0, 0);
+	if (IS_ERR(tfm))
+		return -ENOMEM;
+
+	ret = crypto_shash_tfm_digest(tfm, skey, skey_len, hkey);
+	if (ret < 0)
+		pr_debug("%s: Failed to hash digest len %zu\n", __func__,
+			 skey_len);
+
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
+		u8 *challenge, u8 *aug, size_t hlen)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	u8 *hashed_key;
+	const char *hmac_name;
+	int ret;
+
+	hashed_key = kmalloc(hlen, GFP_KERNEL);
+	if (!hashed_key)
+		return -ENOMEM;
+
+	ret = nvme_auth_hash_skey(hmac_id, skey,
+				  skey_len, hashed_key);
+	if (ret < 0)
+		goto out_free_key;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		ret = -EINVAL;
+		goto out_free_key;
+	}
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out_free_key;
+	}
+
+	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto out_free_hash;
+	}
+	desc->tfm = tfm;
+
+	ret = crypto_shash_setkey(tfm, hashed_key, hlen);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_update(desc, challenge, hlen);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_final(desc, aug);
+out_free_desc:
+	kfree_sensitive(desc);
+out_free_hash:
+	crypto_free_shash(tfm);
+out_free_key:
+	kfree_sensitive(hashed_key);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_augmented_challenge);
+
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, int dh_gid)
+{
+	char *pkey;
+	int ret, pkey_len;
+
+	if (dh_gid == NVME_AUTH_DHCHAP_DHGROUP_2048 ||
+	    dh_gid == NVME_AUTH_DHCHAP_DHGROUP_3072 ||
+	    dh_gid == NVME_AUTH_DHCHAP_DHGROUP_4096 ||
+	    dh_gid == NVME_AUTH_DHCHAP_DHGROUP_6144 ||
+	    dh_gid == NVME_AUTH_DHCHAP_DHGROUP_8192) {
+		struct dh p = {0};
+		int bits = nvme_auth_dhgroup_pubkey_size(dh_gid) << 3;
+		int dh_secret_len = 64;
+		u8 *dh_secret = kzalloc(dh_secret_len, GFP_KERNEL);
+
+		if (!dh_secret)
+			return -ENOMEM;
+
+		/*
+		 * NVMe base spec v2.0: The DH value shall be set to the value
+		 * of g^x mod p, where 'x' is a random number selected by the
+		 * host that shall be at least 256 bits long.
+		 *
+		 * We will be using a 512 bit random number as private key.
+		 * This is large enough to provide adequate security, but
+		 * small enough such that we can trivially conform to
+		 * NIST SB800-56A section 5.6.1.1.4 if
+		 * we guarantee that the random number is not either
+		 * all 0xff or all 0x00. But that should be guaranteed
+		 * by the in-kernel RNG anyway.
+		 */
+		get_random_bytes(dh_secret, dh_secret_len);
+
+		ret = crypto_ffdhe_params(&p, bits);
+		if (ret) {
+			kfree_sensitive(dh_secret);
+			return ret;
+		}
+
+		p.key = dh_secret;
+		p.key_size = dh_secret_len;
+
+		pkey_len = crypto_dh_key_len(&p);
+		pkey = kmalloc(pkey_len, GFP_KERNEL);
+		if (!pkey) {
+			kfree_sensitive(dh_secret);
+			return -ENOMEM;
+		}
+
+		get_random_bytes(pkey, pkey_len);
+		ret = crypto_dh_encode_key(pkey, pkey_len, &p);
+		if (ret) {
+			pr_debug("failed to encode private key, error %d\n",
+				 ret);
+			kfree_sensitive(dh_secret);
+			goto out;
+		}
+	} else {
+		pr_warn("invalid dh group %d\n", dh_gid);
+		return -EINVAL;
+	}
+	ret = crypto_kpp_set_secret(dh_tfm, pkey, pkey_len);
+	if (ret)
+		pr_debug("failed to set private key, error %d\n", ret);
+out:
+	kfree_sensitive(pkey);
+	pkey = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_privkey);
+
+int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
+		u8 *host_key, size_t host_key_len)
+{
+	struct kpp_request *req;
+	struct crypto_wait wait;
+	struct scatterlist dst;
+	int ret;
+
+	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	crypto_init_wait(&wait);
+	kpp_request_set_input(req, NULL, 0);
+	sg_init_one(&dst, host_key, host_key_len);
+	kpp_request_set_output(req, &dst, host_key_len);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
+	kpp_request_free(req);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_pubkey);
+
+int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
+		u8 *ctrl_key, size_t ctrl_key_len,
+		u8 *sess_key, size_t sess_key_len)
+{
+	struct kpp_request *req;
+	struct crypto_wait wait;
+	struct scatterlist src, dst;
+	int ret;
+
+	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	crypto_init_wait(&wait);
+	sg_init_one(&src, ctrl_key, ctrl_key_len);
+	kpp_request_set_input(req, &src, ctrl_key_len);
+	sg_init_one(&dst, sess_key, sess_key_len);
+	kpp_request_set_output(req, &dst, sess_key_len);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
+
+	kpp_request_free(req);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
+
 static int nvme_auth_send(struct nvme_ctrl *ctrl, int qid,
 		void *data, size_t tl)
 {
@@ -480,28 +699,77 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid DH group id %d\n",
 			 chap->qid, data->dhgid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		/* Leave previous dh_tfm intact */
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
+	/* Clear host and controller key to avoid accidental reuse */
+	kfree_sensitive(chap->host_key);
+	chap->host_key = NULL;
+	chap->host_key_len = 0;
+	kfree_sensitive(chap->ctrl_key);
+	chap->ctrl_key = NULL;
+	chap->ctrl_key_len = 0;
+
+	if (chap->dhgroup_id == data->dhgid &&
+	    (data->dhgid == NVME_AUTH_DHCHAP_DHGROUP_NULL || chap->dh_tfm)) {
+		dev_dbg(ctrl->device,
+			"qid %d: reuse existing DH group %s\n",
+			chap->qid, gid_name);
+		goto skip_kpp;
+	}
+
+	/* Reset dh_tfm if it can't be reused */
+	if (chap->dh_tfm) {
+		crypto_free_kpp(chap->dh_tfm);
+		chap->dh_tfm = NULL;
+	}
+
 	if (data->dhgid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
-		dev_warn(ctrl->device,
-			 "qid %d: unsupported DH group %s\n",
-			 chap->qid, kpp_name);
-		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-		return NVME_SC_AUTH_REQUIRED;
+		if (dhvlen == 0) {
+			dev_warn(ctrl->device,
+				 "qid %d: empty DH value\n",
+				 chap->qid);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+			return NVME_SC_INVALID_FIELD;
+		}
+
+		chap->dh_tfm = crypto_alloc_kpp(kpp_name, 0, 0);
+		if (IS_ERR(chap->dh_tfm)) {
+			int ret = PTR_ERR(chap->dh_tfm);
+
+			dev_warn(ctrl->device,
+				 "qid %d: error %d initializing DH group %s\n",
+				 chap->qid, ret, gid_name);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+			chap->dh_tfm = NULL;
+			return NVME_SC_AUTH_REQUIRED;
+		}
+		dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
+			chap->qid, gid_name);
 	} else if (dhvlen != 0) {
 		dev_warn(ctrl->device,
 			 "qid %d: invalid DH value for NULL DH\n",
-			chap->qid);
+			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_INVALID_FIELD;
 	}
 	chap->dhgroup_id = data->dhgid;
-	dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
-		chap->qid, gid_name);
-
+skip_kpp:
 	chap->s1 = le32_to_cpu(data->seqnum);
 	memcpy(chap->c1, data->cval, chap->hash_len);
+	if (dhvlen) {
+		chap->ctrl_key = kmalloc(dhvlen, GFP_KERNEL);
+		if (!chap->ctrl_key) {
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+			return NVME_SC_AUTH_REQUIRED;
+		}
+		chap->ctrl_key_len = dhvlen;
+		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
+		       dhvlen);
+		dev_dbg(ctrl->device, "ctrl public key %*ph\n",
+			 (int)chap->ctrl_key_len, chap->ctrl_key);
+	}
 
 	return 0;
 }
@@ -514,17 +782,19 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 
 	size += 2 * chap->hash_len;
 
+	if (chap->host_key_len)
+		size += chap->host_key_len;
+
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
 	}
-
 	memset(chap->buf, 0, size);
 	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
 	data->t_id = cpu_to_le16(chap->transaction);
 	data->hl = chap->hash_len;
-	data->dhvlen = 0;
+	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->opts->dhchap_ctrl_secret) {
 		get_random_bytes(chap->c2, chap->hash_len);
@@ -540,6 +810,13 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 		chap->s2 = 0;
 	}
 	data->seqnum = cpu_to_le32(chap->s2);
+	if (chap->host_key_len) {
+		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
+			__func__, chap->qid,
+			chap->host_key_len, chap->host_key);
+		memcpy(data->rval + 2 * chap->hash_len, chap->host_key,
+		       chap->host_key_len);
+	}
 	return size;
 }
 
@@ -552,6 +829,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	if (ctrl->opts->dhchap_ctrl_secret)
 		size += chap->hash_len;
 
+
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return NVME_SC_INVALID_FIELD;
@@ -580,7 +858,6 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		return NVME_SC_AUTH_REQUIRED;
 	}
-
 	/* Just print out information for the admin queue */
 	if (chap->qid == -1)
 		dev_info(ctrl->device,
@@ -627,6 +904,45 @@ static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
 
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
+
+	if (!chap->host_response) {
+		chap->host_response = nvme_auth_transform_key(ctrl->dhchap_key,
+					chap->hash_len, chap->hash_id,
+					ctrl->opts->host->nqn);
+		if (IS_ERR(chap->host_response)) {
+			ret = PTR_ERR(chap->host_response);
+			chap->host_response = NULL;
+			return ret;
+		}
+	}
+
+	ret = crypto_shash_setkey(chap->shash_tfm,
+			chap->host_response, chap->hash_len);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+			 chap->qid, ret);
+		goto out;
+	}
+
+	dev_dbg(ctrl->device,
+		"%s: using key %*ph\n", __func__,
+		(int)chap->hash_len, chap->host_response);
+
+	if (chap->dh_tfm) {
+		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(chap->hash_id,
+						    chap->sess_key,
+						    chap->sess_key_len,
+						    chap->c1, challenge,
+						    chap->hash_len);
+		if (ret)
+			goto out;
+	}
+
 	shash->tfm = chap->shash_tfm;
 	ret = crypto_shash_init(shash);
 	if (ret)
@@ -671,9 +987,42 @@ static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	u8 *ctrl_response;
 	u8 buf[4], *challenge = chap->c2;
 	int ret;
 
+	ctrl_response = nvme_auth_transform_key(ctrl->dhchap_ctrl_key,
+				chap->hash_len, chap->hash_id,
+				ctrl->opts->subsysnqn);
+	if (IS_ERR(ctrl_response)) {
+		ret = PTR_ERR(ctrl_response);
+		return ret;
+	}
+	ret = crypto_shash_setkey(chap->shash_tfm,
+			ctrl_response, ctrl->dhchap_key_len);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+			 chap->qid, ret);
+		goto out;
+	}
+	dev_dbg(ctrl->device,
+		"%s: using key %*ph\n", __func__,
+		(int)ctrl->dhchap_ctrl_key_len, ctrl_response);
+
+	if (chap->dh_tfm) {
+		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(chap->hash_id,
+						    chap->sess_key,
+						    chap->sess_key_len,
+						    chap->c2, challenge,
+						    chap->hash_len);
+		if (ret)
+			goto out;
+	}
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
 		__func__, chap->qid, chap->s2, chap->transaction);
 	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
@@ -776,8 +1125,77 @@ int nvme_auth_generate_ctrl_key(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_ctrl_key);
 
+static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	int ret;
+
+	if (chap->host_key && chap->host_key_len) {
+		dev_dbg(ctrl->device,
+			"qid %d: reusing host key\n", chap->qid);
+		goto gen_sesskey;
+	}
+	ret = nvme_auth_gen_privkey(chap->dh_tfm, chap->dhgroup_id);
+	if (ret < 0) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+
+	chap->host_key_len =
+		nvme_auth_dhgroup_pubkey_size(chap->dhgroup_id);
+
+	chap->host_key = kzalloc(chap->host_key_len, GFP_KERNEL);
+	if (!chap->host_key) {
+		chap->host_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return -ENOMEM;
+	}
+	ret = nvme_auth_gen_pubkey(chap->dh_tfm,
+				   chap->host_key, chap->host_key_len);
+	if (ret) {
+		dev_dbg(ctrl->device,
+			"failed to generate public key, error %d\n", ret);
+		kfree(chap->host_key);
+		chap->host_key = NULL;
+		chap->host_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+
+gen_sesskey:
+	chap->sess_key_len = chap->host_key_len;
+	chap->sess_key = kmalloc(chap->sess_key_len, GFP_KERNEL);
+	if (!chap->sess_key) {
+		chap->sess_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return -ENOMEM;
+	}
+
+	ret = nvme_auth_gen_shared_secret(chap->dh_tfm,
+					  chap->ctrl_key, chap->ctrl_key_len,
+					  chap->sess_key, chap->sess_key_len);
+	if (ret) {
+		dev_dbg(ctrl->device,
+			"failed to generate shared secret, error %d\n", ret);
+		kfree_sensitive(chap->sess_key);
+		chap->sess_key = NULL;
+		chap->sess_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+	dev_dbg(ctrl->device, "shared secret %*ph\n",
+		(int)chap->sess_key_len, chap->sess_key);
+	return 0;
+}
+
 static void nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 {
+	kfree_sensitive(chap->ctrl_key);
+	chap->ctrl_key = NULL;
+	chap->ctrl_key_len = 0;
+	kfree_sensitive(chap->sess_key);
+	chap->sess_key = NULL;
+	chap->sess_key_len = 0;
 	chap->status = 0;
 	chap->error = 0;
 	chap->s1 = 0;
@@ -791,6 +1209,11 @@ static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
 {
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
+	if (chap->dh_tfm)
+		crypto_free_kpp(chap->dh_tfm);
+	kfree_sensitive(chap->ctrl_key);
+	kfree_sensitive(chap->host_key);
+	kfree_sensitive(chap->sess_key);
 	kfree_sensitive(chap->host_response);
 	kfree(chap->buf);
 	kfree(chap);
@@ -848,6 +1271,15 @@ static void __nvme_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
+	if (chap->ctrl_key_len) {
+		dev_dbg(ctrl->device,
+			"%s: qid %d DH exponential\n",
+			__func__, chap->qid);
+		ret = nvme_auth_dhchap_exponential(ctrl, chap);
+		if (ret)
+			goto fail2;
+	}
+
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
 	ret = nvme_auth_dhchap_host_response(ctrl, chap);
@@ -1064,6 +1496,6 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	ctrl->dhchap_key_len = 0;
 	kfree(ctrl->dhchap_ctrl_key);
 	ctrl->dhchap_ctrl_key = NULL;
-	ctrl->dhchap_ctrl_key_len = 0;
+	ctrl->dhchap_key_len = 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
diff --git a/drivers/nvme/host/auth.h b/drivers/nvme/host/auth.h
index cf1255f9db6d..aec954e9de1e 100644
--- a/drivers/nvme/host/auth.h
+++ b/drivers/nvme/host/auth.h
@@ -21,5 +21,13 @@ int nvme_auth_hmac_id(const char *hmac_name);
 unsigned char *nvme_auth_extract_secret(unsigned char *dhchap_secret,
 					size_t *dhchap_key_len);
 u8 *nvme_auth_transform_key(u8 *key, size_t key_len, u8 key_hash, char *nqn);
+int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
+				  u8 *challenge, u8 *aug, size_t hlen);
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, int dh_gid);
+int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
+			 u8 *host_key, size_t host_key_len);
+int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
+				u8 *ctrl_key, size_t ctrl_key_len,
+				u8 *sess_key, size_t sess_key_len);
 
 #endif /* _NVME_AUTH_H */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 737b744f564e..1d103ae4afdf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3508,14 +3508,13 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
-		/* Key has changed; re-authenticate with new key */
+		/* Key has changed; re-authentication with new key */
 		nvme_auth_free(ctrl);
 		nvme_auth_generate_key(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
 	return count;
 }
 DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
@@ -3553,14 +3552,13 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
-		/* Key has changed; re-authenticate with new key */
+		/* Key has changed; re-authentication with new key */
 		nvme_auth_free(ctrl);
 		nvme_auth_generate_ctrl_key(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
 	return count;
 }
 DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-- 
2.29.2

