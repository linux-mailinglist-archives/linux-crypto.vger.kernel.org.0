Return-Path: <linux-crypto+bounces-21497-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEaHNueRpmnxRAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21497-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 08:46:47 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A21EA540
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 08:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89FA13017032
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574A337BA3;
	Tue,  3 Mar 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lD5Zk96o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K9o/H7Vp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lD5Zk96o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K9o/H7Vp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8429A2
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523981; cv=none; b=XGV34al9SD4p/fWFfyl6Diw7Q0D2iiHOs9LELnh/QvbldKkYFTYHFuQmUlsuKLjZ608DzzhokFhOBJKdAFMIPcFxlUP7DNsLn6dd+Gjq+H8gShJNF1PX3w8qHaOJcaS3rqd8jAGg6mA4FBGlEve6TqtcZygx5xtjgeZn/Kbkh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523981; c=relaxed/simple;
	bh=XmSSNhkcJ/8OaU/WHvtymAHZ+L7pcVah1YtezE9Ftz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uc5Q05zYcKHfhHMsParOcCgKEVMRZgVvM/QJW04okwFO6UCFRehu11tg16hPnvxRFzrsdAp2asetNT91bqjPcNoH3HTmcaWjZ4QEZ955ISviTcGa+RFyen8OHKFfcEBqReZXWSVeNCBYJpxnzGWZhiWhhtoXFgYr/GKzsZhE9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lD5Zk96o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K9o/H7Vp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lD5Zk96o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K9o/H7Vp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C33E5BDE6;
	Tue,  3 Mar 2026 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQs2nWE2CfmYT6KOxTMv7zDJD3Mzsk0PiYtXLL1dPm4=;
	b=lD5Zk96oB50qU/e6z/jtPwE9r9ED2RP253fW6OTWSI4q5bJ6POotiMWTRdKs1iJA8JK9Sw
	WsAZdN7UvCP3+ZeBe2dAODSChrW3R4s+6dLWmJ+3UTT6UJ8vN3qB1sA3oNv39gxR0Kroj2
	CvPIFx/UAgfVoCQlsaAvu+fZKCuAasQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQs2nWE2CfmYT6KOxTMv7zDJD3Mzsk0PiYtXLL1dPm4=;
	b=K9o/H7VpdQhY1LVdYx1TON0FNovcGPx3SKPR5Hx0+h35FWbaQsXxNFZwI6AuEvrWYc/qte
	84+g2cCmrLnPBuCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQs2nWE2CfmYT6KOxTMv7zDJD3Mzsk0PiYtXLL1dPm4=;
	b=lD5Zk96oB50qU/e6z/jtPwE9r9ED2RP253fW6OTWSI4q5bJ6POotiMWTRdKs1iJA8JK9Sw
	WsAZdN7UvCP3+ZeBe2dAODSChrW3R4s+6dLWmJ+3UTT6UJ8vN3qB1sA3oNv39gxR0Kroj2
	CvPIFx/UAgfVoCQlsaAvu+fZKCuAasQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQs2nWE2CfmYT6KOxTMv7zDJD3Mzsk0PiYtXLL1dPm4=;
	b=K9o/H7VpdQhY1LVdYx1TON0FNovcGPx3SKPR5Hx0+h35FWbaQsXxNFZwI6AuEvrWYc/qte
	84+g2cCmrLnPBuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3180D3EA69;
	Tue,  3 Mar 2026 07:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mEUoCsqRpmnyWwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:46:18 +0000
Message-ID: <d7678b60-0249-429f-bfd2-2eb663d485cc@suse.de>
Date: Tue, 3 Mar 2026 08:46:17 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] crypto: remove HKDF library
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-22-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-22-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EB4A21EA540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21497-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/2/26 08:59, Eric Biggers wrote:
> Remove crypto/hkdf.c, since it's no longer used.  Originally it had two
> users, but now both of them just inline the needed HMAC computations
> using the HMAC library APIs.  That ends up being better, since it
> eliminates all the complexity and performance issues associated with the
> crypto_shash abstraction and multi-step HMAC input formatting.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   crypto/Kconfig        |   6 -
>   crypto/Makefile       |   1 -
>   crypto/hkdf.c         | 573 ------------------------------------------
>   include/crypto/hkdf.h |  20 --
>   4 files changed, 600 deletions(-)
>   delete mode 100644 crypto/hkdf.c
>   delete mode 100644 include/crypto/hkdf.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

