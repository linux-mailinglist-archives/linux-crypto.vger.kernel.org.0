Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9C52B8DD
	for <lists+linux-crypto@lfdr.de>; Wed, 18 May 2022 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiERLXH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 May 2022 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbiERLW7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 May 2022 07:22:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F215A774
        for <linux-crypto@vger.kernel.org>; Wed, 18 May 2022 04:22:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 646DD1F9A4;
        Wed, 18 May 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652872973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksmPwJFkKognP22EEo3xP0hyEO5MzFwqpnRSkU1qjhQ=;
        b=0VBdZJDL8G7H81E0ZizDyyl8e+uBhzJPGym4wkrFjq8jhFuMEp7HHrTG4bTeirKZ40wSdE
        LsxsZOjb+pRKOsbrg9MOotpXa0xW/un7XZB8CimhEzAspQUvZpdD9pyNsl151D3x+AoDOj
        SGfBxZdCkbDSlTJ9bf/Mx8qXfEgKwoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652872973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksmPwJFkKognP22EEo3xP0hyEO5MzFwqpnRSkU1qjhQ=;
        b=uOV+gVrBu1qWHmdw+RD/N/+IU9Nxv4l9pzoU5XheuqR60TOPuBGmRCIA6lQnX+QsZk8SOK
        HhSN19s5jo7scVAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5E7732C14F;
        Wed, 18 May 2022 11:22:53 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id AEA5F5194519; Wed, 18 May 2022 13:22:52 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/11] nvmet-auth: Diffie-Hellman key exchange support
Date:   Wed, 18 May 2022 13:22:33 +0200
Message-Id: <20220518112234.24264-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220518112234.24264-1-hare@suse.de>
References: <20220518112234.24264-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/nvme/target/auth.c             | 157 +++++++++++++++++++++++++
 drivers/nvme/target/configfs.c         |  31 +++++
 drivers/nvme/target/fabrics-cmd-auth.c |  43 +++++--
 drivers/nvme/target/nvmet.h            |   9 ++
 5 files changed, 233 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index e569319be679..8dd6c9541501 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -91,6 +91,7 @@ config NVME_TARGET_AUTH
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
+	select CRYPTO_DH_GROUPS_RFC7919
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 003c0faad7ff..71e13d7eb511 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -54,6 +54,74 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
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
+		pr_debug("%s: ctrl %d setup DH group %d\n",
+			 __func__, ctrl->cntlid, ctrl->dh_gid);
+		ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
+		if (ret < 0) {
+			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
+				 __func__, ctrl->cntlid, ret);
+			kfree_sensitive(ctrl->dh_key);
+			return ret;
+		}
+		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
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
@@ -81,6 +149,10 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
+	if (ret < 0)
+		pr_warn("Failed to setup DH group");
+
 	if (!host->dhchap_secret) {
 		pr_debug("No authentication provided\n");
 		goto out_unlock;
@@ -158,6 +230,14 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
@@ -218,6 +298,21 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	if (ret)
 		goto out_free_response;
 
+	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
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
+	}
+
 	pr_debug("ctrl %d qid %d host response seq %u transaction %d\n",
 		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
 		 req->sq->dhchap_tid);
@@ -315,6 +410,21 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	if (ret)
 		goto out_free_response;
 
+	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
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
+	}
+
 	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(shash_tfm),
 			GFP_KERNEL);
 	if (!shash) {
@@ -365,3 +475,50 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
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
+	req->sq->dhchap_skey_len = ctrl->dh_keysize;
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
index c4200a12655c..e600bc281a42 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1746,10 +1746,41 @@ static ssize_t nvmet_host_dhchap_hash_store(struct config_item *item,
 
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
index 2a0fd2a400f2..3156b052da4d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -24,7 +24,7 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
-	int i, hash_id = 0, fallback_hash_id = 0, dhgid;
+	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
 
 	pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
@@ -66,22 +66,35 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	}
 
 	dhgid = -1;
+	fallback_dhgid = -1;
 	for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
 		int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
 
-		if (tmp_dhgid == NVME_AUTH_DHGROUP_NULL) {
+		if (tmp_dhgid != ctrl->dh_gid) {
 			dhgid = tmp_dhgid;
 			break;
 		}
+		if (fallback_dhgid < 0) {
+			const char *kpp = nvme_auth_dhgroup_kpp(tmp_dhgid);
+
+			if (crypto_has_kpp(kpp, 0, 0))
+				fallback_dhgid = tmp_dhgid;
+		}
 	}
 	if (dhgid < 0) {
-		pr_debug("%s: ctrl %d qid %d: no usable DH group found\n",
+		if (fallback_dhgid < 0) {
+			pr_debug("%s: ctrl %d qid %d: no usable DH group found\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
-		return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		}
+		pr_debug("%s: ctrl %d qid %d: configured DH group %s not found\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 nvme_auth_dhgroup_name(fallback_dhgid));
+		ctrl->dh_gid = fallback_dhgid;
 	}
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
-		 nvme_auth_dhgroup_name(dhgid), dhgid);
+		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
 	return 0;
 }
 
@@ -97,7 +110,11 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
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
@@ -325,6 +342,8 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
 	int data_size = sizeof(*d) + hash_len;
 
+	if (ctrl->dh_tfm)
+		data_size += ctrl->dh_keysize;
 	if (al < data_size) {
 		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
 			 al, data_size);
@@ -343,9 +362,15 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 		return -ENOMEM;
 	get_random_bytes(req->sq->dhchap_c1, data->hl);
 	memcpy(data->cval, req->sq->dhchap_c1, data->hl);
-	pr_debug("%s: ctrl %d qid %d seq %u transaction %d hl %d dhvlen %u\n",
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
 
@@ -463,6 +488,8 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 			break;
 		}
 		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2;
+		if (!ctrl->ctrl_key)
+			req->sq->authenticated = true;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE1:
 		nvmet_auth_failure1(req, d, al);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 765db7541a87..8b239aec3ca2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -225,6 +225,10 @@ struct nvmet_ctrl {
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
 	u8			shash_id;
+	struct crypto_kpp	*dh_tfm;
+	u8			dh_gid;
+	u8			*dh_key;
+	size_t			dh_keysize;
 #endif
 };
 
@@ -701,6 +705,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
@@ -710,6 +715,10 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
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
-- 
2.29.2

