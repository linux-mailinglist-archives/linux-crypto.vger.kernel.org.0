Return-Path: <linux-crypto+bounces-20394-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IFDKZvjdmlVYQEAu9opvQ
	(envelope-from <linux-crypto+bounces-20394-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 04:46:35 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935183BC4
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 04:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2495630013A6
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 03:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074AB2ECE93;
	Mon, 26 Jan 2026 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBJVNymh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322C303C88;
	Mon, 26 Jan 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769399185; cv=none; b=ZQ8ELLTYFAu4PncXqSTUc80tb9WONqwxQowcrsGjiazPlHJc0qpTWGbtrF6YwSZJZiJpM9hMqeumxVk9WDOZzdWkZaKEAkL/68hVDxYWGdUJEJ8EhxDi8dYmy6zvN5RWC7Rc8k+xExTKvTEjw6yuxOwh4BVMYkWWxjH2oB7Qxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769399185; c=relaxed/simple;
	bh=N2rQKBqOhYsVB0pXf0u8V2Nvyp180Bd1ElEkTwRu+6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tank2ecFnmlsM5Az1t+qUnz4xXmShyv3QaYLpt38DklRENcQiaAbEVn1utvOMdvNRngZ5GQ9uuS+XJAJNMRSuyXOth8ng3jJvPZtDjj3d//4C+N5T1AI/2vMvwOe8jZG5LFQI3LNKCL9g7ULfkj79YP6rPQai/h7FSrzmM19WEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBJVNymh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA45C116C6;
	Mon, 26 Jan 2026 03:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769399184;
	bh=N2rQKBqOhYsVB0pXf0u8V2Nvyp180Bd1ElEkTwRu+6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TBJVNymhuEx26LRXpEFnM2aTROQYpNawk6YHqgTBAwsSU2L2GgbLDiTS6kWFrCJhk
	 BhWTNx1XL1VWLV0CwJN2PpMfGYwcadu4kdmnguixYWSq2EDrMuAOAIzw3fP19R+tD3
	 bkQ0Sx/IaHqEPxQSsbcPknJEJCs+Yt6RfKPx7fc4EAwdKiW66iCwa5yp8F+sueHJos
	 +wvEmg7MvOEWEfiKEArtj2WKCOTNU+XyxcXZ1+rebYPA9nyaznqOADVsRjtmtxFiZz
	 ha44XNQ3hhyvjt1m9KxrtfhzMrRKjZmB96hv1g9qlj5UjS66TCiRLxZI4CUrlzmC/7
	 dvO15lkxRNe2g==
Message-ID: <adefb26b-934f-4e13-8d41-d61168744d21@kernel.org>
Date: Sun, 25 Jan 2026 20:46:23 -0700
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ipv6: Switch to higher-level SHA-1 functions
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260123051656.396371-1-ebiggers@kernel.org>
 <20260123051656.396371-2-ebiggers@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260123051656.396371-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20394-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9935183BC4
X-Rspamd-Action: no action

On 1/22/26 10:16 PM, Eric Biggers wrote:
> There's now a proper SHA-1 API that follows the usual conventions for
> hash function APIs: sha1_init(), sha1_update(), sha1_final(), sha1().
> The only remaining user of the older low-level SHA-1 API,
> sha1_init_raw() and sha1_transform(), is ipv6_generate_stable_address().
> I'd like to remove this older API, which is too low-level.
> 
> Unfortunately, ipv6_generate_stable_address() does in fact skip the
> SHA-1 finalization for some reason.  So the values it computes are not
> standard SHA-1 values, and it sort of does want the low-level API.
> 
> Still, it's still possible to use the higher-level functions sha1_init()
> and sha1_update() to get the same result, provided that the resulting
> state is used directly, skipping sha1_final().
> 
> So, let's do that instead.  This will allow removing the low-level API.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  net/ipv6/addrconf.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>



