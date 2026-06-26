Return-Path: <linux-crypto+bounces-25436-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZJ+EMboPmqYMwkAu9opvQ
	(envelope-from <linux-crypto+bounces-25436-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 23:01:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A66D0288
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 23:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oTOfpc+B;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25436-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25436-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BDE313BB0F
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B073BF66C;
	Fri, 26 Jun 2026 20:55:47 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE529353EC0;
	Fri, 26 Jun 2026 20:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507347; cv=none; b=fyrLT+f52Jn9sTK+zN9BmN86aszl98MEOhac5T9XFYNsmDY1bdUzW0pRmaP+1GKZ8Zhp/X2IVHP/sl0quZz1F+P3AAmHjzl/fj/e3IMVeLu0fG0OvwE5WlWe5rPQ32jg0ccRC7f+mlzPlvyjd8Uu88oGQQHyu8EMcOuFeBwgwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507347; c=relaxed/simple;
	bh=w1IsNLHzBjjZh7sU/TEOIN+N7tnsV9gjcRVbaVPySt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHQvRlXapDuBRpn5XTMjuH4kXGu1g4xyuZD1gUhlXvXdPr18L/PdRJppLg8+WQhTK3daWsm0v/mHiiLvy2R+aLgljWWE5VvXgtn2yoTnWd2xXP+CWzwoCRtnxUjmVsxvf0S07x6rj+F/d29tIjJ2wP7EHqjo+B1TdbSWGQdcbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTOfpc+B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE511F00A3D;
	Fri, 26 Jun 2026 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782507346;
	bh=Bmd+bJ8E0pSDSvOLP7c5yac+5ujgjGsTnNkq8rNq6v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oTOfpc+B+HOBKinlp1xH4fRAZHwbvFNBi25NB5k+1VUe1uuziWX9PugRW3/hD1kXR
	 Cdv8/55oqAI0U05iiUxfpVEE9UFWAZPcfknrwCVLDgofQNBWLeJQro79H1IkmcHC/N
	 fKFWPB9I242KzyHJRO69jUFxlaaOm5G5DvzWILCOlJp8qJLDLWTa8sT/neVHR1fA8R
	 pnpRb8pr8N+clDwvN1lmlowmMhoeg5j0+lWWEtjkrQ33+bUmhMZTmAi9BwgR3vskCw
	 Q5Kvs0L8huc/1T0NdOIxsOjGLY0qx7jsFj151BuQO4SxYtZQ6gC0MVK6ArnYAHx/ZG
	 K8E2tJhPVHF3A==
Date: Fri, 26 Jun 2026 20:55:44 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, x86@kernel.org,
	linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626205544.GB2368695@google.com>
References: <20260626043731.319287-1-ebiggers@kernel.org>
 <20260626043731.319287-3-ebiggers@kernel.org>
 <20260626084113.42eae31c@pumpkin>
 <6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
 <20260626114957.1a2b7e5b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626114957.1a2b7e5b@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25436-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:anton.ivanov@cambridgegreys.com,m:x86@kernel.org,m:linux-um@lists.infradead.org,m:linux-raid@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:akpm@linux-foundation.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 427A66D0288

On Fri, Jun 26, 2026 at 11:49:57AM +0100, David Laight wrote:
> > UML is just another userland application from this perspective, so
> > there is no reason for it to behave any different from the rest of
> > the userland.

Which is why it should do the XCR0 check that the vast majority of
userspace programs do, right?  It has always been part of the documented
way to detect AVX and AVX-512 support.

(I think this helps explain why LLMs notice this too.  They've been
trained on lots of code that does it correctly.)

That being said, it does seem likely that it's basically obsolete now.
So maybe we could take a shortcut and omit it.

The important thing is really that we make a definitive decision *once*
for each of UML and native x86.  The status quo is that the decision is
instead punted to every individual AVX optimized function in the kernel,
which isn't working well.

- Eric

