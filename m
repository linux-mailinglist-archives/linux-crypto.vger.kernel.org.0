Return-Path: <linux-crypto+bounces-25956-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z0KKObPsVWpzwAAAu9opvQ
	(envelope-from <linux-crypto+bounces-25956-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 10:00:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F14752238
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 10:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=vjQFSrQM;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25956-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25956-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 143C2300348C
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817373D9DB6;
	Tue, 14 Jul 2026 08:00:44 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8161A38F9;
	Tue, 14 Jul 2026 08:00:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016044; cv=none; b=J5hfKWuhVeO/eczSZWOJaRdarSqW1XvY0Kx2ER2nQqf8ipbwZrXTLvlrNG3C5ge7HOFdHN6m0Uv8954JCwkibEbnIt8hrl9bHdK1TvHmZgjKJR/xYvMmIZ8IUvxMVm0vpnSIDudw1GjZGN1bb9Gf+9t1dCmBuOTGoTptBcttSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016044; c=relaxed/simple;
	bh=lczrq4Wq1EhQvROZoZT33BuqmzgLX9Tkx5j+byiR58A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1GRomiG+JLj1u83Bol84wtglWISCKUy2cFyqYDHbV8Yf33dre2wST4uUIzOWhfO5JBvoKPd11enm2RHgIScDv1nvwESQlTJfJ0PdmAlq+uHx4TyeNaT+ZcdOG+L8J7+QONBCloCVwE2o5nX++fvAfkCUN3sF4eQKFnivCELBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vjQFSrQM; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9768A2065A;
	Tue, 14 Jul 2026 10:00:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6YUFFZZehSg; Tue, 14 Jul 2026 10:00:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CDA8B20643;
	Tue, 14 Jul 2026 10:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CDA8B20643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784016032;
	bh=zzzr7bgGfPkhtHATb7RDXhK8weqXzOaB5npsw5BmWHY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vjQFSrQM0PfFsGsoyx7rN6+6ywJZ8U5YNTQG4kU0i20cIX5U3910cfELEKOpNE5xa
	 IJBbDe/9y21z9rOnr7XSdKoXkIjNGi6c1RWkmNJ+M3GR+BfSx915TxcMXdvM/oKKuf
	 shYpktoJxk3qfsfbLjYGnSzhGsagQyJZw63tWNEed4cmquX9Xr7f8wcZU7hPgewZzR
	 NLunrVG5rQ+bsG0CQUIxBxoEPqdEAHxYJcWDE8W1LjYhQ6hFvdwqkuInaz9r3OxxR2
	 L39qV+4ypy8a+aRgk0pV5bUhfBk9jAzcbuCaUaLMs04kVSRE5f1HXskxNV1pkzcu00
	 ziN8sAUHPJquA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 10:00:32 +0200
Received: (nullmailer pid 570222 invoked by uid 1000);
	Tue, 14 Jul 2026 08:00:31 -0000
Date: Tue, 14 Jul 2026 10:00:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Huth <thuth@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] crypto: pcrypt - Disallow nesting of the pcrypt
 wrapper
Message-ID: <alXsn7_N81fPGJdj@secunet.com>
References: <20260701143947.944593-1-thuth@redhat.com>
 <alRNusgXIT06hTow@gondor.apana.org.au>
 <20260713024654.GE4362@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713024654.GE4362@quark>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25956-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:herbert@gondor.apana.org.au,m:thuth@redhat.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5F14752238

On Sun, Jul 12, 2026 at 10:46:54PM -0400, Eric Biggers wrote:
> On Mon, Jul 13, 2026 at 12:30:18PM +1000, Herbert Xu wrote:
> > This doesn't fix the problem completely since you can nest in other
> > ways, e.g., pcrypt(cryptd(pcrypt(...))).  How about handling the name-
> > too-long error more gracefully?
> 
> Could we just delete pcrypt instead of continuing to try to fix all the
> weird problems it has?  A web search for pcrypt just finds CVEs and
> advice not to use it, e.g.
> https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations

The comments on pctypt there are not quite right, but it
is obsolte, that's correct. It was usefull back in the
days when the overhead of (slow) software crypto was
high compared to an IPI. I guess there are not many
users left, so I'm OK with removing it.


