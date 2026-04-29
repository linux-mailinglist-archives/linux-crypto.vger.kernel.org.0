Return-Path: <linux-crypto+bounces-23518-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDgpBzbp8WmalQEAu9opvQ
	(envelope-from <linux-crypto+bounces-23518-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Apr 2026 13:19:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D9493691
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Apr 2026 13:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8232B3006027
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Apr 2026 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF63F076C;
	Wed, 29 Apr 2026 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnTM7In2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7E3EBF35;
	Wed, 29 Apr 2026 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461546; cv=none; b=SJQTp+G03k7j61GZeit6ZZdIO8NJH9BrisH8yTW929vvsch1uoQZnVqI0HYb5t+zBuYENkUNkAiTET+X3LSG2jFUpodOBQw3QPokCrTwdo/dRdgxxaIpwYArrFAuiJ+Z38YSN5d1KJIdLqf7PnnfKaX+Rdks1Hc1zBC2q3jrJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461546; c=relaxed/simple;
	bh=1v5mK1UjqVjyC5QYbgyYeV6o8ONrWI6PT0weCyXl12Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdF1mADSK+8fNfSdtOy9+XwuvcjEOfrGLBWc5W15D4PR8urH64D+jJYEVJATvUpBlOSD7cA/pa0ZxG1WpelD9xPHRwjqmQHIHQmoc121uxECMetozZt1Bo5w/zogaKr8fNvj9Dth32d/fXPUQlc8Diq3N9D1psH46h1aKJKgcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnTM7In2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E6C19425;
	Wed, 29 Apr 2026 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777461545;
	bh=1v5mK1UjqVjyC5QYbgyYeV6o8ONrWI6PT0weCyXl12Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnTM7In2SJenzZQOhToLK0g8dO/gAAVBuPh7A4U+/HpGJOUN8/tyb6odZcqvwbvRT
	 En3qvEg5K0W3GqoL73dOj6jWtAwMJ5lZGPEFplB9L0UZe65+6PoI5P/bb/6yo+Km3c
	 ao3QQsrZJWPToQBjGgEOmqwCsWvmF7giFJj4kKrwbd/3GuwIOlDgv/umGMy/GkBHe2
	 7c9ZO91yQiufTRZiT0FYv1NRY3vYAcWxRaj/zYQY7r2fRxigclRGcHeq0HmS4nCr/f
	 fGbVgztJFhDp+9S9M5riodntFnMrUtnvSda6OhZGbqS4Hj6JJQ7pJb6DMcFEp5/Koo
	 Cr3cw8D4SVZ+Q==
Date: Wed, 29 Apr 2026 20:19:03 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/slab: Add kvfree_atomic() helper
Message-ID: <rnunkscwmelmfz3sj3ttbcrrgmq3j77xyc3lzoatflyqpsvmul@3jzdw55vmjdo>
References: <20260428161419.94695-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428161419.94695-1-urezki@gmail.com>
X-Rspamd-Queue-Id: 4A4D9493691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23518-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 06:14:18PM +0200, Uladzislau Rezki (Sony) wrote:
> kvmalloc() now supports non-sleeping GFP flags, including
> the vmalloc fallback path. This means it may return vmalloc
> memory even for GFP_ATOMIC and GFP_NOWAIT allocations.
> 
> Freeing such memory with kvfree() may then end up calling
> vfree(), which is not safe for non-sleeping contexts.
> 
> Introduce kvfree_atomic() helper for such cases. It mirrors
> kvfree(), but uses vfree_atomic() for vmalloced memory.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Oh, allowing k[v]free() to be called in interrupt context but not in
non-sleepable context is confusing... but that's not new.

Looks good to me,
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks for fixing it, Ulad!

-- 
Cheers,
Harry / Hyeonggon

