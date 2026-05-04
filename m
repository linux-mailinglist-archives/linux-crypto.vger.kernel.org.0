Return-Path: <linux-crypto+bounces-23673-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAOHLQO++Gl10QIAu9opvQ
	(envelope-from <linux-crypto+bounces-23673-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 17:40:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23E4C0D12
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 884BB303649D
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B13E0C7C;
	Mon,  4 May 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mrK6vOjV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907A3E0C51;
	Mon,  4 May 2026 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909188; cv=none; b=orkOQ5HHhVufynHVR4y9B9a3dOSnv4aAGICJ1f5LPJJGjcKvUf5SFL6dJZb1y31MEPGeisL2/Zn+8HJLpH3vTA5niMWpH5h6HCQaD+kmE6T5SH61FSy6lm9ilCvwVWIgJ4KwWQyIG/DPQMrTLS35K3kodmGS1yiXLWTIbJrPnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909188; c=relaxed/simple;
	bh=AEH4Fq0siKNTVEACtsyUHL32qVGD6A5nC1XUA2IdHZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HExGzM/i97AhBn9eg/TfvbEr9DiQCyccVys01eat/7iE8DOjHf8iG4zV6ow7RKmqhfjLotNYjQl3sujGqSITfRG7BvwFeSDxG2LIo6yvb8UVwI6MS0UAwuCzwVKC8VfE5x5swJ8P0ZWMICv/J/kpEuNgtFmQ4Zj1yb9U6DrDRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mrK6vOjV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 751874E42BBC;
	Mon,  4 May 2026 15:39:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B8055FD5F;
	Mon,  4 May 2026 15:39:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A97F11AD2BA5;
	Mon,  4 May 2026 17:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777909181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bwhElTLpoPeu4nxk9VnwUqKbxxQ2g2S7oxle4dtyMlE=;
	b=mrK6vOjVS6tGJb24NxflSwNQeykZklcuChS8YtAMJByoV5PblLa1wXvv8RrvXnqqDQ3Q4a
	fxLVcw9ugnzZCcdT4NmNh1KKxJMim31NhhZNoXHY15vjWWtBW7h4iNYEYcaqxyonsKZXxr
	gFNoaPwg1ckpuH1DcAg7A5Ij9yQ4bO3O74rE/SlFnVlaKf26s5sqjaA891bs8rY/O+Ay7j
	+DBdMFEFanjki7x7DfZmirb6PuLEFqT3nkph/vrr/MIF4UJlljpD2xDGRmqIHlJ0cPMxdj
	1lsSrFZOG5zj/M2VvnWp5Dz/wiwppiBdQlqp6/K/T2xaUEcYDjuGx9BdhRVyCQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 04 May 2026 17:38:30 +0200
Subject: [PATCH 4/4] crypto: talitos - fix invalid submit_count initial
 value
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-4-c97c641976f5@bootlin.com>
References: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com>
In-Reply-To: <20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909177; l=1086;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=AEH4Fq0siKNTVEACtsyUHL32qVGD6A5nC1XUA2IdHZ0=;
 b=ZksKLsqHf0MDCXf2RZ4SRYvim1JYyVXgEG/5XrffuuWSy6RL4NDlLzkUU94RaUvGsUXzP3Kc/
 dV+xxTGxyWIB6wUP/qlshD0wnrzdA4tHhypXMP+PgXqvFzqgVRedX8n
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2E23E4C0D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23673-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

The submit_count atomic counter is initialized to -(chfifo_len - 1), but
since atomic_inc_not_zero() rejects increments when the value is zero,
one FIFO slot is always wasted. With chfifo_len = 24, only 23
descriptors can be submitted before getting -EAGAIN in talitos_submit().

Fix by initializing submit_count to -chfifo_len so that the counter
reaches zero only after all chfifo_len slots are occupied.

Cc: stable@vger.kernel.org
Fixes: 4b99262881213 ("crypto: talitos - align locks on cache lines")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 8d063ad5639c..429db3ee9123 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3575,7 +3575,7 @@ static int talitos_probe(struct platform_device *ofdev)
 		}
 
 		atomic_set(&priv->chan[i].submit_count,
-			   -(priv->chfifo_len - 1));
+			   -priv->chfifo_len);
 	}
 
 	dma_set_mask(dev, DMA_BIT_MASK(36));

-- 
2.53.0


