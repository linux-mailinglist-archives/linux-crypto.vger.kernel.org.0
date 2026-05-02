Return-Path: <linux-crypto+bounces-23613-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEx+DWWD9WkHMAIAu9opvQ
	(envelope-from <linux-crypto+bounces-23613-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 06:53:57 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B04B0F8C
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 06:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAAB73007B0A
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2026 04:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5629BDB5;
	Sat,  2 May 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ctyyHQQc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309A2DF13F
	for <linux-crypto@vger.kernel.org>; Sat,  2 May 2026 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697630; cv=none; b=S2qhD69Ms4DereHOm2XmbzXAtcUEZe4giygMswMIr6UH6hlEuYUA32vZbtnsL747tdPXOxqeCjpNSmoYcdizL5/qW+JW/1qLtZsonSkvWIDuxCRoUuvizCxHIieBL5EOs+r9iC2uKSV1NHmf6KsEzoSRUlcgl68T118ublCQ0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697630; c=relaxed/simple;
	bh=VpHij7sYWAWN8urHzOdhSOIvoXtvC5qsBfyWrSkS0SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSw0nysmtz652xOK1dRdoCOmIhLJ288axaO/hWL73P0G4448By+iHhIypsfi5J7L3zlG/ylV5nZtsZXUGH9C+bEs/pq24Nbr3TDCJNedVKe9UYwFSEoQYq+lJbdU4uX3b6VB0ELRaLU3Fg4pt3Yyw92+WJyPCwn3qBewTXok0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ctyyHQQc; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=aPqzanSs5K1ZrIjFvVNpSTCpHhpSYlhWV8PkcvIsGwk=; 
	b=ctyyHQQcYkJIBMEaGq1hrmlqDBhBlSxVRtN8HKqk7cyXmTqiFnW19byw12S0BG08yB/srcCQwrp
	hnGlfhuj7/e2Fod5ElX6reWa0PCwwXU96alxEqZMynrdDb/D+ZUj1D3Z8/sSnnWGXUgQi/0cjYkSX
	tAzpdG9d7aNoCifrp5TeOJFKPClsSxmSorqujjUdzVq5VE3Lx8heKko0d2Pn5cEI24vhh3/FUfd7e
	mIzMnA7HI5F9v5bI1mqISRk0F02or5UQZX/1ymqNTJxvg3ND3MuphIlwmCUtvOD2G+Smla1Zq1k+D
	LytPRwGD8UbdHtkpORm7AohSYzYHxOxhf7Aw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wJ2MI-00Ab61-15;
	Sat, 02 May 2026 12:53:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 May 2026 12:53:42 +0800
Date: Sat, 2 May 2026 12:53:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Taeyang Lee <0wn@theori.io>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>, davem@davemloft.net,
	Brian Pak <bpak@theori.io>, Juno Im <juno@theori.io>,
	Jungwon Lim <setuid0@theori.io>
Subject: [v2 PATCH] crypto: authencesn - Use memcpy_from/to_sglist
Message-ID: <afWDVpH2ba-DVpkT@gondor.apana.org.au>
References: <acOpDrnN3cVfiASk@gondor.apana.org.au>
 <CAHk-=wiEzzo=LQ4TasUqFDkSYYAXa3VT6PvLx+AS8asOEA6hng@mail.gmail.com>
 <acSzWm2bzRXTkhVH@gondor.apana.org.au>
 <acTWNAs0eBc9F-d0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acTWNAs0eBc9F-d0@gondor.apana.org.au>
X-Rspamd-Queue-Id: 396B04B0F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23613-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

v2 has been refreshed against current mainline.

Thanks,

---8<---
Convert scatterwalk_map_and_copy to memcpy_to/from_sglist as they
are more readable and less error-prone.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 522df41365d8..ca063576f670 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -94,11 +94,11 @@ static int crypto_authenc_esn_genicv_tail(struct aead_request *req,
 	u32 tmp[2];
 
 	/* Move high-order bits of sequence number back. */
-	scatterwalk_map_and_copy(tmp, dst, 4, 4, 0);
-	scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 0);
-	scatterwalk_map_and_copy(tmp, dst, 0, 8, 1);
+	memcpy_from_sglist(tmp, dst, 4, 4);
+	memcpy_from_sglist(tmp + 1, dst, assoclen + cryptlen, 4);
+	memcpy_to_sglist(dst, 0, tmp, 8);
 
-	scatterwalk_map_and_copy(hash, dst, assoclen + cryptlen, authsize, 1);
+	memcpy_to_sglist(dst, assoclen + cryptlen, hash, authsize);
 	return 0;
 }
 
@@ -129,9 +129,9 @@ static int crypto_authenc_esn_genicv(struct aead_request *req,
 		return 0;
 
 	/* Move high-order bits of sequence number to the end. */
-	scatterwalk_map_and_copy(tmp, dst, 0, 8, 0);
-	scatterwalk_map_and_copy(tmp, dst, 4, 4, 1);
-	scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 1);
+	memcpy_from_sglist(tmp, dst, 0, 8);
+	memcpy_to_sglist(dst, 4, tmp, 4);
+	memcpy_to_sglist(dst, assoclen + cryptlen, tmp + 1, 4);
 
 	sg_init_table(areq_ctx->dst, 2);
 	dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
@@ -217,9 +217,9 @@ static int crypto_authenc_esn_decrypt_tail(struct aead_request *req,
 
 	if (src == dst) {
 		/* Move high-order bits of sequence number back. */
-		scatterwalk_map_and_copy(tmp, dst, 4, 4, 0);
-		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 0);
-		scatterwalk_map_and_copy(tmp, dst, 0, 8, 1);
+		memcpy_from_sglist(tmp, dst, 4, 4);
+		memcpy_from_sglist(tmp + 1, dst, assoclen + cryptlen, 4);
+		memcpy_to_sglist(dst, 0, tmp, 8);
 	} else
 		memcpy_sglist(dst, src, assoclen);
 
@@ -274,18 +274,17 @@ static int crypto_authenc_esn_decrypt(struct aead_request *req)
 		goto tail;
 
 	cryptlen -= authsize;
-	scatterwalk_map_and_copy(ihash, req->src, assoclen + cryptlen,
-				 authsize, 0);
+	memcpy_from_sglist(ihash, req->src, assoclen + cryptlen, authsize);
 
 	/* Move high-order bits of sequence number to the end. */
-	scatterwalk_map_and_copy(tmp, src, 0, 8, 0);
+	memcpy_from_sglist(tmp, src, 0, 8);
 	if (src == dst) {
-		scatterwalk_map_and_copy(tmp, dst, 4, 4, 1);
-		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen, 4, 1);
+		memcpy_to_sglist(dst, 4, tmp, 4);
+		memcpy_to_sglist(dst, assoclen + cryptlen, tmp + 1, 4);
 		dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
 	} else {
-		scatterwalk_map_and_copy(tmp, dst, 0, 4, 1);
-		scatterwalk_map_and_copy(tmp + 1, dst, assoclen + cryptlen - 4, 4, 1);
+		memcpy_to_sglist(dst, 0, tmp, 4);
+		memcpy_to_sglist(dst, assoclen + cryptlen - 4, tmp + 1, 4);
 
 		src = scatterwalk_ffwd(areq_ctx->src, src, 8);
 		dst = scatterwalk_ffwd(areq_ctx->dst, dst, 4);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

