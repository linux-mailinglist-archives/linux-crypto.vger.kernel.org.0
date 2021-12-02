Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA946666A
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Dec 2021 16:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358944AbhLBP1h (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Dec 2021 10:27:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358940AbhLBP1c (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Dec 2021 10:27:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A89061FE02;
        Thu,  2 Dec 2021 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638458648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7IUvKHMStek2+HuUuu4fmmikA97g4NyN1IVLg+orHY=;
        b=unXND1JtM/3A18+gODr3TPF6qiNmeVVwJhq3oQxzGz5nb80o8UTZkwyQg8c1t/2i1awEuJ
        +cFjUN5nrNguLpaJF18EtqTN4IhR1Ta1akXqbyCNjpQiPkdTu6/uiItBJQyiB2c250czw0
        Wp9Hh4nYOi1Wi0q+NhLC+fFZIdOkMFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638458648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7IUvKHMStek2+HuUuu4fmmikA97g4NyN1IVLg+orHY=;
        b=a5dEQfbPSFmK20HOniw2O4nf03gRQWgWEHrR3YXbNRA1mqaV1fZz9Z6WwdIg31BN1qhhQE
        /90PoE3W7Ej8u7Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 98258A3B8E;
        Thu,  2 Dec 2021 15:24:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 486C15191DF8; Thu,  2 Dec 2021 16:24:07 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/12] nvme-auth: Diffie-Hellman key exchange support
Date:   Thu,  2 Dec 2021 16:23:54 +0100
Message-Id: <20211202152358.60116-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211202152358.60116-1-hare@suse.de>
References: <20211202152358.60116-1-hare@suse.de>
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
 drivers/nvme/host/auth.c  | 412 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/auth.h  |   8 +
 3 files changed, 415 insertions(+), 6 deletions(-)

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
index 774085e4f400..e653ca90a531 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -22,6 +22,7 @@ struct nvme_dhchap_queue_context {
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
+	struct crypto_kpp *dh_tfm;
 	void *buf;
 	size_t buf_size;
 	int qid;
@@ -37,6 +38,12 @@ struct nvme_dhchap_queue_context {
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
 
 u32 nvme_auth_get_seqnum(void)
@@ -354,6 +361,218 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
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
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid)
+{
+	char *pkey;
+	int ret, pkey_len;
+
+	if (dh_gid == NVME_AUTH_DHGROUP_2048 ||
+	    dh_gid == NVME_AUTH_DHGROUP_3072 ||
+	    dh_gid == NVME_AUTH_DHGROUP_4096 ||
+	    dh_gid == NVME_AUTH_DHGROUP_6144 ||
+	    dh_gid == NVME_AUTH_DHGROUP_8192) {
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
+		pr_warn("invalid dh group %u\n", dh_gid);
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
 #define nvme_auth_flags_from_qid(qid) \
 	(qid == NVME_QID_ANY) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
@@ -479,6 +698,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_challenge_data *data = chap->buf;
 	u16 dhvlen = le16_to_cpu(data->dhvlen);
 	size_t size = sizeof(*data) + data->hl + dhvlen;
+	const char *gid_name = nvme_auth_dhgroup_name(data->dhgid);
 	const char *hmac_name, *kpp_name;
 
 	if (chap->buf_size < size) {
@@ -549,15 +769,54 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
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
+	    (data->dhgid == NVME_AUTH_DHGROUP_NULL || chap->dh_tfm)) {
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
 	if (data->dhgid != NVME_AUTH_DHGROUP_NULL) {
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
@@ -567,8 +826,21 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	}
 	chap->dhgroup_id = data->dhgid;
 
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
@@ -581,6 +853,9 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 
 	size += 2 * chap->hash_len;
 
+	if (chap->host_key_len)
+		size += chap->host_key_len;
+
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
@@ -591,7 +866,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
 	data->t_id = cpu_to_le16(chap->transaction);
 	data->hl = chap->hash_len;
-	data->dhvlen = 0;
+	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->opts->dhchap_ctrl_secret) {
 		get_random_bytes(chap->c2, chap->hash_len);
@@ -606,6 +881,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
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
+
 	return size;
 }
 
@@ -723,6 +1006,21 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		goto out;
 	}
 
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
@@ -785,6 +1083,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		goto out;
 	}
 
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
 	dev_dbg(ctrl->device, "%s: qid %d ctrl response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s2, chap->transaction);
 	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
@@ -857,8 +1169,82 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
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
 static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 {
+	kfree_sensitive(chap->host_response);
+	chap->host_response = NULL;
+	kfree_sensitive(chap->host_key);
+	chap->host_key = NULL;
+	chap->host_key_len = 0;
+	kfree_sensitive(chap->ctrl_key);
+	chap->ctrl_key = NULL;
+	chap->ctrl_key_len = 0;
+	kfree_sensitive(chap->sess_key);
+	chap->sess_key = NULL;
+	chap->sess_key_len = 0;
 	chap->status = 0;
 	chap->error = 0;
 	chap->s1 = 0;
@@ -872,6 +1258,11 @@ static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
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
@@ -929,6 +1320,15 @@ static void __nvme_auth_work(struct work_struct *work)
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
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
diff --git a/drivers/nvme/host/auth.h b/drivers/nvme/host/auth.h
index 2f39d17296d1..a266bd32147c 100644
--- a/drivers/nvme/host/auth.h
+++ b/drivers/nvme/host/auth.h
@@ -30,5 +30,13 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
+int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
+				  u8 *challenge, u8 *aug, size_t hlen);
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
+int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
+			 u8 *host_key, size_t host_key_len);
+int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
+				u8 *ctrl_key, size_t ctrl_key_len,
+				u8 *sess_key, size_t sess_key_len);
 
 #endif /* _NVME_AUTH_H */
-- 
2.29.2

