Return-Path: <linux-crypto+bounces-24097-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mONuJB37Bmp6qQIAu9opvQ
	(envelope-from <linux-crypto+bounces-24097-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:53:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135954DCA7
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 12:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48E13176DDD
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DD3CF68E;
	Fri, 15 May 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="j59AUqHp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB83CF05D;
	Fri, 15 May 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840759; cv=none; b=FW9R5EcoFKHNQNxojQOA32hKqVsUi0TVncMP+2BPaY0J0QgOYwp0120SlVjiy1CyoNCO2SFXtnR680SkpNo6jYnu/IPIRWVyI3+6yytgkjKcOWhXoAj9/I2qQ65m8HkU2wfjMLfToLv+5PlFTaHPvkpBcWPRi+Ec+AxbdFUwSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840759; c=relaxed/simple;
	bh=9ua1fNtpRrpY8nEWGZCVLL3yx3XkTTA7r+w0nyNHHpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpGPTTZR5y4Jnj/iro3P1nIM9Adm8432aGAkYCdZhBgGZjOMw8kCr/I6BdXsRiXsJOM88FBBzlEF25ZrHptYuvK1LwdoNNqdbQLSV9T8W1KH+f+1wx+r/vb0BcfVUWjBZd2NpZhbjQXxtPkqmuV0ooV88IVZNpVWHWP9YU+F3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=j59AUqHp; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=sqd8gD0dbbKy/oHe14fkFvFJbliuXT+OOHtb/+bjx1s=; 
	b=j59AUqHpSEzgMC6JzLsiuiw76tS6GRjzddvf2Fa55ldBVLq9T1qmmBNjrcXNLBvxahaQI7bP4As
	dKLq6d+l2KxzOOEdGU113MBIJygd5AYzJl6UjISMlh5XEI8T7EHt7UZLPbzWH5aiw/lIAScR90POr
	VxTPJJ0Mt2JlF+ppOtUJOTIQ3MbIUV5AN4JlLbmcRDFKaawsmKWxNIRgsfe+9NSBem75Cuj2Yy+hW
	6Pb2M/RPd/N2ZcG2PafWm/sE4g165/IRDWUPXP6FSE6APmfkboAhJ6DjDAzp9OG9kiuJmA8QtjvFn
	Xsh6oXIVhhA07mw1kLoMJWC3OELY/Z5xAEBg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpjd-00EOdR-1x;
	Fri, 15 May 2026 18:25:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:25:37 +0800
Date: Fri, 15 May 2026 18:25:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: atmel-sha204a - drop __maybe_unused and
 of_match_ptr
Message-ID: <agb0oUVEh0LqaTtB@gondor.apana.org.au>
References: <20260509101155.2095-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509101155.2095-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 9135954DCA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-24097-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 12:11:55PM +0200, Thorsten Blum wrote:
> Since MODULE_DEVICE_TABLE() keeps atmel_sha204a_dt_ids referenced, drop
> the unnecessary __maybe_unused annotation. Also remove of_match_ptr()
> because OF matching is stubbed out when CONFIG_OF=n.
> 
> Reformat atmel_sha204a_dt_ids to silence a checkpatch error and
> atmel_sha204a_id for consistency.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/atmel-sha204a.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

