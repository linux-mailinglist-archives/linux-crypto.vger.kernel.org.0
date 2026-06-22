Return-Path: <linux-crypto+bounces-25313-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HrGUCDhPOWqoqQcAu9opvQ
	(envelope-from <linux-crypto+bounces-25313-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 17:05:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1806B0964
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 17:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codethink.co.uk header.s=imap5-20230908 header.b=LnswnFRD;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25313-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25313-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=codethink.co.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEFA303D4CF
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362432860B;
	Mon, 22 Jun 2026 15:03:29 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544E3264EF;
	Mon, 22 Jun 2026 15:03:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140609; cv=none; b=FShY9hwdbkh0b5RT5pfMGgNZFnV0+qQDNkFa+qa/3iicPn5vALOaLDIrePRt163JfJonvji4hLAnJj7wWpCjh8oGQHyq3CGyZ+DqhZZFNBS899Z2K/a0RtgzFpWZrkrl3w9LX6Sr+M4rzZ3O+c0R1TVhy8LYhfHF9aLVNUTe7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140609; c=relaxed/simple;
	bh=IrEd8FptjLcghWDqFnK6vKBmn5UYZ8T10P12SGk3/Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuhL2sEKeXFr4nj+B1cGc9/lmEgtuZJXeH41gV1zABEgoUx3UUpk5pCmYgBHHlOgplHyPRUsy9Ncz1LnkP9NLACXRLly6Dh0bFFHpHPaMTUcHC8etMWvf3Fph7eDR0L003hPOmgUFiWL78xYA/GsI+/ogZpsWFIitBDv59iDqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=LnswnFRD; arc=none smtp.client-ip=78.40.148.171
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=0ZvJNbuAq/7ydrarG4EIaziK9KwrNXcz/RJYYERhC2I=; b=LnswnFRDSTNUrX
	Rb/CmjdFWxFrDrfNDG0TOgqTvSN77aTBbyW4wSiV52M627jymZw3Zxg+D/FQQ4dye97PAgapTbpJX
	x1LduxsApNFYcX+0ASvZxnWeQj/bauHyj6g3NYI/BuY5Y/j0qNeVP/zjfNnoRqFeSleLNRz7qisdo
	ixEyGTOxdqqD+dI8fz+t3LlO2Q+snlrp+IEvrGQlvYUkXWE8OzSl7ojesuid4tM7s+HhY7tSCKLjn
	dW7DAVJQfzPFbxzIJcobojG4XXKYUJEAD3akDbvOCoBV0ZKRFBWG9uVLBQ6FCHn+smb6M7lH6pKfP
	03/fQoIV/N3zit6oPOAw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbgBI-005GQs-LT; Mon, 22 Jun 2026 16:03:24 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbgBI-00000002Cw8-1pW0;
	Mon, 22 Jun 2026 16:03:24 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev,
	Gonglei <arei.gonglei@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] crypto: virtio - fix missing le64_to_cpu() conversions
Date: Mon, 22 Jun 2026 16:03:22 +0100
Message-Id: <20260622150322.526375-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap5-20230908];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25313-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:virtualization@lists.linux.dev,m:arei.gonglei@huawei.com,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:ben.dooks@codethink.co.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.dooks@codethink.co.uk,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A1806B0964

There are two cases of sending a __le64 type to a print function
so fix this by adding le64_to_cpu() which fixes the following
(prototype) sparse warnings:

drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:234:17: warning: incorrect type in argument 3 (different base types)
drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:234:17:    expected unsigned long long
drivers/crypto/virtio/virtio_crypto_skcipher_algs.c:234:17:    got restricted __le64 [usertype] session_id
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:196:17: warning: incorrect type in argument 3 (different base types)
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:196:17:    expected unsigned long long
drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:196:17:    got restricted __le64 [usertype] session_id

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 3 ++-
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index d8d452cac391..404e33b16db6 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -194,7 +194,8 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			ctrl_status->status, destroy_session->session_id);
+			ctrl_status->status,
+		       le64_to_cpu(destroy_session->session_id));
 		err = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index e82fc16cab25..3ca441ae2759 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -232,7 +232,8 @@ static int virtio_crypto_alg_skcipher_close_session(
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			ctrl_status->status, destroy_session->session_id);
+			ctrl_status->status,
+		       le64_to_cpu(destroy_session->session_id));
 
 		err = -EINVAL;
 		goto out;
-- 
2.37.2.352.g3c44437643


