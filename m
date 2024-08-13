Return-Path: <linux-crypto+bounces-5934-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A310B95036A
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Aug 2024 13:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6B81F23E3A
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Aug 2024 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773B8194AE6;
	Tue, 13 Aug 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQy2Ydce"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B12233A
	for <linux-crypto@vger.kernel.org>; Tue, 13 Aug 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547742; cv=none; b=A+dObR5gGZJxGky7FLwUG/QxE5RwKqOFk+xYLrrUVzMzAPneHTKp2ipUEBsQqJaaFFqwj/PSu0m2BBGDFPnNMOWNvQPtYPUpiWppU8zo7dN3X9pcYBriP9Dffb8hzu2rAJP0Jo4EgK7L2CIpsy7DoWRMUw9AXXO6XgNKJogSjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547742; c=relaxed/simple;
	bh=FvaAP/PZSe5da8Br0cOgaV4n77+sOCWgAbrcmYowNpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrpOFc2RfGonH9mpsRRmHNdxF5S9moxchbx0DabdgX/j8Xn4gAPwllAUUgokDQvLO7Xbrfb/cPSUx4/wSIO8eLIUDBGmER9c8a6b5yM2HUY6a7y5BKZNrVY9AXnHv1XJXnz4lAP4GKf+vXYtfUWdGIHvy4O9y4x7UjoQGoUuaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQy2Ydce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F69BC4AF16;
	Tue, 13 Aug 2024 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547740;
	bh=FvaAP/PZSe5da8Br0cOgaV4n77+sOCWgAbrcmYowNpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQy2YdceYUV/VtsPibuUkBwNrbwHb3o0k2mZPXtpaVfQUay2Iqsrgzfwb+Ihj0QKF
	 cGDcsdREzIhXO5p7e7m8FhovUp1XPeLyY5FTYG57T8LFfmiFDW9GFHsKJwxb5epEPz
	 SvBQ1QBmooWVgmxAGteZSQAP5WkxVLWRHdBwhkuMRmhtr9j4edw2+SEUOd6oZ30Yy6
	 6metfeh+naLczAV3UyVXQHBsag5kw5zTWBK6SWh1U7H6QATXEBLVdJKRub8ZqrZuZc
	 kLnUt1Smoe8ip41s4EjqB1aGLMv4nQPj0q++sdf/+dTJ/ISZrAH4NoAi+PZFVbxnWH
	 hSpZs1QnhPoiw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/9] nvme-keyring: add nvme_tls_psk_refresh()
Date: Tue, 13 Aug 2024 13:15:08 +0200
Message-Id: <20240813111512.135634-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813111512.135634-1-hare@kernel.org>
References: <20240813111512.135634-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to refresh a generated PSK in the specified keyring.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 64 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  9 +++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index ed5167f942d8..8cb253fcd586 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -124,6 +124,70 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+/**
+ * nvme_tls_psk_refresh - Refresh TLS PSK
+ * @keyring: Keyring holding the TLS PSK
+ * @hostnqn: Host NQN to use
+ * @subnqn: Subsystem NQN to use
+ * @hmac_id: Hash function identifier
+ * @data: TLS PSK key material
+ * @data_len: Length of @data
+ * @digest: TLS PSK digest
+ *
+ * Refresh a generated version 1 TLS PSK with the identity generated
+ * from @hmac_id, @hostnqn, @subnqn, and @digest in the keyring given
+ * by @keyring.
+ *
+ * Returns the updated key success or an error pointer otherwise.
+ */
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest)
+{
+	key_perm_t keyperm =
+		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
+		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
+		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
+	char *identity;
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+	struct key *key;
+
+	if (!hostnqn || !subnqn || !data || !data_len)
+		return ERR_PTR(-EINVAL);
+
+	identity = kasprintf(GFP_KERNEL, "NVMe1G%02d %s %s %s",
+		 hmac_id, hostnqn, subnqn, digest);
+	if (!identity)
+		return ERR_PTR(-ENOMEM);
+
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+	pr_debug("keyring %x refresh tls psk '%s'\n",
+		 keyring_id, identity);
+	keyref = key_create_or_update(make_key_ref(keyring, true),
+				"psk", identity, data, data_len,
+				keyperm, KEY_ALLOC_NOT_IN_QUOTA |
+				      KEY_ALLOC_BUILT_IN |
+				      KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(keyref)) {
+		pr_debug("refresh tls psk '%s' failed, error %ld\n",
+			 identity, PTR_ERR(keyref));
+		kfree(identity);
+		return ERR_PTR(-ENOKEY);
+	}
+	kfree(identity);
+	/*
+	 * Set the default timeout to 1 hour
+	 * as suggested in TP8018.
+	 */
+	key = key_ref_to_ptr(keyref);
+	key_set_timeout(key, 3600);
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_psk_refresh);
+
 /*
  * NVMe PSK priority list
  *
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 19d2b256180f..351a02b1bbc3 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,6 +8,9 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
@@ -15,6 +18,12 @@ key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
+static struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
 {
-- 
2.35.3


