Return-Path: <linux-crypto+bounces-20605-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHDCOUMZhGk1ywMAu9opvQ
	(envelope-from <linux-crypto+bounces-20605-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Feb 2026 05:14:59 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA6EE793
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Feb 2026 05:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAC23011772
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Feb 2026 04:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFF2DC331;
	Thu,  5 Feb 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="MYC5lhn3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DC2673B7;
	Thu,  5 Feb 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770264892; cv=none; b=ntaZ9duXeDVI7N3n/4fU1FLj2hSFVQA5hZUAW1oJ/VxwzJc5rxs2qT1DD+ps3xpo+goVCQzmAQrKsHooyrQ+DQAY6xiris8jbMXzym0/wHfdLDPtgLMdbaWpApoROd91A/Oc1rLlxGm6a0KUq73HIC2ME8LEwHdGvEugXSyfiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770264892; c=relaxed/simple;
	bh=0E+cSiIAc4iXxGCVLoXI33/qJEadsbjC11Anxw02gxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNaGIkNkLajELSiHAxI1Ms0o3NnsMEm8IJPqi2JbykGbhKiCc/oVbLJ7YmIOUt/+FDj4Ff79GYWCo2cAWfB/jPt948wekr0lNFUZl6BI01KbFXaRAGS4bfiEJcJ3lqaFD4Q/lqwjQme2qiq4nz5Wk5fd1+YiDD9CbDmKuQCLmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MYC5lhn3; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=DMx5++hqTDx6tKIwhTEaQVGCEoE7NSzZhFlhgtkzgJ8=; 
	b=MYC5lhn3Xb9VliRDwDDj+7mVQ5zc90uaoT96vzZ74Xj3RjBdPHqQDqwQJLzx3NLHA5xH2ZPVB4/
	1aMVBBHzcirjeqbe002SWDDEQGqXyeokqqLAVERFw3JixvBZC5UAU+pC+Z395lv4G77hGGh4ilqHo
	JSUdWrH2SpzoWJMhcurvVoefmU7Nms/5iWeWhrCLd4z8ObSmppUGBVfEoFpZ60qo0MkKunaaVuGzU
	tAExBWauvS3WjCB49Phe4G5EiSjtEpf/x2Q+5De4wV8o1HvXcVMG2bnc72YO7BFe0oodOMOx3DgIo
	QdzvHjn/7KXKyrh/yE60BAA4E0S9i328ea+w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vnqkz-004dup-2F;
	Thu, 05 Feb 2026 12:14:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Feb 2026 12:14:17 +0800
Date: Thu, 5 Feb 2026 12:14:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
	ying.huang@linux.alibaba.com, akpm@linux-foundation.org,
	senozhatsky@chromium.org, sj@kernel.org, kasong@tencent.com,
	linux-crypto@vger.kernel.org, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com, giovanni.cabiddu@intel.com,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v14 18/26] crypto: acomp, iaa - crypto_acomp integration
 of IAA Batching.
Message-ID: <aYQZGXue0F-S_Zqh@gondor.apana.org.au>
References: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
 <20260125033537.334628-19-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125033537.334628-19-kanchana.p.sridhar@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,davemloft.net,baylibre.com,google.com,intel.com];
	TAGGED_FROM(0.00)[bounces-20605-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61BA6EE793
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:35:29PM -0800, Kanchana P Sridhar wrote:
>
> @@ -291,6 +292,65 @@ static __always_inline int acomp_do_req_chain(struct acomp_req *req, bool comp)
>  	return acomp_reqchain_finish(req, err);
>  }
>  
> +static int acomp_do_req_batch_parallel(struct acomp_req *req, bool comp)
> +{
> +	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
> +	unsigned long *bpwq_addr = acomp_request_ctx(req);
> +	wait_queue_head_t batch_parallel_wq;
> +	int ret;
> +
> +	init_waitqueue_head(&batch_parallel_wq);
> +	*bpwq_addr = (unsigned long)&batch_parallel_wq;
> +
> +	ret = comp ? tfm->compress(req) : tfm->decompress(req);
> +
> +	wait_event(batch_parallel_wq, tfm->batch_completed(req, comp));
> +
> +	if (req->slen < 0)
> +		ret |= -EINVAL;
> +
> +	return ret;
> +}

I don't think we should have this in acomp.  Just return EINPROGRESS
and let the user check each unit for the success/error.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

