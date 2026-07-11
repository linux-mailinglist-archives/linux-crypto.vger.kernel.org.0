Return-Path: <linux-crypto+bounces-25839-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJK9NnfSUWoyJQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25839-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 07:19:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B27405C2
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 07:19:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WQFtGND9;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25839-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25839-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF5730177BD
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 05:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4051E5B63;
	Sat, 11 Jul 2026 05:19:44 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E64086A;
	Sat, 11 Jul 2026 05:19:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747184; cv=none; b=PMH6pkuN4LcXngMfG0DcmKbEmuKSipDCW6SdrSxhtpucBalPTKiawEzhiuCnoHk4HSReKiMckSbJy8GhLV9bCvN28M8+lwNrd7jP+GFB15U+j6JQ+lL5uiUU2eG8P9KdX5IjRIBadE+SsFoxzACjzvPZ+zLQ4jp0sjolY+QXsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747184; c=relaxed/simple;
	bh=0XrLGF3FHzU/3ejPXreGdC4uYYvqTwQUg4iuPRoFHso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYDNLphpl/5WJkFDNVc5+GTM8D5UEtxuEMB+IrKB+9a86eY/V2Foot4D3uiGl3H4XkTa75ElSs2bOgadmUBdHUkBKED2vGxWShv40RAEvzHh/XMjNbammrFwREjIuH4y5YQpmCED+YopTf5JPvP6SijCm1fMqxXExGh2lbVHqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQFtGND9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45191F000E9;
	Sat, 11 Jul 2026 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783747182;
	bh=NtxE7OZVoEMtGXRRs1izMiTjUU6MZYt14TxzSMZM528=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQFtGND9JwQemXzlqRRq4tRjYOd30vuGRGC72KSSDtE2XQJEusojHzKTm2lagFEjU
	 tXbkNd3VumfRSjgVX5nNAk9h0NY4UPNpkNOX2eLh2jKS6Hu5zkbTDZVCYcRmHSGWYe
	 0iEmH8PLmTifU0BRJ6+8YKcxX1RR3l411u9L7KFo=
Date: Sat, 11 Jul 2026 07:19:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "David C.C.M. Gall" <david.ccm.gall@googlemail.com>,
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rsassa-pkcs1: use constant-time comparison for
 digest and signature verification
Message-ID: <2026071156-masculine-unsold-3567@gregkh>
References: <alEr_e-G0L2nxxv-@fudgebox>
 <20260710213718.GD1911@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710213718.GD1911@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25839-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:david.ccm.gall@googlemail.com,m:lukas@wunner.de,m:ignat@linux.win,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidccmgall@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[googlemail.com,wunner.de,linux.win,gondor.apana.org.au,davemloft.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C8B27405C2

On Fri, Jul 10, 2026 at 05:37:18PM -0400, Eric Biggers wrote:
> On Fri, Jul 10, 2026 at 07:29:33PM +0200, David C.C.M. Gall wrote:
> > Replace memcmp() with crypto_memneq() for cryptographic digest and
> > signature comparisons to prevent timing side-channel attacks.
> > 
> > crypto/rsassa-pkcs1.c: RSA signature digest verification used memcmp
> > which can leak valid prefix length via timing analysis, user data
> > could reach the leaky comparison via the digest argument to verify.
> > 
> > Assisted-by: gregkh_clanker_t1000
> > Signed-off-by: David C.C.M. Gall <david.ccm.gall@googlemail.com>
> 
> While we should use crypto_memneq() on MACs, auth tags, and other secret
> data, I don't think we should let it creep into domains where it is
> clearly not needed, like public key signature verification.

But isn't this user-controlled data and so a user could use it to figure
out the key?

thanks,

greg k-h

