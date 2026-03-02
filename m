Return-Path: <linux-crypto+bounces-21375-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEQhKWBjpWmx+wUAu9opvQ
	(envelope-from <linux-crypto+bounces-21375-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 11:16:00 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C81D63D1
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BFE30804D1
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EF39527E;
	Mon,  2 Mar 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qQbtPmiN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ngnkUKgr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xDx8kzhS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fMfW15bh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB7395D8C
	for <linux-crypto@vger.kernel.org>; Mon,  2 Mar 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446174; cv=none; b=B+VjtFCbvpvVYqsqJ20XWSwcxIB5G4b0cCm3aJyRD/Kfv7scblVRR0YklzvA59RtwLLF9iYYdmJoHV5WyM5vYzdpe23ncoJHKcAImH727SzXXFie0TUnDe4vMqM51nrOIjtu3/3jC2w4D7fYu7qFPpQiGaLFUg4ZKDfYEWyYWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446174; c=relaxed/simple;
	bh=gjqGuNVtLDgQeOB7B7hGLgiSHhsi0/B/GE8Pcs54p1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGrs1crJ94F+CPfqDD4rVl6bwyYgS2VLleTWzgzeZSsw0tM6sxvysmSCtjYhFBM/e0t/yzETrjUT3grKgWu0acTBBnpRUBUgMc3pnUQsWc4Kn3BSHpfrxlOHseWwZ9Q6514ZoOVR1JbExU84QViCXzdNP1xKhMEJQrTl2/0wuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qQbtPmiN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ngnkUKgr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xDx8kzhS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fMfW15bh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E25033F5DC;
	Mon,  2 Mar 2026 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqj32NaK6rUcxrqbz8ohjEaE9Zu5fLT9oaxL1N7owz4=;
	b=qQbtPmiNJQBczyTZj8cRmC+V1JVIzlBpA+TeFZTz8q6Uvflb4kv7zULs8lFUz40jNxgTfe
	IObeVNKf5ae9Qg2YOSsW/BAZTUtRXDJuTC/wnlAAy2ITNoJd1J0PJb/B4sfV7K/Wk83+g6
	EJZLzA/WBeqDalamkUrWDkV2CYSxfmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqj32NaK6rUcxrqbz8ohjEaE9Zu5fLT9oaxL1N7owz4=;
	b=ngnkUKgrPuRkQrknaKBy7JutSAkAhGxTD/HmpJOwd0cybPIy56lkqFOpNcpG+kO4B1gCIE
	SgRMqRk4FaED5vCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xDx8kzhS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fMfW15bh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqj32NaK6rUcxrqbz8ohjEaE9Zu5fLT9oaxL1N7owz4=;
	b=xDx8kzhShiNGdUr7TqIKAZ3Iv+90kOckUWm8HFl2ZmT+cp8KYK0TsKQZfQJvR59W7CZtrv
	ALCDRxM7ZPhyevAjJp0aYtYBxqRQ9lDjB6Wjijz4+nWd/LAnIONkko7190oA9DeQA4KBi7
	KjwLRTkjCm7RooJ6O+FOev63Bp8h9A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqj32NaK6rUcxrqbz8ohjEaE9Zu5fLT9oaxL1N7owz4=;
	b=fMfW15bhygS5t/diU1dBVMIGKUMUOUFWn2TySMq+ECkYrPFt1KiIj3tEOiiZxQsXkPEi0d
	y/FhI/XZzeg7ReBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B423F3EA69;
	Mon,  2 Mar 2026 10:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o704K9thpWn6HQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 10:09:31 +0000
Message-ID: <a2a8f410-0e9e-40db-9969-280bc4e99666@suse.de>
Date: Mon, 2 Mar 2026 11:09:31 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] nvme-auth: common: use crypto library in
 nvme_auth_transform_key()
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-9-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-9-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21375-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 456C81D63D1
X-Rspamd-Action: no action

On 3/2/26 08:59, Eric Biggers wrote:
> For the HMAC computation in nvme_auth_transform_key(), use the crypto
> library instead of crypto_shash.  This is simpler, faster, and more
> reliable.  Notably, this eliminates the transformation object allocation
> for every call, which was very slow.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/common/auth.c | 53 +++++++-------------------------------
>   1 file changed, 10 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

