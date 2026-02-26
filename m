Return-Path: <linux-crypto+bounces-21218-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMDxEZFeoGlViwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21218-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:54:09 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC781A8043
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D15C8310A619
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2033E9582;
	Thu, 26 Feb 2026 14:46:21 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEA3E9580;
	Thu, 26 Feb 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117180; cv=none; b=EfMckGI1fTKGJ7nj5GFCvFFj0ib8GlEgEW7BzAqUeqkk1XQ/QhPn7MqcBzZmrzWPyL9XeMiI01yACGTdFhdeUaG+LqRQOYKQP4TeEZ4mzA3WO5beP+EHGEIziPJsbJwYn0f3k7+9UJRiz8LBOLQrUQ2qBXUHKlkmtZjeSo7x0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117180; c=relaxed/simple;
	bh=WDbqoRlc5VdtA9YEmUjCjKCV+nqlQWXzMmsmY+2bWsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS8JFCjTO6jTLIzTuJYetz7zZAdCT9RXo0BHrFbpdmv5fq5njxmt5GtLCKbyPi5jX+H8O4xbE6bg71FsA32Ndk53lgIv01dXugwmgf410cSBpxV7PaJsw5PQ1RpDUH1yqommSQtagTiHLJt6McQll2eJnDzsEDwtlgkyZtFO4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66828C19424;
	Thu, 26 Feb 2026 14:46:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] crypto: Clean up CRYPTO_CRC32C usage
Date: Thu, 26 Feb 2026 15:46:08 +0100
Message-ID: <f567add7840bc612382237b3e76f3a8bdbd671e6.1772116160.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772116160.git.geert+renesas@glider.be>
References: <cover.1772116160.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21218-lists,linux-crypto=lfdr.de,renesas];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:mid,glider.be:email]
X-Rspamd-Queue-Id: CCC781A8043
X-Rspamd-Action: no action

Ext4, jbd2, iSCSI, NVMeoF/TCP, and Btrfs stopped using this CRC32c
implementation in commits f2b4fa19647e18a2 ("ext4: switch to using the
crc32c library"), dd348f054b24a3f5 ("jbd2: switch to using the crc32c
library"), 92186c1455a2d356 ("scsi: iscsi_tcp: Switch to using the
crc32c library"), 427fff9aff295e2c ("nvme-tcp: use crc32c() and
skb_copy_and_crc32c_datagram_iter()"), and fe11ac191ce0ad91 ("btrfs:
switch to library APIs for checksums").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 crypto/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 49293b656aff6f52..5e66de2948ed02f9 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1053,8 +1053,6 @@ config CRYPTO_CRC32C
 	  on Communications, Vol. 41, No. 6, June 1993, selected for use with
 	  iSCSI.
 
-	  Used by btrfs, ext4, jbd2, NVMeoF/TCP, and iSCSI.
-
 config CRYPTO_CRC32
 	tristate "CRC32"
 	select CRYPTO_HASH
-- 
2.43.0


