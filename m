Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B53E5A36
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Aug 2021 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhHJMnW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Aug 2021 08:43:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbhHJMnP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Aug 2021 08:43:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 24FC72205F;
        Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628599372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs3N60EEoKxS9ARXt4TzfitpQtIwftipmUKKH0VH9Bk=;
        b=ljpHxsOQdOLI50gTeUINvn5XnTUoLFEHr2pCDA6iu4VV0Dhm1x30Zz72om4qMcSx21rDoc
        k5QsU+O81sQ4E9vAwrBNC9kt1e9rkoadHHC8u2mV3nKmx/Np47ZBayfjMlzcS4J58yqUwd
        nELyOD7NAmYnDbw1Wpwko22KUd/XPs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628599372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs3N60EEoKxS9ARXt4TzfitpQtIwftipmUKKH0VH9Bk=;
        b=dST8BTZI0zyoHDBA4DbZkHoQ8oErnsU1xmS/elcZM3+qEZ26MkLNuTjV0EyDxILhLxnyNp
        VXEXQ/4okhGNJxCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1C65FA3B93;
        Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8553D518C554; Tue, 10 Aug 2021 14:42:50 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/13] nvmet: Implement basic In-Band Authentication
Date:   Tue, 10 Aug 2021 14:42:27 +0200
Message-Id: <20210810124230.12161-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210810124230.12161-1-hare@suse.de>
References: <20210810124230.12161-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
This patch adds two additional configfs entries 'dhchap_key' and 'dhchap_hash'
to the 'host' configfs directory. The 'dhchap_key' needs to be
in the ASCII format as specified in NVMe 2.0 section 8.13.5.8 'Secret
representation'.
'dhchap_hash' is taken from the hash specified in the ASCII
representation of the key, or defaults to 'hmac(sha256)' if no
key transformation has been specified.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/Kconfig            |  10 +
 drivers/nvme/target/Makefile           |   1 +
 drivers/nvme/target/admin-cmd.c        |   4 +
 drivers/nvme/target/auth.c             | 301 ++++++++++++++++
 drivers/nvme/target/configfs.c         |  71 +++-
 drivers/nvme/target/core.c             |   8 +
 drivers/nvme/target/fabrics-cmd-auth.c | 464 +++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c      |  30 +-
 drivers/nvme/target/nvmet.h            |  63 ++++
 9 files changed, 949 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4be2ececbc45..d5656ef1559e 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -85,3 +85,13 @@ config NVME_TARGET_TCP
 	  devices over TCP.
 
 	  If unsure, say N.
+
+config NVME_TARGET_AUTH
+	bool "NVMe over Fabrics In-band Authentication support"
+	depends on NVME_TARGET
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	help
+	  This enables support for NVMe over Fabrics In-band Authentication
+
+	  If unsure, say N.
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 9837e580fa7e..c66820102493 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -13,6 +13,7 @@ nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
+nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0cb98f2bbc8c..320cefc64ee0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1008,6 +1008,10 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_cmd(req);
+
+	if (unlikely(!nvmet_check_auth_status(req)))
+		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+
 	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
 		return nvmet_parse_discovery_cmd(req);
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
new file mode 100644
index 000000000000..5b5f3cd4f914
--- /dev/null
+++ b/drivers/nvme/target/auth.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics DH-HMAC-CHAP authentication.
+ * Copyright (c) 2020 Hannes Reinecke, SUSE Software Solutions.
+ * All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <crypto/hash.h>
+#include <linux/crc32.h>
+#include <linux/base64.h>
+#include <linux/ctype.h>
+#include <linux/random.h>
+#include <asm/unaligned.h>
+
+#include "nvmet.h"
+#include "../host/auth.h"
+
+int nvmet_auth_set_host_key(struct nvmet_host *host, const char *secret)
+{
+	if (sscanf(secret, "DHHC-1:%hhd:%*s", &host->dhchap_key_hash) != 1)
+		return -EINVAL;
+	if (host->dhchap_key_hash > 3) {
+		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
+			 host->dhchap_key_hash);
+		return -EINVAL;
+	}
+	if (host->dhchap_key_hash > 0) {
+		/* Validate selected hash algorithm */
+		const char *hmac = nvme_auth_hmac_name(host->dhchap_key_hash);
+
+		if (!crypto_has_shash(hmac, 0, 0)) {
+			pr_err("DH-HMAC-CHAP hash %s unsupported\n", hmac);
+			host->dhchap_key_hash = -1;
+			return -ENOTSUPP;
+		}
+		/* Use this hash as default */
+		if (!host->dhchap_hash_id)
+			host->dhchap_hash_id = host->dhchap_key_hash;
+	}
+	host->dhchap_secret = kstrdup(secret, GFP_KERNEL);
+	if (!host->dhchap_secret)
+		return -ENOMEM;
+	/* Default to SHA256 */
+	if (!host->dhchap_hash_id)
+		host->dhchap_hash_id = NVME_AUTH_DHCHAP_SHA256;
+
+	pr_debug("Using hash %s\n",
+		 nvme_auth_hmac_name(host->dhchap_hash_id));
+	return 0;
+}
+
+int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+{
+	int ret = 0;
+	struct nvmet_host_link *p;
+	struct nvmet_host *host = NULL;
+	const char *hash_name;
+
+	down_read(&nvmet_config_sem);
+	if (ctrl->subsys->type == NVME_NQN_DISC)
+		goto out_unlock;
+
+	list_for_each_entry(p, &ctrl->subsys->hosts, entry) {
+		pr_debug("check %s\n", nvmet_host_name(p->host));
+		if (strcmp(nvmet_host_name(p->host), ctrl->hostnqn))
+			continue;
+		host = p->host;
+		break;
+	}
+	if (!host) {
+		pr_debug("host %s not found\n", ctrl->hostnqn);
+		ret = -EPERM;
+		goto out_unlock;
+	}
+	if (!host->dhchap_secret) {
+		pr_debug("No authentication provided\n");
+		goto out_unlock;
+	}
+	if (ctrl->shash_tfm &&
+	    host->dhchap_hash_id == ctrl->shash_id) {
+		pr_debug("Re-use existing hash ID %d\n",
+			 ctrl->shash_id);
+		ret = 0;
+		goto out_unlock;
+	}
+	hash_name = nvme_auth_hmac_name(host->dhchap_hash_id);
+	if (!hash_name) {
+		pr_warn("Hash ID %d invalid\n", host->dhchap_hash_id);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	ctrl->shash_tfm = crypto_alloc_shash(hash_name, 0,
+					     CRYPTO_ALG_ALLOCATES_MEMORY);
+	if (IS_ERR(ctrl->shash_tfm)) {
+		pr_err("failed to allocate shash %s\n", hash_name);
+		ret = PTR_ERR(ctrl->shash_tfm);
+		ctrl->shash_tfm = NULL;
+		goto out_unlock;
+	}
+	ctrl->shash_id = host->dhchap_hash_id;
+
+	/* Skip the 'DHHC-1:XX:' prefix */
+	ctrl->dhchap_key = nvme_auth_extract_secret(host->dhchap_secret + 10,
+						    &ctrl->dhchap_key_len);
+	if (IS_ERR(ctrl->dhchap_key)) {
+		pr_debug("failed to extract host key, error %d\n", ret);
+		ret = PTR_ERR(ctrl->dhchap_key);
+		ctrl->dhchap_key = NULL;
+		goto out_free_hash;
+	}
+	pr_debug("%s: using key %*ph\n", __func__,
+		 (int)ctrl->dhchap_key_len, ctrl->dhchap_key);
+out_free_hash:
+	if (ret) {
+		if (ctrl->dhchap_key) {
+			kfree_sensitive(ctrl->dhchap_key);
+			ctrl->dhchap_key = NULL;
+		}
+		crypto_free_shash(ctrl->shash_tfm);
+		ctrl->shash_tfm = NULL;
+		ctrl->shash_id = 0;
+	}
+out_unlock:
+	up_read(&nvmet_config_sem);
+
+	return ret;
+}
+
+void nvmet_auth_sq_free(struct nvmet_sq *sq)
+{
+	kfree(sq->dhchap_c1);
+	sq->dhchap_c1 = NULL;
+	kfree(sq->dhchap_c2);
+	sq->dhchap_c2 = NULL;
+	kfree(sq->dhchap_skey);
+	sq->dhchap_skey = NULL;
+}
+
+void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
+{
+	if (ctrl->shash_tfm) {
+		crypto_free_shash(ctrl->shash_tfm);
+		ctrl->shash_tfm = NULL;
+		ctrl->shash_id = 0;
+	}
+	if (ctrl->dhchap_key) {
+		kfree(ctrl->dhchap_key);
+		ctrl->dhchap_key = NULL;
+	}
+}
+
+bool nvmet_check_auth_status(struct nvmet_req *req)
+{
+	if (req->sq->ctrl->shash_tfm &&
+	    !req->sq->authenticated)
+		return false;
+	return true;
+}
+
+int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
+			 unsigned int shash_len)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	SHASH_DESC_ON_STACK(shash, ctrl->shash_tfm);
+	u8 *challenge = req->sq->dhchap_c1, *host_response;
+	u8 buf[4];
+	int ret;
+
+	host_response = nvme_auth_transform_key(ctrl->dhchap_key,
+				shash_len, ctrl->shash_id,
+				ctrl->hostnqn);
+	if (IS_ERR(host_response))
+		return PTR_ERR(host_response);
+
+	ret = crypto_shash_setkey(ctrl->shash_tfm, host_response, shash_len);
+	if (ret) {
+		kfree_sensitive(host_response);
+		return ret;
+	}
+	if (ctrl->dh_gid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	shash->tfm = ctrl->shash_tfm;
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, challenge, shash_len);
+	if (ret)
+		goto out;
+	put_unaligned_le32(req->sq->dhchap_s1, buf);
+	ret = crypto_shash_update(shash, buf, 4);
+	if (ret)
+		goto out;
+	put_unaligned_le16(req->sq->dhchap_tid, buf);
+	ret = crypto_shash_update(shash, buf, 2);
+	if (ret)
+		goto out;
+	memset(buf, 0, 4);
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, "HostHost", 8);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->subsysnqn,
+				  strlen(ctrl->subsysnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_final(shash, response);
+out:
+	if (challenge != req->sq->dhchap_c1)
+		kfree(challenge);
+	kfree_sensitive(host_response);
+	return 0;
+}
+
+int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
+			 unsigned int shash_len)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	SHASH_DESC_ON_STACK(shash, ctrl->shash_tfm);
+	u8 *challenge = req->sq->dhchap_c2, *ctrl_response;
+	u8 buf[4];
+	int ret;
+
+	pr_debug("%s: ctrl %d hash seq %d transaction %u\n", __func__,
+		 ctrl->cntlid, req->sq->dhchap_s2, req->sq->dhchap_tid);
+	pr_debug("%s: ctrl %d challenge %*ph\n", __func__,
+		 ctrl->cntlid, shash_len, req->sq->dhchap_c2);
+	pr_debug("%s: ctrl %d subsysnqn %s\n", __func__,
+		 ctrl->cntlid, ctrl->subsysnqn);
+	pr_debug("%s: ctrl %d hostnqn %s\n", __func__,
+		 ctrl->cntlid, ctrl->hostnqn);
+
+	ctrl_response = nvme_auth_transform_key(ctrl->dhchap_key,
+				shash_len, ctrl->shash_id,
+				ctrl->subsysnqn);
+	if (IS_ERR(ctrl_response))
+		return PTR_ERR(ctrl_response);
+
+	ret = crypto_shash_setkey(ctrl->shash_tfm, ctrl_response, shash_len);
+	if (ret) {
+		kfree_sensitive(ctrl_response);
+		return ret;
+	}
+	if (ctrl->dh_gid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
+		ret = -ENOTSUPP;
+		goto out;
+	}
+
+	shash->tfm = ctrl->shash_tfm;
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, challenge, shash_len);
+	if (ret)
+		goto out;
+	put_unaligned_le32(req->sq->dhchap_s2, buf);
+	ret = crypto_shash_update(shash, buf, 4);
+	if (ret)
+		goto out;
+	put_unaligned_le16(req->sq->dhchap_tid, buf);
+	ret = crypto_shash_update(shash, buf, 2);
+	if (ret)
+		goto out;
+	memset(buf, 0, 4);
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, "Controller", 10);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->subsysnqn,
+			    strlen(ctrl->subsysnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_final(shash, response);
+out:
+	if (challenge != req->sq->dhchap_c2)
+		kfree(challenge);
+	kfree_sensitive(ctrl_response);
+	return 0;
+}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 273555127188..e0760911a761 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -11,8 +11,13 @@
 #include <linux/ctype.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
 
 #include "nvmet.h"
+#ifdef CONFIG_NVME_TARGET_AUTH
+#include "../host/auth.h"
+#endif
 
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
@@ -1656,10 +1661,71 @@ static const struct config_item_type nvmet_ports_type = {
 static struct config_group nvmet_subsystems_group;
 static struct config_group nvmet_ports_group;
 
-static void nvmet_host_release(struct config_item *item)
+#ifdef CONFIG_NVME_TARGET_AUTH
+static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
+		char *page)
+{
+	u8 *dhchap_secret = to_host(item)->dhchap_secret;
+
+	if (!dhchap_secret)
+		return sprintf(page, "\n");
+	return sprintf(page, "%s\n", dhchap_secret);
+}
+
+static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
+		const char *page, size_t count)
 {
 	struct nvmet_host *host = to_host(item);
+	int ret;
 
+	ret = nvmet_auth_set_host_key(host, page);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_key);
+
+static ssize_t nvmet_host_dhchap_hash_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_host *host = to_host(item);
+	const char *hash_name = nvme_auth_hmac_name(host->dhchap_hash_id);
+
+	return sprintf(page, "%s\n", hash_name ? hash_name : "none");
+}
+
+static ssize_t nvmet_host_dhchap_hash_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_host *host = to_host(item);
+	int hmac_id;
+
+	hmac_id = nvme_auth_hmac_id(page);
+	if (hmac_id < 0)
+		return -EINVAL;
+	if (!crypto_has_shash(nvme_auth_hmac_name(hmac_id), 0, 0))
+		return -ENOTSUPP;
+	host->dhchap_hash_id = hmac_id;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_host_, dhchap_hash);
+
+static struct configfs_attribute *nvmet_host_attrs[] = {
+	&nvmet_host_attr_dhchap_key,
+	&nvmet_host_attr_dhchap_hash,
+	NULL,
+};
+#endif /* CONFIG_NVME_TARGET_AUTH */
+
+static void nvmet_host_release(struct config_item *item)
+{
+	struct nvmet_host *host = to_host(item);
+#ifdef CONFIG_NVME_TARGET_AUTH
+	if (host->dhchap_secret)
+		kfree(host->dhchap_secret);
+#endif
 	kfree(host);
 }
 
@@ -1669,6 +1735,9 @@ static struct configfs_item_operations nvmet_host_item_ops = {
 
 static const struct config_item_type nvmet_host_type = {
 	.ct_item_ops		= &nvmet_host_item_ops,
+#ifdef CONFIG_NVME_TARGET_AUTH
+	.ct_attrs		= nvmet_host_attrs,
+#endif
 	.ct_owner		= THIS_MODULE,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 163f7dc1a929..41ddf1087129 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -793,6 +793,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
+	nvmet_auth_sq_free(sq);
 
 	if (ctrl) {
 		/*
@@ -1264,6 +1265,11 @@ u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 		       req->cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
+
+	if (unlikely(!nvmet_check_auth_status(req))) {
+		pr_warn("qid %d not authenticated\n", req->sq->qid);
+		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+	}
 	return 0;
 }
 
@@ -1456,6 +1462,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
+	nvmet_destroy_auth(ctrl);
+
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
new file mode 100644
index 000000000000..ab9dfc06bac0
--- /dev/null
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics DH-HMAC-CHAP authentication command handling.
+ * Copyright (c) 2020 Hannes Reinecke, SUSE Software Solutions.
+ * All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blkdev.h>
+#include <linux/random.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+#include "nvmet.h"
+#include "../host/auth.h"
+
+void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
+{
+	/* Initialize in-band authentication */
+	req->sq->authenticated = false;
+	req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+	req->cqe->result.u32 |= 0x2 << 16;
+}
+
+static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmf_auth_dhchap_negotiate_data *data = d;
+	int i, hash_id, null_dh = -1;
+
+	pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
+		 __func__, ctrl->cntlid, req->sq->qid,
+		 data->sc_c, data->napd, data->auth_protocol[0].dhchap.authid,
+		 data->auth_protocol[0].dhchap.halen,
+		 data->auth_protocol[0].dhchap.dhlen);
+	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
+	if (data->sc_c)
+		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+
+	if (data->napd != 1)
+		return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+
+	if (data->auth_protocol[0].dhchap.authid !=
+	    NVME_AUTH_DHCHAP_AUTH_ID)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	hash_id = 0;
+	for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
+		if (ctrl->shash_id != data->auth_protocol[0].dhchap.idlist[i])
+			continue;
+		hash_id = ctrl->shash_id;
+		break;
+	}
+	if (hash_id == 0) {
+		pr_debug("%s: ctrl %d qid %d: no usable hash found\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+	}
+
+	for (i = data->auth_protocol[0].dhchap.halen;
+	     i < data->auth_protocol[0].dhchap.halen +
+		     data->auth_protocol[0].dhchap.dhlen; i++) {
+		int dhgid = data->auth_protocol[0].dhchap.idlist[i];
+
+		if (dhgid == NVME_AUTH_DHCHAP_DHGROUP_NULL) {
+			null_dh = dhgid;
+			continue;
+		}
+	}
+	if (null_dh < 0) {
+		pr_debug("%s: ctrl %d qid %d: no DH group selected\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+	}
+	ctrl->dh_gid = null_dh;
+	pr_debug("%s: ctrl %d qid %d: DH group %s (%d)\n",
+		 __func__, ctrl->cntlid, req->sq->qid,
+		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
+	return 0;
+}
+
+static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmf_auth_dhchap_reply_data *data = d;
+	int hash_len = crypto_shash_digestsize(ctrl->shash_tfm);
+	u8 *response;
+
+	pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %d\n",
+		 __func__, ctrl->cntlid, req->sq->qid,
+		 data->hl, data->cvalid, data->dhvlen);
+	if (data->hl != hash_len)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	if (data->dhvlen) {
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+	}
+
+	response = kmalloc(data->hl, GFP_KERNEL);
+	if (!response)
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+
+	if (nvmet_auth_host_hash(req, response, data->hl) < 0) {
+		pr_debug("ctrl %d qid %d DH-HMAC-CHAP hash failed\n",
+			 ctrl->cntlid, req->sq->qid);
+		kfree(response);
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+	}
+
+	if (memcmp(data->rval, response, data->hl)) {
+		pr_info("ctrl %d qid %d DH-HMAC-CHAP response mismatch\n",
+			ctrl->cntlid, req->sq->qid);
+		kfree(response);
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+	}
+	kfree(response);
+	pr_info("ctrl %d qid %d DH-HMAC-CHAP host authenticated\n",
+		ctrl->cntlid, req->sq->qid);
+	if (data->cvalid) {
+		req->sq->dhchap_c2 = kmalloc(data->hl, GFP_KERNEL);
+		if (!req->sq->dhchap_c2)
+			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		memcpy(req->sq->dhchap_c2, data->rval + data->hl, data->hl);
+
+		pr_debug("ctrl %d qid %d challenge %*ph\n",
+			 ctrl->cntlid, req->sq->qid, data->hl,
+			 req->sq->dhchap_c2);
+		req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
+	} else
+		req->sq->dhchap_c2 = NULL;
+
+	return 0;
+}
+
+static u16 nvmet_auth_failure2(struct nvmet_req *req, void *d)
+{
+	struct nvmf_auth_dhchap_failure_data *data = d;
+
+	return data->rescode_exp;
+}
+
+void nvmet_execute_auth_send(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmf_auth_dhchap_success2_data *data;
+	void *d;
+	u32 tl;
+	u16 status = 0;
+
+	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_send_command, secp);
+		goto done;
+	}
+	if (req->cmd->auth_send.spsp0 != 0x01) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_send_command, spsp0);
+		goto done;
+	}
+	if (req->cmd->auth_send.spsp1 != 0x01) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_send_command, spsp1);
+		goto done;
+	}
+	tl = le32_to_cpu(req->cmd->auth_send.tl);
+	if (!tl) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_send_command, tl);
+		goto done;
+	}
+	if (!nvmet_check_transfer_len(req, tl)) {
+		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
+		return;
+	}
+
+	d = kmalloc(tl, GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto done;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, tl);
+	if (status) {
+		kfree(d);
+		goto done;
+	}
+
+	data = d;
+	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
+		 ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
+		 req->sq->dhchap_step);
+	if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
+	    data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
+		goto done_failure1;
+	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
+		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
+			/* Restart negotiation */
+			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
+				 ctrl->cntlid, req->sq->qid);
+			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+		} else if (data->auth_id != req->sq->dhchap_step)
+			goto done_failure1;
+		/* Validate negotiation parameters */
+		status = nvmet_auth_negotiate(req, d);
+		if (status == 0)
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
+		else {
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+			req->sq->dhchap_status = status;
+			status = 0;
+		}
+		goto done_kfree;
+	}
+	if (data->auth_id != req->sq->dhchap_step) {
+		pr_debug("%s: ctrl %d qid %d step mismatch (%d != %d)\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 data->auth_id, req->sq->dhchap_step);
+		goto done_failure1;
+	}
+	if (le16_to_cpu(data->t_id) != req->sq->dhchap_tid) {
+		pr_debug("%s: ctrl %d qid %d invalid transaction %d (expected %d)\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 le16_to_cpu(data->t_id),
+			 req->sq->dhchap_tid);
+		req->sq->dhchap_step =
+			NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+		req->sq->dhchap_status =
+			NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		goto done_kfree;
+	}
+	switch (data->auth_id) {
+	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
+		status = nvmet_auth_reply(req, d);
+		if (status == 0)
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
+		else {
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+			req->sq->dhchap_status = status;
+			status = 0;
+		}
+		goto done_kfree;
+		break;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
+		req->sq->authenticated = true;
+		pr_debug("%s: ctrl %d qid %d authenticated\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		goto done_kfree;
+		break;
+	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
+		status = nvmet_auth_failure2(req, d);
+		if (status) {
+			pr_warn("ctrl %d qid %d: authentication failed (%d)\n",
+				ctrl->cntlid, req->sq->qid, status);
+			req->sq->dhchap_status = status;
+			status = 0;
+		}
+		goto done_kfree;
+		break;
+	default:
+		req->sq->dhchap_status =
+			NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
+		req->sq->dhchap_step =
+			NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
+		goto done_kfree;
+		break;
+	}
+done_failure1:
+	req->sq->dhchap_status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
+	req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
+
+done_kfree:
+	kfree(d);
+done:
+	pr_debug("%s: ctrl %d qid %d dhchap status %x step %x\n", __func__,
+		 ctrl->cntlid, req->sq->qid,
+		 req->sq->dhchap_status, req->sq->dhchap_step);
+	if (status)
+		pr_debug("%s: ctrl %d qid %d nvme status %x error loc %d\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 status, req->error_loc);
+	req->cqe->result.u64 = 0;
+	nvmet_req_complete(req, status);
+	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
+	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+		return;
+	/* Final states, clear up variables */
+	nvmet_auth_sq_free(req->sq);
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
+		nvmet_ctrl_fatal_error(ctrl);
+}
+
+static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
+{
+	struct nvmf_auth_dhchap_challenge_data *data = d;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int ret = 0;
+	int hash_len = crypto_shash_digestsize(ctrl->shash_tfm);
+	int data_size = sizeof(*d) + hash_len;
+
+	if (al < data_size) {
+		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
+			 al, data_size);
+		return -EINVAL;
+	}
+	memset(data, 0, data_size);
+	req->sq->dhchap_s1 = ctrl->dhchap_seqnum++;
+	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
+	data->t_id = cpu_to_le16(req->sq->dhchap_tid);
+	data->hashid = ctrl->shash_id;
+	data->hl = hash_len;
+	data->seqnum = cpu_to_le32(req->sq->dhchap_s1);
+	req->sq->dhchap_c1 = kmalloc(data->hl, GFP_KERNEL);
+	if (!req->sq->dhchap_c1)
+		return -ENOMEM;
+	get_random_bytes(req->sq->dhchap_c1, data->hl);
+	memcpy(data->cval, req->sq->dhchap_c1, data->hl);
+	pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %d\n",
+		 __func__, ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
+		 req->sq->dhchap_tid, data->hl, data->dhvlen);
+	return ret;
+}
+
+static int nvmet_auth_success1(struct nvmet_req *req, void *d, int al)
+{
+	struct nvmf_auth_dhchap_success1_data *data = d;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	int hash_len = crypto_shash_digestsize(ctrl->shash_tfm);
+
+	WARN_ON(al < sizeof(*data));
+	memset(data, 0, sizeof(*data));
+	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
+	data->t_id = cpu_to_le16(req->sq->dhchap_tid);
+	data->hl = hash_len;
+	if (req->sq->dhchap_c2) {
+		if (nvmet_auth_ctrl_hash(req, data->rval, data->hl))
+			return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+		data->rvalid = 1;
+		pr_debug("ctrl %d qid %d response %*ph\n",
+			 ctrl->cntlid, req->sq->qid, data->hl, data->rval);
+	}
+	return 0;
+}
+
+static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
+{
+	struct nvmf_auth_dhchap_failure_data *data = d;
+
+	WARN_ON(al < sizeof(*data));
+	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+	data->t_id = cpu_to_le32(req->sq->dhchap_tid);
+	data->rescode = NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED;
+	data->rescode_exp = req->sq->dhchap_status;
+}
+
+void nvmet_execute_auth_receive(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	void *d;
+	u32 al;
+	u16 status = 0;
+
+	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, secp);
+		goto done;
+	}
+	if (req->cmd->auth_receive.spsp0 != 0x01) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, spsp0);
+		goto done;
+	}
+	if (req->cmd->auth_receive.spsp1 != 0x01) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, spsp1);
+		goto done;
+	}
+	al = le32_to_cpu(req->cmd->auth_receive.al);
+	if (!al) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, al);
+		goto done;
+	}
+	if (!nvmet_check_transfer_len(req, al)) {
+		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
+		return;
+	}
+
+	d = kmalloc(al, GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto done;
+	}
+	pr_debug("%s: ctrl %d qid %d step %x\n", __func__,
+		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_step);
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		status = nvmet_auth_challenge(req, d, al);
+		if (status < 0) {
+			pr_warn("ctrl %d qid %d: challenge error (%d)\n",
+				ctrl->cntlid, req->sq->qid, status);
+			status = NVME_SC_INTERNAL;
+			break;
+		}
+		if (status) {
+			req->sq->dhchap_status = status;
+			nvmet_auth_failure1(req, d, al);
+			pr_warn("ctrl %d qid %d: challenge status (%x)\n",
+				ctrl->cntlid, req->sq->qid,
+				req->sq->dhchap_status);
+			status = 0;
+			break;
+		}
+		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
+		break;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		status = nvmet_auth_success1(req, d, al);
+		if (status) {
+			req->sq->dhchap_status = status;
+			nvmet_auth_failure1(req, d, al);
+			pr_warn("ctrl %d qid %d: success1 status (%x)\n",
+				ctrl->cntlid, req->sq->qid,
+				req->sq->dhchap_status);
+			break;
+		}
+		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2;
+		break;
+	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE1:
+		nvmet_auth_failure1(req, d, al);
+		pr_warn("ctrl %d qid %d failure1 (%x)\n",
+			ctrl->cntlid, req->sq->qid, req->sq->dhchap_status);
+		break;
+	default:
+		pr_warn("ctrl %d qid %d unhandled step (%d)\n",
+			ctrl->cntlid, req->sq->qid, req->sq->dhchap_step);
+		req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+		req->sq->dhchap_status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		nvmet_auth_failure1(req, d, al);
+		status = 0;
+		break;
+	}
+
+	status = nvmet_copy_to_sgl(req, 0, d, al);
+	kfree(d);
+done:
+	req->cqe->result.u64 = 0;
+	nvmet_req_complete(req, status);
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+		nvmet_auth_sq_free(req->sq);
+		nvmet_ctrl_fatal_error(ctrl);
+	}
+}
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..d2dc4d3bc3e5 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -93,6 +93,14 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 	case nvme_fabrics_type_property_get:
 		req->execute = nvmet_execute_prop_get;
 		break;
+#ifdef CONFIG_NVME_TARGET_AUTH
+	case nvme_fabrics_type_auth_send:
+		req->execute = nvmet_execute_auth_send;
+		break;
+	case nvme_fabrics_type_auth_receive:
+		req->execute = nvmet_execute_auth_receive;
+		break;
+#endif
 	default:
 		pr_debug("received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
@@ -155,6 +163,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
+	int ret;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
@@ -197,17 +206,31 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
+	ret = nvmet_setup_auth(ctrl);
+	if (ret < 0) {
+		pr_err("Failed to setup authentication, error %d\n", ret);
+		nvmet_ctrl_put(ctrl);
+		if (ret == -EPERM)
+			status = (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR);
+		else
+			status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
 		nvmet_ctrl_put(ctrl);
 		goto out;
 	}
 
-	pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
+	pr_info("creating controller %d for subsystem %s for NQN %s%s%s.\n",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
-		ctrl->pi_support ? " T10-PI is enabled" : "");
+		ctrl->pi_support ? " T10-PI is enabled" : "",
+		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
+	if (nvmet_has_auth(ctrl))
+		nvmet_init_auth(ctrl, req);
 out:
 	kfree(d);
 complete:
@@ -267,6 +290,9 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	}
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
+	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
+	if (nvmet_has_auth(ctrl))
+		nvmet_init_auth(ctrl, req);
 
 out:
 	kfree(d);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 06dd3d537f07..adcbe2523710 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -108,6 +108,18 @@ struct nvmet_sq {
 	u16			size;
 	u32			sqhd;
 	bool			sqhd_disabled;
+#ifdef CONFIG_NVME_TARGET_AUTH
+	bool			authenticated;
+	u16			dhchap_tid;
+	u16			dhchap_status;
+	int			dhchap_step;
+	u8			*dhchap_c1;
+	u8			*dhchap_c2;
+	u32			dhchap_s1;
+	u32			dhchap_s2;
+	u8			*dhchap_skey;
+	int			dhchap_skey_len;
+#endif
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
@@ -209,6 +221,15 @@ struct nvmet_ctrl {
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
+#ifdef CONFIG_NVME_TARGET_AUTH
+	u32			dhchap_seqnum;
+	u8			*dhchap_key;
+	size_t			dhchap_key_len;
+	struct crypto_shash	*shash_tfm;
+	u8			shash_id;
+	u32			dh_gid;
+	u32			dh_keysize;
+#endif
 };
 
 struct nvmet_subsys {
@@ -270,6 +291,10 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 
 struct nvmet_host {
 	struct config_group	group;
+	u8			*dhchap_secret;
+	u8			dhchap_key_hash;
+	u8			dhchap_hash_id;
+	u8			dhchap_dhgroup_id;
 };
 
 static inline struct nvmet_host *to_host(struct config_item *item)
@@ -659,4 +684,42 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_NVME_TARGET_AUTH
+void nvmet_execute_auth_send(struct nvmet_req *req);
+void nvmet_execute_auth_receive(struct nvmet_req *req);
+int nvmet_auth_set_host_key(struct nvmet_host *host, const char *secret);
+int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
+int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+void nvmet_init_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
+void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
+void nvmet_auth_sq_free(struct nvmet_sq *sq);
+bool nvmet_check_auth_status(struct nvmet_req *req);
+int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
+			 unsigned int hash_len);
+int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
+			 unsigned int hash_len);
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+{
+	return ctrl->shash_tfm != NULL;
+}
+#else
+static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+{
+	return 0;
+}
+static inline void nvmet_init_auth(struct nvmet_ctrl *ctrl,
+				   struct nvmet_req *req) {};
+static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
+static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline bool nvmet_check_auth_status(struct nvmet_req *req)
+{
+	return true;
+}
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+{
+	return false;
+}
+static inline const char *nvmet_dhchap_dhgroup_name(int dhgid) { return NULL; }
+#endif
+
 #endif /* _NVMET_H */
-- 
2.29.2

