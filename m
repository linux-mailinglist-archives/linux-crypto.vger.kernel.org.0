Return-Path: <linux-crypto+bounces-21495-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOS9HSaSpmnxRAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21495-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 08:47:50 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A81EA579
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 08:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3828630B38B2
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8908376BE8;
	Tue,  3 Mar 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gRJxVw+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bqJQg/lC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gRJxVw+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bqJQg/lC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF019ADB0
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523915; cv=none; b=rc5EetEzfUeKtL1HCb5konEFSocRDBUTXSB91mfbfHMaK4AjGFRbEHQLxpmPqApx34+OnCR8q5mO0Bh3C1KK5BAFZTBaJz4aqbDsKjO187qbtfeO42bkLAfJALAHiZwNjkyKh902TGo14duFveaPu3HSM2t/SFUomtuwsQX6J2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523915; c=relaxed/simple;
	bh=nosZM3MbcbQMXzerZRKVYAg68uKxVy7EjpQzE9I2UhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3fMvryX4+CG5H8YyfwaLp4Oq1yOqaXqyVInPNwwW6E780SNuwNL880mLlFMWxBNjd1P8yk7S1njgqDs8732WkioPu6QlLRS7WbaI9iMYMxnZDFb2lWNXXjE8hJDrFZO9xoPN7KTL2y4aVAuak6VB/wwSkcfvFpI9wl7e+0eHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gRJxVw+W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bqJQg/lC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gRJxVw+W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bqJQg/lC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59F913F8F1;
	Tue,  3 Mar 2026 07:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5rDzNmNKlUslYBWpE8CLa+dDB+iqX95e/LvixPJLls=;
	b=gRJxVw+Wb9bmxe617WMVy3yndbeZCj4xjHKUcrRUzk0YfMm41TJ6GCSUk0uni0yhIwfwBu
	iUUFOUS6YH0tcUB35r1rWByzZNKmD1ySwuAUJ6yEbwyF8BPvtUxvnCqxs11yExOTye6/G3
	/uKig2gDYg1ok3j8Pa7LsRKHXI7eOXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5rDzNmNKlUslYBWpE8CLa+dDB+iqX95e/LvixPJLls=;
	b=bqJQg/lCNf8Hx/KiKl1zMWh/WbnEUJt5CKJYIoTGZD7ftkeXSDbNcuJeRsO/ArlThyg105
	5y05icEb06yM8dBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gRJxVw+W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="bqJQg/lC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5rDzNmNKlUslYBWpE8CLa+dDB+iqX95e/LvixPJLls=;
	b=gRJxVw+Wb9bmxe617WMVy3yndbeZCj4xjHKUcrRUzk0YfMm41TJ6GCSUk0uni0yhIwfwBu
	iUUFOUS6YH0tcUB35r1rWByzZNKmD1ySwuAUJ6yEbwyF8BPvtUxvnCqxs11yExOTye6/G3
	/uKig2gDYg1ok3j8Pa7LsRKHXI7eOXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5rDzNmNKlUslYBWpE8CLa+dDB+iqX95e/LvixPJLls=;
	b=bqJQg/lCNf8Hx/KiKl1zMWh/WbnEUJt5CKJYIoTGZD7ftkeXSDbNcuJeRsO/ArlThyg105
	5y05icEb06yM8dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 010613EA69;
	Tue,  3 Mar 2026 07:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id toMXOoaRpmmEWgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:45:10 +0000
Message-ID: <0ae218ab-8f20-4e5d-8398-374c4b1dad4a@suse.de>
Date: Tue, 3 Mar 2026 08:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] nvme-auth: common: remove nvme_auth_digest_name()
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-20-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-20-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: DA0A81EA579
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21495-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 08:59, Eric Biggers wrote:
> Since nvme_auth_digest_name() is no longer used, remove it and the
> associated data from the hash_map array.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/common/auth.c | 12 ------------
>   include/linux/nvme-auth.h  |  1 -
>   2 files changed, 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

