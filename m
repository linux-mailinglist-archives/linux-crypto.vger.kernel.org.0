Return-Path: <linux-crypto+bounces-22751-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOy0IEYSz2nXsgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22751-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:05:10 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021B38FCFB
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EFFC301DDC4
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2026 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC4D202C48;
	Fri,  3 Apr 2026 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="lwco94i8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444A26E142
	for <linux-crypto@vger.kernel.org>; Fri,  3 Apr 2026 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178308; cv=none; b=IyI5K1i5DKrRfWVKfZeImbX22gQ+e5bOoWQ0lmZL7DV+1RALAn0T0I5CYH0sFGbY55jjMCORZ0A1yMJWqbMkwLCO9OqKoBR2J6CRsWGl0LpioZGTFGDofYFsDfhcJzVReIIpYuWH4Yph6+BZGrwFIPI4BE8zByGXwwrgLT15qrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178308; c=relaxed/simple;
	bh=hiknWIVNKJXRbWCUou+KuAYyBuL39DFxqzH50IDaQGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2lFP+rR5zH+XIeQfTowwwbVgMMLGm2dJM2pRmUQK1c9t8WnVNT0qv19gj3AUF/QCsss352T9TTAuMKrd99vGzyV7W0zdK3TINKIUNp3kkBGWPcDrl+8dotqvfc+kyR99K7vfZJ/38IMpYqEXlxPNl5h03jmqTv12jwLsO2uR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lwco94i8; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=NeKIUlTPKeJW4kqyi5LJU5kHBG00DM7ucKYq35YkI/Y=; 
	b=lwco94i8m7uVkW5hBk/34+MVJ+n1DhvUMTS6iOV/GBSf1xSTUv4qxP8lScmxjdB23q5eRKiZay8
	gDyRfCQ3CLIRK1G00APe4eBoMDU/CIxq8pj7JF8bcdhfbvX13kHIoJACp4dcqzLPY4DEZCeubGid+
	a3M1IoXr7ZreXM0WqWF2Z0fyMzk6IKpXb6FdeOcnZ4AuWKQsBpSxQjXUaHP4fx8P7XJAXO3+iW6E7
	VDtZdT2fbheu863Xp7PXbhdDlvQ+lwc/Gn/cfUSGWlYbjnKS5ZENRpvWuTI1rztumL2yspqan//lc
	35zD0+yOiL7+VirQmqznVf+2yDFqOthxzBAA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w8SYd-003Qzb-2O;
	Fri, 03 Apr 2026 09:05:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2026 09:05:02 +0800
Date: Fri, 3 Apr 2026 09:05:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: vinicius.gomes@intel.com, kristen.c.accardi@intel.com,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: iaa - fix per-node CPU counter reset in
 rebalance_wq_table()
Message-ID: <ac8SPlFhiQx7OChZ@gondor.apana.org.au>
References: <20260324182912.123665-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324182912.123665-1-giovanni.cabiddu@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22751-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 3021B38FCFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:29:05PM +0000, Giovanni Cabiddu wrote:
> The cpu counter used to compute the IAA device index is reset to zero
> at the start of each NUMA node iteration. This causes CPUs on every
> node to map starting from IAA index 0 instead of continuing from the
> previous node's last index. On multi-node systems, this results in all
> nodes mapping their CPUs to the same initial set of IAA devices,
> leaving higher-indexed devices unused.
> 
> Move the cpu counter initialization before the for_each_node_with_cpus()
> loop so that the IAA index computation accumulates correctly across all
> nodes.
> 
> Fixes: 714ca27e9bf4 ("crypto: iaa - Optimize rebalance_wq_table()")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

