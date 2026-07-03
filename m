Return-Path: <linux-crypto+bounces-25568-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id grqPMEJ4R2r3YgAAu9opvQ
	(envelope-from <linux-crypto+bounces-25568-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 10:52:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1BC7004A5
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Jul 2026 10:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=hZwWDQmQ;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25568-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25568-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5679F301A758
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2026 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6533D51A;
	Fri,  3 Jul 2026 08:37:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDA32572F;
	Fri,  3 Jul 2026 08:37:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067860; cv=none; b=cmK1BL085dI/pTVB2D9dAZcjN5ibaRM1etGB4r8uToWBRpJp1GQ1BXJonLYjKiKRGO/zRgYo7rOmzsJ3YuD0DBXUAzxIbrZPzOjOhaG05y/PqPGPxxFulqw//nF14g5NxVeSVa+WRdMAA06L4MOMeKaqKUO/yTV0NnJ9jOC3270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067860; c=relaxed/simple;
	bh=FVkqwUOZ4ERZ/PhJIF0Or0/yfrhW1DhsRRfvtsAsn5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSFuxLqhWWBXhb8uktXldHTp93r1jUI7+0I7t64Ng0v7TzHOU7SS3GXlK+x8eJXRYkiYYcVRbmvdBQ460jpdQ277rEM+3CtyS2uF5B+y/o+KgwhM7SF+yBLLRL6d84g6xHugWgGQKzvwXKJtx1FEige+IZIOzkd9IeLhnKyeUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hZwWDQmQ; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=jNKDH9oVNm6OpwXQb+w/OSiu1n+mkgu5LnZiOJS5z9s=; 
	b=hZwWDQmQJfhfXgOLVJaS1LAH5Ib7T9V93H+MVico3q7fOH22ys+W9jx/3iZwixRFRE/ST10wk3J
	GNE88KnnCk4QglNWSeqeUmI8Xgg9Oaf+PM4VLjVwIeZszd0lrv3MwaGrOjyWhOibj6YTQQHToIy7i
	iAibZCL9awuPOnBWGKkgMgR3X4HJeU17cnutUvgQaCZvgF+5XO0h9QrROwgL3sNtM+/e6QgoyHY94
	+vqQuvKwr+Tps1uotoTFP/MaJoWcqbvkR5ZZ8vWIIQndH3eo9h6Bjb6po1d7gm9aqPCZFwaYG16zs
	bCnUdWD1bCcpXW21Z8PTbXPyCgP7wS1A20Ew==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wfZOu-0000000AJOc-1BNB;
	Fri, 03 Jul 2026 16:37:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2026 16:37:32 +0800
Date: Fri, 3 Jul 2026 16:37:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mert Seftali <mertsftl@gmail.com>
Cc: T Pratham <t-pratham@ti.com>, "David S . Miller" <davem@davemloft.net>,
	Dan Carpenter <error27@gmail.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: ti - Use list_first_entry_or_null() in
 dthe_get_dev()
Message-ID: <akd0zGzVZSG_45hK@gondor.apana.org.au>
References: <20260613085858.32580-1-mertsftl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613085858.32580-1-mertsftl@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25568-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,davemloft.net,gmail.com,vger.kernel.org,intel.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mertsftl@gmail.com,m:t-pratham@ti.com,m:davem@davemloft.net,m:error27@gmail.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lkp@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F1BC7004A5

On Sat, Jun 13, 2026 at 10:58:58AM +0200, Mert Seftali wrote:
> dthe_get_dev() fetches a device from the global device list with
> list_first_entry() and then checks the result for NULL. However,
> list_first_entry() never returns NULL: on an empty list it returns a
> bogus pointer computed from the list head. The NULL check is therefore
> dead code, and an empty list would be treated as a valid entry and
> moved around as if it were a real device.
> 
> Use list_first_entry_or_null() so the existing NULL check works as
> intended and an empty list is handled gracefully.
> 
> Fixes: 52f641bc63a4 ("crypto: ti - Add driver for DTHE V2 AES Engine (ECB, CBC)")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202606111933.69GGTKxr-lkp@intel.com/
> Signed-off-by: Mert Seftali <mertsftl@gmail.com>
> ---
>  drivers/crypto/ti/dthev2-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This only fixes the symptom of the problem.  But the root goes
deeper.

The main issue is that the device can go away in the middle of
an operation.  The driver needs to be handle it gracefully, and
certainly not by crashing the system because the associated memory
has been freed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

