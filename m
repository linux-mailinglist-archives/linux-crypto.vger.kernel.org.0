Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE3452F07
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Nov 2021 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhKPK3C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 16 Nov 2021 05:29:02 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39691 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhKPK24 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 16 Nov 2021 05:28:56 -0500
Received: by mail-wm1-f45.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1505697wmr.4
        for <linux-crypto@vger.kernel.org>; Tue, 16 Nov 2021 02:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SstCGxUlXgiaFRlRa8gXVA97peLLHo4ebbqeeffP8ks=;
        b=gDfuUJ2hSgZI9NDc88+jWZ4SMnvYq3ujgy0irslm/btTtKFbk4XeDuiysCl/WhY0/e
         xNdKMnyNecHSwDeU7R+7oUG1QYAEX23H2jlaP5NYDjff4iMdm4b6qmoakxIGmFbUwzs5
         37Qgo4IR8anB63EU36IXQZ+fwH35Aod7HAqw4jkSUlv5JOqwL1eBzbB8XJl5+wUJCgFY
         BAu8kKpvCeZyGNNeue1OXDsnDMri45FGfmUz67c/yYf+RpAna05QAoRA6pxXfzLnYske
         /qcEa7RgEsV+6rRFMwYBzmkyaoKeUhPLdlYikQjHinY4tB/2+/XicVdrXcbfoWik6zto
         EPqA==
X-Gm-Message-State: AOAM531s2EVmXvnuiJ+jt/mJqwWkTEOwK+KxN0sJIBpCkuBoul0tVEen
        de6Kidt7mPVjx4e1vqAQMsA6IPatRls=
X-Google-Smtp-Source: ABdhPJzWOvAreGs5WY9g0nhz+fiAb6a5rZfiMw5YD2HI8QJu/VLahbKRaMOhwK9dc6fJhJXtAG/lpw==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr6493792wml.11.1637058357202;
        Tue, 16 Nov 2021 02:25:57 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18sm2395499wmq.4.2021.11.16.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:25:52 -0800 (PST)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <20211112125928.97318-8-hare@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29139bb6-ecfe-b971-2ca2-b77a20be7e09@grimberg.me>
Date:   Tue, 16 Nov 2021 12:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112125928.97318-8-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 11/12/21 2:59 PM, Hannes Reinecke wrote:
> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
> This patch adds two new fabric options 'dhchap_secret' to specify the
> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
> the pre-shared controller key for bi-directional authentication of both
> the host and the controller.
> Re-authentication can be triggered by writing the PSK into the new
> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/Kconfig   |   11 +
>   drivers/nvme/host/Makefile  |    1 +
>   drivers/nvme/host/auth.c    | 1164 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/auth.h    |   25 +
>   drivers/nvme/host/core.c    |  133 +++-
>   drivers/nvme/host/fabrics.c |   79 ++-
>   drivers/nvme/host/fabrics.h |    7 +
>   drivers/nvme/host/nvme.h    |   36 ++
>   drivers/nvme/host/tcp.c     |    1 +
>   drivers/nvme/host/trace.c   |   32 +
>   10 files changed, 1482 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/nvme/host/auth.c
>   create mode 100644 drivers/nvme/host/auth.h
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index dc0450ca23a3..49269c581ec4 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -83,3 +83,14 @@ config NVME_TCP
>   	  from https://github.com/linux-nvme/nvme-cli.
>   
>   	  If unsure, say N.
> +
> +config NVME_AUTH
> +	bool "NVM Express over Fabrics In-Band Authentication"
> +	depends on NVME_CORE
> +	select CRYPTO_HMAC
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	help
> +	  This provides support for NVMe over Fabrics In-Band Authentication.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index dfaacd472e5d..4bae2a4a8d8c 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -15,6 +15,7 @@ nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
>   nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
>   nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
>   nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
> +nvme-core-$(CONFIG_NVME_AUTH)		+= auth.o
>   
>   nvme-y					+= pci.o
>   
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> new file mode 100644
> index 000000000000..6ab95a178213
> --- /dev/null
> +++ b/drivers/nvme/host/auth.c
> @@ -0,0 +1,1164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
> + */
> +
> +#include <linux/crc32.h>
> +#include <linux/base64.h>
> +#include <asm/unaligned.h>
> +#include <crypto/hash.h>
> +#include <crypto/dh.h>
> +#include <crypto/ffdhe.h>
> +#include "nvme.h"
> +#include "fabrics.h"
> +#include "auth.h"
> +
> +static atomic_t nvme_dhchap_seqnum = ATOMIC_INIT(0);
> +
> +struct nvme_dhchap_queue_context {
> +	struct list_head entry;
> +	struct work_struct auth_work;
> +	struct nvme_ctrl *ctrl;
> +	struct crypto_shash *shash_tfm;
> +	void *buf;
> +	size_t buf_size;
> +	int qid;
> +	int error;
> +	u32 s1;
> +	u32 s2;
> +	u16 transaction;
> +	u8 status;
> +	u8 hash_id;
> +	u8 hash_len;
> +	u8 dhgroup_id;
> +	u8 c1[64];
> +	u8 c2[64];
> +	u8 response[64];
> +	u8 *host_response;
> +};
> +
> +static struct nvme_auth_dhgroup_map {
> +	int id;
> +	const char name[16];
> +	const char kpp[16];
> +	int privkey_size;
> +	int pubkey_size;
> +} dhgroup_map[] = {
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_NULL,
> +	  .name = "null", .kpp = "null",
> +	  .privkey_size = 0, .pubkey_size = 0 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_2048,
> +	  .name = "ffdhe2048", .kpp = "dh",
> +	  .privkey_size = 256, .pubkey_size = 256 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_3072,
> +	  .name = "ffdhe3072", .kpp = "dh",
> +	  .privkey_size = 384, .pubkey_size = 384 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_4096,
> +	  .name = "ffdhe4096", .kpp = "dh",
> +	  .privkey_size = 512, .pubkey_size = 512 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_6144,
> +	  .name = "ffdhe6144", .kpp = "dh",
> +	  .privkey_size = 768, .pubkey_size = 768 },
> +	{ .id = NVME_AUTH_DHCHAP_DHGROUP_8192,
> +	  .name = "ffdhe8192", .kpp = "dh",
> +	  .privkey_size = 1024, .pubkey_size = 1024 },
> +};
> +
> +const char *nvme_auth_dhgroup_name(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].name;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
> +
> +int nvme_auth_dhgroup_pubkey_size(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].pubkey_size;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_pubkey_size);
> +
> +int nvme_auth_dhgroup_privkey_size(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].privkey_size;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_privkey_size);
> +
> +const char *nvme_auth_dhgroup_kpp(int dhgroup_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (dhgroup_map[i].id == dhgroup_id)
> +			return dhgroup_map[i].kpp;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
> +
> +int nvme_auth_dhgroup_id(const char *dhgroup_name)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
> +			     strlen(dhgroup_map[i].name)))
> +			return dhgroup_map[i].id;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
> +
> +static struct nvme_dhchap_hash_map {
> +	int id;
> +	int len;
> +	const char hmac[15];
> +	const char digest[15];
> +} hash_map[] = {
> +	{.id = NVME_AUTH_DHCHAP_SHA256, .len = 32,
> +	 .hmac = "hmac(sha256)", .digest = "sha256" },
> +	{.id = NVME_AUTH_DHCHAP_SHA384, .len = 48,
> +	 .hmac = "hmac(sha384)", .digest = "sha384" },
> +	{.id = NVME_AUTH_DHCHAP_SHA512, .len = 64,
> +	 .hmac = "hmac(sha512)", .digest = "sha512" },
> +};
> +
> +const char *nvme_auth_hmac_name(int hmac_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
> +		if (hash_map[i].id == hmac_id)
> +			return hash_map[i].hmac;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
> +
> +const char *nvme_auth_digest_name(int hmac_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
> +		if (hash_map[i].id == hmac_id)
> +			return hash_map[i].digest;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
> +
> +int nvme_auth_hmac_id(const char *hmac_name)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
> +		if (!strncmp(hash_map[i].hmac, hmac_name,
> +			     strlen(hash_map[i].hmac)))
> +			return hash_map[i].id;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
> +
> +int nvme_auth_hmac_hash_len(int hmac_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
> +		if (hash_map[i].id == hmac_id)
> +			return hash_map[i].len;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
> +
> +unsigned char *nvme_auth_extract_secret(unsigned char *secret, u8 key_hash,
> +					size_t *out_len)
> +{
> +	unsigned char *key, *p;
> +	u32 crc;
> +	int key_len;
> +	size_t allocated_len = strlen(secret);
> +
> +	/* Secret might be affixed with a ':' */
> +	p = strrchr(secret, ':');
> +	if (p)
> +		allocated_len = p - secret;
> +	key = kzalloc(allocated_len, GFP_KERNEL);
> +	if (!key)
> +		return ERR_PTR(-ENOMEM);
> +
> +	key_len = base64_decode(secret, allocated_len, key);
> +	if (key_len < 0) {
> +		pr_debug("base64 key decoding error %d\n",
> +			 key_len);
> +		return ERR_PTR(key_len);
> +	}
> +	if (key_len != 36 && key_len != 52 &&
> +	    key_len != 68) {
> +		pr_debug("Invalid key len %d\n",
> +			 key_len);

pr_err?

> +		kfree_sensitive(key);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (key_hash > 0 &&
> +	    (key_len - 4) != nvme_auth_hmac_hash_len(key_hash)) {
> +		pr_debug("Invalid key len %d for %s\n", key_len,
> +			 nvme_auth_hmac_name(key_hash));

pr_err?

> +		kfree_sensitive(key);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* The last four bytes is the CRC in little-endian format */
> +	key_len -= 4;
> +	/*
> +	 * The linux implementation doesn't do pre- and post-increments,
> +	 * so we have to do it manually.
> +	 */
> +	crc = ~crc32(~0, key, key_len);
> +
> +	if (get_unaligned_le32(key + key_len) != crc) {
> +		pr_debug("DH-HMAC-CHAP key crc mismatch (key %08x, crc %08x)\n",
> +		       get_unaligned_le32(key + key_len), crc);

pr_err?

> +		kfree_sensitive(key);
> +		return ERR_PTR(-EKEYREJECTED);
> +	}
> +	*out_len = key_len;
> +	return key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_extract_secret);
> +
> +u8 *nvme_auth_transform_key(u8 *key, size_t key_len, u8 key_hash, char *nqn)
> +{
> +	const char *hmac_name = nvme_auth_hmac_name(key_hash);
> +	struct crypto_shash *key_tfm;
> +	struct shash_desc *shash;
> +	u8 *transformed_key;
> +	int ret;
> +
> +	if (key_hash == 0) {
> +		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
> +		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (!key || !key_len) {
> +		pr_warn("No key specified\n");

pr_err?

> +		return ERR_PTR(-ENOKEY);
> +	}
> +	if (!hmac_name) {
> +		pr_warn("Invalid key hash id %d\n", key_hash);

pr_err?

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(key_tfm))
> +		return (u8 *)key_tfm;
> +
> +	shash = kmalloc(sizeof(struct shash_desc) +
> +			crypto_shash_descsize(key_tfm),
> +			GFP_KERNEL);
> +	if (!shash) {
> +		ret = -ENOMEM;
> +		goto out_free_key;
> +	}
> +
> +	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
> +	if (!transformed_key) {
> +		ret = -ENOMEM;
> +		goto out_free_shash;
> +	}
> +
> +	shash->tfm = key_tfm;
> +	ret = crypto_shash_setkey(key_tfm, key, key_len);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret = crypto_shash_init(shash);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret = crypto_shash_update(shash, nqn, strlen(nqn));
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret = crypto_shash_final(shash, transformed_key);
> +out_free_shash:
> +	kfree(shash);
> +out_free_key:
> +	crypto_free_shash(key_tfm);
> +	if (ret < 0) {
> +		kfree_sensitive(transformed_key);
> +		return ERR_PTR(ret);
> +	}
> +	return transformed_key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
> +
> +static int nvme_auth_send(struct nvme_ctrl *ctrl, int qid,
> +		void *data, size_t tl)
> +{
> +	struct nvme_command cmd = {};
> +	blk_mq_req_flags_t flags = qid == NVME_QID_ANY ?
> +		0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED;
> +	struct request_queue *q = qid == NVME_QID_ANY ?
> +		ctrl->fabrics_q : ctrl->connect_q;
> +	int ret;
> +
> +	cmd.auth_send.opcode = nvme_fabrics_command;
> +	cmd.auth_send.fctype = nvme_fabrics_type_auth_send;
> +	cmd.auth_send.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
> +	cmd.auth_send.spsp0 = 0x01;
> +	cmd.auth_send.spsp1 = 0x01;
> +	cmd.auth_send.tl = cpu_to_le32(tl);
> +
> +	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, tl, 0, qid,
> +				     0, flags);
> +	if (ret > 0)
> +		dev_dbg(ctrl->device,
> +			"%s: qid %d nvme status %d\n", __func__, qid, ret);

dev_err? Also can we phrase "failed auth_send" instead of the __func__?

> +	else if (ret < 0)
> +		dev_dbg(ctrl->device,
> +			"%s: qid %d error %d\n", __func__, qid, ret);

dev_err?

> +	return ret;
> +}
> +
> +static int nvme_auth_receive(struct nvme_ctrl *ctrl, int qid,
> +		void *buf, size_t al)
> +{
> +	struct nvme_command cmd = {};
> +	blk_mq_req_flags_t flags = qid == NVME_QID_ANY ?
> +		0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED;
> +	struct request_queue *q = qid == NVME_QID_ANY ?
> +		ctrl->fabrics_q : ctrl->connect_q;
> +	int ret;
> +
> +	cmd.auth_receive.opcode = nvme_fabrics_command;
> +	cmd.auth_receive.fctype = nvme_fabrics_type_auth_receive;
> +	cmd.auth_receive.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
> +	cmd.auth_receive.spsp0 = 0x01;
> +	cmd.auth_receive.spsp1 = 0x01;
> +	cmd.auth_receive.al = cpu_to_le32(al);
> +
> +	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, buf, al, 0, qid,
> +				     0, flags);
> +	if (ret > 0) {
> +		dev_dbg(ctrl->device, "%s: qid %d nvme status %x\n",
> +			__func__, qid, ret);

dev_err? "failed auth_recv" instead of the __func__

> +		ret = -EIO;
> +	}
> +	if (ret < 0) {
> +		dev_dbg(ctrl->device, "%s: qid %d error %d\n",
> +			__func__, qid, ret);

dev_err

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvme_auth_receive_validate(struct nvme_ctrl *ctrl, int qid,
> +		struct nvmf_auth_dhchap_failure_data *data,
> +		u16 transaction, u8 expected_msg)
> +{
> +	dev_dbg(ctrl->device, "%s: qid %d auth_type %d auth_id %x\n",
> +		__func__, qid, data->auth_type, data->auth_id);
> +
> +	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES &&
> +	    data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> +		return data->rescode_exp;
> +	}
> +	if (data->auth_type != NVME_AUTH_DHCHAP_MESSAGES ||
> +	    data->auth_id != expected_msg) {
> +		dev_warn(ctrl->device,
> +			 "qid %d invalid message %02x/%02x\n",
> +			 qid, data->auth_type, data->auth_id);
> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
> +	}
> +	if (le16_to_cpu(data->t_id) != transaction) {
> +		dev_warn(ctrl->device,
> +			 "qid %d invalid transaction ID %d\n",
> +			 qid, le16_to_cpu(data->t_id));

why not dev_err?

> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
> +	}
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
> +	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
> +
> +	if (chap->buf_size < size) {
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return -EINVAL;
> +	}
> +	memset((u8 *)chap->buf, 0, size);
> +	data->auth_type = NVME_AUTH_COMMON_MESSAGES;
> +	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
> +	data->t_id = cpu_to_le16(chap->transaction);
> +	data->sc_c = 0; /* No secure channel concatenation */
> +	data->napd = 1;
> +	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
> +	data->auth_protocol[0].dhchap.halen = 3;
> +	data->auth_protocol[0].dhchap.dhlen = 6;
> +	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_DHCHAP_SHA256;
> +	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_DHCHAP_SHA384;
> +	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_DHCHAP_SHA512;
> +	data->auth_protocol[0].dhchap.idlist[3] = NVME_AUTH_DHCHAP_DHGROUP_NULL;
> +	data->auth_protocol[0].dhchap.idlist[4] = NVME_AUTH_DHCHAP_DHGROUP_2048;
> +	data->auth_protocol[0].dhchap.idlist[5] = NVME_AUTH_DHCHAP_DHGROUP_3072;
> +	data->auth_protocol[0].dhchap.idlist[6] = NVME_AUTH_DHCHAP_DHGROUP_4096;
> +	data->auth_protocol[0].dhchap.idlist[7] = NVME_AUTH_DHCHAP_DHGROUP_6144;
> +	data->auth_protocol[0].dhchap.idlist[8] = NVME_AUTH_DHCHAP_DHGROUP_8192;
> +
> +	return size;
> +}
> +
> +static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_challenge_data *data = chap->buf;
> +	u16 dhvlen = le16_to_cpu(data->dhvlen);
> +	size_t size = sizeof(*data) + data->hl + dhvlen;
> +	const char *hmac_name, *kpp_name;
> +
> +	if (chap->buf_size < size) {
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	hmac_name = nvme_auth_hmac_name(data->hashid);
> +	if (!hmac_name) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid HASH ID %d\n",
> +			 chap->qid, data->hashid);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	if (chap->hash_id == data->hashid && chap->shash_tfm &&
> +	    !strcmp(crypto_shash_alg_name(chap->shash_tfm), hmac_name) &&
> +	    crypto_shash_digestsize(chap->shash_tfm) == data->hl) {
> +		dev_dbg(ctrl->device,
> +			"qid %d: reuse existing hash %s\n",
> +			chap->qid, hmac_name);
> +		goto select_kpp;
> +	}
> +
> +	/* Reset if hash cannot be reused */
> +	if (chap->shash_tfm) {
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->hash_id = 0;
> +		chap->hash_len = 0;
> +	}
> +	chap->shash_tfm = crypto_alloc_shash(hmac_name, 0,
> +					     CRYPTO_ALG_ALLOCATES_MEMORY);
> +	if (IS_ERR(chap->shash_tfm)) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: failed to allocate hash %s, error %ld\n",
> +			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
> +		chap->shash_tfm = NULL;
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	if (crypto_shash_digestsize(chap->shash_tfm) != data->hl) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid hash length %d\n",
> +			 chap->qid, data->hl);
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->shash_tfm = NULL;
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	/* Reset host response if the hash had been changed */
> +	if (chap->hash_id != data->hashid) {
> +		kfree(chap->host_response);
> +		chap->host_response = NULL;
> +	}
> +
> +	chap->hash_id = data->hashid;
> +	chap->hash_len = data->hl;
> +	dev_dbg(ctrl->device, "qid %d: selected hash %s\n",
> +		chap->qid, hmac_name);
> +
> +select_kpp:
> +	kpp_name = nvme_auth_dhgroup_kpp(data->dhgid);
> +	if (!kpp_name) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid DH group id %d\n",
> +			 chap->qid, data->dhgid);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	if (data->dhgid != NVME_AUTH_DHCHAP_DHGROUP_NULL) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: unsupported DH group %s\n",
> +			 chap->qid, kpp_name);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	} else if (dhvlen != 0) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid DH value for NULL DH\n",
> +			 chap->qid);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +	chap->dhgroup_id = data->dhgid;
> +
> +	chap->s1 = le32_to_cpu(data->seqnum);
> +	memcpy(chap->c1, data->cval, chap->hash_len);
> +
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_reply_data *data = chap->buf;
> +	size_t size = sizeof(*data);
> +
> +	size += 2 * chap->hash_len;
> +
> +	if (chap->buf_size < size) {
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return -EINVAL;
> +	}
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
> +	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
> +	data->t_id = cpu_to_le16(chap->transaction);
> +	data->hl = chap->hash_len;
> +	data->dhvlen = 0;
> +	memcpy(data->rval, chap->response, chap->hash_len);
> +	if (ctrl->opts->dhchap_ctrl_secret) {
> +		get_random_bytes(chap->c2, chap->hash_len);
> +		data->cvalid = 1;
> +		chap->s2 = atomic_inc_return(&nvme_dhchap_seqnum);
> +		memcpy(data->rval + chap->hash_len, chap->c2,
> +		       chap->hash_len);
> +		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
> +			__func__, chap->qid,
> +			chap->hash_len, chap->c2);
> +	} else {
> +		memset(chap->c2, 0, chap->hash_len);
> +		chap->s2 = 0;
> +	}
> +	data->seqnum = cpu_to_le32(chap->s2);
> +	return size;
> +}
> +
> +static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
> +	size_t size = sizeof(*data);
> +
> +	if (ctrl->opts->dhchap_ctrl_secret)
> +		size += chap->hash_len;
> +
> +	if (chap->buf_size < size) {
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	if (data->hl != chap->hash_len) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid hash length %d\n",
> +			 chap->qid, data->hl);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	/* Just print out information for the admin queue */
> +	if (chap->qid == -1)
> +		dev_info(ctrl->device,
> +			 "qid 0: authenticated with hash %s dhgroup %s\n",
> +			 nvme_auth_hmac_name(chap->hash_id),
> +			 nvme_auth_dhgroup_name(chap->dhgroup_id));
> +
> +	if (!data->rvalid)
> +		return 0;
> +
> +	/* Validate controller response */
> +	if (memcmp(chap->response, data->rval, data->hl)) {
> +		dev_dbg(ctrl->device, "%s: qid %d ctrl response %*ph\n",
> +			__func__, chap->qid, chap->hash_len, data->rval);
> +		dev_dbg(ctrl->device, "%s: qid %d host response %*ph\n",
> +			__func__, chap->qid, chap->hash_len, chap->response);
> +		dev_warn(ctrl->device,
> +			 "qid %d: controller authentication failed\n",
> +			 chap->qid);
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	/* Just print out information for the admin queue */
> +	if (chap->qid == -1)
> +		dev_info(ctrl->device,
> +			 "qid 0: controller authenticated\n");
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_success2_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_success2_data *data = chap->buf;
> +	size_t size = sizeof(*data);
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
> +	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2;
> +	data->t_id = cpu_to_le16(chap->transaction);
> +
> +	return size;
> +}
> +
> +static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_failure_data *data = chap->buf;
> +	size_t size = sizeof(*data);
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
> +	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
> +	data->t_id = cpu_to_le16(chap->transaction);
> +	data->rescode = NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED;
> +	data->rescode_exp = chap->status;
> +
> +	return size;
> +}
> +
> +static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> +	u8 buf[4], *challenge = chap->c1;
> +	int ret;
> +
> +	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
> +		__func__, chap->qid, chap->s1, chap->transaction);
> +
> +	if (!chap->host_response) {
> +		chap->host_response = nvme_auth_transform_key(ctrl->dhchap_key,
> +					ctrl->dhchap_key_len,
> +					ctrl->dhchap_key_hash,
> +					ctrl->opts->host->nqn);
> +		if (IS_ERR(chap->host_response)) {
> +			ret = PTR_ERR(chap->host_response);
> +			chap->host_response = NULL;
> +			return ret;
> +		}
> +	} else {
> +		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
> +			__func__, chap->qid);
> +	}
> +
> +	ret = crypto_shash_setkey(chap->shash_tfm,
> +			chap->host_response, ctrl->dhchap_key_len);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +			 chap->qid, ret);
> +		goto out;
> +	}
> +
> +	shash->tfm = chap->shash_tfm;
> +	ret = crypto_shash_init(shash);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, challenge, chap->hash_len);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le32(chap->s1, buf);
> +	ret = crypto_shash_update(shash, buf, 4);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le16(chap->transaction, buf);
> +	ret = crypto_shash_update(shash, buf, 2);
> +	if (ret)
> +		goto out;
> +	memset(buf, 0, sizeof(buf));
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, "HostHost", 8);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
> +				  strlen(ctrl->opts->host->nqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
> +			    strlen(ctrl->opts->subsysnqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_final(shash, chap->response);
> +out:
> +	if (challenge != chap->c1)
> +		kfree(challenge);
> +	return ret;
> +}
> +
> +static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> +	u8 *ctrl_response;
> +	u8 buf[4], *challenge = chap->c2;
> +	int ret;
> +
> +	ctrl_response = nvme_auth_transform_key(ctrl->dhchap_ctrl_key,
> +				ctrl->dhchap_ctrl_key_len,
> +				ctrl->dhchap_ctrl_key_hash,
> +				ctrl->opts->subsysnqn);
> +	if (IS_ERR(ctrl_response)) {
> +		ret = PTR_ERR(ctrl_response);
> +		return ret;
> +	}
> +	ret = crypto_shash_setkey(chap->shash_tfm,
> +			ctrl_response, ctrl->dhchap_ctrl_key_len);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +			 chap->qid, ret);
> +		goto out;
> +	}
> +
> +	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
> +		__func__, chap->qid, chap->s2, chap->transaction);
> +	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
> +		__func__, chap->qid, chap->hash_len, challenge);
> +	dev_dbg(ctrl->device, "%s: qid %d subsysnqn %s\n",
> +		__func__, chap->qid, ctrl->opts->subsysnqn);
> +	dev_dbg(ctrl->device, "%s: qid %d hostnqn %s\n",
> +		__func__, chap->qid, ctrl->opts->host->nqn);
> +	shash->tfm = chap->shash_tfm;
> +	ret = crypto_shash_init(shash);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, challenge, chap->hash_len);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le32(chap->s2, buf);
> +	ret = crypto_shash_update(shash, buf, 4);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le16(chap->transaction, buf);
> +	ret = crypto_shash_update(shash, buf, 2);
> +	if (ret)
> +		goto out;
> +	memset(buf, 0, 4);
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, "Controller", 10);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
> +				  strlen(ctrl->opts->subsysnqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
> +				  strlen(ctrl->opts->host->nqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_final(shash, chap->response);
> +out:
> +	if (challenge != chap->c2)
> +		kfree(challenge);
> +	return ret;
> +}
> +
> +int nvme_auth_generate_key(struct nvme_ctrl *ctrl)
> +{
> +	u8 *secret = ctrl->opts->dhchap_secret;
> +	u8 *key;
> +	size_t key_len;
> +	u8 key_hash;
> +
> +	if (!secret)
> +		return 0;
> +
> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> +		return -EINVAL;
> +
> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> +	key = nvme_auth_extract_secret(secret + 10, key_hash,
> +				       &key_len);
> +	if (IS_ERR(key)) {
> +		dev_dbg(ctrl->device, "failed to extract key, error %ld\n",
> +			PTR_ERR(key));
> +		return PTR_ERR(key);
> +	}
> +
> +	ctrl->dhchap_key = key;
> +	key = NULL;
> +	ctrl->dhchap_key_len = key_len;
> +	ctrl->dhchap_key_hash = key_hash;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
> +
> +int nvme_auth_generate_ctrl_key(struct nvme_ctrl *ctrl)
> +{
> +	u8 *secret = ctrl->opts->dhchap_ctrl_secret;
> +	u8 *key;
> +	size_t key_len;
> +	u8 key_hash;
> +
> +	if (!secret)
> +		return 0;
> +
> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> +		return -EINVAL;
> +
> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> +	key = nvme_auth_extract_secret(secret + 10, key_hash,
> +				       &key_len);
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);
> +
> +	ctrl->dhchap_ctrl_key = key;
> +	key = NULL;
> +	ctrl->dhchap_ctrl_key_len = key_len;
> +	ctrl->dhchap_ctrl_key_hash = key_hash;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_generate_ctrl_key);

This and the other look identical just operate on
a different key, perhaps merge them into one?

Overall this looks sane to me.
Just nitpicking on the logging to use err when you
hit a errors.
