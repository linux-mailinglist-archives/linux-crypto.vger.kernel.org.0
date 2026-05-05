Return-Path: <linux-crypto+bounces-23701-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIDSMTiF+WmM9QIAu9opvQ
	(envelope-from <linux-crypto+bounces-23701-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 07:50:48 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC554C6F7C
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 07:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C6330156F8
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74813BED66;
	Tue,  5 May 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="dl9GGNBf"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E903BD654;
	Tue,  5 May 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960241; cv=none; b=dlbtl/3eM3I52BAInIuptIbfaWc6CtFqSYUhrgh271s97u2xiZEd0OPENSj309zUUgIFydsmWLytbhdeGllhMBjfH6qaWtzyGVPQZK3Dr/wLshpemzH9jt58iUN4+TwgTYZT8u9ALDFS1YXtugvwL1Esjc4nMGU4xhr1FKoZVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960241; c=relaxed/simple;
	bh=OfrV6+RJWoZMQILdTtVAw8sCC8csn93eRDN+xzU7/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB8RZt0/dR3u0bsMzT+r47R13/Yky/7S+FPVXVjXaAOG9zpyOrJ9QYO8uJ1eRMZoVqerfzkrbtrRiA9bthRZcSe/xPK236BLeBi5gZUYV3zNz6mydrwU0QYcBW0FWrSf/eVt5PotbSY/69vxb3Ejk/Y8jrBh1EHXbpBCzB6rbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=dl9GGNBf; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=wAejJCOWGhS6ahmi7F3Y7ihhgKOa0pYIpSX1RnrC5kA=; 
	b=dl9GGNBfTI7IKWghAe2oVvSt5kRLD04G9uhCGVeopEr5k7HGwGwI0SV9d5JbwJxDVm2dpX4+Ho4
	UZmqqHXQPO4q6N0B3y3a9soTw+ZML/fvrkSb8PCsqhlKKWHe9TPwX+oitFqtGncS0xrBvLHqe3ke0
	oWLHd9GQDtx5tr4Nl7Zq70ayLT0OTniNwDGuDVYzYDDrpXAuaX7OBduXC4Ai146unnwukeEsDCNtk
	XEVa8RZ5SOiLDhPQHcbn9zYFV2MIsZ2rNY44CX9bla0e5gpD8EHrE/CWN4yU51gJTabyDna5dxXdE
	EpABqVuv1g0GyD53j4PDa21e4Z48L4GoH/2g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wK8fx-00BKda-2i;
	Tue, 05 May 2026 13:50:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 13:50:33 +0800
Date: Tue, 5 May 2026 13:50:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] talitos: allocate channels with main struct
Message-ID: <afmFKQjJQUHeQO2O@gondor.apana.org.au>
References: <20260430214340.59588-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430214340.59588-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 3FC554C6F7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23701-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

On Thu, Apr 30, 2026 at 02:43:40PM -0700, Rosen Penev wrote:
>
> -	priv = devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
> +	of_property_read_u32(np, "fsl,num-channels", &num_channels);

Sashiko suggests that you check the return value of this call:

https://sashiko.dev/#/patchset/20260430214340.59588-1-rosenp%40gmail.com

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

