Return-Path: <linux-crypto+bounces-25513-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KFfXON6/RGrv0AoAu9opvQ
	(envelope-from <linux-crypto+bounces-25513-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 09:21:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE46EA93C
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 09:21:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k3XOdT1j;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25513-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25513-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 146E8301EF7F
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2026 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723363B388E;
	Wed,  1 Jul 2026 07:21:00 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A83A3830;
	Wed,  1 Jul 2026 07:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890460; cv=none; b=nJ3h6nusAt/DIZTCMYhydxLEBM2lxkU4MvPUWyzBuMTs7PdHwKVLEcbRuzrFzg8f/93SgIPBtJk+zJeQmpw+QFfMFwLlTUxACyBxLpqXgqMA+SRtwMIsCkcOHzLCv4LU84T/q6xMGAg3fzHxQU/Iys90GvTB84Q0viHKBvEa9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890460; c=relaxed/simple;
	bh=9hpAc1+MXlpU115bkiS7aY+dhuRScu+PhmKpwwjIRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuCH3gX1ZEFlL3GfAxnWyQC4ohA0Np5GZBn1BqYagrKHjhRDD4YKXagVmLSxQ3x1PON/FvIYXzrUWIfvPNHCYnx7cctutSAkeWEXtxzfv0ea66miUT5SEDoMpXazQGb237mYDMshPuhb6Z+sDBID80UNfq0MbHGl+E6TN2wuCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3XOdT1j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D6A1F000E9;
	Wed,  1 Jul 2026 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782890459;
	bh=iZ/3Tm7ZRm3ifBbKZc7mGH8pURO/2EJBjkwryWHH6ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3XOdT1jZpwM3GYI89WMduQIiAqLdyKwbU+y82VmubNe3ZjWwhW1ZLq8xloaPIz6G
	 Zp9s7f4DSDsSaU06Iwx5xzhA5nPemONb4X+DUyjgGMHZrQwUz3QWsL4L6peiqINT7p
	 QesnK5Ni6xkroBuwO2Rbsgs+/IsSpkt9//tqFccN7LSihN1J7E8JLhyU302BM1sNzn
	 Pbmf3/z7okSoHSU/21SZW2/OrE7KfJT0XQ/44cQ6vGFKP5WRTtWda4izAmUAks1F5m
	 DlDRQspNT3yq+yzeK1YAH4sCyDnlZGidKexnIWH8yEb0or/byFvYd8khSJ6GlRsiqs
	 SgTT573+E/Rcg==
Date: Wed, 1 Jul 2026 00:19:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Leonid Ravich <lravich@amazon.com>
Cc: linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	snitzer@kernel.org, mpatocka@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v5 0/5] crypto: skcipher - multi-data-unit dispatch as a
 template
Message-ID: <20260701071919.GA111652@sol>
References: <20260630083431.2772-1-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630083431.2772-1-lravich@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lravich@amazon.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25513-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sol:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72FE46EA93C

On Tue, Jun 30, 2026 at 08:34:26AM +0000, Leonid Ravich wrote:
> This is v5. It reworks the multi-data-unit support from the in-core
> auto-splitter of v4 into a crypto template, dun(...), addressing the v4
> review: there is now no added cost on the core skcipher path, no
> per-algorithm capability flag, and the per-data-unit split lives in an
> algorithm rather than in crypto_skcipher_encrypt/decrypt the shape
> Herbert suggested, which removes the "overhead for everyone" Eric
> objected to.

No, this didn't address my feedback.  It moved things around but still
adds additional overhead for everyone to support an out-of-tree driver,
which also hasn't been shown to be any better than just using the CPU.

- Eric

