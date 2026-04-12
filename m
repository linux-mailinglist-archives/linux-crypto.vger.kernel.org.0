Return-Path: <linux-crypto+bounces-22953-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEH3IfZZ22nNAgkAu9opvQ
	(envelope-from <linux-crypto+bounces-22953-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 10:38:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FAE3E31A1
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5585E301C6C4
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C24830C371;
	Sun, 12 Apr 2026 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="cmgank5K"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE82212548;
	Sun, 12 Apr 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775983089; cv=none; b=okoYjye2MTV5qPc7gousQaUPY0z720QBBw+luagXgwyRWTdvcrQA5w9p0ZEWB4bwhsoWCkhCDmF3P9t6sIItOcC2LKuWGgmYdl0xJe0lEqexmgdin3szC9/VICzTcDTsbmPTmWt7Mne7v4oYGI5VSlR+F/JYOLPpn96lpuq93QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775983089; c=relaxed/simple;
	bh=eBEqv6b7F2owlx3WNLor5kliMDQAqJrM/FuQdcKjZhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoFnscOd9lT5lN8KATOTqKoT5itgmHRTQMw1xAUWJymetG0UnTlbQH8Vy4GCVGIUcsQ3My+7TLux4yxilTECNDUuVjyHjre+vktQS1Zyg7DkXOGVYyIxoA19RD6wHZ0mq66PsooPLyB/IdOrjo1ZlxFVOvOKDRLJthPqMBX/Dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cmgank5K; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=5W2MKluaDGA38IpyehFQb5q6vfKRPVvsv+0GniGglKM=; 
	b=cmgank5KSX/kNGa3ZwDqUu6wk8C6/cYMdBKPE9sweSg055qqqmONhIq4n/knpY2HHyZ4Huji5b5
	IZeO0B74XIolVNMVRD7bktNo0BR43A8y/NxOI31GWXMEdhzpkBjTtiM0XiLYQjrP3k5yxIsuEaxBD
	76LDNoEZ/Uikt7UBv0HAgBchB0ZvnyDE+1HwKmue2J9iMQixJpTy4a+0uIOpaSnkJcWRCoqwzVGbV
	2A6uohDqpzH5mLlpjoV2DK5xnykeIOzETOKq+UIVe3FM404Ol3Nigv8k10eahMiJ75vtKXKa+tQPk
	CYexXANaCCOBapIg2ndDF5uAeJkNu1nWo4mg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBpua-005U9U-2l;
	Sun, 12 Apr 2026 16:37:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Apr 2026 16:37:39 +0800
Date: Sun, 12 Apr 2026 16:37:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: atmel-ecc - add support for atecc608b
Message-ID: <adtZ06qiYly4ft2P@gondor.apana.org.au>
References: <20260330100800.389042-3-thorsten.blum@linux.dev>
 <adsyzmm3WSZ1ao4a@gondor.apana.org.au>
 <adtHNa-eMUQO0JqX@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adtHNa-eMUQO0JqX@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22953-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3FAE3E31A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 09:18:13AM +0200, Thorsten Blum wrote:
>
> Patch 2/2 is here:
> 
> https://lore.kernel.org/lkml/20260330100800.389042-4-thorsten.blum@linux.dev/

Please repost 2/2 to linux-crypto with Rob's ack.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

