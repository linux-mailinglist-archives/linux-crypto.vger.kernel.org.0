Return-Path: <linux-crypto+bounces-21912-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOEsH2GEs2msXQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21912-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 04:28:33 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB28327D177
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 04:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9308F309DC77
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5B33FE0F;
	Fri, 13 Mar 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWs0q61N"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD92F3C13;
	Fri, 13 Mar 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372508; cv=none; b=pe+LDTDBLVT+faeMxdbGYstT7HW/sgrkPQmfhipB5LPPmPP8ISJnTDf7+t0pUQWGIshDdpWArI61q3MjEPmcSbyUW4oEjRsJltu+4ZsqVSUPheaqjFf7+ORt7nlgQFWrtOwgIncgYbCMbrBApkJMGKiOmDQHPYeo0KTPqE1bob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372508; c=relaxed/simple;
	bh=GtW3z8sG1Yly3I8AHx8qfx+GLm+Dr1nsxqK02WRUEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEDivx77V7p9rd00+/RVLM6NtPso1YgvtNKQh2KY6TphGIhMC1liceB3it0PZzqAit0gyBdmj/4JrAV9jgTLOXPjktfpwD/hw1h+7kgw8M0wYxXknd5zoolQDrwORk6J4wl8WnNgaFkN40EOMewXYE68pYu2Q3aCZaLdZ+4BJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWs0q61N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF0CC19424;
	Fri, 13 Mar 2026 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773372508;
	bh=GtW3z8sG1Yly3I8AHx8qfx+GLm+Dr1nsxqK02WRUEdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWs0q61NsI0iiFZ2BXXT1Xw4C7DNYZ/MXVH2BlUxdnSVMC7H+mCtM0UcW0kvw4DSJ
	 LddY3KqS4i7L8krFSRKy2iqXK9T6UaI54WNoF1bTN0VvG60hP6+4A1vFWHKaVudu0u
	 +rZ1nNmwFVCPB5qPUZjtatES1VWZpyk4HgIEBKp+aP24631j8d9s6+sgyPn3Zl9t8c
	 vQdGnwO8aTRJaMAwDVATlh1/gXC2cyjEX5BMGk6mIfzB1UuuO6QaNjqV/+F2081wEQ
	 5KSNkMepjddKvftpsHskqq2C4RQRl5ZXnO342DXFI+uuBY9EzCrRsaF/YkDJgI4YlU
	 7qEUHvi+YAD2g==
Date: Fri, 13 Mar 2026 03:28:26 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: AlanSong-oc <AlanSong-oc@zhaoxin.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
	ardb@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, CobeChen@zhaoxin.com,
	TonyWWang-oc@zhaoxin.com, YunShen@zhaoxin.com,
	GeorgeXue@zhaoxin.com, LeoLiu@zhaoxin.com, HansHu@zhaoxin.com
Subject: Re: [PATCH v3 2/3] lib/crypto: x86/sha1: PHE Extensions optimized
 SHA1 transform function
Message-ID: <20260313032826.GB1458907@google.com>
References: <20260116071513.12134-1-AlanSong-oc@zhaoxin.com>
 <20260116071513.12134-3-AlanSong-oc@zhaoxin.com>
 <20260118003120.GF74518@quark>
 <220d9651-3edc-4dc1-9086-e3482d2d5da3@zhaoxin.com>
 <20260305191848.GE2796@quark>
 <5fe5b47d-5065-4e74-b2b3-4685e74a1130@zhaoxin.com>
 <20260312040349.GA2359@sol>
 <4b65047a-2a2f-4fd7-a349-525cf12d85c4@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b65047a-2a2f-4fd7-a349-525cf12d85c4@zhaoxin.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21912-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB28327D177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:58:07AM +0800, AlanSong-oc wrote:
> On 3/12/26 12:03, Eric Biggers wrote:
> > On Wed, Mar 11, 2026 at 07:37:39PM +0800, AlanSong-oc wrote:
> >>> I also have to ask: are you sure you need SHA-1 to be optimized at all?
> >>> SHA-1 has been deprecated for a long time.  Most users have moved to
> >>> SHA-256 and other stronger algorithms, and those that haven't need to
> >>> move very soon.  There's little value in adding new optimized code for
> >>> SHA-1.
> >>>
> >>> How about simplifying your patch to just SHA-256?  Then we can focus on
> >>> the one that's actually important and not on the deprecated SHA-1.
> >>
> >> It is true that SHA-1 is rarely used by most users today. However, it
> >> may still be needed in certain scenarios. For those cases, we would like
> >> to add support for the XHSA1 instruction to accelerate SHA-1.
> >>
> >> Does the crypto community have any plans to remove SHA-1 support in
> >> recent kernel versions?
> > 
> > It's already possible to build a kernel without SHA-1 support.  SHA-1
> > has been cryptographically broken and is considered obsolete.
> > Performance-critical hashing in the kernel already tends to use SHA-256.
> > 
> > These patches already feel marginal, as they are being pushed without
> > QEMU support, so the community will be unable to test them.  The only
> > reason I would consider accepting them without QEMU support is because
> > there was already code in drivers/crypto/ that used these instructions.
> 
> Sorry for the inconvenience caused by the inability to test provided
> patches, as QEMU currently does not support emulation of the XSHA1 and
> XSHA256 instructions.
> 
> Besides, since the previous patch adding XSHA384 and XSHA512 instruction
> support was not accepted, I would like to ask whether adding emulation
> support for XSHA384 and XSHA512 instructions in QEMU would help the
> crypto community evaluate and accept the corresponding kernel patches.
> 
> > It also helps that they are just single instructions.  Though, even with
> > that I still found a bug in the proposed code as well as errors in the
> > CPU documentation, as mentioned.  And the drivers/crypto/ implementation
> > that uses these instructions is broken too, as you're aware of.
> > 
> > Overall, it's clear that platform-specific routines like this are very
> > risky to maintain without adequate testing.  Yet, correctness is the
> > first priority in cryptographic code.
> > 
> > So I would suggest that to reduce the risk, we focus on just one
> > algorithm, SHA-256.  Note that this makes your job easier, as well.
> 
> Thanks for your suggestions. I will only add XSHA256 instruction support
> for the SHA-256 algorithm in the next version of the patch.

Thanks.  Yes, adding QEMU support for these instructions would be very
helpful. 

- Eric

