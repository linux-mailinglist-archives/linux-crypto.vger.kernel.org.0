Return-Path: <linux-crypto+bounces-22853-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrzMkoN1mmfAwgAu9opvQ
	(envelope-from <linux-crypto+bounces-22853-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 10:09:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B63B8C5A
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F3DC301A6B2
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Apr 2026 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BCA38E5CE;
	Wed,  8 Apr 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="slUEtJ/a"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351F39D6F3;
	Wed,  8 Apr 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635750; cv=none; b=sxTKRTD0MzEAmkWkEPnmc+CRaxanSYFvkmO4cJye7MFinCm16lR0+0/joUPXv+kyI9xMSQOXc0Gf4/btLaTO2ZkzkOrHAzIS8NP0GGZmU/gRDrjRF1OtCeIbxpJL3RXFBkwR6mmaN/CmtoXTW4wGF7QY/1F8ayx9t4F+S2oGI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635750; c=relaxed/simple;
	bh=koSehwWSxjU3ovsKT7f36DXu4y6eMsgpzShZGFK93+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAS80yalPCjXxpfXU5CSo6KY1Ix0WRezfdMH5BZe/Ql4+Zfyad9StDgLtJHbp+IO+vsvh7+KNHzwkl9e50NTAUiEQowKpCXaL0QkQzfMIEjIx9cSK0i6V0Z1NHG82bQ1BNP5FouLF2L5Tx88NtELzJmEmMQsl9os7RIVN015nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=slUEtJ/a; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=l8aaaehgysH2hcfIZINOSwreJrwK4RdOvdUPlIC0mwY=; 
	b=slUEtJ/asWbPK7wnHP/gklNlHvd8xYUVOgV7KqsctVF0ppZufBjaEoKrx4uKCIFoT0WdMnVKWh+
	bJAWhVlVJTOA2HTDu1xujmh/z0mzsLtscPH+w7p04GhBOG4vIVpWC43em4L/bs3MVLhwN2L8J8SDD
	repz4041mk82cl6wgKpsEeZ6FX6WL3UWSpv4kYaVUjqnQLkCk0+Gg/R9BK+mz4c4CLwahZtGZaFmS
	A+uTUvQhzSAR8Zjjo65NbuJaSYXxhjM/0tPbVstNxH5expWzTHbzCIX3xFDHfAxqIZzmlbFLLjFjW
	kzGcG3agrG34DXtK3DBleJ1Bz6moytH7I1Hw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wANYN-004dIK-1B;
	Wed, 08 Apr 2026 16:08:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Apr 2026 16:08:42 +0800
Date: Wed, 8 Apr 2026 16:08:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	Paul Monson <paul.monson@capgemini.com>
Subject: Re: [PATCH] crypto: tstmgr - guard xxhash tests
Message-ID: <adYNClYB6RY820Xl@gondor.apana.org.au>
References: <20260407192859.270745-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407192859.270745-1-hamzamahfooz@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,linux.microsoft.com,capgemini.com];
	TAGGED_FROM(0.00)[bounces-22853-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SEM_FAIL(0.00)[104.64.211.4:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,capgemini.com:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Queue-Id: 0D3B63B8C5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:28:59PM -0700, Hamza Mahfooz wrote:
> If the kernel isn't built with CONFIG_CRYPTO_XXHASH and booted with FIPS
> mode enabled it will currently panic. So, only benchmark xxhash64 if
> CRYPTO_XXHASH is enabled.
> 
> Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> Cc: Paul Monson <paul.monson@capgemini.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  crypto/testmgr.c | 2 ++
>  1 file changed, 2 insertions(+)

Please show me the panic.  Normally it's not an issue if an algorithm
is not present while the test vectors are.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

