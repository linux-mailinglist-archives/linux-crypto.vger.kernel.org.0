Return-Path: <linux-crypto+bounces-25871-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AaZDNgBFVGolkAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25871-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 03:53:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC57467FE
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 03:53:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="kWGe3tv/";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25871-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25871-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC23630080A1
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239825C804;
	Mon, 13 Jul 2026 01:52:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FE235358;
	Mon, 13 Jul 2026 01:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907578; cv=none; b=ofIcBXWo7Z8sKq4/XO7SCxiNxEv1lPZWx1HPGB79VBvwP8PdRWntWAPxP51//4H3Q9HUleVDzSuMr7hbH5CW4pGgxsOGVJAM/PkVVMw49lu3WKsIwJFr+vYpMfl+T1t1e3L7K79hGuc7NgunQX+1uICkpjyMmbEL35XaoJYJcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907578; c=relaxed/simple;
	bh=sOeyh8tlqFvfL1PtK6gJHdGuEw/pQ6sZUBS7u0oH+vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsP+Vdc3mwthJSN3h7PDfpt2E9+ophXl1IRY0DHBh649HMfh1TwQR39jEWEki1ns+llq4oGhSkIBpD3rk1Shz3AZmhM896asE0X+c4duQRbWhOULKTqLkwyzo9UrNPvyUnxzv+9gp0+0z7atpxxxEH+zKePV+Dv5Ra0aZthdynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=kWGe3tv/; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=QXiVq/5z2ggrvTc1XV4itCZeXI2wd2N1BuuSuc2Ws7k=; 
	b=kWGe3tv/djbGGXGG5YRb68jqJa08jUc/pu7TYXEq9XKeXGCyK7gjkgMb732z7+gmPVfFrtQ1fo7
	OPdV774y46xYRzXvZJqaDYXpf0UCm6xDxjF2EQ+rM8NXGGMaYp9KJn0CDEUdM339Yu8PBGV62SFhQ
	df6WEgKv2CjYgNVTL6LDboaMG99nvLWYRUKpDcpGQ1ESktelMsXjJ/170+n+fIqHRkz+S2tXinMPn
	rKIC3spH6tXua64cr+N20MyN6f6gs7xeLPKO73yKl/coroqZ+CM7TS2Ib6tGCr/bHi9XRzPBKgQv2
	aXkyx13MpPa4HiydhjLmKJCztHfJq2bNXI7Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj5qi-0000000Cx3Y-1Wge;
	Mon, 13 Jul 2026 09:52:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 11:52:48 +1000
Date: Mon, 13 Jul 2026 11:52:48 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: cyper@tutanota.com
Cc: Davem <davem@davemloft.net>,
	Linux Crypto <linux-crypto@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: algif_aead - stop recvmsg looping after a
 completed request
Message-ID: <alRE8Mqf-W0Qqpnq@gondor.apana.org.au>
References: <OwDrEgL--F-9@tutanota.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OwDrEgL--F-9@tutanota.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25871-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cyper@tutanota.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tutanota.com:email,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19FC57467FE

On Sun, Jun 28, 2026 at 05:34:15PM +0200, cyper@tutanota.com wrote:
> >From e0ed18c8ad9a7d2ecf939f0b97e2be0567180c1d Mon Sep 17 00:00:00 2001
> From: Qiguang Wang <cyper@tutanota.com>
> Date: Sat, 27 Jun 2026 21:49:55 +0000
> Subject: [PATCH] crypto: algif_aead - stop recvmsg looping after a completed
> request
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>,
>     linux-crypto@vger.kernel.org,
>     linux-kernel@vger.kernel.org
> 
> A blocking recvmsg()/read() into an output buffer larger than the cipher
> result hangs forever.
> 
> After the first pass of the "while (msg_data_left(msg))" loop in
> aead_recvmsg() (and the identical loop in skcipher_recvmsg()) produces
> the result, af_alg_get_rsgl() has consumed only as many bytes from the
> output iterator as the cipher produced, so msg_data_left() is still
> non-zero and the loop runs a second pass.  By then af_alg_pull_tsgl()
> has executed
> 
> ctx->init = ctx->more;
> 
> which, for a request that was not flagged MSG_MORE, resets ctx->init to
> 0 and drains ctx->used.  The second pass therefore takes the
> _aead_recvmsg()/_skcipher_recvmsg() gate
> 
> if (!ctx->init || ctx->more)
> err = af_alg_wait_for_data(sk, flags, 0);
> 
> and af_alg_wait_for_data() blocks on
> 
> ctx->init && (!ctx->more || (min && ctx->used >= min))
> 
> which can never become true again (ctx->init == 0, min == 0), so the
> task sleeps in MAX_SCHEDULE_TIMEOUT forever even though the result was
> already produced in pass 1.

The point of this loop is to wait for a new sendmsg on the socket
which is supposed to set ctx->init to true again.  So are you saying
that even a new sendmsg cannot get out of this wait?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

