Return-Path: <linux-crypto+bounces-22211-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG3mMvX0vmk0mAMAu9opvQ
	(envelope-from <linux-crypto+bounces-22211-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 20:43:49 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6893B2E70B5
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 20:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96A23016241
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186233C197;
	Sat, 21 Mar 2026 19:43:44 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE83112C0;
	Sat, 21 Mar 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122224; cv=none; b=SFben710WtjbWYwFESUWpf/bfcLxBDlHvjSTVFhOOIwlKb3INcqZyr1W2zXS905uC/ie3fjEOTytY27kAaUSfJ0j4RJ+4pHYfLWY0fLNLEQOup50y6bqaWo6W0J79Ekbl48l1KWafI6KAFpVPBbPWC5f8DehPLzlFgzY4OhMnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122224; c=relaxed/simple;
	bh=kZ/Ic8rOxG8oiFW36++CtsV185eY4QTgmnqbYMlYh/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDFvM3s7UffEPwplLWWMqdlT+zOd+plGacSb1qM9PLDf1vq4lSknbHsIL7H7c7PwAoB+7RNCNqD3V8d69GrVTprWGIv3nhOn6ksPfqB2H9eaOmSzeUkQTHLTTgpjAgZ9Tfm3WudfrW1NpEeAhzJ7cZ6tLQLq/nCzt3GBS6kndTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C9E0110615;
	Sat, 21 Mar 2026 20:43:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B906E60024C9; Sat, 21 Mar 2026 20:43:31 +0100 (CET)
Date: Sat, 21 Mar 2026 20:43:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ignat Korchagin <ignat@cloudflare.com>, akpm@linux-foundation.org,
	dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	ignat@linux.win
Subject: Re: [PATCH] MAINTAINERS: update email address for Ignat Korchagin
Message-ID: <ab7041i5NKEH0Uvp@wunner.de>
References: <20260309173445.71393-1-ignat@cloudflare.com>
 <ab5ajEP3OL-3RLCr@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5ajEP3OL-3RLCr@gondor.apana.org.au>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22211-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6893B2E70B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 05:45:00PM +0900, Herbert Xu wrote:
> Ignat Korchagin <ignat@cloudflare.com> wrote:
> > Since I'm moving from Cloudflare update my email address in the
> > MAINTAINERS file and add an entry to .mailmap so nothing gets lost.
> > 
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> > .mailmap    | 1 +
> > MAINTAINERS | 8 ++++----
> > 2 files changed, 5 insertions(+), 4 deletions(-)
> 
> Patch applied.  Thanks.

Andrew already applied it and forwarded it to Linus.
This is now commit 182b9b3d8d1d in Linus' tree.

Thanks,

Lukas

