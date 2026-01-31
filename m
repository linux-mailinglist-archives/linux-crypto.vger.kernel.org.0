Return-Path: <linux-crypto+bounces-20503-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLVpNLlufWmTSAIAu9opvQ
	(envelope-from <linux-crypto+bounces-20503-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 03:53:45 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7412AC0626
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 03:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3AD3018BF8
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jan 2026 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EA30F957;
	Sat, 31 Jan 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KvZLABHJ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73C2FE07D;
	Sat, 31 Jan 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827946; cv=none; b=NcLkpJwUWiMvf1NfInet+e+hcaGEHq65KMROWfZ32J/Xan+aBD5x1wU0aTBtjr3CdmKOducplyskIjjrUSh0ZSzCuN+QgWB/yXygfz2acAOGfdKB9HtzTWZa+MjZryPm4/Lt/HHogqQI4FJEV7BJCJS/xXx/fK9dmjYZU8IEPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827946; c=relaxed/simple;
	bh=Nq0gA/cnU3hC+pTygVMKfrGyNwrScFu3syd74aePS3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAK5uZSVwyDdWJ11wWaX1minpP/2HcG8hVmpKPMDkz8NTY3k3PzoEA0IFOoXOspRxfzINS3zI6T1yzYvN4iLfHm5GZva/53BenH26aAbTATQ1Xrp0Vp3aa8Lo/opTsQtCUsttyAMkutFC5a9a4CWJ4L1ON8W94RpDy3RGdop1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KvZLABHJ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=9RA4evnkWnigTi0hEwSAJctd8OnLBTl1I3r4McPl7zo=; 
	b=KvZLABHJJqryZU0dP1mvkoqIHlRrV4axMSQ1WdGm/zmnyPudpyQzSDDd+NlqIgYwMO24Iumz2K/
	l8/OF1QnKEd6thJr8k6zqCWCSdNbAFZtiIu/O/uQrsNhseLjT/mFgL69L8wKzl/IvqdE72a7PlrbY
	cYiAkHIL8nKELMs1rahp39wKiIsG0yxeUGsALAVYfbYScQ9dIdVG+j1e48j6BpQt4g+o53LjQq8vM
	fX1t6Y32+kc74y22D7wFkd11z6aobQ4jsVl0OEXq2cVk1d0VZ/aBMtPW7CBVbRIWi4lmnPn9AiHYl
	kobGe9Jlhw4264zzmBvjcrxl1DLLadQLmWOw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vm15q-003Rvd-20;
	Sat, 31 Jan 2026 10:52:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 31 Jan 2026 10:52:14 +0800
Date: Sat, 31 Jan 2026 10:52:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, davem@davemloft.net, robh@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, matthias.bgg@gmail.com,
	atenart@kernel.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 0/4] Fixes for EIP97/EIP197 binding and devicetrees
Message-ID: <aX1uXlLMJtkMQAzI@gondor.apana.org.au>
References: <20260112145558.54644-1-angelogioacchino.delregno@collabora.com>
 <aX1uH28_Zd1i-d_A@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX1uH28_Zd1i-d_A@gondor.apana.org.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,lunn.ch,bootlin.com,gmail.com,vger.kernel.org,lists.infradead.org,collabora.com];
	TAGGED_FROM(0.00)[bounces-20503-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: 7412AC0626
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 10:51:11AM +0800, Herbert Xu wrote:
> On Mon, Jan 12, 2026 at 03:55:54PM +0100, AngeloGioacchino Del Regno wrote:
> > Changes in v2:
> >  - Reorder commits
> >  - Change to restrict interrupts/interrupt-names minItems to MediaTek only
> > 
> > This series adds SoC compatibles to the EIP97/EIP197 binding, and also
> > fixes all of the devicetrees to actually declare those in their nodes.
> > 
> > The only platforms using this binding are Marvell and MediaTek.
> > 
> > AngeloGioacchino Del Regno (4):
> >   dt-bindings: crypto: inside-secure,safexcel: Add SoC compatibles
> >   dt-bindings: crypto: inside-secure,safexcel: Mandate only ring IRQs
> >   arm64: dts: marvell: Add SoC specific compatibles to SafeXcel crypto
> >   arm64: dts: mediatek: mt7986a: Change compatible for SafeXcel crypto
> > 
> >  .../crypto/inside-secure,safexcel.yaml        | 22 +++++++++++++++++++
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  3 ++-
> >  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  3 ++-
> >  arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  2 +-
> >  4 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > -- 
> > 2.52.0
> 
> Patches 1-2 applied.  Thanks.

Oops, they've already been applied elsewhere so I'm backing them
out of cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

