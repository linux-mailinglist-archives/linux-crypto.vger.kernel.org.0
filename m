Return-Path: <linux-crypto+bounces-23953-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL/cDkg1A2oA1gEAu9opvQ
	(envelope-from <linux-crypto+bounces-23953-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 16:12:24 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222A52208E
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E418B3123607
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2839A4D6;
	Tue, 12 May 2026 13:48:17 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BD3998BA;
	Tue, 12 May 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593697; cv=none; b=quBI7iUGjsFOFt9N942L66E1+hwePQREeBqphWPA7GWxkVFviA/0Wj1zqlaR+T3u3ERdhd5zeM8OjJCSgGt3hDwcmMcaSalUKkEKJw/RI6wgegIqPXk5lPF2/gCCFOOLClRaCaTpn9yHB2IPeOUcV2JrfnyoTtAN1j7ZyR9Vqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593697; c=relaxed/simple;
	bh=ROhebuTzRI3+x+UVCMTkjzsAgIsB6GwIzYS6u/P/bKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8kxH064Bifiyew5LN7QNhEc2wUlemmTgGLGFzDDiaostswI0z92rGhYrrcraA0pourr5mMxUJcsy9ANGNtA/8rL08H4hODky3eMpFXFK2V+fkQxcCwPAlRCn2nuBRhvkTHXS3hMiHIlU45sMbIwqXWzKMvqP5AzpCWXbTI9E1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id B3281C8B;
	Tue, 12 May 2026 15:48:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8D2D6603572F; Tue, 12 May 2026 15:48:11 +0200 (CEST)
Date: Tue, 12 May 2026 15:48:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Anastasia Tishchenko <sv3iry@gmail.com>
Cc: Ignat Korchagin <ignat@linux.win>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto : ecc - Fix carry overflow in vli multiplication
Message-ID: <agMvm_bA-OcDWhbc@wunner.de>
References: <20260508114844.29694-1-sv3iry@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508114844.29694-1-sv3iry@gmail.com>
X-Rspamd-Queue-Id: 2222A52208E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23953-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.907];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 02:48:44PM +0300, Anastasia Tishchenko wrote:
> The carry flag calculation fails when r01.m_high is saturated
> (0xFFFFFFFFFFFFFFFF) and addition of lower bits overflows.
> 
> The condition (r01.m_high < product.m_high) doesn't handle the case
> where r01.m_high == product.m_high and an additional carry exists
> from lower-bit overflow.
> 
> Add proper handling for this boundary by accounting for the carry
> from the lower addition.
[...]
> +++ b/crypto/ecc.c
> @@ -427,7 +427,10 @@ static void vli_mult(u64 *result, const u64 *left, const u64 *right,
>  			product = mul_64_64(left[i], right[k - i]);
>  
>  			r01 = add_128_128(r01, product);
> -			r2 += (r01.m_high < product.m_high);
> +			if (r01.m_high != product.m_high)
> +				r2 += (r01.m_high < product.m_high);
> +			else
> +				r2 += (r01.m_low < product.m_low);
>  		}
>  
>  		result[k] = r01.m_low;

ICYMI, sashiko's AI-generated review alleges that the if-else condition
may cause a timing side channel vis-à-vis binary arithmetic:

https://sashiko.dev/#/patchset/20260508114844.29694-1-sv3iry%40gmail.com

You may want to address this if/when respinning your patch.  If you do,
a code comment is probably merited to explain this subtlety.

Thanks,

Lukas

