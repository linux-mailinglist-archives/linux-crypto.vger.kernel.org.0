Return-Path: <linux-crypto+bounces-23427-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH/LMe+N72mhCwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23427-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 18:25:19 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C047653C
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D890306E808
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747893644CB;
	Mon, 27 Apr 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxOQLuei"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1E355F49;
	Mon, 27 Apr 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306542; cv=none; b=Vur99VucRRt8LmRlbZFtC8Ilk/OR1pminK1S4pogQsZGTp2OZhfi1e+dTFY3wvWFtSZ5rG0GwintnqZCylsQ9EWTKKWb15zfuOvzch+sKYyS14Dncilx+82Wib3615M292g5g5fDYSrrHg1z3cuL8PSkovRO/Zwzs8HuxyxXUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306542; c=relaxed/simple;
	bh=kFNV6IvwRebNmrJadqN5N4ec/NhPbNyKzVZb/1MxaUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9JY4xikpqgMUwC+cV0UFGxQOX8YkcHr9GqxCosZj9A2NdZW0blmCSxhN7Fq9C1lzCjh8Wli9SYz3Vu2IBZl0MepbptGp+P4BgAyGiU8Kkki8y8YlxqI/Ih41nm3iiADF17UGT4tX2tAQeKqGeTCKo5t4UIrYdHRa1ClDVHqbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxOQLuei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9593C2BCB5;
	Mon, 27 Apr 2026 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777306542;
	bh=kFNV6IvwRebNmrJadqN5N4ec/NhPbNyKzVZb/1MxaUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxOQLuei/EJYGbsbItGRY8LBU+KkHm9/1hfR7UIVDhvIqULQl5Bm0hTUYAObXWfZ3
	 5LgqxWnVpx7E90wh1Au8JEEpm035YI2koVERz5hdvCF9RLbhm+Zj1ya1tO2QdH/enk
	 1QAo4TBgyQ0pOrThmDl4uykKsp3+8yi3DZD2OkMD4bB1LJR6FR+WcWZp3BszI5pVWh
	 UjC5Z6BjWc+VgeFBqUFbcq6h8neXyz8+IYoocvEXwdAQUz1vsDk7IefW63l452hp/E
	 fzNRxUiKGM78dd5sqAK1JEcidOiSp7FEH9iNWdGfzm7veRqpHhUPMGLFdBYJpY7VM5
	 DxafetOOSjeVA==
From: Tycho Andersen <tycho@kernel.org>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v1 2/4] crypto/ccp: Do not initialize SNP for ioctl(SNP_COMMIT)
Date: Mon, 27 Apr 2026 10:15:05 -0600
Message-ID: <20260427161507.32686-3-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427161507.32686-1-tycho@kernel.org>
References: <20260427161507.32686-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D8C047653C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23427-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Sashiko notes:

> if SEV initialization fails and KVM is actively running normal VMs, could a
> userspace process trigger this code path via /dev/sev ioctls (e.g.,
> SEV_PDH_GEN) and zero out MSR_VM_HSAVE_PA globally? Would the next VMRUN
> execution for an active VM trigger a general protection fault and crash the
> host?

The SNP_COMMIT command does not require the firmware to be in any
particular state. Skip initializing it if it was previously uninitialized.

The SEV-SNP firmware specification doc 56860 does not mention SNP_COMMIT in
Table 5 as a command that is allowed in the UNINIT state, but it is in fact
allowed and a future documentation update will reflect that.

Fixes: ceac7fb89e8d ("crypto: ccp - Ensure implicit SEV/SNP init and shutdown in ioctls")
Reported-by: Sashiko
Assisted-by: Gemini:gemini-3.1-pro-preview
Link: https://sashiko.dev/#/patchset/20260324161301.1353976-1-tycho%40kernel.org
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6891b90bbb88..572f06368d4b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2437,24 +2437,13 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 
 static int sev_ioctl_do_snp_commit(struct sev_issue_cmd *argp)
 {
-	struct sev_device *sev = psp_master->sev_data;
 	struct sev_data_snp_commit buf;
-	bool shutdown_required = false;
-	int ret, error;
-
-	if (!sev->snp_initialized) {
-		ret = snp_move_to_init_state(argp, &shutdown_required);
-		if (ret)
-			return ret;
-	}
+	int ret;
 
 	buf.len = sizeof(buf);
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error);
 
-	if (shutdown_required)
-		__sev_snp_shutdown_locked(&error, false);
-
 	return ret;
 }
 
-- 
2.53.0


