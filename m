Return-Path: <linux-crypto+bounces-23751-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ33BsYl+mlIKQMAu9opvQ
	(envelope-from <linux-crypto+bounces-23751-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 19:15:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B04D1EA0
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF042300C7C2
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF248B389;
	Tue,  5 May 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwr0MUIZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BE392C52;
	Tue,  5 May 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001344; cv=none; b=MSMaUPs3X3q3rTloqmq5Nu+TZaxYPLrWmiNnjxOos2/0EM9BlIk05S+7BGc4DXibZvAcnHH7j3HJhINf3hhpBj6APzeniNem4bgIdhv8xpN0Qobqz2ln5IWehYFtWPtqfeV8zvLJ7Y81fMBER3Mh0ZFdiu6kLfiDBAnVIly7nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001344; c=relaxed/simple;
	bh=p+kXkUUsL0EOWDxii9ahd29pn2Z5VfXQoGjhwSebnZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKppqPEk064xEWf/mGPCm6u32c9f9OxKy1SLMZ5z8SM58Sj2+tebjCrGH6I2G1O+lauvmhVvBnwdDHebswT9VrPFhotby6MZVRftT447hzaiv3tm6sijrl+JGzF/2fV+8HiXDUP2ZM0JT/sfdCuc7nWGWyghoLuKmEHrmtXMfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwr0MUIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B93C2BCB4;
	Tue,  5 May 2026 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778001343;
	bh=p+kXkUUsL0EOWDxii9ahd29pn2Z5VfXQoGjhwSebnZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwr0MUIZdxTY9BNcjP8SAD+u+Pno35zf4VXFMTNrj/LAnQ6IZp+eHfEtnG1V33X2I
	 00Q83Ml5MKgC3i7mU60vdbaHQQRmN3YoxV53SU4TSBQXVB2C5/oNZ4mXyywIfkio8D
	 1Af2Sx5+nKb2e5sKMAWSaPySo1FDUxzZipXeaiiqL+SuJxW/tV6pvLKThBsMlYXnmG
	 9yOjHmPugvqjNBxZ+f/EdlJKOiMeqR9P6Kof7CQWQfZuudVGfbHI1qzg+hvp10VFnR
	 coQVjVtcau6mdHMYe6sgmiMRkid0wc7FdzThTLAqlIoul+ha4wZvNPhTjW842z0lYt
	 henTv9pPjUH/A==
Date: Tue, 5 May 2026 10:14:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
Message-ID: <20260505171424.GA2291@sol>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
 <20260504180044.GC2291@sol>
 <ac6b9bcf-0106-49fd-82ff-20ccc5612fa1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6b9bcf-0106-49fd-82ff-20ccc5612fa1@kernel.org>
X-Rspamd-Queue-Id: 1C9B04D1EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,lists.ozlabs.org,gmail.com,ellerman.id.au,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-23751-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,miae:email]

On Tue, May 05, 2026 at 06:34:00PM +0200, Christophe Leroy (CS GROUP) wrote:
> With userspace MD5:
> 
> root@miae:~# time ./busybox md5sum avion.au
> 6513851d6109d42477b20cd56bf57f28  avion.au
> real    0m 2.38s
> user    0m 1.99s
> sys     0m 0.38s

Again, that's an unoptimized md5sum implementation, specifically
busybox's which is designed for size rather than speed.  You'll just
need to replace it with a speed-optimized one, if that's what you need.

As I said, you can even reuse the same asm file, as it doesn't contain
any privileged instructions.  However, there might be even faster code
out there (a GitHub search might be worthwhile).  The code that's in the
kernel often isn't the fastest code that's available/possible.

> Now, we are talking about MD5 which is obsolete and being replaced in our
> systems by SHA256. So a commit message ressembling to the one in commit
> 23e5c306a207 ("lib/crypto: sparc: Drop optimized MD5 code") would be better
> as a justification for the removal.

Sure, I'll update the commit message to cover that too.

> By the way, what are your plans for SHA1 ? I think SHA1 should likely go
> away as well for the same reason.

Eventually the same thing will happen, but it will be some years in the
future.

- Eric

