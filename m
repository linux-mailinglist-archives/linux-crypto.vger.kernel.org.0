Return-Path: <linux-crypto+bounces-25589-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OrI4L7nsSWpW8gAAu9opvQ
	(envelope-from <linux-crypto+bounces-25589-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:33:45 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951470908E
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 07:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=hOaup+t5;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25589-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25589-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6659300E381
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728D2DFF3F;
	Sun,  5 Jul 2026 05:33:43 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE42C0296
	for <linux-crypto@vger.kernel.org>; Sun,  5 Jul 2026 05:33:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783229623; cv=none; b=UO02aNkE5bsLnbEs60IIAGskiPFr3DkL6U7U7qTeedCSsVhf7J0ewrNKJoad/Y5uGITsmhb8bdgpLeDhYP/bx2Nxr+hOby4GjUR4TNOeeOauTpeGgA8JPNSQdKKlDXYpJpi2iw090+I/qd1lGSjj8k1YhXvH4zRRy8XIYuDnDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783229623; c=relaxed/simple;
	bh=NeIbXBDg9sY9u4gAnhjeG2uKeAkUhD+l18AFRm4+POE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtqzjINfWu3K4pDBEfrFFPNjXHjKbFwIUYxYdA9kFN+l3MAambinZILQEE3HihXuCK5+fEinDZOzX/t+e/u3FCr8Pk9fhhOIEHvZD2qMghBxPGpBxspvXQbjzgqWUxgm6nqdwNLoPUcpGCfONGVfKCrIRSF6RkPRnxULnAw2n8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hOaup+t5; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=BRkbh9w2c+zAjH58NXsWsFks3bAu/1aefpyeKz6UnSk=; 
	b=hOaup+t5fnbjX50+vxSAnF50c4dITFDBSMqwxWfqWmjWQsTKXag58D9PHoVdtamvQMmL2FLmoqS
	KhzSSCtvYeHv/LNTWXnFv7bPx6aHkwEArNguf381vXPjO8W6GDN1UZ+heOpSUfw0ZeYD1FpXRNFgd
	gbHXXKPNKEksV9/yH41VlqwqO2NjQIjHo2Q8o/zW+W9ZyM5C/lajOTP9ZRiOObBnCCYlkcDr6FUni
	MrZgAfmWO0MCgSVaPKirdo3lCo2HfyHFWSM/CQ+C8+AcIjwoSERaE8GGNJLhmvTo8EffyUdAEtGCW
	wQRXwncRuEoDouHlJzCgqoCLwJQ4XgR96V4w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgFU2-0000000AjgB-0VL6;
	Sun, 05 Jul 2026 13:33:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 13:33:38 +0800
Date: Sun, 5 Jul 2026 13:33:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH] crypto: qat - cancel work on re-enable SR-IOV timeout
Message-ID: <aknssg1kRsm9zHt2@gondor.apana.org.au>
References: <20260608150104.135313-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608150104.135313-1-giovanni.cabiddu@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25589-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:giovanni.cabiddu@intel.com,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:ahsan.atta@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0951470908E

On Mon, Jun 08, 2026 at 03:59:40PM +0100, Giovanni Cabiddu wrote:
> The QAT reset worker queues SR-IOV reenable work using a work_struct and
> completion embedded in an on-stack adf_sriov_dev_data. If the completion
> wait times out, the reset worker can return while device_sriov_wq still
> holds or executes the stack-backed work item.
> 
> Cancel the work on the device_sriov_wq on timeout before the stack frame
> unwinds.
> 
> Fixes: 4469f9b23468 ("crypto: qat - re-enable sriov after pf reset")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_aer.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

