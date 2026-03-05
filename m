Return-Path: <linux-crypto+bounces-21624-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPWnCMnXqWl5GAEAu9opvQ
	(envelope-from <linux-crypto+bounces-21624-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 20:21:45 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91D217684
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B9130FE613
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF13043C8;
	Thu,  5 Mar 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BejCJ/N3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F027EFEE;
	Thu,  5 Mar 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738330; cv=none; b=iAQvH19HwAPfVhKDfJ4whd9xCXlRW7ymFNO+N8R8gCqKxlrVXQLOiBRg8Mub15ES3bnQXPvvblF0pE7ifO1U7PD5AmlqdF4Fw1Wlz3xYvjWRxHphJlfJQ683QaNNHxwwPMzMG3fGvXLos6isalLTT/huj34lg6TA3UYo6Q7p0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738330; c=relaxed/simple;
	bh=7bW3zVCUcKx/uUThhITnhEOsb5qrvu2vw31CflHamwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFVf+XkVwaJqujyqXHd+eMqvtBgqpthD6564HPcwF/08iTSUkBeJK1sbCpxG0Zp421guQh1HPkq38EagBDifrol+uv6jMHBsOAoijyKpg2j53oOwf+dQVdc8DeJVTLkj5ME+WAQpEaoRPtialwZdcxJTLylE+dtqBqJ805w6fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BejCJ/N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9916C116C6;
	Thu,  5 Mar 2026 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772738330;
	bh=7bW3zVCUcKx/uUThhITnhEOsb5qrvu2vw31CflHamwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BejCJ/N3uIRMlbA7yZOF5u0HjAQ4esHMQvxLQAKwCcxZJv9kTA2sLsoHx6YYrS7C3
	 erny1fOLlvik+FLXoeH4gPG3hQCshv79AGqpgHiHwZsX2Z/WlG3kMXWxsMPMsE88jH
	 rZ6yiA6aMCesIjR5ko6fbivzS6vPwJPzGjY2wWghcHhNI2W48CUri3+Vw+i2bxXPKV
	 qm4tXqSt59bJxBbpfaO/Xd3XlFX8PWbjgzdbrr4391oxVaQRcNbVucFCiNdXgQVDkn
	 ZjxbISwZHVeH8hoqWEFZ9xc1Dm4Rg0979e7ZKfyuGbcA1iVwC2stZHVcI8DcJjvsp1
	 W/QMtXpOAq5ZQ==
Date: Thu, 5 Mar 2026 11:18:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: AlanSong-oc <AlanSong-oc@zhaoxin.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
	ardb@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, CobeChen@zhaoxin.com,
	TonyWWang-oc@zhaoxin.com, YunShen@zhaoxin.com,
	GeorgeXue@zhaoxin.com, LeoLiu-oc@zhaoxin.com, HansHu@zhaoxin.com
Subject: Re: [PATCH v3 2/3] lib/crypto: x86/sha1: PHE Extensions optimized
 SHA1 transform function
Message-ID: <20260305191848.GE2796@quark>
References: <20260116071513.12134-1-AlanSong-oc@zhaoxin.com>
 <20260116071513.12134-3-AlanSong-oc@zhaoxin.com>
 <20260118003120.GF74518@quark>
 <220d9651-3edc-4dc1-9086-e3482d2d5da3@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220d9651-3edc-4dc1-9086-e3482d2d5da3@zhaoxin.com>
X-Rspamd-Queue-Id: 9E91D217684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21624-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:37:01AM +0800, AlanSong-oc wrote:
> > Also, the spec describes all four registers as both input and output
> > registers.  Yet your inline asm marks %rax and %rcx as inputs only.
> 
> Thank you for pointing this question out.
> 
> On the one hand, when the '+' constraint modifier is applied to an
> operand, it is treated as both an input and an output operand.
> Therefore, %rsi and %rdi are considered input operands as well.
> 
> On the other hand, after the instruction executes, the values in %rax,
> %rsi, and %rcx are modified. These registers should therefore use the
> '+' constraint modifier to inform the compiler that their values are
> updated by the assembly code. We cannot rely on clobbers to indicate
> that the values of input operands are modified following the suggestion
> by gcc manual. However, since %rax is initialized with a constant value,
> it does not need the '+' constraint modifier. It should can simply be
> specified as an input operand.
> 
> In addition, although %rdi itself is not modified by the instruction but
> the memory it references may be updated, a "memory" clobber should be
> added to notify the compiler about possible memory side effects.
> 
> The corrected inline assembly should be written as follows:
> 
>     asm volatile(".byte 0xf3,0x0f,0xa6,0xc8" /* REP XSHA1 */
>                 : "+S"(data), "+c"(nblocks)
>                 : "a"((long)-1), "D"(dst)
>                 : "memory");

If the instruction both reads and writes %rax, then the constraint needs
to be "+a", even if the C code doesn't use the updated value.  Otherwise
the compiler can assume that the value stored in %rax is unchanged and
optimize the code accordingly, for example by not reinitializing %rax if
the constant -1 is needed again later on.

Yes, this means you'll need to move the constant -1 to a local variable.

> > As before, all these comments apply to the SHA-256 patch too.
> 
> Surely, I will also apply all of the suggestions mentioned above to the
> SHA-256 patch.

I also have to ask: are you sure you need SHA-1 to be optimized at all?
SHA-1 has been deprecated for a long time.  Most users have moved to
SHA-256 and other stronger algorithms, and those that haven't need to
move very soon.  There's little value in adding new optimized code for
SHA-1.

How about simplifying your patch to just SHA-256?  Then we can focus on
the one that's actually important and not on the deprecated SHA-1.

- Eric

