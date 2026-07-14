Return-Path: <linux-crypto+bounces-25957-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5kjSKiTtVWqywAAAu9opvQ
	(envelope-from <linux-crypto+bounces-25957-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 10:02:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59580752262
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 10:02:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PXGCn1HU;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25957-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25957-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB32A303B7F3
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB473EC2EF;
	Tue, 14 Jul 2026 08:02:28 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988251A38F9
	for <linux-crypto@vger.kernel.org>; Tue, 14 Jul 2026 08:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016148; cv=none; b=HLM6dEyhVAW5Nxk1pI5MUsF4l3m7j913BbIBTSLZjlaCmKesX51UqymQp9PHdcIDOlRMmKnOJLB8zbxfBpApSRTEPs9kGcOeP4XwNH7llqgOxE1kk/rGkgtDAXAaktCKjxCVKGt9UyzSiGEcdmFqjd3CPIcNCpBPGqXQ5l8cDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016148; c=relaxed/simple;
	bh=xn6FRjCb7BaLOzN9sSeZMxB95itrGogr8EEGOjZL6C0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGvMmzRKrMNRPorq5Wf4a/KHisSVwzFjP3gDLMs6H+MebeiY97GppFypviety+nnXiboJ/3vYVmxspKRLz3Sw4s68ELJYntQAs99oXTA0laf4Yr5Vmhif0oqhRvRy5BiIwlqyoKSnUjcpmk7TU7871zJrCSr5H6oWGFWwG8OMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXGCn1HU; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ec555a26so25791175e9.0
        for <linux-crypto@vger.kernel.org>; Tue, 14 Jul 2026 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784016145; x=1784620945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zVvBJ4SkbeNu5Hhcf3lSf/7F1/qZ3Gn5ctGfd77mXz4=;
        b=PXGCn1HUgPa3uQsE9w0QBvdOigOiqThLQBJqS1O2zeA8v1K2b9kBqA1+lBPVG4xzKL
         OsKBAgJM2vHIPmDZzlhh7q3lrPeAxExwIsN0JVqHjO7clcryc6nyGAtCoVnxlAao6wp5
         xqJpkZiMnx2N/wLfu50KD8JUaBLOkXrbNugjk7O4ygeRwYwCOGRM3M70IsC+8sf9U4hs
         GkzflnCTvZcj8qLaeOoJAOsPWSfJuDOADu4w4cSckJGiwtW1slqqj0SuZvmlcfQHy3JO
         3aPFlzv2IyxZ8KoLJGpKxBYwRiVsU/t2feZ8FKOT/UEqnrnoHU4V31cxHym7dFsKzVgI
         kVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016145; x=1784620945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVvBJ4SkbeNu5Hhcf3lSf/7F1/qZ3Gn5ctGfd77mXz4=;
        b=APM79vifQWWZJplzWaHd7G3BsW1+xvXncccqOIgUdkY33t4EX/OObeyvAT8qur3fr4
         hHonBfGXp32ANL2Eq7hWbZjbgfOP+0vyAJEOUPvkKnIADcE7e2eANepZ/riEt1Sh9SK3
         qILUhz9jSwl0QTiTiMGVOYREc+oniG9odwmb708TlADiJM6X5J5zAp/WQXSxDiGiQM8g
         dUFEUvTGindndwErCH4BH1RvMUIclQP0XbOZoZw4qMxCy1ZWHPpyaHzVxdzbalIuTb/r
         aII6uao0tQ8M074dMSsm2JleS/YE/mvMkeHjwpkDLNYB9pVHkxkmk7V3FdReXWYupyfo
         b/qg==
X-Gm-Message-State: AOJu0YxC/9qxj1Jrbe+g5GX2jMzCRgBTsubaY9mixR8qM0Y2K7/yNxVD
	m3g8ZqdShSgr2rc+Ctly1PbWBCc9kZvhjfmbO8oX7PVxe/FNVoP8rMWP
X-Gm-Gg: AfdE7cm6SoCRtNUCf6pxnHa8D6xWaFuCtI2lVwCLeEuKeAKklm7xeRZGiC7el+8e5aC
	Q3gsqMgDPUbmzvRBQKQOrqU4c5MY5rGp8TJ/f3XFTqoT9nnSprcxHnPiLdKPxnqsFI7rQbYzVKS
	Glz+IA/tvknyiGRLMjT+B88NnW6Agoxs2Ip1G/Lkko1IgzSygyBJHLcp10iE65TMZYL8BjuMk6b
	IrXCJOhlkfnzaiCvayCMQYzbxv44uQzeUoM1ma162+EzgzTTLIrhQF2frM/A1UYJxlziKxqN2qD
	CTHlOU8FIXZEDTQ/NAaIw1D06TGMhNdmxV61SN9f+HJJIWaOT8cDySeFMNMcqLi0KWTVpu/gG/f
	s25ub3+UY9WwbUOXo4uk80dqiq9pP7oLiaAm2HcxT1D713Rg1VtZpMI3RQtbOUVRMYJyaYvSazx
	jHFNZ09CfScq/BekHtWK72ewZiaUttFrHZ+AvjCNcLRYCw/M+1YQ==
X-Received: by 2002:a05:600c:6b17:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-493f8834e5emr87474225e9.35.1784016129734;
        Tue, 14 Jul 2026 01:02:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm243600725e9.0.2026.07.14.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:02:09 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:02:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] lib/crypto: aes: Add CBC and CBC-CTS support
Message-ID: <20260714090208.6438dfa4@pumpkin>
In-Reply-To: <20260707053503.209874-4-ebiggers@kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
	<20260707053503.209874-4-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25957-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[pumpkin:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[pumpkin:query timed out];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59580752262

On Mon,  6 Jul 2026 22:34:33 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Add support for AES-CBC and AES-CBC-CTS to the crypto library.
> 
> These will be used to provide streamlined implementations of the
> "cbc(aes)" and "cts(cbc(aes))" crypto_skcipher algorithms.  Most users
> of these crypto_skcipher algorithms will also be able to switch to the
> library, which as usual will be simpler and faster, e.g.:
> 
>     - block/blk-crypto-fallback.c (for AES-128-CBC-ESSIV)
>     - fs/crypto/crypto.c (for AES-128-CBC-ESSIV)
>     - fs/crypto/fname.c (for AES-256-CTS and AES-128-CBC)
>     - kernel/bpf/crypto.c
>     - net/ceph/crypto.c
>     - security/keys/encrypted-keys/encrypted.c
> 
...
> +void aes_cbc_encrypt(u8 *dst, const u8 *src, size_t len, u8 iv[AES_BLOCK_SIZE],
> +		     aes_encrypt_arg key)


Does embedding the 'u8 iv[]' in a structure work?
It gives better type-checking for the length of the array.

	David

