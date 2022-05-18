Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE77452B8B6
	for <lists+linux-crypto@lfdr.de>; Wed, 18 May 2022 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiERLXN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 May 2022 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiERLXC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 May 2022 07:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B7515E612
        for <linux-crypto@vger.kernel.org>; Wed, 18 May 2022 04:22:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5E7E221BAD;
        Wed, 18 May 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652872973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xb20AYH4cAuZlmryuDX91aQ7e+LkL3mIdg23JPNDkY=;
        b=XbzTRxqrt4BJBc+7Q88ystGpXAbRsF7lBojTN4cqzKfqR1a9BEwi2WE0uMbronNPzx72u7
        +FtZ5kWNjkjPWRv7oW226WjjGSDzDQeio+78CNNe4cwuww8zKv+f2InMi4sjEf7e1ZiMR7
        vUPibMwZkLkxpOeWiIvtjeGbS7BJj2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652872973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xb20AYH4cAuZlmryuDX91aQ7e+LkL3mIdg23JPNDkY=;
        b=KMDu0CYAJwFc9I0cP++/aTeqYjNxGqiewdU/MY/abTlMyrRrqda4wSIlo/GAUkP1sZTXok
        McoTb51QVeknw+Dw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 572552C146;
        Wed, 18 May 2022 11:22:53 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 918085194511; Wed, 18 May 2022 13:22:52 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/11] nvme: Implement In-Band authentication
Date:   Wed, 18 May 2022 13:22:29 +0200
Message-Id: <20220518112234.24264-7-hare@suse.de>
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

Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
This patch adds two new fabric options 'dhchap_secret' to specify the
pre-shared key (in ASCII respresentation according to NVMe 2.0 section
8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
the pre-shared controller key for bi-directional authentication of both
the host and the controller.
Re-authentication can be triggered by writing the PSK into the new
controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/Kconfig   |   11 +
 drivers/nvme/host/Makefile  |    1 +
 drivers/nvme/host/auth.c    | 1124 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/auth.h    |   32 +
 drivers/nvme/host/core.c    |  141 ++++-
 drivers/nvme/host/fabrics.c |   79 ++-
 drivers/nvme/host/fabrics.h |    7 +
 drivers/nvme/host/nvme.h    |   31 +
 drivers/nvme/host/rdma.c    |    1 +
 drivers/nvme/host/tcp.c     |    1 +
 drivers/nvme/host/trace.c   |   32 +
 11 files changed, 1453 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/host/auth.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d6d056963c06..dd0e91fb0615 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -91,3 +91,14 @@ config NVME_TCP
 	  from https://github.com/linux-nvme/nvme-cli.
 
 	  If unsure, say N.
+
+config NVME_AUTH
+	bool "NVM Express over Fabrics In-Band Authentication"
+	depends on NVME_CORE
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	help
+	  This provides support for NVMe over Fabrics In-Band Authentication.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 476c5c988496..7755f5e3b281 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -15,6 +15,7 @@ nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
+nvme-core-$(CONFIG_NVME_AUTH)		+= auth.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
new file mode 100644
index 000000000000..abe5c2fe8479
--- /dev/null
+++ b/drivers/nvme/host/auth.c
@@ -0,0 +1,1124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
+ */
+
+#include <linux/crc32.h>
+#include <linux/base64.h>
+#include <linux/prandom.h>
+#include <asm/unaligned.h>
+#include <crypto/hash.h>
+#include <crypto/dh.h>
+#include "nvme.h"
+#include "fabrics.h"
+#include "auth.h"
+
+static u32 nvme_dhchap_seqnum;
+static DEFINE_MUTEX(nvme_dhchap_mutex);
+
+struct nvme_dhchap_queue_context {
+	struct list_head entry;
+	struct work_struct auth_work;
+	struct nvme_ctrl *ctrl;
+	struct crypto_shash *shash_tfm;
+	void *buf;
+	size_t buf_size;
+	int qid;
+	int error;
+	u32 s1;
+	u32 s2;
+	u16 transaction;
+	u8 status;
+	u8 hash_id;
+	size_t hash_len;
+	u8 dhgroup_id;
+	u8 c1[64];
+	u8 c2[64];
+	u8 response[64];
+	u8 *host_response;
+};
+
+u32 nvme_auth_get_seqnum(void)
+{
+	u32 seqnum;
+
+	mutex_lock(&nvme_dhchap_mutex);
+	if (!nvme_dhchap_seqnum)
+		nvme_dhchap_seqnum = prandom_u32();
+	else {
+		nvme_dhchap_seqnum++;
+		if (!nvme_dhchap_seqnum)
+			nvme_dhchap_seqnum++;
+	}
+	seqnum = nvme_dhchap_seqnum;
+	mutex_unlock(&nvme_dhchap_mutex);
+	return seqnum;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_get_seqnum);
+
+static struct nvme_auth_dhgroup_map {
+	const char name[16];
+	const char kpp[16];
+} dhgroup_map[] = {
+	[NVME_AUTH_DHGROUP_NULL] = {
+		.name = "null", .kpp = "null" },
+	[NVME_AUTH_DHGROUP_2048] = {
+		.name = "ffdhe2048", .kpp = "ffdhe2048(dh)" },
+	[NVME_AUTH_DHGROUP_3072] = {
+		.name = "ffdhe3072", .kpp = "ffdhe3072(dh)" },
+	[NVME_AUTH_DHGROUP_4096] = {
+		.name = "ffdhe4096", .kpp = "ffdhe4096(dh)" },
+	[NVME_AUTH_DHGROUP_6144] = {
+		.name = "ffdhe6144", .kpp = "ffdhe6144(dh)" },
+	[NVME_AUTH_DHGROUP_8192] = {
+		.name = "ffdhe8192", .kpp = "ffdhe8192(dh)" },
+};
+
+const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
+{
+	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
+	    !dhgroup_map[dhgroup_id].name ||
+	    !strlen(dhgroup_map[dhgroup_id].name))
+		return NULL;
+	return dhgroup_map[dhgroup_id].name;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
+
+const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
+{
+	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
+	    !dhgroup_map[dhgroup_id].kpp ||
+	    !strlen(dhgroup_map[dhgroup_id].kpp))
+		return NULL;
+	return dhgroup_map[dhgroup_id].kpp;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
+
+u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
+		if (!dhgroup_map[i].name ||
+		    !strlen(dhgroup_map[i].name))
+			continue;
+		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
+			     strlen(dhgroup_map[i].name)))
+			return i;
+	}
+	return NVME_AUTH_DHGROUP_INVALID;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
+
+static struct nvme_dhchap_hash_map {
+	int len;
+	const char hmac[15];
+	const char digest[8];
+} hash_map[] = {
+	[NVME_AUTH_HASH_SHA256] = {
+		.len = 32,
+		.hmac = "hmac(sha256)",
+		.digest = "sha256",
+	},
+	[NVME_AUTH_HASH_SHA384] = {
+		.len = 48,
+		.hmac = "hmac(sha384)",
+		.digest = "sha384",
+	},
+	[NVME_AUTH_HASH_SHA512] = {
+		.len = 64,
+		.hmac = "hmac(sha512)",
+		.digest = "sha512",
+	},
+};
+
+const char *nvme_auth_hmac_name(u8 hmac_id)
+{
+	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	    !hash_map[hmac_id].hmac ||
+	    !strlen(hash_map[hmac_id].hmac))
+		return NULL;
+	return hash_map[hmac_id].hmac;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
+
+const char *nvme_auth_digest_name(u8 hmac_id)
+{
+	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	    !hash_map[hmac_id].digest ||
+	    !strlen(hash_map[hmac_id].digest))
+		return NULL;
+	return hash_map[hmac_id].digest;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
+
+u8 nvme_auth_hmac_id(const char *hmac_name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
+		if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
+			continue;
+		if (!strncmp(hash_map[i].hmac, hmac_name,
+			     strlen(hash_map[i].hmac)))
+			return i;
+	}
+	return NVME_AUTH_HASH_INVALID;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
+
+size_t nvme_auth_hmac_hash_len(u8 hmac_id)
+{
+	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	    !hash_map[hmac_id].hmac ||
+	    !strlen(hash_map[hmac_id].hmac))
+		return 0;
+	return hash_map[hmac_id].len;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
+
+struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
+					      u8 key_hash)
+{
+	struct nvme_dhchap_key *key;
+	unsigned char *p;
+	u32 crc;
+	int ret, key_len;
+	size_t allocated_len = strlen(secret);
+
+	/* Secret might be affixed with a ':' */
+	p = strrchr(secret, ':');
+	if (p)
+		allocated_len = p - secret;
+	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	if (!key)
+		return ERR_PTR(-ENOMEM);
+	key->key = kzalloc(allocated_len, GFP_KERNEL);
+	if (!key->key) {
+		ret = -ENOMEM;
+		goto out_free_key;
+	}
+
+	key_len = base64_decode(secret, allocated_len, key->key);
+	if (key_len < 0) {
+		pr_debug("base64 key decoding error %d\n",
+			 key_len);
+		ret = key_len;
+		goto out_free_secret;
+	}
+
+	if (key_len != 36 && key_len != 52 &&
+	    key_len != 68) {
+		pr_err("Invalid key len %d\n", key_len);
+		ret = -EINVAL;
+		goto out_free_secret;
+	}
+
+	if (key_hash > 0 &&
+	    (key_len - 4) != nvme_auth_hmac_hash_len(key_hash)) {
+		pr_err("Mismatched key len %d for %s\n", key_len,
+		       nvme_auth_hmac_name(key_hash));
+		ret = -EINVAL;
+		goto out_free_secret;
+	}
+
+	/* The last four bytes is the CRC in little-endian format */
+	key_len -= 4;
+	/*
+	 * The linux implementation doesn't do pre- and post-increments,
+	 * so we have to do it manually.
+	 */
+	crc = ~crc32(~0, key->key, key_len);
+
+	if (get_unaligned_le32(key->key + key_len) != crc) {
+		pr_err("key crc mismatch (key %08x, crc %08x)\n",
+		       get_unaligned_le32(key->key + key_len), crc);
+		ret = -EKEYREJECTED;
+		goto out_free_secret;
+	}
+	key->len = key_len;
+	key->hash = key_hash;
+	return key;
+out_free_secret:
+	kfree_sensitive(key->key);
+out_free_key:
+	kfree(key);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
+
+void nvme_auth_free_key(struct nvme_dhchap_key *key)
+{
+	if (!key)
+		return;
+	kfree_sensitive(key->key);
+	kfree(key);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_free_key);
+
+u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
+{
+	const char *hmac_name = nvme_auth_hmac_name(key->hash);
+	struct crypto_shash *key_tfm;
+	struct shash_desc *shash;
+	u8 *transformed_key;
+	int ret;
+
+	if (key->hash == 0) {
+		transformed_key = kmemdup(key->key, key->len, GFP_KERNEL);
+		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
+	}
+
+	if (!key || !key->key) {
+		pr_warn("No key specified\n");
+		return ERR_PTR(-ENOKEY);
+	}
+	if (!hmac_name) {
+		pr_warn("Invalid key hash id %d\n", key->hash);
+		return ERR_PTR(-EINVAL);
+	}
+
+	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(key_tfm))
+		return (u8 *)key_tfm;
+
+	shash = kmalloc(sizeof(struct shash_desc) +
+			crypto_shash_descsize(key_tfm),
+			GFP_KERNEL);
+	if (!shash) {
+		ret = -ENOMEM;
+		goto out_free_key;
+	}
+
+	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
+	if (!transformed_key) {
+		ret = -ENOMEM;
+		goto out_free_shash;
+	}
+
+	shash->tfm = key_tfm;
+	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
+	if (ret < 0)
+		goto out_free_shash;
+	ret = crypto_shash_init(shash);
+	if (ret < 0)
+		goto out_free_shash;
+	ret = crypto_shash_update(shash, nqn, strlen(nqn));
+	if (ret < 0)
+		goto out_free_shash;
+	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
+	if (ret < 0)
+		goto out_free_shash;
+	ret = crypto_shash_final(shash, transformed_key);
+out_free_shash:
+	kfree(shash);
+out_free_key:
+	crypto_free_shash(key_tfm);
+	if (ret < 0) {
+		kfree_sensitive(transformed_key);
+		return ERR_PTR(ret);
+	}
+	return transformed_key;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
+
+#define nvme_auth_flags_from_qid(qid) \
+	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
+#define nvme_auth_queue_from_qid(ctrl, qid) \
+	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
+
+static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
+			    void *data, size_t data_len, bool auth_send)
+{
+	struct nvme_command cmd = {};
+	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
+	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
+	int ret;
+
+	cmd.auth_common.opcode = nvme_fabrics_command;
+	cmd.auth_common.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
+	cmd.auth_common.spsp0 = 0x01;
+	cmd.auth_common.spsp1 = 0x01;
+	if (auth_send) {
+		cmd.auth_send.fctype = nvme_fabrics_type_auth_send;
+		cmd.auth_send.tl = cpu_to_le32(data_len);
+	} else {
+		cmd.auth_receive.fctype = nvme_fabrics_type_auth_receive;
+		cmd.auth_receive.al = cpu_to_le32(data_len);
+	}
+
+	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len, 0,
+				     qid == 0 ? NVME_QID_ANY : qid,
+				     0, flags);
+	if (ret > 0)
+		dev_warn(ctrl->device,
+			"qid %d auth_send failed with status %d\n", qid, ret);
+	else if (ret < 0)
+		dev_err(ctrl->device,
+			"qid %d auth_send failed with error %d\n", qid, ret);
+	return ret;
+}
+
+static int nvme_auth_receive_validate(struct nvme_ctrl *ctrl, int qid,
+		struct nvmf_auth_dhchap_failure_data *data,
+		u16 transaction, u8 expected_msg)
+{
+	dev_dbg(ctrl->device, "%s: qid %d auth_type %d auth_id %x\n",
+		__func__, qid, data->auth_type, data->auth_id);
+
+	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES &&
+	    data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+		return data->rescode_exp;
+	}
+	if (data->auth_type != NVME_AUTH_DHCHAP_MESSAGES ||
+	    data->auth_id != expected_msg) {
+		dev_warn(ctrl->device,
+			 "qid %d invalid message %02x/%02x\n",
+			 qid, data->auth_type, data->auth_id);
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
+	}
+	if (le16_to_cpu(data->t_id) != transaction) {
+		dev_warn(ctrl->device,
+			 "qid %d invalid transaction ID %d\n",
+			 qid, le16_to_cpu(data->t_id));
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
+	}
+	return 0;
+}
+
+static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
+	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
+
+	if (chap->buf_size < size) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return -EINVAL;
+	}
+	memset((u8 *)chap->buf, 0, size);
+	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+	data->t_id = cpu_to_le16(chap->transaction);
+	data->sc_c = 0; /* No secure channel concatenation */
+	data->napd = 1;
+	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
+	data->auth_protocol[0].dhchap.halen = 3;
+	data->auth_protocol[0].dhchap.dhlen = 6;
+	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_HASH_SHA256;
+	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_HASH_SHA384;
+	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_HASH_SHA512;
+	data->auth_protocol[0].dhchap.idlist[30] = NVME_AUTH_DHGROUP_NULL;
+	data->auth_protocol[0].dhchap.idlist[31] = NVME_AUTH_DHGROUP_2048;
+	data->auth_protocol[0].dhchap.idlist[32] = NVME_AUTH_DHGROUP_3072;
+	data->auth_protocol[0].dhchap.idlist[33] = NVME_AUTH_DHGROUP_4096;
+	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
+	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
+
+	return size;
+}
+
+static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_challenge_data *data = chap->buf;
+	u16 dhvlen = le16_to_cpu(data->dhvlen);
+	size_t size = sizeof(*data) + data->hl + dhvlen;
+	const char *hmac_name, *kpp_name;
+
+	if (chap->buf_size < size) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return NVME_SC_INVALID_FIELD;
+	}
+
+	hmac_name = nvme_auth_hmac_name(data->hashid);
+	if (!hmac_name) {
+		dev_warn(ctrl->device,
+			 "qid %d: invalid HASH ID %d\n",
+			 chap->qid, data->hashid);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+		return NVME_SC_INVALID_FIELD;
+	}
+
+	if (chap->hash_id == data->hashid && chap->shash_tfm &&
+	    !strcmp(crypto_shash_alg_name(chap->shash_tfm), hmac_name) &&
+	    crypto_shash_digestsize(chap->shash_tfm) == data->hl) {
+		dev_dbg(ctrl->device,
+			"qid %d: reuse existing hash %s\n",
+			chap->qid, hmac_name);
+		goto select_kpp;
+	}
+
+	/* Reset if hash cannot be reused */
+	if (chap->shash_tfm) {
+		crypto_free_shash(chap->shash_tfm);
+		chap->hash_id = 0;
+		chap->hash_len = 0;
+	}
+	chap->shash_tfm = crypto_alloc_shash(hmac_name, 0,
+					     CRYPTO_ALG_ALLOCATES_MEMORY);
+	if (IS_ERR(chap->shash_tfm)) {
+		dev_warn(ctrl->device,
+			 "qid %d: failed to allocate hash %s, error %ld\n",
+			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
+		chap->shash_tfm = NULL;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return NVME_SC_AUTH_REQUIRED;
+	}
+
+	if (crypto_shash_digestsize(chap->shash_tfm) != data->hl) {
+		dev_warn(ctrl->device,
+			 "qid %d: invalid hash length %d\n",
+			 chap->qid, data->hl);
+		crypto_free_shash(chap->shash_tfm);
+		chap->shash_tfm = NULL;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+		return NVME_SC_AUTH_REQUIRED;
+	}
+
+	/* Reset host response if the hash had been changed */
+	if (chap->hash_id != data->hashid) {
+		kfree(chap->host_response);
+		chap->host_response = NULL;
+	}
+
+	chap->hash_id = data->hashid;
+	chap->hash_len = data->hl;
+	dev_dbg(ctrl->device, "qid %d: selected hash %s\n",
+		chap->qid, hmac_name);
+
+select_kpp:
+	kpp_name = nvme_auth_dhgroup_kpp(data->dhgid);
+	if (!kpp_name) {
+		dev_warn(ctrl->device,
+			 "qid %d: invalid DH group id %d\n",
+			 chap->qid, data->dhgid);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		return NVME_SC_AUTH_REQUIRED;
+	}
+
+	if (data->dhgid != NVME_AUTH_DHGROUP_NULL) {
+		dev_warn(ctrl->device,
+			 "qid %d: unsupported DH group %s\n",
+			 chap->qid, kpp_name);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		return NVME_SC_AUTH_REQUIRED;
+	} else if (dhvlen != 0) {
+		dev_warn(ctrl->device,
+			 "qid %d: invalid DH value for NULL DH\n",
+			 chap->qid);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return NVME_SC_INVALID_FIELD;
+	}
+	chap->dhgroup_id = data->dhgid;
+
+	chap->s1 = le32_to_cpu(data->seqnum);
+	memcpy(chap->c1, data->cval, chap->hash_len);
+
+	return 0;
+}
+
+static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_reply_data *data = chap->buf;
+	size_t size = sizeof(*data);
+
+	size += 2 * chap->hash_len;
+
+	if (chap->buf_size < size) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return -EINVAL;
+	}
+
+	memset(chap->buf, 0, size);
+	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
+	data->t_id = cpu_to_le16(chap->transaction);
+	data->hl = chap->hash_len;
+	data->dhvlen = 0;
+	memcpy(data->rval, chap->response, chap->hash_len);
+	if (ctrl->opts->dhchap_ctrl_secret) {
+		get_random_bytes(chap->c2, chap->hash_len);
+		data->cvalid = 1;
+		chap->s2 = nvme_auth_get_seqnum();
+		memcpy(data->rval + chap->hash_len, chap->c2,
+		       chap->hash_len);
+		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
+			__func__, chap->qid, (int)chap->hash_len, chap->c2);
+	} else {
+		memset(chap->c2, 0, chap->hash_len);
+		chap->s2 = 0;
+	}
+	data->seqnum = cpu_to_le32(chap->s2);
+	return size;
+}
+
+static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
+	size_t size = sizeof(*data);
+
+	if (ctrl->opts->dhchap_ctrl_secret)
+		size += chap->hash_len;
+
+	if (chap->buf_size < size) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return NVME_SC_INVALID_FIELD;
+	}
+
+	if (data->hl != chap->hash_len) {
+		dev_warn(ctrl->device,
+			 "qid %d: invalid hash length %u\n",
+			 chap->qid, data->hl);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
+		return NVME_SC_INVALID_FIELD;
+	}
+
+	/* Just print out information for the admin queue */
+	if (chap->qid == 0)
+		dev_info(ctrl->device,
+			 "qid 0: authenticated with hash %s dhgroup %s\n",
+			 nvme_auth_hmac_name(chap->hash_id),
+			 nvme_auth_dhgroup_name(chap->dhgroup_id));
+
+	if (!data->rvalid)
+		return 0;
+
+	/* Validate controller response */
+	if (memcmp(chap->response, data->rval, data->hl)) {
+		dev_dbg(ctrl->device, "%s: qid %d ctrl response %*ph\n",
+			__func__, chap->qid, (int)chap->hash_len, data->rval);
+		dev_dbg(ctrl->device, "%s: qid %d host response %*ph\n",
+			__func__, chap->qid, (int)chap->hash_len,
+			chap->response);
+		dev_warn(ctrl->device,
+			 "qid %d: controller authentication failed\n",
+			 chap->qid);
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return NVME_SC_AUTH_REQUIRED;
+	}
+
+	/* Just print out information for the admin queue */
+	if (chap->qid == 0)
+		dev_info(ctrl->device,
+			 "qid 0: controller authenticated\n");
+	return 0;
+}
+
+static int nvme_auth_set_dhchap_success2_data(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_success2_data *data = chap->buf;
+	size_t size = sizeof(*data);
+
+	memset(chap->buf, 0, size);
+	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2;
+	data->t_id = cpu_to_le16(chap->transaction);
+
+	return size;
+}
+
+static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	struct nvmf_auth_dhchap_failure_data *data = chap->buf;
+	size_t size = sizeof(*data);
+
+	memset(chap->buf, 0, size);
+	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
+	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
+	data->t_id = cpu_to_le16(chap->transaction);
+	data->rescode = NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED;
+	data->rescode_exp = chap->status;
+
+	return size;
+}
+
+static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	u8 buf[4], *challenge = chap->c1;
+	int ret;
+
+	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
+		__func__, chap->qid, chap->s1, chap->transaction);
+
+	if (!chap->host_response) {
+		chap->host_response = nvme_auth_transform_key(ctrl->host_key,
+						ctrl->opts->host->nqn);
+		if (IS_ERR(chap->host_response)) {
+			ret = PTR_ERR(chap->host_response);
+			chap->host_response = NULL;
+			return ret;
+		}
+	} else {
+		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
+			__func__, chap->qid);
+	}
+
+	ret = crypto_shash_setkey(chap->shash_tfm,
+			chap->host_response, ctrl->host_key->len);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+			 chap->qid, ret);
+		goto out;
+	}
+
+	shash->tfm = chap->shash_tfm;
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, challenge, chap->hash_len);
+	if (ret)
+		goto out;
+	put_unaligned_le32(chap->s1, buf);
+	ret = crypto_shash_update(shash, buf, 4);
+	if (ret)
+		goto out;
+	put_unaligned_le16(chap->transaction, buf);
+	ret = crypto_shash_update(shash, buf, 2);
+	if (ret)
+		goto out;
+	memset(buf, 0, sizeof(buf));
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, "HostHost", 8);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
+				  strlen(ctrl->opts->host->nqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
+			    strlen(ctrl->opts->subsysnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_final(shash, chap->response);
+out:
+	if (challenge != chap->c1)
+		kfree(challenge);
+	return ret;
+}
+
+static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	u8 *ctrl_response;
+	u8 buf[4], *challenge = chap->c2;
+	int ret;
+
+	ctrl_response = nvme_auth_transform_key(ctrl->ctrl_key,
+				ctrl->opts->subsysnqn);
+	if (IS_ERR(ctrl_response)) {
+		ret = PTR_ERR(ctrl_response);
+		return ret;
+	}
+	ret = crypto_shash_setkey(chap->shash_tfm,
+			ctrl_response, ctrl->ctrl_key->len);
+	if (ret) {
+		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+			 chap->qid, ret);
+		goto out;
+	}
+
+	dev_dbg(ctrl->device, "%s: qid %d ctrl response seq %u transaction %d\n",
+		__func__, chap->qid, chap->s2, chap->transaction);
+	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
+		__func__, chap->qid, (int)chap->hash_len, challenge);
+	dev_dbg(ctrl->device, "%s: qid %d subsysnqn %s\n",
+		__func__, chap->qid, ctrl->opts->subsysnqn);
+	dev_dbg(ctrl->device, "%s: qid %d hostnqn %s\n",
+		__func__, chap->qid, ctrl->opts->host->nqn);
+	shash->tfm = chap->shash_tfm;
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, challenge, chap->hash_len);
+	if (ret)
+		goto out;
+	put_unaligned_le32(chap->s2, buf);
+	ret = crypto_shash_update(shash, buf, 4);
+	if (ret)
+		goto out;
+	put_unaligned_le16(chap->transaction, buf);
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
+	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
+				  strlen(ctrl->opts->subsysnqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, buf, 1);
+	if (ret)
+		goto out;
+	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
+				  strlen(ctrl->opts->host->nqn));
+	if (ret)
+		goto out;
+	ret = crypto_shash_final(shash, chap->response);
+out:
+	if (challenge != chap->c2)
+		kfree(challenge);
+	return ret;
+}
+
+int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
+{
+	struct nvme_dhchap_key *key;
+	u8 key_hash;
+
+	if (!secret) {
+		*ret_key = NULL;
+		return 0;
+	}
+
+	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
+		return -EINVAL;
+
+	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
+	key = nvme_auth_extract_key(secret + 10, key_hash);
+	if (IS_ERR(key)) {
+		return PTR_ERR(key);
+	}
+
+	*ret_key = key;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
+
+static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
+{
+	chap->status = 0;
+	chap->error = 0;
+	chap->s1 = 0;
+	chap->s2 = 0;
+	chap->transaction = 0;
+	memset(chap->c1, 0, sizeof(chap->c1));
+	memset(chap->c2, 0, sizeof(chap->c2));
+}
+
+static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
+{
+	__nvme_auth_reset(chap);
+	if (chap->shash_tfm)
+		crypto_free_shash(chap->shash_tfm);
+	kfree_sensitive(chap->host_response);
+	kfree(chap->buf);
+	kfree(chap);
+}
+
+static void __nvme_auth_work(struct work_struct *work)
+{
+	struct nvme_dhchap_queue_context *chap =
+		container_of(work, struct nvme_dhchap_queue_context, auth_work);
+	struct nvme_ctrl *ctrl = chap->ctrl;
+	size_t tl;
+	int ret = 0;
+
+	chap->transaction = ctrl->transaction++;
+
+	/* DH-HMAC-CHAP Step 1: send negotiate */
+	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
+		__func__, chap->qid);
+	ret = nvme_auth_set_dhchap_negotiate_data(ctrl, chap);
+	if (ret < 0) {
+		chap->error = ret;
+		return;
+	}
+	tl = ret;
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
+	if (ret) {
+		chap->error = ret;
+		return;
+	}
+
+	/* DH-HMAC-CHAP Step 2: receive challenge */
+	dev_dbg(ctrl->device, "%s: qid %d receive challenge\n",
+		__func__, chap->qid);
+
+	memset(chap->buf, 0, chap->buf_size);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid %d failed to receive challenge, %s %d\n",
+			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
+		chap->error = ret;
+		return;
+	}
+	ret = nvme_auth_receive_validate(ctrl, chap->qid, chap->buf, chap->transaction,
+					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
+	if (ret) {
+		chap->status = ret;
+		chap->error = NVME_SC_AUTH_REQUIRED;
+		return;
+	}
+
+	ret = nvme_auth_process_dhchap_challenge(ctrl, chap);
+	if (ret) {
+		/* Invalid challenge parameters */
+		goto fail2;
+	}
+
+	dev_dbg(ctrl->device, "%s: qid %d host response\n",
+		__func__, chap->qid);
+	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	if (ret)
+		goto fail2;
+
+	/* DH-HMAC-CHAP Step 3: send reply */
+	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
+		__func__, chap->qid);
+	ret = nvme_auth_set_dhchap_reply_data(ctrl, chap);
+	if (ret < 0)
+		goto fail2;
+
+	tl = ret;
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
+	if (ret)
+		goto fail2;
+
+	/* DH-HMAC-CHAP Step 4: receive success1 */
+	dev_dbg(ctrl->device, "%s: qid %d receive success1\n",
+		__func__, chap->qid);
+
+	memset(chap->buf, 0, chap->buf_size);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid %d failed to receive success1, %s %d\n",
+			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
+		chap->error = ret;
+		return;
+	}
+	ret = nvme_auth_receive_validate(ctrl, chap->qid,
+					 chap->buf, chap->transaction,
+					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
+	if (ret) {
+		chap->status = ret;
+		chap->error = NVME_SC_AUTH_REQUIRED;
+		return;
+	}
+
+	if (ctrl->opts->dhchap_ctrl_secret) {
+		dev_dbg(ctrl->device,
+			"%s: qid %d controller response\n",
+			__func__, chap->qid);
+		ret = nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
+		if (ret) {
+			chap->error = ret;
+			goto fail2;
+		}
+	}
+
+	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
+	if (ret) {
+		/* Controller authentication failed */
+		chap->error = NVME_SC_AUTH_REQUIRED;
+		goto fail2;
+	}
+
+	if (ctrl->opts->dhchap_ctrl_secret) {
+		/* DH-HMAC-CHAP Step 5: send success2 */
+		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
+			__func__, chap->qid);
+		tl = nvme_auth_set_dhchap_success2_data(ctrl, chap);
+		ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
+	}
+	if (!ret) {
+		chap->error = 0;
+		return;
+	}
+
+fail2:
+	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
+		__func__, chap->qid, chap->status);
+	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
+	/*
+	 * only update error if send failure2 failed and no other
+	 * error had been set during authentication.
+	 */
+	if (ret && !chap->error)
+		chap->error = ret;
+}
+
+int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
+{
+	struct nvme_dhchap_queue_context *chap;
+
+	if (!ctrl->host_key) {
+		dev_warn(ctrl->device, "qid %d: no key\n", qid);
+		return -ENOKEY;
+	}
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	/* Check if the context is already queued */
+	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
+		WARN_ON(!chap->buf);
+		if (chap->qid == qid) {
+			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
+			mutex_unlock(&ctrl->dhchap_auth_mutex);
+			flush_work(&chap->auth_work);
+			__nvme_auth_reset(chap);
+			queue_work(nvme_wq, &chap->auth_work);
+			return 0;
+		}
+	}
+	chap = kzalloc(sizeof(*chap), GFP_KERNEL);
+	if (!chap) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		return -ENOMEM;
+	}
+	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
+	chap->ctrl = ctrl;
+
+	/*
+	 * Allocate a large enough buffer for the entire negotiation:
+	 * 4k should be enough to ffdhe8192.
+	 */
+	chap->buf_size = 4096;
+	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
+	if (!chap->buf) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		kfree(chap);
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&chap->auth_work, __nvme_auth_work);
+	list_add(&chap->entry, &ctrl->dhchap_auth_list);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	queue_work(nvme_wq, &chap->auth_work);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
+
+int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
+{
+	struct nvme_dhchap_queue_context *chap;
+	int ret;
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
+		if (chap->qid != qid)
+			continue;
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		flush_work(&chap->auth_work);
+		ret = chap->error;
+		return ret;
+	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_wait);
+
+void nvme_auth_reset(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dhchap_queue_context *chap;
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		flush_work(&chap->auth_work);
+		__nvme_auth_reset(chap);
+	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_reset);
+
+static void nvme_dhchap_auth_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, dhchap_auth_work);
+	int ret, q;
+
+	/* Authenticate admin queue first */
+	ret = nvme_auth_negotiate(ctrl, 0);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid 0: error %d setting up authentication\n", ret);
+		return;
+	}
+	ret = nvme_auth_wait(ctrl, 0);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "qid 0: authentication failed\n");
+		return;
+	}
+
+	for (q = 1; q < ctrl->queue_count; q++) {
+		ret = nvme_auth_negotiate(ctrl, q);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %d: error %d setting up authentication\n",
+				 q, ret);
+			break;
+		}
+	}
+
+	/*
+	 * Failure is a soft-state; credentials remain valid until
+	 * the controller terminates the connection.
+	 */
+}
+
+void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
+{
+	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
+	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
+	mutex_init(&ctrl->dhchap_auth_mutex);
+	if (!ctrl->opts)
+		return;
+	nvme_auth_generate_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
+	nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
+
+void nvme_auth_stop(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+
+	cancel_work_sync(&ctrl->dhchap_auth_work);
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry)
+		cancel_work_sync(&chap->auth_work);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_stop);
+
+void nvme_auth_free(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dhchap_queue_context *chap = NULL, *tmp;
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
+		list_del_init(&chap->entry);
+		flush_work(&chap->auth_work);
+		__nvme_auth_free(chap);
+	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	if (ctrl->host_key) {
+		nvme_auth_free_key(ctrl->host_key);
+		ctrl->host_key = NULL;
+	}
+	if (ctrl->ctrl_key) {
+		nvme_auth_free_key(ctrl->ctrl_key);
+		ctrl->ctrl_key = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_auth_free);
diff --git a/drivers/nvme/host/auth.h b/drivers/nvme/host/auth.h
new file mode 100644
index 000000000000..73d6ec63a5c8
--- /dev/null
+++ b/drivers/nvme/host/auth.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Hannes Reinecke, SUSE Software Solutions
+ */
+
+#ifndef _NVME_AUTH_H
+#define _NVME_AUTH_H
+
+#include <crypto/kpp.h>
+
+struct nvme_dhchap_key {
+	u8 *key;
+	size_t len;
+	u8 hash;
+};
+
+u32 nvme_auth_get_seqnum(void);
+const char *nvme_auth_dhgroup_name(u8 dhgroup_id);
+const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id);
+u8 nvme_auth_dhgroup_id(const char *dhgroup_name);
+
+const char *nvme_auth_hmac_name(u8 hmac_id);
+const char *nvme_auth_digest_name(u8 hmac_id);
+size_t nvme_auth_hmac_hash_len(u8 hmac_id);
+u8 nvme_auth_hmac_id(const char *hmac_name);
+
+struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
+					      u8 key_hash);
+void nvme_auth_free_key(struct nvme_dhchap_key *key);
+u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
+
+#endif /* _NVME_AUTH_H */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42f9772abc4d..979350909794 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -24,6 +24,7 @@
 
 #include "nvme.h"
 #include "fabrics.h"
+#include "auth.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -330,6 +331,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	AUTHENTICATE,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -337,6 +339,9 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
+	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+		return AUTHENTICATE;
+
 	if (blk_noretry_request(req) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
@@ -375,11 +380,13 @@ static inline void nvme_end_req(struct request *req)
 
 void nvme_complete_rq(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (nvme_req(req)->ctrl->kas)
-		nvme_req(req)->ctrl->comp_seen = true;
+	if (ctrl->kas)
+		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
@@ -391,6 +398,14 @@ void nvme_complete_rq(struct request *req)
 	case FAILOVER:
 		nvme_failover_req(req);
 		return;
+	case AUTHENTICATE:
+#ifdef CONFIG_NVME_AUTH
+		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+		nvme_retry_req(req);
+#else
+		nvme_end_req(req);
+#endif
+		return;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
@@ -702,7 +717,9 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		switch (ctrl->state) {
 		case NVME_CTRL_CONNECTING:
 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
-			    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
+			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
+			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_send ||
+			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
 				return true;
 			break;
 		default:
@@ -3546,6 +3563,108 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
+#ifdef CONFIG_NVME_AUTH
+static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (!opts->dhchap_secret)
+		return sysfs_emit(buf, "none\n");
+	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+}
+
+static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *dhchap_secret;
+
+	if (!ctrl->opts->dhchap_secret)
+		return -EINVAL;
+	if (count < 7)
+		return -EINVAL;
+	if (memcmp(buf, "DHHC-1:", 7))
+		return -EINVAL;
+
+	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!dhchap_secret)
+		return -ENOMEM;
+	memcpy(dhchap_secret, buf, count);
+	nvme_auth_stop(ctrl);
+	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		int ret;
+
+		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
+		if (ret)
+			return ret;
+		kfree(opts->dhchap_secret);
+		opts->dhchap_secret = dhchap_secret;
+		/* Key has changed; re-authentication with new key */
+		nvme_auth_reset(ctrl);
+	}
+	/* Start re-authentication */
+	dev_info(ctrl->device, "re-authenticating controller\n");
+	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+
+	return count;
+}
+DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
+	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
+
+static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+
+	if (!opts->dhchap_ctrl_secret)
+		return sysfs_emit(buf, "none\n");
+	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+}
+
+static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *dhchap_secret;
+
+	if (!ctrl->opts->dhchap_ctrl_secret)
+		return -EINVAL;
+	if (count < 7)
+		return -EINVAL;
+	if (memcmp(buf, "DHHC-1:", 7))
+		return -EINVAL;
+
+	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	if (!dhchap_secret)
+		return -ENOMEM;
+	memcpy(dhchap_secret, buf, count);
+	nvme_auth_stop(ctrl);
+	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		int ret;
+
+		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
+		if (ret)
+			return ret;
+		kfree(opts->dhchap_ctrl_secret);
+		opts->dhchap_ctrl_secret = dhchap_secret;
+		/* Key has changed; re-authentication with new key */
+		nvme_auth_reset(ctrl);
+	}
+	/* Start re-authentication */
+	dev_info(ctrl->device, "re-authenticating controller\n");
+	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+
+	return count;
+}
+DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
+	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+#endif
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3569,6 +3688,10 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+#ifdef CONFIG_NVME_AUTH
+	&dev_attr_dhchap_secret.attr,
+	&dev_attr_dhchap_ctrl_secret.attr,
+#endif
 	NULL
 };
 
@@ -3592,6 +3715,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
 		return 0;
+#ifdef CONFIG_NVME_AUTH
+	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
+		return 0;
+#endif
 
 	return a->mode;
 }
@@ -4444,8 +4571,10 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		 * recovery actions from interfering with the controller's
 		 * firmware activation.
 		 */
-		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+			nvme_auth_stop(ctrl);
 			queue_work(nvme_wq, &ctrl->fw_act_work);
+		}
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
@@ -4492,6 +4621,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
+	nvme_auth_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
@@ -4549,6 +4679,8 @@ static void nvme_free_ctrl(struct device *dev)
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
+	nvme_auth_stop(ctrl);
+	nvme_auth_free(ctrl);
 	__free_page(ctrl->discard_page);
 
 	if (subsys) {
@@ -4639,6 +4771,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
+	nvme_auth_init_ctrl(ctrl);
 
 	return 0;
 out_free_name:
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 953e3076aab1..f5786a60931c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -369,6 +369,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	union nvme_result res;
 	struct nvmf_connect_data *data;
 	int ret;
+	u32 result;
 
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
@@ -401,8 +402,25 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		goto out_free_data;
 	}
 
-	ctrl->cntlid = le16_to_cpu(res.u16);
-
+	result = le32_to_cpu(res.u32);
+	ctrl->cntlid = result & 0xFFFF;
+	if ((result >> 16) & 2) {
+		/* Authentication required */
+		ret = nvme_auth_negotiate(ctrl, 0);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid 0: authentication setup failed\n");
+			ret = NVME_SC_AUTH_REQUIRED;
+			goto out_free_data;
+		}
+		ret = nvme_auth_wait(ctrl, 0);
+		if (ret)
+			dev_warn(ctrl->device,
+				 "qid 0: authentication failed\n");
+		else
+			dev_info(ctrl->device,
+				 "qid 0: authenticated\n");
+	}
 out_free_data:
 	kfree(data);
 	return ret;
@@ -435,6 +453,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	struct nvmf_connect_data *data;
 	union nvme_result res;
 	int ret;
+	u32 result;
 
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
@@ -460,6 +479,21 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
 	}
+	result = le32_to_cpu(res.u32);
+	if ((result >> 16) & 2) {
+		/* Authentication required */
+		ret = nvme_auth_negotiate(ctrl, qid);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %d: authentication setup failed\n", qid);
+			ret = NVME_SC_AUTH_REQUIRED;
+		} else {
+			ret = nvme_auth_wait(ctrl, qid);
+			if (ret)
+				dev_warn(ctrl->device,
+					 "qid %u: authentication failed\n", qid);
+		}
+	}
 	kfree(data);
 	return ret;
 }
@@ -552,6 +586,8 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
+	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -833,6 +869,34 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_DHCHAP_SECRET:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
+				pr_err("Invalid DH-CHAP secret %s\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+			kfree(opts->dhchap_secret);
+			opts->dhchap_secret = p;
+			break;
+		case NVMF_OPT_DHCHAP_CTRL_SECRET:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
+				pr_err("Invalid DH-CHAP secret %s\n", p);
+				ret = -EINVAL;
+				goto out;
+			}
+			kfree(opts->dhchap_ctrl_secret);
+			opts->dhchap_ctrl_secret = p;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -951,6 +1015,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
+	kfree(opts->dhchap_secret);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
@@ -960,7 +1025,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
-				 NVMF_OPT_FAIL_FAST_TMO)
+				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
+				 NVMF_OPT_DHCHAP_CTRL_SECRET)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
@@ -1196,7 +1262,14 @@ static void __exit nvmf_exit(void)
 	BUILD_BUG_ON(sizeof(struct nvmf_connect_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_property_get_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_property_set_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_send_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_receive_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_connect_data) != 1024);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_negotiate_data) != 8);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_challenge_data) != 16);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_reply_data) != 16);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_success1_data) != 16);
+	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_success2_data) != 16);
 }
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 46d6e194ac2b..a6e22116e139 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,8 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
+	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
 };
 
 /**
@@ -97,6 +99,9 @@ enum {
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
  *              the controller, (-1) means reconnect forever, zero means remove
  *              immediately;
+ * @dhchap_secret: DH-HMAC-CHAP secret
+ * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
+ *              authentication
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
@@ -121,6 +126,8 @@ struct nvmf_ctrl_options {
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
+	char			*dhchap_secret;
+	char			*dhchap_ctrl_secret;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 81c4f5379c0c..004f6c118c7b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,6 +328,15 @@ struct nvme_ctrl {
 	struct work_struct ana_work;
 #endif
 
+#ifdef CONFIG_NVME_AUTH
+	struct work_struct dhchap_auth_work;
+	struct list_head dhchap_auth_list;
+	struct mutex dhchap_auth_mutex;
+	struct nvme_dhchap_key *host_key;
+	struct nvme_dhchap_key *ctrl_key;
+	u16 transaction;
+#endif
+
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
@@ -958,6 +967,28 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
 
+#ifdef CONFIG_NVME_AUTH
+void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
+void nvme_auth_stop(struct nvme_ctrl *ctrl);
+int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
+int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
+void nvme_auth_reset(struct nvme_ctrl *ctrl);
+void nvme_auth_free(struct nvme_ctrl *ctrl);
+int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
+#else
+static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
+static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
+static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
+{
+	return -EPROTONOSUPPORT;
+}
+static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
+{
+	return NVME_SC_AUTH_REQUIRED;
+}
+static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
+#endif
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b87c8ae41d9b..bd4c25af74d3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1197,6 +1197,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
+	nvme_auth_stop(&ctrl->ctrl);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d241b..a7848e430a5c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2174,6 +2174,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	nvme_auth_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 2a89c5aa0790..1c36fcedea20 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -287,6 +287,34 @@ static const char *nvme_trace_fabrics_property_get(struct trace_seq *p, u8 *spc)
 	return ret;
 }
 
+static const char *nvme_trace_fabrics_auth_send(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 spsp0 = spc[1];
+	u8 spsp1 = spc[2];
+	u8 secp = spc[3];
+	u32 tl = get_unaligned_le32(spc + 4);
+
+	trace_seq_printf(p, "spsp0=%02x, spsp1=%02x, secp=%02x, tl=%u",
+			 spsp0, spsp1, secp, tl);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+static const char *nvme_trace_fabrics_auth_receive(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 spsp0 = spc[1];
+	u8 spsp1 = spc[2];
+	u8 secp = spc[3];
+	u32 al = get_unaligned_le32(spc + 4);
+
+	trace_seq_printf(p, "spsp0=%02x, spsp1=%02x, secp=%02x, al=%u",
+			 spsp0, spsp1, secp, al);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
 static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -306,6 +334,10 @@ const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
 		return nvme_trace_fabrics_connect(p, spc);
 	case nvme_fabrics_type_property_get:
 		return nvme_trace_fabrics_property_get(p, spc);
+	case nvme_fabrics_type_auth_send:
+		return nvme_trace_fabrics_auth_send(p, spc);
+	case nvme_fabrics_type_auth_receive:
+		return nvme_trace_fabrics_auth_receive(p, spc);
 	default:
 		return nvme_trace_fabrics_common(p, spc);
 	}
-- 
2.29.2

