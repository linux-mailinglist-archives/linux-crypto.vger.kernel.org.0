Return-Path: <linux-crypto+bounces-21808-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EQDJOZ2sGnJjQIAu9opvQ
	(envelope-from <linux-crypto+bounces-21808-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 20:54:14 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC072573D6
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6DC3137B1A
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24F3AD52B;
	Tue, 10 Mar 2026 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcLHkQXG"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804A3B8959;
	Tue, 10 Mar 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172381; cv=none; b=qqM8ODf1w9l+blLmFi8x8Rphj6j31A6DrEmwul0aoa7uaSyHx9xx3NbVo7fDjaazWKjXXmpaSoX9dncfvmj8UwyZEenckjhqJLp7rkYWgVDTIfmlsVQrLb69zs4TxgekYDWXlzKIvdvccMLHXR1VYiis0/h8Noma+7onUv/eNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172381; c=relaxed/simple;
	bh=kN/Vk85gyOzB9l+V19qIFjeAt0h9A4wogUE0W0Vedxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzAP2BA/edMJsYdn7E4cc8lfJRCHHHUIqsTuwzHyfXStZAjeWVMsaVvznJ0N1EhjC0wctADAu8D2TdcD5ClTpti4gihRa/f3dl3VnWsuKn23dwnszwlmUtPXtz0ftdMZGPW7NyExlMFI6S8jWncj47L834Dx3mEDtQTP8jr0NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcLHkQXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3485C2BC87;
	Tue, 10 Mar 2026 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172381;
	bh=kN/Vk85gyOzB9l+V19qIFjeAt0h9A4wogUE0W0Vedxo=;
	h=From:To:Cc:Subject:Date:From;
	b=EcLHkQXGN1Q7dVL+q+zJJ2xH9UCjawRXffJNQ6GZ4CHtIOczRKbmmL2TwPr5Eh+zs
	 2Q/vPcrIVhT3ASSIGI55BC8jsY9g5UNizxG0zNV+14Sx056k5RMV3LIwXC6EuO6Mu2
	 UuvlKjxpjCUxPtaQRbts5a7bOMt+aOJ/ZfPHlS2RTRDTk90KeG0Qf6BWM5OuHLXHGo
	 UWmumdGquktlMqvBaR4tkawYd/Mz1E1rsWEgXWnG0CY5aM5dXcmZX5QT92CPPq3YXW
	 hT3XZUHcYFnfditYPl1IC/+5Tg41SkGrGauKyDOO/R/QRc7STBsx295Jhf0S+pcQsx
	 jk0y6dDwlzG2Q==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15] ksmbd: Compare MACs in constant time
Date: Tue, 10 Mar 2026 12:52:59 -0700
Message-ID: <20260310195259.70949-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BC072573D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21808-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

commit c5794709bc9105935dbedef8b9cf9c06f2b559fa upstream.

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c    | 4 +++-
 fs/ksmbd/smb2pdu.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 647692ca78a28..7a06139274172 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -11,10 +11,11 @@
 #include <linux/writeback.h>
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <crypto/hash.h>
 #include <crypto/aead.h>
+#include <crypto/algapi.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
 #include "auth.h"
 #include "glob.h"
@@ -279,11 +280,12 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	if (rc) {
 		ksmbd_debug(AUTH, "Could not generate sess key\n");
 		goto out;
 	}
 
-	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
+	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
+			  CIFS_HMAC_MD5_HASH_SIZE))
 		rc = -EINVAL;
 out:
 	if (ctx)
 		ksmbd_release_crypto_ctx(ctx);
 	kfree(construct);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9cb..829329abca664 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2,10 +2,11 @@
 /*
  *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
  *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
  */
 
+#include <crypto/algapi.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
 #include <linux/namei.h>
 #include <linux/statfs.h>
@@ -8396,11 +8397,11 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 
 	if (ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, 1,
 				signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
 
 	return 1;
@@ -8484,11 +8485,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	iov[0].iov_len = len;
 
 	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
 
 	return 1;

base-commit: 91d48252ad4b17577cf8cc8d3e1353402e4da8f1
-- 
2.53.0


