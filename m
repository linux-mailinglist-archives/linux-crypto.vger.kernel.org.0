Return-Path: <linux-crypto+bounces-25669-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ObXFiyRTGpKmQEAu9opvQ
	(envelope-from <linux-crypto+bounces-25669-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:39:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FF717849
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:39:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VNxfwFNa;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25669-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25669-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C543061951
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 05:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FE39DBD3;
	Tue,  7 Jul 2026 05:37:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E477388E49;
	Tue,  7 Jul 2026 05:37:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402642; cv=none; b=R0CCdtVbjE3fHf36uel3paOk2P9aEL40EdPhLCblXaU8BisyV3pfa0YYYWCHiZ3zAG/n0DmdPGnbd9UBRspVScu02gqHxUmwgQJntkJEZfXd8bdA+uunfZGR9HDpH71x+JUdJgWk7QSj8S9LrhdM3hsmXldX8mNHcLalq55ao+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402642; c=relaxed/simple;
	bh=wnM35bJcOrJW22IbMYdfntJ03MQkTuCcS9UbLh1bL9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTLVPa5V+Qv9EW44DK8Yrk2qGC5f223Dm0msoRnC9S4pnHFMXR+NeCzTpdaRlhiH1Te0zgHIycZv/aYxTD8keng24HF6ksO3WskD/mYQZznVZNNgODGF/j41MNFV0zW34oaSulLA76APTtvMUhaM7+anuymJRYY1V1+9Xf0ujrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNxfwFNa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4071F00ADF;
	Tue,  7 Jul 2026 05:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783402640;
	bh=hAKO0zcfr94vN6Gl2AEd3YrY6lcA0R+sy07m8WcBAq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNxfwFNahzvFW5d2ACnLY6FXEB50wCOITn6eBsl5uPVUsMxNe6Xl1NmSx9wW3nERO
	 FFqORB9sTKVCJWXYZ7xFMxAWo+1WQccb7QWo+vRthopeQejMDCxxGUrNEiiDCu1hVs
	 tu/IU/WiGw5dgX7GwDpwqFkyj0+p756xyuEe9+7eNxSgJBDIS6yOQWyT6C54Oinuuv
	 xkLPstCObLb8h4c4YeqUrV56hE11RTMAbdCPET5VnjrKNV+OoJEq2eKaP1I99pJP96
	 +7oFSzHrKQHhfZHLJj+aygEyTVxBiOgMYolBaA/3gJsbSjnfoL+iiIkbeqQNfMy7lE
	 jX+JJl6P/+6yQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 14/33] x86/sev: Use new AES-GCM library
Date: Mon,  6 Jul 2026 22:34:44 -0700
Message-ID: <20260707053503.209874-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707053503.209874-1-ebiggers@kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25669-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B34FF717849

The old AES-GCM library code is being replaced as part of an overhaul
that is adding support for all the common AES encryption modes with
consistent conventions.  The SEV code is the only client of the old
AES-GCM code, so update it to the new API.

Besides some slight adjustments to the calling convention, the only
notable change is replacing the direct accesses to the auth tag length
field (which should be considered private until/unless someone truly
needs it) with the AUTHTAG_LEN constant.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/Kconfig                        |  2 +-
 arch/x86/coco/sev/core.c                | 44 ++++++++++++-------------
 arch/x86/include/asm/sev.h              |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c |  7 ++--
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..0b89641cac16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1495,7 +1495,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select UNACCEPTED_MEMORY
-	select CRYPTO_LIB_AESGCM
+	select CRYPTO_LIB_AES_GCM
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd77d3217f3..085bbee6baf4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -25,7 +25,7 @@
 #include <linux/psp-sev.h>
 #include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
-#include <crypto/gcm.h>
+#include <crypto/aes-gcm.h>
 
 #include <asm/init.h>
 #include <asm/cpu_entry_area.h>
@@ -1535,21 +1535,21 @@ static u8 *get_vmpck(int id, struct snp_secrets_page *secrets, u32 **seqno)
 	return key;
 }
 
-static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
+static struct aes_gcm_key *snp_init_crypto(const u8 *key, size_t keylen)
 {
-	struct aesgcm_ctx *ctx;
+	struct aes_gcm_key *gcm_key;
 
-	ctx = kzalloc_obj(*ctx);
-	if (!ctx)
+	gcm_key = kzalloc_obj(*gcm_key);
+	if (!gcm_key)
 		return NULL;
 
-	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
-		pr_err("Crypto context initialization failed\n");
-		kfree(ctx);
+	if (aes_gcm_preparekey(gcm_key, key, keylen, AUTHTAG_LEN)) {
+		pr_err("AES-GCM key preparation failed\n");
+		kfree(gcm_key);
 		return NULL;
 	}
 
-	return ctx;
+	return gcm_key;
 }
 
 int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id)
@@ -1572,8 +1572,8 @@ int snp_msg_init(struct snp_msg_desc *mdesc, int vmpck_id)
 
 	mdesc->vmpck_id = vmpck_id;
 
-	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
-	if (!mdesc->ctx)
+	mdesc->gcm_key = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
+	if (!mdesc->gcm_key)
 		return -ENOMEM;
 
 	return 0;
@@ -1624,7 +1624,7 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	if (!mdesc)
 		return;
 
-	kfree(mdesc->ctx);
+	kfree(mdesc->gcm_key);
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 	iounmap((__force void __iomem *)mdesc->secrets);
@@ -1709,7 +1709,7 @@ static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_r
 	struct snp_guest_msg *req_msg = &mdesc->secret_request;
 	struct snp_guest_msg_hdr *req_msg_hdr = &req_msg->hdr;
 	struct snp_guest_msg_hdr *resp_msg_hdr = &resp_msg->hdr;
-	struct aesgcm_ctx *ctx = mdesc->ctx;
+	struct aes_gcm_key *gcm_key = mdesc->gcm_key;
 	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
@@ -1732,23 +1732,21 @@ static int verify_and_dec_payload(struct snp_msg_desc *mdesc, struct snp_guest_r
 	 * If the message size is greater than our buffer length then return
 	 * an error.
 	 */
-	if (unlikely((resp_msg_hdr->msg_sz + ctx->authsize) > req->resp_sz))
+	if (unlikely(resp_msg_hdr->msg_sz + AUTHTAG_LEN > req->resp_sz))
 		return -EBADMSG;
 
 	/* Decrypt the payload */
 	memcpy(iv, &resp_msg_hdr->msg_seqno, min(sizeof(iv), sizeof(resp_msg_hdr->msg_seqno)));
-	if (!aesgcm_decrypt(ctx, req->resp_buf, resp_msg->payload, resp_msg_hdr->msg_sz,
-			    &resp_msg_hdr->algo, AAD_LEN, iv, resp_msg_hdr->authtag))
-		return -EBADMSG;
-
-	return 0;
+	return aes_gcm_decrypt(req->resp_buf, resp_msg->payload,
+			       resp_msg_hdr->authtag, resp_msg_hdr->msg_sz,
+			       &resp_msg_hdr->algo, AAD_LEN, iv, gcm_key);
 }
 
 static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_req *req)
 {
 	struct snp_guest_msg *msg = &mdesc->secret_request;
 	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct aesgcm_ctx *ctx = mdesc->ctx;
+	struct aes_gcm_key *gcm_key = mdesc->gcm_key;
 	u8 iv[GCM_AES_IV_SIZE] = {};
 
 	memset(msg, 0, sizeof(*msg));
@@ -1769,12 +1767,12 @@ static int enc_payload(struct snp_msg_desc *mdesc, u64 seqno, struct snp_guest_r
 	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
 		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
-	if (WARN_ON((req->req_sz + ctx->authsize) > sizeof(msg->payload)))
+	if (WARN_ON(req->req_sz + AUTHTAG_LEN > sizeof(msg->payload)))
 		return -EBADMSG;
 
 	memcpy(iv, &hdr->msg_seqno, min(sizeof(iv), sizeof(hdr->msg_seqno)));
-	aesgcm_encrypt(ctx, msg->payload, req->req_buf, req->req_sz, &hdr->algo,
-		       AAD_LEN, iv, hdr->authtag);
+	aes_gcm_encrypt(msg->payload, hdr->authtag, req->req_buf, req->req_sz,
+			&hdr->algo, AAD_LEN, iv, gcm_key);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 594cfa19cbd4..9e7a077c445d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -314,7 +314,7 @@ struct snp_msg_desc {
 
 	struct snp_secrets_page *secrets;
 
-	struct aesgcm_ctx *ctx;
+	struct aes_gcm_key *gcm_key;
 
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d186ae55cf63..935537a41469 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -17,7 +17,6 @@
 #include <linux/set_memory.h>
 #include <linux/fs.h>
 #include <linux/tsm.h>
-#include <crypto/gcm.h>
 #include <linux/psp-sev.h>
 #include <linux/sockptr.h>
 #include <linux/cleanup.h>
@@ -87,7 +86,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
+	resp_len = sizeof(report_resp->data) + AUTHTAG_LEN;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp)
 		return -ENOMEM;
@@ -130,7 +129,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(derived_key_resp->data) + mdesc->ctx->authsize;
+	resp_len = sizeof(derived_key_resp->data) + AUTHTAG_LEN;
 	derived_key_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!derived_key_resp)
 		return -ENOMEM;
@@ -230,7 +229,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
+	resp_len = sizeof(report_resp->data) + AUTHTAG_LEN;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
 	if (!report_resp) {
 		ret = -ENOMEM;
-- 
2.54.0


