Return-Path: <linux-crypto+bounces-21522-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COwhElEkp2mMegAAu9opvQ
	(envelope-from <linux-crypto+bounces-21522-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:11:29 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B06511F511E
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BB43198A0E
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63482381AF2;
	Tue,  3 Mar 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ao+Kf/Rm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AC381AE4
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561151; cv=none; b=D5XMzCFryAFxwAC+buOki3/rMM3KIUKf+sXsAsmb/6mlhOgNOdolwzM7Bknh7F2p5qzDG9dvlDroZOAMY9hdd3c13ciYfZ02kb76KbBXuHqJuSuJUnx9aISG9O5M8euQAGAZH91paJ9l2wHfTXkQOv5WgnnG/xy0KHM3gczvi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561151; c=relaxed/simple;
	bh=GvgoXKlNCZTmxNXe6NFfKIWcdPwKdgPPUwYm+o9DDjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmj9uSQlKMz8en7/JbAEUZieXO0cX5Z12WxOFoEn/Zv98oa12PkbGYV1lAJP2xrTFzoY9t/8lci8TDs3yoYtkee1o/n4A6fvdIr5N1GYedYB7QO2Z47EpUE3o9jHGfiq3Iyep7mF9P2x4tht0a+8kw6UusY7aeb67CIz1sfRh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ao+Kf/Rm; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33240 invoked from network); 3 Mar 2026 19:05:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1772561144; bh=5mjDT9HvVdpxDl2NEzmymPUuj7JOMwJIRk5fyMsCZws=;
          h=Subject:To:Cc:From;
          b=ao+Kf/RmuLz4Oa2NX4HlE99Fc+oBPJ+tHKMqkFviOYyukDp8EzfTxFn4Jx+BeifQu
           7u523LY8GzLfwPIDBvugqBqIvP55noyZbXEesBIn0umZMpmCqxQAev6EAAAaIRc9Y5
           tYxgxPzkB0RSYlHKoQJJOa22CgbzSU3b9tLskYLU4yoZ/OrBHEqEQ6mghAAmUYQ3Ek
           OUf/lV89dFqDLSsJA0bMlcWD2tJX1NNIhRnC+6xdzJ0cn8JfN5G/8Na+TYfcg2wAQD
           DVpJy4y+dDcaSi3u4e5HoqXZ4b9z7A2CiLO/vN/n3ctGMhRB78tkF1An+eoXLHEZoc
           hK8EBX54uX/xA==
Received: from 83.24.116.171.ipv4.supernova.orange.pl (HELO [192.168.3.246]) (olek2@wp.pl@[83.24.116.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ebiggers@kernel.org>; 3 Mar 2026 19:05:44 +0100
Message-ID: <29f5c202-6244-4a89-aa5f-b067cb828033@wp.pl>
Date: Tue, 3 Mar 2026 19:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: testmgr - Fix stale references to aes-generic
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302234856.30569-1-ebiggers@kernel.org>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260302234856.30569-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: ddd5f56e168f6581aae617a789909c35
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [QaqX]                               
X-Rspamd-Queue-Id: B06511F511E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21522-lists,linux-crypto=lfdr.de];
	FREEMAIL_FROM(0.00)[wp.pl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wp.pl:dkim,wp.pl:email,wp.pl:mid]
X-Rspamd-Action: no action


On 3/3/26 00:48, Eric Biggers wrote:
> Due to commit a2484474272e ("crypto: aes - Replace aes-generic with
> wrapper around lib"), the "aes-generic" driver name has been replaced
> with "aes-lib".  Update a couple testmgr entries that were added
> concurrently with this change.
>
> Fixes: a22d48cbe558 ("crypto: testmgr - Add test vectors for authenc(hmac(sha224),cbc(aes))")
> Fixes: 030218dedee2 ("crypto: testmgr - Add test vectors for authenc(hmac(sha384),cbc(aes))")
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>
> This patch is targeting libcrypto-fixes for v7.0
>
>   crypto/testmgr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 49b607f65f636..4985411dedaec 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -4130,11 +4130,11 @@ static const struct alg_test_desc alg_test_descs[] = {
>   		.alg = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
>   		.test = alg_test_null,
>   		.fips_allowed = 1,
>   	}, {
>   		.alg = "authenc(hmac(sha224),cbc(aes))",
> -		.generic_driver = "authenc(hmac-sha224-lib,cbc(aes-generic))",
> +		.generic_driver = "authenc(hmac-sha224-lib,cbc(aes-lib))",
>   		.test = alg_test_aead,
>   		.suite = {
>   			.aead = __VECS(hmac_sha224_aes_cbc_tv_temp)
>   		}
>   	}, {
> @@ -4192,11 +4192,11 @@ static const struct alg_test_desc alg_test_descs[] = {
>   		.alg = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
>   		.test = alg_test_null,
>   		.fips_allowed = 1,
>   	}, {
>   		.alg = "authenc(hmac(sha384),cbc(aes))",
> -		.generic_driver = "authenc(hmac-sha384-lib,cbc(aes-generic))",
> +		.generic_driver = "authenc(hmac-sha384-lib,cbc(aes-lib))",
>   		.test = alg_test_aead,
>   		.suite = {
>   			.aead = __VECS(hmac_sha384_aes_cbc_tv_temp)
>   		}
>   	}, {
>
> base-commit: f33ac74f9cc1cdadd3921246832b2084a5dec53a

