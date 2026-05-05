Return-Path: <linux-crypto+bounces-23723-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCAsDuCv+Wk+/AIAu9opvQ
	(envelope-from <linux-crypto+bounces-23723-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:52:48 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 432154C8EF1
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BCCC3030743
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF139DBC4;
	Tue,  5 May 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="UbEbgyUs"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7512308F0A;
	Tue,  5 May 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971117; cv=none; b=rC6aNq+5WuSoEi1H9fk19G5i73H6elSpNjrwTbQVI1armLshp/MYpKHVQBd3o2A20JZk7Do35Wv9lAikz3Z8xdeBxeEgqgZWOYWTMLrsfQQK4MO+FXv2nnutMFA6ykEuSe84xTHHVsC9iZke5867amJzr9kCETCBVjL/CHlvuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971117; c=relaxed/simple;
	bh=oJc9HiDoZli3tvCYinH5Wz/OX1WkpjXWZEHmigcCD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCyvrAL/yL+WkJZSCBNv8V+BqlKAfa6B8WO9ATSEfn5FrdymN5RJ0Z6Jwq3084Yam2JwcWEcil9UrgGNx2//UB81VwRj7hfXR4GWOUVCE/2VK1BbQEimWBBSO/cc5+XAy97iBPGM+qlsbF4SrS0TvnuS4cWiTr4Ps31vf6wLhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=UbEbgyUs; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=qxODDZ2GZbzq+d7FoPshQ569sDsyOc2DnK+dDvAlqoY=; 
	b=UbEbgyUsgu3bKepusTL0WwK3nDooQdLOIc7IFAHq+iwhX0pgbKnmOprymBIq6PeIxMUbv78nXQO
	+/2A2gLpgecZO44JRIwRIREAVr+ro0XfT4sZAKyhPZeodm1CaJkLZ5uVec90MPwSy/0faXRR4Jjvc
	702equrXyyFiTQjDEorlgafGLHlDJZmztwC3h3J6bl/Ih3cHaXH8+NwHceBlgeyLNHQLW0NmlZEUB
	Cj4dH4CPRQjAkih1hTTxUJO2anasN76hpmLs+QgRABVLISezjbBVQ7wFFyLo/G74eSg90yRZxA05W
	v2ES4YgtCXhJmESelEkR3dJULEU+OkllKe1g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKBVC-00BNB9-32;
	Tue, 05 May 2026 16:51:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 16:51:38 +0800
Date: Tue, 5 May 2026 16:51:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Olivia Mackall <olivia@selenic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: rng: mtk-rng: fix style problems in
 example
Message-ID: <afmvmqI-4wQ0IvU7@gondor.apana.org.au>
References: <912fe579eccf577f3064b69d6c945e2c9087cab8.1776702734.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912fe579eccf577f3064b69d6c945e2c9087cab8.1776702734.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 432154C8EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[selenic.com,kernel.org,gmail.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-23723-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:email]

On Mon, Apr 20, 2026 at 05:34:45PM +0100, Daniel Golle wrote:
> Use 4 spaces for each level indentation, remove unused label, and add
> missing empty line between header include and body.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4: new patch
> 
>  Documentation/devicetree/bindings/rng/mtk-rng.yaml | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

