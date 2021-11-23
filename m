Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F945A2C9
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Nov 2021 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhKWMl3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 23 Nov 2021 07:41:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhKWMlY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 23 Nov 2021 07:41:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4726821910;
        Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637671094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ouwmiSkQ3BKYJuKYVDcXroIaYP0LlYePTPBRtrm4e8=;
        b=tfHWoCdHjEJU6Sf97eXDbb+1sxL2gcV9BmBiA4Aa58BOzRQeCcM6EYO9G0OD00+bERPXSS
        cIKbATbwcqFxF0629stJUkO1Mqwt59vQal306o7DEEZCJzARY8GJZOsfzGkuGZFKFJ+CMk
        SHmNCKnLpuKw6uy+mwGPmH5vi4lCafs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637671094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ouwmiSkQ3BKYJuKYVDcXroIaYP0LlYePTPBRtrm4e8=;
        b=HGScYbdtsJcn0viGm0ByvSAfHY/CHGX7SsuMm4TC0zr5Xb00t1RC9lJh9Vaerbb/VQft9H
        PscdW1Mti0MXmkCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 40496A3B95;
        Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D11B951918D0; Tue, 23 Nov 2021 13:38:12 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.org>,
        linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/12] nvmet-auth: Diffie-Hellman key exchange support
Date:   Tue, 23 Nov 2021 13:38:00 +0100
Message-Id: <20211123123801.73197-12-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123123801.73197-1-hare@suse.de>
References: <20211123123801.73197-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Implement Diffie-Hellman key exchange using FFDHE groups for NVMe
In-Band Authentication.
This patch adds a new host configfs attribute 'dhchap_dhgroup' to
select the FFDHE group to use.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/Kconfig            |   1 +
 drivers/nvme/target/auth.c             | 153 ++++++++++++++++++++++++-
 drivers/nvme/target/configfs.c         |  31 +++++
 drivers/nvme/target/fabrics-cmd-auth.c |  21 +++-
 drivers/nvme/target/nvmet.h            |  12 +-
 5 files changed, 207 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index e569319be679..0aceb8f7cedf 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -91,6 +91,7 @@ config NVME_TARGET_AUTH
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
+	select CRYPTO_FFDHE
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ed82231fc978..ffab835cff7e 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -54,6 +54,71 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	return 0;
 }
 
+int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
+{
+	const char *dhgroup_kpp;
+	int ret = 0;
+
+	pr_debug("%s: ctrl %d selecting dhgroup %d\n",
+		 __func__, ctrl->cntlid, dhgroup_id);
+
+	if (ctrl->dh_tfm) {
+		if (ctrl->dh_gid == dhgroup_id) {
+			pr_debug("%s: ctrl %d reuse existing DH group %d\n",
+				 __func__, ctrl->cntlid, dhgroup_id);
+			return 0;
+		}
+		crypto_free_kpp(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+		ctrl->dh_gid = 0;
+	}
+
+	if (dhgroup_id == NVME_AUTH_DHGROUP_NULL)
+		return 0;
+
+	dhgroup_kpp = nvme_auth_dhgroup_kpp(dhgroup_id);
+	if (!dhgroup_kpp) {
+		pr_debug("%s: ctrl %d invalid DH group %d\n",
+			 __func__, ctrl->cntlid, dhgroup_id);
+		return -EINVAL;
+	}
+	ctrl->dh_tfm = crypto_alloc_kpp(dhgroup_kpp, 0, 0);
+	if (IS_ERR(ctrl->dh_tfm)) {
+		pr_debug("%s: ctrl %d failed to setup DH group %d, err %ld\n",
+			 __func__, ctrl->cntlid, dhgroup_id,
+			 PTR_ERR(ctrl->dh_tfm));
+		ret = PTR_ERR(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+		ctrl->dh_gid = 0;
+	} else {
+		ctrl->dh_gid = dhgroup_id;
+		ctrl->dh_keysize = nvme_auth_dhgroup_pubkey_size(dhgroup_id);
+		pr_debug("%s: ctrl %d setup DH group %d\n",
+			 __func__, ctrl->cntlid, ctrl->dh_gid);
+		ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
+		if (ret < 0)
+			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
+				 __func__, ctrl->cntlid, ret);
+		kfree_sensitive(ctrl->dh_key);
+		ctrl->dh_key = kzalloc(ctrl->dh_keysize, GFP_KERNEL);
+		if (!ctrl->dh_key) {
+			pr_warn("ctrl %d failed to allocate public key\n",
+				ctrl->cntlid);
+			return -ENOMEM;
+		}
+		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
+					   ctrl->dh_keysize);
+		if (ret < 0) {
+			pr_warn("ctrl %d failed to generate public key\n",
+				ctrl->cntlid);
+			kfree(ctrl->dh_key);
+			ctrl->dh_key = NULL;
+		}
+	}
+
+	return ret;
+}
+
 int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	int ret = 0;
@@ -81,6 +146,10 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
+	if (ret < 0)
+		pr_warn("Failed to setup DH group");
+
 	if (!host->dhchap_secret) {
 		pr_debug("No authentication provided\n");
 		goto out_unlock;
@@ -160,6 +229,14 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 {
 	ctrl->shash_id = 0;
 
+	if (ctrl->dh_tfm) {
+		crypto_free_kpp(ctrl->dh_tfm);
+		ctrl->dh_tfm = NULL;
+		ctrl->dh_gid = 0;
+	}
+	kfree_sensitive(ctrl->dh_key);
+	ctrl->dh_key = NULL;
+
 	if (ctrl->host_key) {
 		nvme_auth_free_key(ctrl->host_key);
 		ctrl->host_key = NULL;
@@ -221,8 +298,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_response;
 
 	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
-		ret = -ENOTSUPP;
-		goto out;
+		challenge = kmalloc(shash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out_free_response;
+		}
+		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+						    req->sq->dhchap_skey,
+						    req->sq->dhchap_skey_len,
+						    req->sq->dhchap_c1,
+						    challenge, shash_len);
+		if (ret)
+			goto out_free_response;
 	}
 
 	pr_debug("ctrl %d qid %d host response seq %d transaction %d\n",
@@ -323,8 +410,18 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_response;
 
 	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
-		ret = -ENOTSUPP;
-		goto out;
+		challenge = kmalloc(shash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out_free_response;
+		}
+		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
+						    req->sq->dhchap_skey,
+						    req->sq->dhchap_skey_len,
+						    req->sq->dhchap_c2,
+						    challenge, shash_len);
+		if (ret)
+			goto out_free_response;
 	}
 
 	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(shash_tfm),
@@ -377,3 +474,51 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	crypto_free_shash(shash_tfm);
 	return 0;
 }
+
+int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
+				u8 *buf, int buf_size)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int ret = 0;
+
+	if (!ctrl->dh_key) {
+		pr_warn("ctrl %d no DH public key!\n", ctrl->cntlid);
+		return -ENOKEY;
+	}
+	if (buf_size != ctrl->dh_keysize) {
+		pr_warn("ctrl %d DH public key size mismatch, need %lu is %d\n",
+			ctrl->cntlid, ctrl->dh_keysize, buf_size);
+		ret = -EINVAL;
+	} else {
+		memcpy(buf, ctrl->dh_key, buf_size);
+		pr_debug("%s: ctrl %d public key %*ph\n", __func__,
+			 ctrl->cntlid, (int)buf_size, buf);
+	}
+
+	return ret;
+}
+
+int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
+			    u8 *pkey, int pkey_size)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int ret;
+
+	req->sq->dhchap_skey_len =
+		nvme_auth_dhgroup_privkey_size(ctrl->dh_gid);
+	req->sq->dhchap_skey = kzalloc(req->sq->dhchap_skey_len, GFP_KERNEL);
+	if (!req->sq->dhchap_skey)
+		return -ENOMEM;
+	ret = nvme_auth_gen_shared_secret(ctrl->dh_tfm,
+					  pkey, pkey_size,
+					  req->sq->dhchap_skey,
+					  req->sq->dhchap_skey_len);
+	if (ret)
+		pr_debug("failed to compute shared secred, err %d\n", ret);
+	else
+		pr_debug("%s: shared secret %*ph\n", __func__,
+			 (int)req->sq->dhchap_skey_len,
+			 req->sq->dhchap_skey);
+
+	return ret;
+}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9fb52880aef5..59b575fa3c97 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1784,10 +1784,41 @@ static ssize_t nvmet_host_dhchap_hash_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_host_, dhchap_hash);
 
+static ssize_t nvmet_host_dhchap_dhgroup_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_host *host = to_host(item);
+	const char *dhgroup = nvme_auth_dhgroup_name(host->dhchap_dhgroup_id);
+
+	return sprintf(page, "%s\n", dhgroup ? dhgroup : "none");
+}
+
+static ssize_t nvmet_host_dhchap_dhgroup_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_host *host = to_host(item);
+	int dhgroup_id;
+
+	dhgroup_id = nvme_auth_dhgroup_id(page);
+	if (dhgroup_id == NVME_AUTH_DHGROUP_INVALID)
+		return -EINVAL;
+	if (dhgroup_id != NVME_AUTH_DHGROUP_NULL) {
+		const char *kpp = nvme_auth_dhgroup_kpp(dhgroup_id);
+
+		if (!crypto_has_kpp(kpp, 0, 0))
+			return -EINVAL;
+	}
+	host->dhchap_dhgroup_id = dhgroup_id;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
+
 static struct configfs_attribute *nvmet_host_attrs[] = {
 	&nvmet_host_attr_dhchap_key,
 	&nvmet_host_attr_dhchap_ctrl_key,
 	&nvmet_host_attr_dhchap_hash,
+	&nvmet_host_attr_dhchap_dhgroup,
 	NULL,
 };
 #endif /* CONFIG_NVME_TARGET_AUTH */
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 0f3e86491bb9..a7ff6f58eb93 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -61,7 +61,7 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		     data->auth_protocol[0].dhchap.dhlen; i++) {
 		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i];
 
-		if (tmp_dhgid == NVME_AUTH_DHGROUP_NULL) {
+		if (tmp_dhgid != ctrl->dh_gid) {
 			dhgid = tmp_dhgid;
 			break;
 		}
@@ -71,7 +71,6 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			 __func__, ctrl->cntlid, req->sq->qid);
 		return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
-	ctrl->dh_gid = dhgid;
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
@@ -90,7 +89,11 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		 data->hl, data->cvalid, dhvlen);
 
 	if (dhvlen) {
-		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		if (!ctrl->dh_tfm)
+			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,
+					    dhvlen) < 0)
+			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 	}
 
 	response = kmalloc(data->hl, GFP_KERNEL);
@@ -318,6 +321,8 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
 	int data_size = sizeof(*d) + hash_len;
 
+	if (ctrl->dh_tfm)
+		data_size += ctrl->dh_keysize;
 	if (al < data_size) {
 		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
 			 al, data_size);
@@ -336,9 +341,15 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 		return -ENOMEM;
 	get_random_bytes(req->sq->dhchap_c1, data->hl);
 	memcpy(data->cval, req->sq->dhchap_c1, data->hl);
-	pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %d\n",
+	if (ctrl->dh_tfm) {
+		data->dhgid = ctrl->dh_gid;
+		data->dhvlen = cpu_to_le32(ctrl->dh_keysize);
+		ret = nvmet_auth_ctrl_exponential(req, data->cval + data->hl,
+						  ctrl->dh_keysize);
+	}
+	pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %lu\n",
 		 __func__, ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
-		 req->sq->dhchap_tid, data->hl, 0);
+		 req->sq->dhchap_tid, data->hl, ctrl->dh_keysize);
 	return ret;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 95e78e2b258e..0cfed712cf8c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -226,7 +226,10 @@ struct nvmet_ctrl {
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
 	u8			shash_id;
-	u32			dh_gid;
+	struct crypto_kpp	*dh_tfm;
+	u8			dh_gid;
+	u8			*dh_key;
+	size_t			dh_keysize;
 #endif
 };
 
@@ -701,6 +704,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
@@ -710,6 +714,10 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
 {
 	return ctrl->host_key != NULL;
 }
+int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
+				u8 *buf, int buf_size);
+int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
+			    u8 *buf, int buf_size);
 #else
 static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
@@ -727,7 +735,7 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
 {
 	return false;
 }
-static inline const char *nvmet_dhchap_dhgroup_name(int dhgid) { return NULL; }
+static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
 #endif
 
 #endif /* _NVMET_H */
-- 
2.29.2

