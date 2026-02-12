Return-Path: <linux-crypto+bounces-20881-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDsNJO6tjWmz5wAAu9opvQ
	(envelope-from <linux-crypto+bounces-20881-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Feb 2026 11:39:42 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A5112C98D
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Feb 2026 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5852630BF39C
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Feb 2026 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40912E2F0E;
	Thu, 12 Feb 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nsLKylHB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ctraEmnn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8llgl8Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UKHSTwsz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6932BE630
	for <linux-crypto@vger.kernel.org>; Thu, 12 Feb 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892443; cv=none; b=srlhm8fTBcu0QYEzuScJ+bqC22dMCjpdRma5bFfBK7Yn/Xr/XXsAPy2FeMIJSKjO2S7HsQGC9te39WPX5A6uPy7d3sqmxBRp7qjE1+Z9BNguXf9Nl2+wrnwFEwHpHyPsDesGg5ux5ltgNzN2pJ1DhCuehwaQT7A3ylFrFJejQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892443; c=relaxed/simple;
	bh=kLZwO6LnZFSRcZNUwXxBDrrg2rSZk13WMmdXPZp5bHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6o3UwinuYoTESab1LrHqtyYDThRKzVxjEzj9rO/ZgwmvZQuOhIG3nGpz/I7EBYcWEVGIuv+dv3V5sUjhdh+jdWIOfTwn3QerS3B6hgadbP8yvd9WW4guAXqqV9kApAL+WeAp6JD2so+Njj89waRgBIsUyGb8ieRs3hidU3hViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nsLKylHB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ctraEmnn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8llgl8Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UKHSTwsz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
	by smtp-out2.suse.de (Postfix) with ESMTP id C33FC5BDAD;
	Thu, 12 Feb 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770892441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeqIufAnYFkDobcmSJZWZ2CF3hg0EmflNlkkrGIm70U=;
	b=nsLKylHB2RCOPy8131sxnnODIOADcYH6mFmK5mdtcESmMXnNjDYV9fJUN6QJ0+8dNVULwL
	OeiKltQzlUQahubViNh8d4ygNwYOc4um3TApa4/R0ZRycLJdWM6Hx3iUZvCmRECW6xtIF4
	PKFbO6etyfBYAw8rR7+S2mMhtY2rjqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770892441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeqIufAnYFkDobcmSJZWZ2CF3hg0EmflNlkkrGIm70U=;
	b=ctraEmnnzOPGB2pjH+6bObn5UnOpNRFk6wffYbCuXaSwDTXjXcrDSLpgAAUyDMX/a11Wjr
	4spUj71SJeEfgqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d8llgl8Y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UKHSTwsz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770892440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeqIufAnYFkDobcmSJZWZ2CF3hg0EmflNlkkrGIm70U=;
	b=d8llgl8YGpXU3bLR71G4BOLv8H8nzNx0xCNaqYEQBknIKOLnjDf4H5XulvGAl35mQYAyQU
	ZyoB4rYuJ/JgMYuDvVxsafSNZEgwbCmJdaOupDN8LRrLSzgJfLNLTAUBMZ+Ba9hOJFx5+t
	9LuoN6rmuJB16LahLniFFfNRmdCF19I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770892440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeqIufAnYFkDobcmSJZWZ2CF3hg0EmflNlkkrGIm70U=;
	b=UKHSTwsz4ggPCOXEVZLqlnng5t29saErflvm5qpBVM1LvWZpGvIj4K8uAuyKCXJzH53e20
	QzPVzB+HlRXI3DCQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id A8E114A0A2B; Thu, 12 Feb 2026 11:34:00 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org,  linux-kernel@vger.kernel.org,  Ard
 Biesheuvel <ardb@kernel.org>,  "Jason A . Donenfeld" <Jason@zx2c4.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,  Vivian Wang
 <wangruikang@iscas.ac.cn>,  Jerry Shih <jerry.shih@sifive.com>,  "David S
 . Miller" <davem@davemloft.net>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Paul Walmsley <pjw@kernel.org>,  Alexandre Ghiti <alex@ghiti.fr>,
  "Martin K . Petersen" <martin.petersen@oracle.com>,  Han Gao
 <gaohan@iscas.ac.cn>,  linux-riscv@lists.infradead.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: riscv: Depend on
 RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
In-Reply-To: <20251206213750.81474-1-ebiggers@kernel.org> (Eric Biggers's
	message of "Sat, 6 Dec 2025 13:37:50 -0800")
References: <20251206213750.81474-1-ebiggers@kernel.org>
Date: Thu, 12 Feb 2026 11:34:00 +0100
Message-ID: <mvm1piq9ron.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: YES
X-Spamd-Bar: +++++++++++++++
X-Spam-Level: ***************
X-Spam-Score: 15.29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-20881-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schwab@suse.de,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: E7A5112C98D
X-Rspamd-Action: no action

On Dez 06 2025, Eric Biggers wrote:

> Replace the RISCV_ISA_V dependency of the RISC-V crypto code with
> RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS, which implies RISCV_ISA_V as
> well as vector unaligned accesses being efficient.

That should be a runtime dependency.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

