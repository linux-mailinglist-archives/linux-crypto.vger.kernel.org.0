Return-Path: <linux-crypto+bounces-8374-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E679E1A3F
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Dec 2024 12:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673AA281E20
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Dec 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE81E3DE6;
	Tue,  3 Dec 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSV2LrNT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DC1E283E
	for <linux-crypto@vger.kernel.org>; Tue,  3 Dec 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223778; cv=none; b=ms6ovJSB3dz0ldDxYI0LpwIhSkkBh3syTWDR9NiTdZc5785mtu+d8d3bwejR9Go0hSbnFBsiWph1d7mV3e6cnXVtil/sVQ3tXTGQaBfVnikGlcs38Lr3jblK+ZoBRzigXsgb7dPkl9eixf7WlvfAsvURw70fwGdkmNiRQgBTMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223778; c=relaxed/simple;
	bh=uNTM3mfcC8n8xFcKb0O6XGynrlWkv7SXX3XHz7IPLRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI6l0t747SPY6ynsLf9otfgV9Y34goq7MCvLHDrk8dOtNFAtEe7yj3FVk0EUVtIYISG99neHmcoU7i7qKNigu40UgCe5J/OHA2XC5yNfcQX+5UHMnwqINl9hOOpd8oqdnhvCbzPZAKq0pIbhDI34t34vdEIg2b/JXWsZv87wU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSV2LrNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD82C4CED9;
	Tue,  3 Dec 2024 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223778;
	bh=uNTM3mfcC8n8xFcKb0O6XGynrlWkv7SXX3XHz7IPLRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSV2LrNTnqrWMIM416VjBCR85vDuMN39wXxXq1ZcjufjbPwerPrjJeSSDNhjBiJJ7
	 +PUizp1bAm6zA2AbqbxzEo3uT8UbEupraYZeKka4ne5xmNY+BOutK+u4H27hzlPTTy
	 Q4rW/ZE46Jch9znhz1PpuZ9cSnWS0vUt5lxEFHlJ6ZrvAtrYW8q5AGoBo5wzXv5qJG
	 ggRqebQXxN1uAMBeZ3XMWOjUBlXQ7JjRS/nhB3Hat9wDzQ4qPsShTawL7Xc2wW2eZ4
	 Jqk/7LrxjBkPfIFHEbU6oFWIE35LSyvs/+Y3yStQsEUXukeUfrw1S7lgWow2e1Apcu
	 +p10EIKtYAnJQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/6] nvme-keyring: add nvme_tls_psk_refresh()
Date: Tue,  3 Dec 2024 12:02:29 +0100
Message-Id: <20241203110238.128630-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241203110238.128630-1-hare@kernel.org>
References: <20241203110238.128630-1-hare@kernel.org>
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
 include/linux/nvme-keyring.h  | 10 +++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

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
index 19d2b256180f..f7bbcbeb4b13 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,13 +8,21 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
-
+static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
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


