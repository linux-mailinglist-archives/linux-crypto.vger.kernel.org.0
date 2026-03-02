Return-Path: <linux-crypto+bounces-21399-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKtvGqynpWngCwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21399-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 16:07:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAD1DB723
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DACA30E2B87
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD5401483;
	Mon,  2 Mar 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5zKctiz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C53E7172;
	Mon,  2 Mar 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463757; cv=none; b=D0HP2YEBylOwrYvvgE6tMHIWQzjACIffKRT+p0c0ucgfh1OtgxAAZnBTQKzPzJRm7qJmd2tWX91Ca9RBXgmJiOG/W55zRm5+85pDqMJbnCZgVX+GvtZAZ9Irbcs8E1Z8Pk8H+7ogPKAZGUJBf7mmQVh4ao7sR17DItbOfZ05+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463757; c=relaxed/simple;
	bh=HHeDj+KF6QektlNz6hjab7qUia77cZtM3PHhvm2nGh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY58CW/BkB+gJllhfSCewR7spCB9P+YJviSWGEp+iWWsmrL9wMR8Jcfs/R3cy8Ebdt3ckjKYkV/XbAXyCoOdz+PWyteL2CY/RmDUtt6fNLgEwXksLYm711Y1sn2LVQ3a3pRk2m4EWLRtxXhag9Qo68Iiy6DXUB48FAabrg9rC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5zKctiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC0CC2BC86;
	Mon,  2 Mar 2026 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772463757;
	bh=HHeDj+KF6QektlNz6hjab7qUia77cZtM3PHhvm2nGh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5zKctizyquGR2/kQT5MhN3zUeb/NlPhYLZL6VutT8AlfnDzYbesbxD1bx63SAoBL
	 405eEI+JhMcLohzn5U5g83AceCZXCWeXyZdMZHJ8vflvEfYmHO2A2GSheSZDXmwYN0
	 YQDxKz4xoIFvozzAzX0+8N3IfqU0lRGX3EwBYRgyNc1GYuTTn1Isx5HTcAhOoLLJn4
	 0gPVOneGAzf+TVAhov5fSYrliTSwTN2fdYPoz64MpnLQ87i1OM/SYDLo7rQ58BRFjX
	 syZac1kCySxP8Gbk0KOD6lnc1Zhjsx+4XD+LEcuYJA0f9UaLByl1cNUJSRy47y/yJ6
	 wJHhaf2YZp+8w==
From: Tycho Andersen <tycho@kernel.org>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] include/psp-sev.h: fix structure member in comment
Date: Mon,  2 Mar 2026 08:02:24 -0700
Message-ID: <20260302150224.786118-2-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302150224.786118-1-tycho@kernel.org>
References: <20260302150224.786118-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BAAD1DB723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21399-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

The member is 'data', not 'opaque'.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 include/uapi/linux/psp-sev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 2b5b042eb73b..52dae70b058b 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -277,7 +277,7 @@ struct sev_user_data_snp_wrapped_vlek_hashstick {
  * struct sev_issue_cmd - SEV ioctl parameters
  *
  * @cmd: SEV commands to execute
- * @opaque: pointer to the command structure
+ * @data: pointer to the command structure
  * @error: SEV FW return code on failure
  */
 struct sev_issue_cmd {
-- 
2.53.0


