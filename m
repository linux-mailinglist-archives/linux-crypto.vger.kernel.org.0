Return-Path: <linux-crypto+bounces-22193-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC+aItVavmmYNQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22193-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:46:13 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E083F2E435F
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840CD303B4C8
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637E33EAEA;
	Sat, 21 Mar 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="IR1r8+3J"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF034889C;
	Sat, 21 Mar 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082714; cv=none; b=HYU53DRoi1A4qwPdTyqmWSgmiUY6xZ1oxcAeBIMHn3Ogyk6DujhwPbTMhZ5JcQbzinBxEUfGlXDBqFTutTvgJrRSI1U2Fqyj01o4gB/DjavXMMrJ2wkQoNYsdUk8GW7PDJcYTPFOOQ2EMh4Y7BS3wmr756k9G8gdNZVn1v8APcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082714; c=relaxed/simple;
	bh=3cxrFvDjbKxQW1tvi0xPgzZeD8r0gxeQtgqcky+vhZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pWz0KuAap50eMHfG6TNGPTZ3ZeepqvDtEeMrLYcttkW96i69M88ZeAgh0LSy436QNMnxqcRfSpzaKqKQ+5JOHG8se/DO5nYLY+zJHdUXC9l9Gy43fSR/6nAuQx1fMltcMGnCeHKe5tDVqVStmSOFMo8StGYSgj5E/wrx2WXVchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=IR1r8+3J; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=1zh8l9f4SfArzEpvsYR+U6vnmpbgpivf4KXSSRYalFg=; b=IR1r8+3Jf/4MSAkt4uQ0jobqFL
	zPPXRTsZx8FYAjVLw8mZB5DSZk0/vnI0gJeK5Jh/MsdwFSKWOMAu+f7Gq3KIvYRPZTBCWCAmGcsv0
	JZ1i6yHEnV7Rh/GSZvb4iQz/eWeLnDg6RpNUMo8UFe8Pw6HdWBvhLiSFAEfArW74Ti3om4/iVt1Gf
	u+hB/JbYUQn/D2FwLWFJBH/lTkxRk/kkTyUFh/C9xzPHqwIHEXX/D/BrNn+e7u/PLtwS7NDbB53Yk
	XNjWjsb7Xva3RQnEvnqH2f9aTMf6X5/hcROCxFNr/fTfcEh0cI8iac1T+Q9SQYVSJLoeZ2jCvrGqo
	WT2Uwtfw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3rx6-00GJ76-0I;
	Sat, 21 Mar 2026 16:45:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:45:00 +0900
Date: Sat, 21 Mar 2026 17:45:00 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: akpm@linux-foundation.org, dhowells@redhat.com, lukas@wunner.de,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, ignat@linux.win, ignat@cloudflare.com
Subject: Re: [PATCH] MAINTAINERS: update email address for Ignat Korchagin
Message-ID: <ab5ajEP3OL-3RLCr@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309173445.71393-1-ignat@cloudflare.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22193-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: E083F2E435F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ignat Korchagin <ignat@cloudflare.com> wrote:
> Since I'm moving from Cloudflare update my email address in the
> MAINTAINERS file and add an entry to .mailmap so nothing gets lost.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
> .mailmap    | 1 +
> MAINTAINERS | 8 ++++----
> 2 files changed, 5 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

