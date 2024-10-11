Return-Path: <linux-crypto+bounces-7260-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE599A86C
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2024 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CC6285705
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2024 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A96198827;
	Fri, 11 Oct 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaUkIu6T"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDD18EFC1
	for <linux-crypto@vger.kernel.org>; Fri, 11 Oct 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662105; cv=none; b=qhJghSOha0zaGms2g3j9LNYEVK5p3Fphqb0iRVGD4PwcpJ2/BEIx+jX9dLAKb5OyDOeaw1aGnFxfQ9J27AcCDq3DSiT3bjE4AgY6pLGhSylcHw7kqqTzoRqPH1/BKXXjA5F4U+1zRGRupu82VinvrRYiT5ZWxyMbctHKdCoviEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662105; c=relaxed/simple;
	bh=Am+r76JuH7opOfj/Fb3p6G35hWv7Dvsbu8bmE7sZIFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mD4mKTkcCag2fLp2b2INyGbUSrdjTFigfdMcw64P9v0d0Mv8WfgyRkilcHUn/gMapQXQMvlsYVEVa4HCxI3/Epu2PC13EbhH9SYBgWevDLO72Cj6lWWcRIKspG/ClEXdj2gCzoM+vqoANx6f5aP/dEbsETHiAHiOawuigNFpWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaUkIu6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE5C4CECF;
	Fri, 11 Oct 2024 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662105;
	bh=Am+r76JuH7opOfj/Fb3p6G35hWv7Dvsbu8bmE7sZIFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaUkIu6Tr/q0l5eHRekTuVfGz0f0RMRxv3xIGZwndLv/qn50Gv7zizh/Vgic1RhT3
	 72JJOoPS2wjGpWucXMSy8w++ufcarDvKhNxG5wa2hhTSkTU3pyhxtwHIgR2p68RUyt
	 ed7hJuURRwg2+lhiLVksWjPvIo1pbhpTpSdkcoWd9H3UZanDd8zceAf5qei1TVq6Jy
	 vYSrzLpHsbny3y7fsQksNDIKD6QT5Bbif0FWEXrowqLWUb/s9bd3jZyckbg+Id6waq
	 Bs6MHl9I1hcOTldJ7XFM1alGWnvtDKe+D/GKSfnUr5HLqc1kSoV6QT1teQZHbEjLOz
	 Xl7g/jm8z2dlQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/9] nvmet-tcp: support secure channel concatenation
Date: Fri, 11 Oct 2024 17:54:29 +0200
Message-Id: <20241011155430.43450-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241011155430.43450-1-hare@kernel.org>
References: <20241011155430.43450-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
the generated PSK once negotiation has finished.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c             | 72 +++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++++---
 drivers/nvme/target/fabrics-cmd.c      | 33 +++++++++---
 drivers/nvme/target/nvmet.h            | 38 +++++++++++---
 drivers/nvme/target/tcp.c              | 23 +++++++-
 5 files changed, 192 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 7897d02c681d..7470ac020db6 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 #include <asm/unaligned.h>
 
 #include "nvmet.h"
@@ -138,7 +139,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -164,6 +165,11 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		goto out_unlock;
 	}
 
+	if (nvmet_queue_tls_keyid(req->sq)) {
+		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
+		goto out_unlock;
+	}
+
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
 	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
@@ -232,6 +238,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	sq->tls_key = 0;
+#endif
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
@@ -260,6 +269,12 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 		nvme_auth_free_key(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	if (ctrl->tls_key) {
+		key_put(ctrl->tls_key);
+		ctrl->tls_key = NULL;
+	}
+#endif
 }
 
 bool nvmet_check_auth_status(struct nvmet_req *req)
@@ -541,3 +556,58 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 
 	return ret;
 }
+
+void nvmet_auth_insert_psk(struct nvmet_sq *sq)
+{
+	int hash_len = nvme_auth_hmac_hash_len(sq->ctrl->shash_id);
+	u8 *psk, *digest, *tls_psk;
+	size_t psk_len;
+	int ret;
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key *tls_key = NULL;
+#endif
+
+	ret = nvme_auth_generate_psk(sq->ctrl->shash_id,
+				     sq->dhchap_skey,
+				     sq->dhchap_skey_len,
+				     sq->dhchap_c1, sq->dhchap_c2,
+				     hash_len, &psk, &psk_len);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to generate PSK, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		return;
+	}
+	ret = nvme_auth_generate_digest(sq->ctrl->shash_id, psk, psk_len,
+					sq->ctrl->subsysnqn,
+					sq->ctrl->hostnqn, &digest);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to generate digest, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		goto out_free_psk;
+	}
+	ret = nvme_auth_derive_tls_psk(sq->ctrl->shash_id, psk, psk_len,
+				       digest, &tls_psk);
+	if (ret) {
+		pr_warn("%s: ctrl %d qid %d failed to derive TLS PSK, error %d\n",
+			__func__, sq->ctrl->cntlid, sq->qid, ret);
+		goto out_free_digest;
+	}
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
+				       sq->ctrl->shash_id, tls_psk, psk_len, digest);
+	if (IS_ERR(tls_key)) {
+		pr_warn("%s: ctrl %d qid %d failed to refresh key, error %ld\n",
+			__func__, sq->ctrl->cntlid, sq->qid, PTR_ERR(tls_key));
+		tls_key = NULL;
+		kfree_sensitive(tls_psk);
+	}
+	if (sq->ctrl->tls_key)
+		key_put(sq->ctrl->tls_key);
+	sq->ctrl->tls_key = tls_key;
+#endif
+
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_psk:
+	kfree_sensitive(psk);
+}
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 3f2857c17d95..cf4b38c0e7bd 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -43,8 +43,26 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 		 data->auth_protocol[0].dhchap.halen,
 		 data->auth_protocol[0].dhchap.dhlen);
 	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
-	if (data->sc_c)
-		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	if (data->sc_c != NVME_AUTH_SECP_NOSC) {
+		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		/* Secure concatenation can only be enabled on the admin queue */
+		if (req->sq->qid)
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		switch (data->sc_c) {
+		case NVME_AUTH_SECP_NEWTLSPSK:
+			if (nvmet_queue_tls_keyid(req->sq))
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		case NVME_AUTH_SECP_REPLACETLSPSK:
+			if (!nvmet_queue_tls_keyid(req->sq))
+				return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+			break;
+		default:
+			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+		}
+		ctrl->concat = true;
+	}
 
 	if (data->napd != 1)
 		return NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
@@ -103,6 +121,13 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 			 nvme_auth_dhgroup_name(fallback_dhgid));
 		ctrl->dh_gid = fallback_dhgid;
 	}
+	if (ctrl->dh_gid == NVME_AUTH_DHGROUP_NULL &&
+	    ctrl->concat) {
+		pr_debug("%s: ctrl %d qid %d: NULL DH group invalid "
+			 "for secure channel concatenation\n", __func__,
+			 ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
+	}
 	pr_debug("%s: ctrl %d qid %d: selected DH group %s (%d)\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 nvme_auth_dhgroup_name(ctrl->dh_gid), ctrl->dh_gid);
@@ -154,6 +179,12 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	kfree(response);
 	pr_debug("%s: ctrl %d qid %d host authenticated\n",
 		 __func__, ctrl->cntlid, req->sq->qid);
+	if (!data->cvalid && ctrl->concat) {
+		pr_debug("%s: ctrl %d qid %d invalid challenge\n",
+			 __func__, ctrl->cntlid, req->sq->qid);
+		return NVME_AUTH_DHCHAP_FAILURE_FAILED;
+	}
+	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 	if (data->cvalid) {
 		req->sq->dhchap_c2 = kmemdup(data->rval + data->hl, data->hl,
 					     GFP_KERNEL);
@@ -163,11 +194,15 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
 			 req->sq->dhchap_c2);
-	} else {
+	}
+	if (req->sq->dhchap_s2 == 0) {
+		if (ctrl->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
+		kfree(req->sq->dhchap_c2);
 		req->sq->dhchap_c2 = NULL;
-	}
-	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
+	} else if (!data->cvalid)
+		req->sq->authenticated = true;
 
 	return 0;
 }
@@ -241,7 +276,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl);
+				dhchap_status = nvmet_setup_auth(ctrl, req);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
@@ -298,6 +333,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		}
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
+		if (ctrl->concat)
+			nvmet_auth_insert_psk(req->sq);
 		req->sq->authenticated = true;
 		pr_debug("%s: ctrl %d qid %d ctrl authenticated\n",
 			 __func__, ctrl->cntlid, req->sq->qid);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index c4b2eddd5666..9a1256deee51 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -199,10 +199,26 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	return ret;
 }
 
-static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl)
+static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
+	bool needs_auth = nvmet_has_auth(ctrl, req);
+	key_serial_t keyid = nvmet_queue_tls_keyid(req->sq);
+
+	/* Do not authenticate I/O queues for secure concatenation */
+	if (ctrl->concat && req->sq->qid)
+		needs_auth = false;
+
+	if (keyid)
+		pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 needs_auth ? "" : "not ", keyid);
+	else
+		pr_debug("%s: ctrl %d qid %d should %sauthenticate%s\n",
+			 __func__, ctrl->cntlid, req->sq->qid,
+			 needs_auth ? "" : "not ",
+			 ctrl->concat ? ", secure concatenation" : "");
 	return (u32)ctrl->cntlid |
-		(nvmet_has_auth(ctrl) ? NVME_CONNECT_AUTHREQ_ATR : 0);
+		(needs_auth ? NVME_CONNECT_AUTHREQ_ATR : 0);
 }
 
 static void nvmet_execute_admin_connect(struct nvmet_req *req)
@@ -251,7 +267,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl);
+	dhchap_status = nvmet_setup_auth(ctrl, req);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
@@ -269,12 +285,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s.\n",
+	pr_info("creating %s controller %d for subsystem %s for NQN %s%s%s%s.\n",
 		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
 		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
-		ctrl->pi_support ? " T10-PI is enabled" : "",
-		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+		ctrl->pi_support ? ", T10-PI" : "",
+		nvmet_has_auth(ctrl, req) ? ", DH-HMAC-CHAP" : "",
+		nvmet_queue_tls_keyid(req->sq) ? ", TLS" : "");
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
@@ -330,7 +347,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
-	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
+	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl, req));
 out:
 	kfree(d);
 complete:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..c2e17201c757 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -121,6 +121,9 @@ struct nvmet_sq {
 	u32			dhchap_s2;
 	u8			*dhchap_skey;
 	int			dhchap_skey_len;
+#endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
 #endif
 	struct completion	free_done;
 	struct completion	confirm_done;
@@ -237,6 +240,7 @@ struct nvmet_ctrl {
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 	bool			pi_support;
+	bool			concat;
 #ifdef CONFIG_NVME_TARGET_AUTH
 	struct nvme_dhchap_key	*host_key;
 	struct nvme_dhchap_key	*ctrl_key;
@@ -246,6 +250,9 @@ struct nvmet_ctrl {
 	u8			*dh_key;
 	size_t			dh_keysize;
 #endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	struct key		*tls_key;
+#endif
 };
 
 struct nvmet_subsys {
@@ -716,13 +723,29 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
+{
+	return sq->tls_key ? key_serial(sq->tls_key) : 0;
+}
+static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
+{
+	if (sq->tls_key) {
+		key_put(sq->tls_key);
+		sq->tls_key = NULL;
+	}
+}
+#else
+static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq) { return 0; }
+static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq) {}
+#endif
 #ifdef CONFIG_NVME_TARGET_AUTH
 void nvmet_execute_auth_send(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -732,16 +755,18 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int hash_len);
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 {
-	return ctrl->host_key != NULL;
+	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(req->sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size);
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
+void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
-static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_req *req)
 {
 	return 0;
 }
@@ -754,11 +779,12 @@ static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
 }
-static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
+static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl,
+				  struct nvmet_req *req)
 {
 	return false;
 }
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
+static inline void nvmet_auth_insert_psk(struct nvmet_sq *sq) {};
 #endif
-
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..671600b5c64b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1073,10 +1073,11 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 
 	if (unlikely(!nvmet_req_init(req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_tcp_ops))) {
-		pr_err("failed cmd %p id %d opcode %d, data_len: %d\n",
+		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
-			le32_to_cpu(req->cmd->common.dptr.sgl.length));
+		       le32_to_cpu(req->cmd->common.dptr.sgl.length),
+		       le16_to_cpu(req->cqe->status));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
 		return 0;
@@ -1602,6 +1603,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
+	nvmet_sq_put_tls_key(&queue->nvme_sq);
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
@@ -1807,6 +1809,23 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	spin_unlock_bh(&queue->state_lock);
 
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
+
+	if (!status) {
+		struct key *tls_key = nvme_tls_key_lookup(peerid);
+
+		if (IS_ERR(tls_key)) {
+			pr_warn("%s: queue %d failed to lookup key %x\n",
+				__func__, queue->idx, peerid);
+			spin_lock_bh(&queue->state_lock);
+			queue->state = NVMET_TCP_Q_FAILED;
+			spin_unlock_bh(&queue->state_lock);
+			status = PTR_ERR(tls_key);
+		} else {
+			pr_debug("%s: queue %d using TLS PSK %x\n",
+				 __func__, queue->idx, peerid);
+			queue->nvme_sq.tls_key = tls_key;
+		}
+	}
 	if (status)
 		nvmet_tcp_schedule_release_queue(queue);
 	else
-- 
2.35.3


