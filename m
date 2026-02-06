Return-Path: <linux-crypto+bounces-20625-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKy6GHjJhWnAGAQAu9opvQ
	(envelope-from <linux-crypto+bounces-20625-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:59:04 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20473FCEA9
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Feb 2026 11:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C09E93010B6D
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Feb 2026 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC5392C5B;
	Fri,  6 Feb 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="s6sH4vsW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60913612FE
	for <linux-crypto@vger.kernel.org>; Fri,  6 Feb 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375536; cv=none; b=LudtQlChrQqqFx3rVfsCk8OoiFm78pm7QYxEbmmpnd4FE79T18UKN4912dofe4aR3TMbU2Ia5aqMnRaT/YBoc8yPMssDmYTghGrfzSGBEvHlt/GkumZ+QvAoDJnS2pserDR+Lh+w5wNsTlqcKRkYvnDHpbda84KeYlPlTMgcZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375536; c=relaxed/simple;
	bh=SVxrvug3dHxkYz1wSVuAt1ZNkGIaefrBE1cEITAOAUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtD0dEi92FZCLHMSLMgzjEfhWb2VdGZ7b/kzxmvnutGOCka7s7686M+WCpk5w5x+JrjO7I5WvMCh2TCTRI+/+JlsGE9V22G1qWinJenijuk3pkpOHJhJ276T3k31bVLUgqWCWxZoax4W4XyiISZnAaYQ25R7Gwpu+vwK4gFTHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=s6sH4vsW; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=uf3Mn4yUKMvW/6DBZicxxhoSqJXvniVryUZ0kXqs+XI=; 
	b=s6sH4vsW4qgkyo2SxElIASHPgrDhkK8fivT1GLXnfltpJm3HNla4qi8Sf6y4+0G+OQD4MoFaGtE
	AEoyGaQ180Sxsog9mtf+uPMyU3G5YoweBP4HSyohz76HGwM4w77eCC7Lya2msir7wQvIOHKXQQGPD
	zrOV4clt0ZIs5Ugb2WmyUYdvGfsVFV6ciFGJF1GKz8V3hjBkuPBQkbO8U/305AeF3n9RpdKDxPCI9
	loxGkgcf4CA30e8GVF5/9MvEYkQbNP2Ff/uNXV1KOzaaVQNCtw/j1ZOtwAr7xWGR1lLlZEXSdCfQQ
	0xFuV6Kie1rznFIDIwadiina9yJPt796jYVQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1voJY0-004zVG-1g;
	Fri, 06 Feb 2026 18:58:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Feb 2026 18:58:48 +0800
Date: Fri, 6 Feb 2026 18:58:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harsh Jain <h.jain@amd.com>
Cc: michal.simek@amd.com, davem@davemloft.net, linux-crypto@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [LINUX PATCH] crypto: xilinx: Fix inconsistant indentation
Message-ID: <aYXJaKCXVkQo81u8@gondor.apana.org.au>
References: <20260127070155.199790-1-h.jain@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127070155.199790-1-h.jain@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20625-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 20473FCEA9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:31:55PM +0530, Harsh Jain wrote:
> Fix smatch inconsistant code warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601251908.baMDVVgW-lkp@intel.com/
> Signed-off-by: Harsh Jain <h.jain@amd.com>
> ---
>  drivers/crypto/xilinx/zynqmp-aes-gcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

