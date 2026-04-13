Return-Path: <linux-crypto+bounces-22979-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPGSLkDb3GlwXgkAu9opvQ
	(envelope-from <linux-crypto+bounces-22979-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 14:02:08 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89E3EBAA1
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A5630071D9
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AA3BB9EF;
	Mon, 13 Apr 2026 11:58:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65037C914
	for <linux-crypto@vger.kernel.org>; Mon, 13 Apr 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081505; cv=none; b=SXlXfaQvXbSLFCh+k7VZY5Y8y3xL1XDiWRrFoWpfXkIS2z45mX+bgd2f7I6EOOZNwVUMbRBAwowVitpEzZkdi3lGgh04wtW/fbADUNZrStxCaZddpr3eidubK6w8C3tdNywXY+zj5KOnbfgHHuQLVGhsQq5ycE15Z5g8lI1eGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081505; c=relaxed/simple;
	bh=okS2ETBuQ9uKfB0uN9rufSyTr0vTdhbAhvNPLht4dF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7hcQN3KW0eU15iPB7385Y+BtJfZRG12tSINK1hK8JH3Xoe4GtYirzJT1fvOIfFY2f9T+Jaiwcoj8pES4mMczv2r83ENc3Ltbelj8I40Gnf7rqT2LEt5MJVr0RZEa38iCBugPdzSutmWD75iJtni8jJNzoWbVZdAweZUX2RElEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 49FC738A;
	Mon, 13 Apr 2026 13:58:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 339506017530; Mon, 13 Apr 2026 13:58:13 +0200 (CEST)
Date: Mon, 13 Apr 2026 13:58:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Eric Biggers <ebiggers@kernel.org>, Jason Donenfeld <jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ignat Korchagin <ignat@linux.win>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Tadeusz Struk <tstruk@gigaio.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: lib/mpi - Fix integer underflow in
 mpi_read_raw_from_sgl()
Message-ID: <adzaVYg-TEYpL0C8@wunner.de>
References: <59eca92ff4f87e2081777f1423a0efaaadcfdb39.1776003111.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59eca92ff4f87e2081777f1423a0efaaadcfdb39.1776003111.git.lukas@wunner.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22979-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zx2c4.com,gmail.com,gondor.apana.org.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: 1F89E3EBAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 04:19:47PM +0200, Lukas Wunner wrote:
> Yiming reports an integer underflow in mpi_read_raw_from_sgl() when
> subtracting "lzeros" from the unsigned "nbytes".
[...]
> +++ b/lib/crypto/mpi/mpicoder.c
> @@ -347,7 +347,7 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
>  	lzeros = 0;
>  	len = 0;
>  	while (nbytes > 0) {
> -		while (len && !*buff) {
> +		while (len && !*buff && lzeros < nbytes) {
>  			lzeros++;
>  			len--;
>  			buff++;

As a side note, in 2018, commit 8a2a0dd35f2e ("crypto: caam - strip
input zeros from RSA input buffer") copy-pasted a large portion of
mpi_read_raw_from_sgl() into caam_rsa_count_leading_zeros() and
duplicated the bug as well.

One year later, commit c3725f7ccc8c ("crypto: caam - fix
pkcs1pad(rsa-caam, sha256) failure because of invalid input")
fixed the bug in the duplicated function, but unfortunately not
in the original mpi_read_raw_from_sgl().  The fix was identical
to the one I'm proposing above.

Thanks,

Lukas

