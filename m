Return-Path: <linux-crypto+bounces-25038-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XUZ6DixNKmo4mgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25038-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:52:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681E66ECDE
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=PHsFQmuq;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25038-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25038-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBEA8308431C
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEE34DCC7;
	Thu, 11 Jun 2026 05:51:00 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9C24DFF9;
	Thu, 11 Jun 2026 05:50:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157059; cv=none; b=hfZgEc3k7xYObr/wyYG45ZH2tgCU/NfMO3KOUycH1Fil74+F17r/VsY1ZKxtSeKNNBRmWdhKRjfY1TzepXUpl98esGZK0YPN8Pyhe3/OcdQ47X4lm53CisvbpSnrzO/qOldxqMGEsrwVeAN8fCaXWpjt08YA+f0moH10KVbIV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157059; c=relaxed/simple;
	bh=aFCBRapvOXew+Noti49kRnnBaKKU2jD8tcX7iyV7Sfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSQHfquBdwO+wuOhAL8bSMlk4jtA41NE03Ltxzu0bwdZgmUQrYt1NdcGpZr3nzTzRoE7dbv8d18Nv3xDK9geJV5rNZDLQ3FqSeRhIXjsEc7YjlpW8z828Ps8nnhez4EEjrTP66jzxGfNWgc8ESrYK8hqrbrBiLkjUprRHl6SgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=PHsFQmuq; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=nqS/eIx4316IuyHGDGsTI2Mit/s75slnzsaDmUc7NhU=; 
	b=PHsFQmuq1Z2V1HiPubIPvX4M8kGjH9eqqFv3hpzoti55/gcKnKwu9U7vyL4R+/pPRcSshgHHwBC
	iPUn5K5MobboF+N7OlRnEfRRd7/h9ZajuV54EWlp1wOAv/QHahgcKaDYYcqDhOKq66Exo3YNEAIIU
	LaNJIgn3QwTZfEi4OsiTMUTq7jZS/NTJNLDtjV9xt2hXVfHHLJkXD+/qHMIvvZXQFG6IwtdDLZs5l
	6sM1CP7SrzKbKiVSjoXHer41qbnFut1jkydXowuDXP7KhcbskusC9HO4SFQslZps1OPgQC7KiCpph
	T2Us3L5y8ic/9scnHYWkjEd+enLSYq82il/A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXYJa-00000004UZM-0NLn;
	Thu, 11 Jun 2026 13:50:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 13:50:54 +0800
Date: Thu, 11 Jun 2026 13:50:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com, rbannerm@synopsys.com,
	manjunath.hadli@vayavyalabs.com, adityak@vayavyalabs.com,
	navami.telsang@vayavyalabs.com, bhoomikak@vayavyalabs.com
Subject: Re: [PATCH v13 2/4] crypto: spacc - Add SPAcc ahash support
Message-ID: <aipMvkD_Y4NO4hfR@gondor.apana.org.au>
References: <20260604165210.1141842-1-pavitrakumarm@vayavyalabs.com>
 <20260604165210.1141842-3-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604165210.1141842-3-pavitrakumarm@vayavyalabs.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25038-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:pavitrakumarm@vayavyalabs.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:Ruud.Derwig@synopsys.com,m:rbannerm@synopsys.com,m:manjunath.hadli@vayavyalabs.com,m:adityak@vayavyalabs.com,m:navami.telsang@vayavyalabs.com,m:bhoomikak@vayavyalabs.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vayavyalabs.com:email,synopsys.com:email,sashiko.dev:url,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9681E66ECDE

On Thu, Jun 04, 2026 at 10:22:08PM +0530, Pavitrakumar Managutte wrote:
> Add ahash support to SPAcc driver.
> Below are the hash algos supported:
> - cmac(aes)
> - xcbc(aes)
> - cmac(sm4)
> - xcbc(sm4)
> - hmac(md5)
> - md5
> - hmac(sha1)
> - sha1
> - sha224
> - sha256
> - sha384
> - sha512
> - hmac(sha224)
> - hmac(sha256)
> - hmac(sha384)
> - hmac(sha512)
> - sha3-224
> - sha3-256
> - sha3-384
> - sha3-512
> - michael_mic
> 
> Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
> Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
> Acked-by: Ross Bannerman <rbannerm@synopsys.com>
> Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
> Signed-off-by: Manjunath Hadli <manjunath.hadli@vayavyalabs.com>
> ---
>  drivers/crypto/dwc-spacc/spacc_ahash.c     |  897 ++++++++++++++
>  drivers/crypto/dwc-spacc/spacc_core.c      | 1311 ++++++++++++++++++++
>  drivers/crypto/dwc-spacc/spacc_core.h      |  838 +++++++++++++
>  drivers/crypto/dwc-spacc/spacc_device.c    |  275 ++++
>  drivers/crypto/dwc-spacc/spacc_device.h    |  237 ++++
>  drivers/crypto/dwc-spacc/spacc_hal.c       |  374 ++++++
>  drivers/crypto/dwc-spacc/spacc_hal.h       |  114 ++
>  drivers/crypto/dwc-spacc/spacc_interrupt.c |  329 +++++
>  drivers/crypto/dwc-spacc/spacc_manager.c   |  611 +++++++++
>  9 files changed, 4986 insertions(+)
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_core.c
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_core.h
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_device.c
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_device.h
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_hal.c
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_hal.h
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_interrupt.c
>  create mode 100644 drivers/crypto/dwc-spacc/spacc_manager.c

Please also check the Sashiko comments, some of those look alarming:

https://sashiko.dev/#/patchset/20260604165210.1141842-1-pavitrakumarm%40vayavyalabs.com

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

