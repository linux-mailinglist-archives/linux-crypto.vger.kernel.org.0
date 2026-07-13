Return-Path: <linux-crypto+bounces-25943-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GBoHK/B2VWo4owAAu9opvQ
	(envelope-from <linux-crypto+bounces-25943-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 01:38:24 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA974FC19
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 01:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YgS8C3B1;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25943-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25943-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545F7303FB97
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF13B813E;
	Mon, 13 Jul 2026 23:38:01 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0235C193;
	Mon, 13 Jul 2026 23:37:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985881; cv=none; b=jN2DF6THXfa3m8inlLJh1ZUe9E/XKhKb2GnX0dHlt4K+Jb3GQyCrO32p1gkU//VyaaOVLy9ilfA2O7dodMFYqkZ3WxdE1OCcNYvQtrb05eFOxo1euDKvIKiT/0kXoQHjpmNq8HFedfByz+PMt8kGGw1Zghv1YRnO5gz4xXa+oUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985881; c=relaxed/simple;
	bh=aie/e6QWHi7Lkahi+k51njfqugr3fUsirwejXCbUGMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzJ0/qRgN607UCoHnQCgMXX3XQEXsh4veZKXfdvakP97pdC+j0KQyQD6ovTDCSGE/lsVzHDElW6SXva3ra+svWcUE6qBCzlvd8DecbcpnNUCDs+QURzH9M+F/3kSgxlwhBdQmDNE8JjaCZwmvMDpihx5SJk0eJdbiVFFplhd9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgS8C3B1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A2D1F000E9;
	Mon, 13 Jul 2026 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783985879;
	bh=dQZxIocQ/FM4iU3WHgnq2vLxLp2hH8yLHsbTBcVXpvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YgS8C3B1pSfIdQTo1HSXvwvCcUD6aJf+t6+nJ4vJ3qEBSeoB8XEcddL52t96GyXlv
	 holqMBAD2SBt0oJpA1UcJEsMLPpxnndR8WyZp1Jy32drzRPSHCHcJnrcJjbcheS7HN
	 10if1r1pmfbJcd04taq6ArYF1nkTG7T6qFKAILLhFzwG31d9XAuShdw/Wyj/lF9JJE
	 jm+vlWJVLSji3rXnz1ipe/cRgG920m/7Uq1O/HQ68Xme7pXk1iew8x8rmNG+Dg0/Uf
	 qH0HI8vTxB9RMD9/FndoAFjpb8vSAep7MkJX5a6qvno4j+mI+raOnHCDhGMoSNJm5h
	 5qcZ6o6r0gF8A==
Date: Mon, 13 Jul 2026 19:37:57 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] lib/crypto: aes: Add CBC and CBC-CTS support
Message-ID: <20260713233757.GA24654@quark>
References: <20260707053503.209874-1-ebiggers@kernel.org>
 <20260707053503.209874-4-ebiggers@kernel.org>
 <2bbc6563-3328-4153-97fb-2d0a10ceefaf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbc6563-3328-4153-97fb-2d0a10ceefaf@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25943-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thuth@redhat.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quark:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12CA974FC19

On Thu, Jul 09, 2026 at 03:06:03PM +0200, Thomas Huth wrote:
> On 07/07/2026 07.34, Eric Biggers wrote:
> > Add support for AES-CBC and AES-CBC-CTS to the crypto library.
> > 
> > These will be used to provide streamlined implementations of the
> > "cbc(aes)" and "cts(cbc(aes))" crypto_skcipher algorithms.  Most users
> > of these crypto_skcipher algorithms will also be able to switch to the
> > library, which as usual will be simpler and faster, e.g.:
> > 
> >      - block/blk-crypto-fallback.c (for AES-128-CBC-ESSIV)
> >      - fs/crypto/crypto.c (for AES-128-CBC-ESSIV)
> >      - fs/crypto/fname.c (for AES-256-CTS and AES-128-CBC)
> >      - kernel/bpf/crypto.c
> >      - net/ceph/crypto.c
> >      - security/keys/encrypted-keys/encrypted.c
> > 
> > As usual, the architecture-optimized AES-CBC and AES-CBC-CTS code will
> > be migrated into the library as well (using the hooks provided in this
> > commit), eliminating lots of repetitive boilerplate code.
> > 
> > Initial test coverage is provided by the crypto_skcipher support added
> > in a later commit.  I'm planning a KUnit test suite as well.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >   .../crypto/libcrypto-unauth-encryption.rst    |   7 +
> >   include/crypto/aes-cbc.h                      |  77 ++++++++
> >   lib/crypto/Kconfig                            |   6 +
> >   lib/crypto/aes.c                              | 174 ++++++++++++++++++
> >   lib/crypto/tests/Kconfig                      |   1 +
> >   5 files changed, 265 insertions(+)
> >   create mode 100644 include/crypto/aes-cbc.h
> ...
> > +void aes_cbc_cts_decrypt(u8 *dst, const u8 *src, size_t len,
> > +			 u8 iv[AES_BLOCK_SIZE], const struct aes_key *key)
> > +{
> > +	/* Offset to P[n] and C[n] (last plaintext and ciphertext block) */
> > +	size_t pn_offset = round_down(len - 1, AES_BLOCK_SIZE);
> > +	/* Length of P[n] and C[n], 1 <= pn_len <= AES_BLOCK_SIZE */
> > +	size_t pn_len = len - pn_offset;
> > +	u8 *pad;
> > +
> > +	if (WARN_ON_ONCE(len < AES_BLOCK_SIZE))
> > +		return;
> > +
> > +	if (len == AES_BLOCK_SIZE) {
> > +		aes_cbc_decrypt(dst, src, len, iv, key);
> > +		return;
> > +	}
> > +	if (likely(aes_cbc_cts_decrypt_arch(dst, src, len, iv, key)))
> > +		return;
> > +
> > +	/* Compute P[0]..P[n - 2]. */
> > +	aes_cbc_decrypt(dst, src, pn_offset - AES_BLOCK_SIZE, iv, key);
> > +
> > +	/* Compute P[n] and P[n - 1], considering that src may equal dst. */
> > +	pad = &dst[pn_offset - AES_BLOCK_SIZE];
> > +	aes_decrypt(key, pad, &src[pn_offset - AES_BLOCK_SIZE]);
> > +	crypto_xor_cpy(&dst[pn_offset], &src[pn_offset], pad,
> > +		       pn_len); /* P[n] */
> > +	crypto_xor(pad, &dst[pn_offset], pn_len);
> 
> Took me a while to understand why you'd use the above xor instead of a
> memcpy(pad, &src[pn_offset], pn_len) here, but that's because src and dst
> might point to the same buffer, right?
> 
> Anyway, patch looks good to me, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Yes, the write to &dst[pn_offset] can overwrite &src[pn_offset].

- Eric

