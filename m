Return-Path: <linux-crypto+bounces-24925-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZ0wKj62ImoecgEAu9opvQ
	(envelope-from <linux-crypto+bounces-24925-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:42:54 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44E647D14
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=XlwZHnJm;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24925-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24925-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24FEF30450AC
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8554D90DB;
	Fri,  5 Jun 2026 11:41:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63324D90D3
	for <linux-crypto@vger.kernel.org>; Fri,  5 Jun 2026 11:41:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659700; cv=none; b=OZ7l9jn0PE77vuBmYbfDU7EHnt1mpgC3IbDE1T3D8LCW5j4P34FcCxTizILlJc5+/uYlYwsH2zJVirDyFdJgXfyQc5c/wIZtwpycTLgWpLtbFrlE4p7/Y/4TCS+E7CcwOFCy2R8nAndllfh4mKacEgrvbo7T4sEOhroKOoX+MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659700; c=relaxed/simple;
	bh=yXUrFa+FZD9RgKgX9mpwl/oMjCfAeRt6gDhRuV29mHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak49MgYggMm7nYG1tIig3YYf4ICofgoOP0VUbGz6I6Ik+145tWKPiU9uXc1H5kA/Ev4EsK5Le6D/EBj6FqZIOA/4Ms5y3qXLj7Gi4GfprOz+8vuXgbMsUR6O1Yf/9ZVYYD0yWi6v+kL9r6opAaRMyZSUd7f+qvRfS7LR0ZZxf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=XlwZHnJm; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=phXP58fEJwQPQjWvXEaKS99PCugFwTbuSRAeqZED06k=; 
	b=XlwZHnJmIRrTsw7ZvnCDKDfTJnYDTQw2WDUvnfaQ+iVmD5K1XsJr954RzUnNoXyNkdXzAA6Sv4w
	ldkcl1lIH8rbtjpNVg8LTKhuPxo+RJSJjKaW1wWxO8rkiZ97bEcFnWH58cl2oT58gZexUhQmPk7qR
	GUPssoqMwWOM9E6wRTk4kpqd7QNnslvzl9SLBDZI2Y7IGUQXX8DMMxm4hw9Jzhrl3wrKGATv4IYYC
	3Bfo/3z7jFa2BW3kzb9LbRgWcUhKxWeZPha6lh+rbOzSMu6c+lklRHqsyfbVC9Kc0E0cjU2zVOhTE
	iFl7q/noc2vGWvuh49poqsZ112iAwpQfAr+w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSvf-002onS-1V;
	Fri, 05 Jun 2026 19:41:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:41:35 +0800
Date: Fri, 5 Jun 2026 19:41:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, yuantan098@gmail.com,
	zcliangcn@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn,
	ngochuongbui67@gmail.com
Subject: Re: [PATCH crypto 1/1] crypto: chacha20poly1305: validate poly1305
 template argument
Message-ID: <aiK17686DCMVKGVF@gondor.apana.org.au>
References: <cover.1779777598.git.ngochuongbui67@gmail.com>
 <e7a116d3474cd00e421393e0512ad11b151ca2f1.1779777598.git.ngochuongbui67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a116d3474cd00e421393e0512ad11b151ca2f1.1779777598.git.ngochuongbui67@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-24925-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-crypto@vger.kernel.org,m:davem@davemloft.net,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:ngochuongbui67@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E44E647D14

On Tue, May 26, 2026 at 06:11:43PM +0800, Ren Wei wrote:
> From: Xiaonan Zhao <ngochuongbui67@gmail.com>
> 
> chachapoly_create() still accepts the compatibility poly1305 parameter
> in the template name, but it assumes the second template argument is
> always present and immediately passes it to strcmp().
> 
> When the argument is missing, crypto_attr_alg_name() returns an error
> pointer. Check for that before comparing the name so malformed template
> instantiations fail with an error instead of dereferencing the error
> pointer in strcmp().
> 
> This matches the surrounding Crypto API template pattern where
> crypto_attr_alg_name() results are validated before string-specific use.
> 
> Fixes: a298765e28ad ("crypto: chacha20poly1305 - Use lib/crypto poly1305")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Xiaonan Zhao <ngochuongbui67@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  crypto/chacha20poly1305.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

