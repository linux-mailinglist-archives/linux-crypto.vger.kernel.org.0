Return-Path: <linux-crypto+bounces-25874-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B28KIxBKVGoDkQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25874-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:14:40 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8097468C8
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Sdsj2/a6";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25874-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25874-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF974300A8DE
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE92DEA64;
	Mon, 13 Jul 2026 02:14:37 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194032D063E;
	Mon, 13 Jul 2026 02:14:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908877; cv=none; b=HAM6oXNGRmafM4xEwbaHl3IWc2G837JFaMcavlgPQINPGgHxMA167S7HdyU5GZ7G0xVwg+CiKbiZf4lWyDguS+Mg4uQRuA5ukkgpxoE1SyGI9khdhngRNeuhN9tKNcr5BlZZ1LRxZSclOtK5LyDWRWBn0T/XlTNmZa+60fNG1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908877; c=relaxed/simple;
	bh=UX28gsVdYmd/ZtXAV9cWHKUy3torOF5arESPbi2d7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2IfE3NXEi1mynyzuuCRctpFss6jWwzszfBd04RscNbw64EBzYVLozHXVPHC+OPdNj5xU3VePiJpCY100Didh1AHxpOoBTR46mVCro+IT+K8p8ZIJ9y2fmZH+vIv8zsL5SsjlwxoF6ArEw6XSkIjmlNxlCO3Xve1y3Y7U4ru620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdsj2/a6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4555A1F000E9;
	Mon, 13 Jul 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783908875;
	bh=DPJRDOGPpWg9LRXJHy7GdkQ8ROeAYOuU+PE/r8RiwRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sdsj2/a6LNdrlJo3bJ8/OJaSJoeiyknjrSdpRiTeHTjmf4lIUoXVBvqD2A9Aewi/f
	 ktZ339g3KFEyxSeJsdX1VYUHpx+dAF9rESRwqUIZ53D9OHsAU0PMxqLYMz9Q3oK9ty
	 F7qy8bSStnz5w57q32SegEeSzU0RSL2fLlzc80F3d759SDnbxQi/7H/WAyvCdxByqH
	 FZ/e29bu90WWhMhx6Z39ahazxIYeLZklQ1R2ucQDEK+Ow7PBOyKKtFOGiFgRMWgbEo
	 wBseUldoN5hCLT0fYyG7cSgO2PVNSQ34u+QRqiggIDcLIZBeeBGWNgtP4TBv8Q4m3X
	 y9xaaHwM04HkA==
Date: Sun, 12 Jul 2026 22:14:33 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] lib/crypto: docs: Fix some sentence fragments
Message-ID: <20260713021433.GB4362@quark>
References: <20260709022651.44216-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709022651.44216-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,m:thuth@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25874-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,quark:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B8097468C8

On Wed, Jul 08, 2026 at 10:26:51PM -0400, Eric Biggers wrote:
> Currently, the section about the library API for each algorithm begins
> with a noun phrase that was intended to serve as an elaboration on the
> title.  It's better to use complete sentences.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric

