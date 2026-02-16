Return-Path: <linux-crypto+bounces-20913-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EsMLG1Olk2lN7QEAu9opvQ
	(envelope-from <linux-crypto+bounces-20913-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Feb 2026 00:16:35 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88C14807D
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Feb 2026 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF7B6300F12F
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Feb 2026 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B481F2BAD;
	Mon, 16 Feb 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlD/iEsD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999412AE77
	for <linux-crypto@vger.kernel.org>; Mon, 16 Feb 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771283790; cv=none; b=Kmc/bcKyFic6SuWOakfleXhuAoO9TQlne9wH6et7UwtXnE6NyieZZJjEaM4LQPtAiNDdhyOFiDVsfI55r5UsZxy1G5dP5drp0t1msFmVeNBet1uliN1j0v2BnpzS1jqpadBfNXFWdGVAdT1n6GN6gDx8jSVDF3V0l0T/SCx4XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771283790; c=relaxed/simple;
	bh=Pa2MOcKe8uKCnqHODEMByomNJHgh5aTvfH2oa/S9N1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ53qSb79iA4w2hsn1h8XPwYlCxJnxfErW01H4K7tV/hXfYzS7V50Vgidzzsoan4jFvlQfpwGaJw3WewtvKFOlyyuYmE9ecXpcrr6HSej2pCLLrvMY0HT2NBfiwvGSnpd6zG0ewi0iOMSSUon91gu0P4/EU6poH4xNYNzmQMOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlD/iEsD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-796d68083cdso51205007b3.1
        for <linux-crypto@vger.kernel.org>; Mon, 16 Feb 2026 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771283789; x=1771888589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvdWQUNtVV5F3OwagAitOy7mrtkoaXiSfNcPJB7Gg9s=;
        b=hlD/iEsDguy2b5pYxqtV9clqabpCEG6eMym/H7sA7sKtRdTdFHQYg9DJuTJUq14CIU
         u59XWfs2zd2DvYf2YT620voEZHxbrDfuy9C5cfVOzttsGxxmVHR+oIrpQGxTDcYUxtr7
         SIwO+QujccuFaepabqR0UNFijUG2Y6g7T3DreETmRUUZodzxvj+ybc1s1jxElx61eR4s
         hOgZG42IXGrkq8nT33gd8bRc9RmMhJkX1lb4AGU9JAgIHrRmsksE1Zxn8afZlTu9foVG
         2vhgLwsq4VeYHKC3onZvNvWPf/msUSi1CV0A2RsMLuYxe7WQmtCo/K2n3hzbnggMn/4S
         NLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771283789; x=1771888589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvdWQUNtVV5F3OwagAitOy7mrtkoaXiSfNcPJB7Gg9s=;
        b=aiAR/4NNVX/kLM8i2XlNshQa1N+pBoH2OlAa3dmRmNJzHrYYQwjUdZMxit8kqf6FmH
         R9gANwsPJoRX3nnEZAkmTOlk5DgUiPZQWxL+QOE40nlRyyM4uk1Nq5vpYqpcyCyXiveD
         wN7G8p3dXIxmnMFkCjUu+/S6+iUCkK+m1eydk2F7PfjwJMvjvMD5qalIVWHiDKQ1UnJR
         TFQ7T7NhhOmncFePTuQ8IP8jO0G93xRaAzG4BBq1wxQJCUDYpf2mfZnSusxl9lwKDHyC
         wfkkQoBFQ6EWCu2rPPzdnrUkL7g3FzqXRDrDkzVUpIZnLc/lpoZmSPMTnfFsqyQYFhTw
         gMMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCUlhG8CmbUFkFtJoJKO4GlW1rlRhW/6lcVD/wWfwopekj9cgPpsCsxt7RAMtckIJEI4Kjxjln2YLPgXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qrMmpWDx8x1UtU1CC5y2RUHIzGsaOOrUOGIkObJodrn2NemD
	3xWrVaS9qkPYWMg9Qlzsz2gjVd+hoghb0qcWhxb0HLwB97OXxicbXgDvFIAzC8VgIKE=
X-Gm-Gg: AZuq6aJMsS8SQgsICstMZBG2SRWzaTjxJQDSqapH6k53F9d4+qXOV4+5yCcLgyaG1Bc
	sL1cqKvHxafQe4lwzDgAY3q/sNKFEJJMXfpQ05IaABt+fuxc6UOQWHLHqEP0QqMNtVvGhKfwcAy
	vT8eHvNA4EWfrGRzUnLhm0KA921eANQIjvM21nZVOZTMB8XBQdWBYTWX3KKbktdQ258Fnnq266x
	ozmo7FbdAP0MhWy96LgrEHd8iLIG+uzlJJW9R6XsOQk/cp37c2ZdXK+r8c9JASysYorKu2lUaK2
	guTqVOICuivpRsa9vMSNqLIx8ylSfFjCrXEU0VXAepaB2qBMN5AUwxzWlrOABi2ZFbGS3+Nz4Fs
	lB1ukyGvlj8zgc6Z7B4VGpEbeyOJuMjX9E7+Xngf0jcZdEWup0hRSxr01jHZyPG+XczI1AffJLX
	OtCXmyxhQgycRJhk53ARDD3qFtmDNaS604EnnjEX8qso+FGFYKC//RUgYhU968t/KWUBMOXQiJ5
	C2eZc5hS+Dzb+pk7UUHlOpQXeAQRlwHErpPKNSmrQY=
X-Received: by 2002:a05:690c:18:b0:794:ebee:7f15 with SMTP id 00721157ae682-797aa902defmr72650237b3.21.1771283788617;
        Mon, 16 Feb 2026 15:16:28 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b464sm106738567b3.13.2026.02.16.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 15:16:28 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Keerthy <j-keerthy@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] crypto: sa2ul: add missing IS_ERR checks
Date: Mon, 16 Feb 2026 17:16:09 -0600
Message-ID: <20260216231609.38021-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20913-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA88C14807D
X-Rspamd-Action: no action

The function dmaengine_desc_get_metadata_ptr() can return an error
pointer and is not checked for it. Add error pointer checks.

Fixes: 7694b6ca649fe ("crypto: sa2ul - Add crypto driver")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/crypto/sa2ul.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index fdc0b2486069..58d41c269d62 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1051,6 +1051,9 @@ static void sa_aes_dma_in_callback(void *data)
 	if (req->iv) {
 		mdptr = (__be32 *)dmaengine_desc_get_metadata_ptr(rxd->tx_in, &pl,
 							       &ml);
+		if (IS_ERR(mdptr))
+			return;
+
 		result = (u32 *)req->iv;
 
 		for (i = 0; i < (rxd->enc_iv_size / 4); i++)
@@ -1272,6 +1275,8 @@ static int sa_run(struct sa_req *req)
 	 * crypto algorithm to be used, data sizes, different keys etc.
 	 */
 	mdptr = (u32 *)dmaengine_desc_get_metadata_ptr(tx_out, &pl, &ml);
+	if (IS_ERR(mdptr))
+		return PTR_ERR(mdptr);
 
 	sa_prepare_tx_desc(mdptr, (sa_ctx->cmdl_size + (SA_PSDATA_CTX_WORDS *
 				   sizeof(u32))), cmdl, sizeof(sa_ctx->epib),
@@ -1367,6 +1372,9 @@ static void sa_sha_dma_in_callback(void *data)
 	authsize = crypto_ahash_digestsize(tfm);
 
 	mdptr = (__be32 *)dmaengine_desc_get_metadata_ptr(rxd->tx_in, &pl, &ml);
+	if (IS_ERR(mdptr))
+		return;
+
 	result = (u32 *)req->result;
 
 	for (i = 0; i < (authsize / 4); i++)
@@ -1677,6 +1685,9 @@ static void sa_aead_dma_in_callback(void *data)
 	authsize = crypto_aead_authsize(tfm);
 
 	mdptr = (u32 *)dmaengine_desc_get_metadata_ptr(rxd->tx_in, &pl, &ml);
+	if (IS_ERR(mdptr))
+		return;
+
 	for (i = 0; i < (authsize / 4); i++)
 		mdptr[i + 4] = swab32(mdptr[i + 4]);
 
-- 
2.53.0


