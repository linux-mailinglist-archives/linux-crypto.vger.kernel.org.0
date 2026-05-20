Return-Path: <linux-crypto+bounces-24334-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH26IdMhDWpptgUAu9opvQ
	(envelope-from <linux-crypto+bounces-24334-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 04:52:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9363586F82
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 04:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0704300B638
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EC26E6E1;
	Wed, 20 May 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KcStqXBH"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE926461F
	for <linux-crypto@vger.kernel.org>; Wed, 20 May 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245482; cv=none; b=jwCsc5meYJ/ukVF1BHYoLVJfJ3wNf8G/cnCkmQCH1kGANNF+II8D8ZDo6lhxnQuqQw70Q2qmwzCW91oTXLs3NBB9HXmMWf05kuU4rX/ddkN5tqh7lqbpUoOVcD3rAaiw1y57FCn5Jvak1Ne7mIj/zT/5bI1LFWTf9bBoM6qwfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245482; c=relaxed/simple;
	bh=qpsxJsKXC79TMvc2FcdPgwAH2Rx+HqkKx6pZvlgHW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyJZ51x4YbgXhDXZYeNrql48i8AfVH/kCmItIXLFfms9IGu7Vvn/jG5rrw2pfC9Hy7daBTfguPVdfNM3/jRYEgn5CqNu/4TE9CDVM+TK7Y9XpQdvE93OECKNqVuxh8Zbtq3NOwJEV3vuxnLm+WMA0JcuCA12qmA7lZmhSUnPlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KcStqXBH; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=dw8cbynrhTnfBOwxwu1/xwWmwgKaszGOKdrhyt42eDA=; 
	b=KcStqXBH7UDJt1yXXRAc9xZ0ZexwxfreKruES85eD9mlw+cT4VHt0OKFSZvVhdwcT8YdB+0xTeN
	/RNSA8nxSKEziBDcAe+info4WR+j/jtMB0GoiG5fW1cKlssJy0wcQmy+IU5PZELGamu098K6fuEUC
	Xncuhu9MjSY8oSpq85WFXvZ0CppDAUBGPjvqmHf1DKPQ/mycMI+6uPnsBtXvvdDdR6GOGNQpn2ytr
	qdAV7umVANejy8S32NyE99jIRDtnkbcTaKud1zlGYvVDKAJ0dX+1sQuidXlS35xO8EC6hlEEwoqSQ
	GtjaptroLb5GNbIvgrbqd14URDMemh/G/A5A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wPX1e-00Fg7J-08;
	Wed, 20 May 2026 10:51:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 May 2026 10:51:14 +0800
Date: Wed, 20 May 2026 10:51:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vladislav Dronov <vdronov@redhat.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Akhil R <akhilrajeev@nvidia.com>,
	Patrick Talbert <ptalbert@redhat.com>
Subject: [PATCH] crypto: tegra - Return ENOMEM when input buffer allocation
 fails for ccm
Message-ID: <ag0houiGk0cLZ9ls@gondor.apana.org.au>
References: <agvleqNqloWB6tpf@gondor.apana.org.au>
 <CAMusb+T_q1Vu3MD+VjiPWfpe3NNpjJehXWQ9gePo=hM+NGm1zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMusb+T_q1Vu3MD+VjiPWfpe3NNpjJehXWQ9gePo=hM+NGm1zg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-24334-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9363586F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 01:42:59PM +0200, Vladislav Dronov wrote:
>
> sashiko.dev makes a point here (
> https://sashiko.dev/#/patchset/agvleqNqloWB6tpf%40gondor.apana.org.au )
> that the code does not set ret to an error value, as done in the other
> similar places, see:

Thanks Vladis.  This is an existing bug and I'll fix it with a
separate patch:

---8<---
Ensure the ENOMEM error value is set when the input buffer allocation
fails in tegra_ccm_do_one_req.

Reported-by: Vladislav Dronov <vdronov@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 30c78afe3dea..7ed39b40e4f5 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -1213,16 +1213,15 @@ static int tegra_ccm_do_one_req(struct crypto_engine *engine, void *areq)
 	rctx->inbuf.size = rctx->assoclen + rctx->authsize + rctx->cryptlen + 100;
 	rctx->inbuf.buf = dma_alloc_coherent(ctx->se->dev, rctx->inbuf.size,
 					     &rctx->inbuf.addr, GFP_KERNEL);
+	ret = -ENOMEM;
 	if (!rctx->inbuf.buf)
 		goto out_finalize;
 
 	rctx->outbuf.size = rctx->assoclen + rctx->authsize + rctx->cryptlen + 100;
 	rctx->outbuf.buf = dma_alloc_coherent(ctx->se->dev, rctx->outbuf.size,
 					      &rctx->outbuf.addr, GFP_KERNEL);
-	if (!rctx->outbuf.buf) {
-		ret = -ENOMEM;
+	if (!rctx->outbuf.buf)
 		goto out_free_inbuf;
-	}
 
 	if (!ctx->key_id) {
 		ret = tegra_key_submit_reserved_aes(ctx->se, ctx->key,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

