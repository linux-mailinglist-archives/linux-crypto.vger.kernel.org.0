Return-Path: <linux-crypto+bounces-22098-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLqyKXfVummfcAIAu9opvQ
	(envelope-from <linux-crypto+bounces-22098-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 17:40:23 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242572BF70A
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B7633084117
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE73FE350;
	Wed, 18 Mar 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bni1YBeq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98A2B9B7;
	Wed, 18 Mar 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850620; cv=none; b=HAg4bTOcXD+qLswI4kDLj+8R/GorTcbf24NLbCunHgUDaIN1YxvpV9WRYENqp+gjX663PtYgqKmSOtkByoow+wtVKC1PuMBA6pcawwFsQtdAfbnYzmReBPT4ux9mh9ZpYxk5EgIiMwwiGKaZENgmjZlPlAzQpXx9ccDwPqvJlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850620; c=relaxed/simple;
	bh=nikIQ5WWnDkcra9ZrAZlo2ANEg12v0c7OcUhEbKbnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgByypk0B8CiuOY7HZ0AM+FsGB4XbP7yG/nCS696py4klpBBHnwqfZFIVWCvVm2HEuqkyanoYGYKhug+3gRugqtznC4F2mCQ2MAluy+Hg0IuTn7Y271PMCbaVxm2kbSHSWHDg/i7yXRTKWI89RcgLvPdVZj2YWBtyFz+PESZaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bni1YBeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C60EC19421;
	Wed, 18 Mar 2026 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850620;
	bh=nikIQ5WWnDkcra9ZrAZlo2ANEg12v0c7OcUhEbKbnwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bni1YBeq1vKGJn8qKlbC2ZRHfOoGozjeHyAb8KJHT8zrj6WfMGd4XOC63MnvVJjoV
	 lLYca6AOPbPNifuc4WB1U8+a03zgkTrzhkJLb/CeOrcyg+Q2vX1SVUXHB7ShOh0+jX
	 RSrFRmgOpIuoQNVaxgC4nII2XCg8hF0u95tNGYHEhx2fC12rmz9V4Ek3PgqRLlZe+E
	 XC69PXrJT71NkTa48c0KaJD47QhYNdTWZOCIwLA024VFv5vqGvlxTJa7JrzQbloxLr
	 QXpehjD1L6BSy2NiBxjPOgBg7+Q7mmHFQEPoP+68W8bFFotXjC22pMm9F0q2r8f9MO
	 efYRLEpNN8Cwg==
Date: Wed, 18 Mar 2026 09:15:58 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Marvin =?iso-8859-1?Q?H=E4user?= <haeuser@rptu.de>,
	Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Roxana Bradescu <roxabee@chromium.org>,
	Adam Langley <agl@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Message-ID: <20260318161558.GA2255@sol>
References: <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
 <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com>
 <Y9MAvhQYlOe4l2BM@gmail.com>
 <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
 <16e3217b-1561-51ea-7514-014e27240402@intel.com>
 <Y9oMmYWzy7mlk3D9@sol.localdomain>
 <c5809098-9066-d90d-1bcc-108a11525cac@intel.com>
 <851920c5-31c9-ddd9-3e2d-57d379aa0671@intel.com>
 <33E64985-BE38-49D6-AB1C-CD7CFC1D08F1@rptu.de>
 <7dfb5fe7-295f-4a29-a633-c2907a1fdb60@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dfb5fe7-295f-4a29-a633-c2907a1fdb60@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22098-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 242572BF70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 08:44:05AM -0700, Dave Hansen wrote:
> On 3/18/26 08:33, Marvin Häuser wrote:
> > As I haven’t found any news on the list or the tree, I'd like to
> > inquire whether there’s been any updates on the situation.
> 
> I'd summarize it like this: lots of meetings, no updates.
> 
> IMNHO (and not speaking for my employer) DOITM itself is dead. There's
> almost no chance of Linux ever doing anything with the existing, public
> DOITM architecture.

Doesn't DOITM still need to be enabled by default for now, given that
data-dependent timing is a backwards compatibility break and code hasn't
been updated to account for it yet?

- Eric

