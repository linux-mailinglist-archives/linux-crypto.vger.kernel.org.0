Return-Path: <linux-crypto+bounces-22201-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oACSMRRcvmmYNQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22201-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:51:32 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C62E43EF
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5F63036056
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425EF2FE05B;
	Sat, 21 Mar 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="fzspxCTE"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481A272816;
	Sat, 21 Mar 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083005; cv=none; b=NlhjnRHweWcoNk+iOUQnVVg/OLeo7je26CzGUm+a9gTSFg4TmVC8++vd0T0mgNIZfKPQplG7RzGp74Z9YD3mzgqPHR6Q4PTCsjJGOJUiQ1qcvIVF05U5F2gCrZUS1mpeAnBj/C/kukddN7Re3kNsVd4+TZOajQwhGaju8L83/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083005; c=relaxed/simple;
	bh=ofzraNFyxQIh8ZLkcj9koBTINPF+Ls4MudH2v3nfIuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nksBj9R6sguSCVcgUObRXS/Sifb6biIoif0Lz9kxy5iIcrT7dyIrvwfS972K62BvD8siCYklOtcPBbMTzAMILIwr535TBsImDWpxE+G5CfxV+GM/VKs7//ss56flgLOxLCepeUMD0jxYBd1p7S7a3zNb4jLSrcAbV0pVzUfnBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=fzspxCTE; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=D3ONsQGxZPVdYLczvZ9OCO4G3QllTcAcohxKN8gpMCQ=; 
	b=fzspxCTEonVcOwC51XIHMw5IVjWkYgHh9uQcyLhBO8pG98UZz9b+wURGhT4KKjTISq5ayPSe3M1
	PvvqQxeLfJC9NpOU6CC1AcS+zDcNXYQlgQXeaOB7jxFM4SPVhsm/d//371Zt2y9YolJu+/3xpz6E/
	KeAMZyEVbkB3oXHNVufTLLJPd1QSNbDWnjHiya6czlxPlO2rPxhHyaM42CgSB43u9DS+MZ9bAkXqK
	CKNEnQ9g2JXICUXAZP+o4cP/GppUfqSsHIat5ZSWpmWN/OoxdT5QVYTZerxkZDN+1lS6ArCVWi8kO
	8cNNhnfTah/VSC6zSCYTuG6qV65YY5oR5Vbg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3s1w-00GJDh-1A;
	Sat, 21 Mar 2026 16:50:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:50:00 +0900
Date: Sat, 21 Mar 2026 17:50:00 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sun Chaobo <suncoding913@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Fix several spelling mistakes in comments
Message-ID: <ab5buHDvepKWipF9@gondor.apana.org.au>
References: <20260313145257.41937-1-suncoding913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313145257.41937-1-suncoding913@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22201-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 2A8C62E43EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:52:57PM +0800, Sun Chaobo wrote:
> Fix several typos in comments and messages.
> No functional change.
> 
> Signed-off-by: Sun Chaobo <suncoding913@gmail.com>
> ---
>  crypto/drbg.c   | 2 +-
>  crypto/lrw.c    | 2 +-
>  crypto/tcrypt.c | 2 +-
>  crypto/tea.c    | 2 +-
>  crypto/xts.c    | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

