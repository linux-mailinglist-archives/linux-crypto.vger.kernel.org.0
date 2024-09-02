Return-Path: <linux-crypto+bounces-6504-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9685968A29
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Sep 2024 16:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749E11F22728
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Sep 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB51A2646;
	Mon,  2 Sep 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oC+MStkb"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247841A2623;
	Mon,  2 Sep 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288095; cv=none; b=PDW87hauDqJEuG7FV9VDcaad05N0bcyqf6IXA39+n/93iLBqDNDWHWnUbwLvI2DQa/EsZEE9ky6slvt/LTyj5jT21x+8Jwr42uZXwlx1ofPnULapD5S0PkVQyCpNRRzgDFpkDNURTjN+9NH40qbQznsTXboaR8PwmYyWvKqVCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288095; c=relaxed/simple;
	bh=n6pixgFJm/W7VxoBNxj40RKzDl7YlyerQp4unEJnep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M75I8obcHRbJlFPa002cPuGKcs2jwHJpq+rh6/LSQ6mLK+AE/VJC0+ZOSrjHRLOaHI5mF21MOHLHlLDr9bkijQl+tLdIDsnJbo7VUysksNrPx+Gj7cQaMcrUAjjCSHFjL6hMYPevqYTXex8Gzs3W2cOJPWa/5kXyNIh+YlbmLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oC+MStkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F411C4CEC2;
	Mon,  2 Sep 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oC+MStkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725288092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yUcMtLgoLG9tzCuXt+yY+rp6XTZocqr3Yjofx3Z2Ag=;
	b=oC+MStkbWG8SIsGeZ0TJLGzYBxRZjy7xt6yjTvTgKTB8gciUKdBNYK5k5k0aaKqVC4tdRR
	hnv0w0qJDCdhpX1yUiZeuGINbWbJxSGAuUeAmFmUCJPpB9si5u3zQL2vCkwkAcPkm+8hex
	4MD3RQ74UKyWrrbJpiLM02HOD6skMt4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd46b2e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 14:41:31 +0000 (UTC)
Date: Mon, 2 Sep 2024 16:41:28 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtXOmHYuTI9DQGij@zx2c4.com>
References: <20240902125312.3934-1-adhemerval.zanella@linaro.org>
 <ZtXMT3qSFgneeZb9@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXMT3qSFgneeZb9@J2N7QTR9R3>

On Mon, Sep 02, 2024 at 03:31:43PM +0100, Mark Rutland wrote:
> ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags,
> 			   void *opaque_state, size_t opaque_len)
> {
> 	if (alternative_has_cap_likely(ARM64_HAS_FPSIMD)) {
> 		return __cvdso_getrandom(buffer, len, flags,
> 					 opaque_state, opaque_len);
> 	}
> 
> 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
> 		return -ENOSYS;
> 	
> 	return getrandom_syscall(buffer, len, flags);
> }
> 
> ... though the conditions for returning -ENOSYS look very odd to me; why
> do we care about fast-pathing that specific case rather than forwarding
> that to the kernel, and does __cvdso_getrandom() handle that correctly?

Adhemerval's code here is fine and correct. The opaque_len==~0UL thing
is a special vDSO case for getting the param struct back, not something
related to the kernel. See __cvdso_getrandom_data() for details.

