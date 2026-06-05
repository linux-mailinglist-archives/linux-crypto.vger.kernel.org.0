Return-Path: <linux-crypto+bounces-24927-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qacmG923ImqEcgEAu9opvQ
	(envelope-from <linux-crypto+bounces-24927-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:49:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F5647DCA
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=exlly9Bg;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24927-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24927-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA59301BC01
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630F4D90B3;
	Fri,  5 Jun 2026 11:42:39 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DD4C9560;
	Fri,  5 Jun 2026 11:42:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659759; cv=none; b=fs6GYuZbS7kyWBPKNLD10uenPSYyjzRx8IAOiNWRQZ/lhNQX06BRjDCC8IPFqp8f2mOXZkGIxRZiOzLMaFi8hdf1OI5jygRpSXd4IhNh+gMO2rrJd9qdk1su7gyTU8zplYiD+DM+2nN3yOXfy1QuKcyObK0w5lYkU3+U+vKWId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659759; c=relaxed/simple;
	bh=FPtVU2E/Zl9EIbPrg41H2SphC62ZbhiA26SzM+8m7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5U3sCNb/J4BwhD23rYftAITRgd+N4f1awqiOt8FhFAu1a+woSRmx/C3/zLOh6gnhcj4p5oQ12DhV3DBMOwusEn6nTALRERNqaZ9bCiNgFcd8kLyF+X7dkrmFQHmsgOYX+/jAQNmtye3bPSseu3nNg0Qjk2auipObFQHpId3hpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=exlly9Bg; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=kf75sN2ychg4Pf3OLsWqw3dsduAhvKwS/MuhUqgFAI4=; 
	b=exlly9BgaF48yoZy4omsu4053BgH9DSKf3X5KH/nr7rajhR1cmR2cB4bJSXA9CB53eUbrPQmLPg
	K8yzzd5JXFfaIQgdG0rC4oy1fTY11c+nn2PEA3RSfDJnu1JqcXXJj1hEhsAYtEd/X8arP4kNNxzDA
	d5g6KGx5S1s+rOQnP+QuJDhX/W4yHVGwtgPuYqiapvfm84hCSpbQSdVgRHFOJOd6VPJPSYo5+SKmn
	NVPkbhO3+VT9uOs7cpfCUk+8f5ksGMg+PfosLuYbMVoMtFV2KJFwlpExNlNpzGzfOhqoka2cd/5ot
	U4uVatZZgXK/bp1SkmFOUMxm/+cbpbQZPxBg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSwY-002oqT-2B;
	Fri, 05 Jun 2026 19:42:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:42:30 +0800
Date: Fri, 5 Jun 2026 19:42:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Karthikeyan Gopal <karthikeyan.gopal@intel.com>,
	qat-linux@intel.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - simplify adf_service_mask_to_string helper
Message-ID: <aiK2JnFpQzurAX_m@gondor.apana.org.au>
References: <20260527174655.1390543-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527174655.1390543-3-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24927-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:giovanni.cabiddu@intel.com,m:davem@davemloft.net,m:suman.kumar.chakraborty@intel.com,m:karthikeyan.gopal@intel.com,m:qat-linux@intel.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC3F5647DCA

On Wed, May 27, 2026 at 07:46:55PM +0200, Thorsten Blum wrote:
> Use a single scnprintf() for each set bit and drop the offset in the
> else branch to simplify adf_service_mask_to_string().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_cfg_services.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

