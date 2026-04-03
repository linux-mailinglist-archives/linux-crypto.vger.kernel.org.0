Return-Path: <linux-crypto+bounces-22745-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMKcFeIRz2nXsgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22745-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:03:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF5738FCAD
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 189E2301E9BD
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2026 01:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4C270EDF;
	Fri,  3 Apr 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="VrRTTO4a"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D978F3A
	for <linux-crypto@vger.kernel.org>; Fri,  3 Apr 2026 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178204; cv=none; b=LjmLZGVfQ3Ogorq5xbtKaCE28lvos+RvIA6jixv1PFe2VmgXz/duL1Y7IGWT2EH6TQ6MMFTGWKCr9qk/x6X1WTZ55kkzibsV1HYyg7i7pqQ3kQkeK2el/H0pz88NV2Gj+/OOfVhkmBAFgRWJerQjZUnOManJ3OYkLQYJ9BZxeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178204; c=relaxed/simple;
	bh=50+udKKbWTX1x4K3rA+7PlgGvctdvPu/wrAYeOQjCqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc3s8ezFwMWo/qWJus21GQfkTtf7dU0hJfUWpspM9lFiEdt5qOY8MbES90vDGnncs4MtlammsuL21FBY36FdUCf6xxVSKDbYPc6IYLF8KClRCzMx4sqlOla6Hir9wXLgShD+dibtjdA/7YMrd/Fqc1HpaAoX+/oAcKOco/4Ls+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=VrRTTO4a; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=J1wvmRp6NMrNvCMkg0wAkSVk8XC9OfRjASJGcw09Xg0=; 
	b=VrRTTO4aJlECb9TsM+VOwdm1lRUZ+AsENMN1OiPWpoJs5KIuUwWjtWbCNXYaufKNcFWUbORT1ju
	wYZFanPZUNF5Pfo7lrmwOpIWNC90HMl7dzSh0gte887acO65Oqcq6wmiFuovAEZSmcTHZQ6ID15KO
	NUrxAjO/qNO01TkkthX1MWCbUjzDU3Dq9ssBK1dc9gJFICxTf7no6N7qmMBChVwnAROawoj2hW+T/
	9B1F/n4uzN+aOJM9n3MwL5U8/XDBePK8KTwLRWgecSdZK1rhSlu9lxnHdNlic7SXuDDBd5JcYi09p
	60fVj0px9vV5SQRx86FTQDgisgI2DNoB5RqA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w8SWy-003Qwx-0o;
	Fri, 03 Apr 2026 09:03:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2026 09:03:19 +0800
Date: Fri, 3 Apr 2026 09:03:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ahsan Atta <ahsan.atta@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - disable 420xx AE cluster when lead engine
 is fused off
Message-ID: <ac8R1yLXy3M9UqC3@gondor.apana.org.au>
References: <20260324111234.227329-1-ahsan.atta@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324111234.227329-1-ahsan.atta@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22745-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBF5738FCAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:12:34AM +0000, Ahsan Atta wrote:
> The get_ae_mask() function only disables individual engines based on
> the fuse register, but engines are organized in clusters of 4. If the
> lead engine of a cluster is fused off, the entire cluster must be
> disabled.
> 
> Replace the single bitmask inversion with explicit test_bit() checks
> on the lead engine of each group, disabling the full ADF_AE_GROUP
> when the lead bit is set.
> 
> Signed-off-by: Ahsan Atta <ahsan.atta@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: fcf60f4bcf54 ("crypto: qat - add support for 420xx devices")
> ---
>  .../intel/qat/qat_420xx/adf_420xx_hw_data.c   | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

