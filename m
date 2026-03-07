Return-Path: <linux-crypto+bounces-21682-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCIPE+y3q2n7fwEAu9opvQ
	(envelope-from <linux-crypto+bounces-21682-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:30:20 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86622A415
	for <lists+linux-crypto@lfdr.de>; Sat, 07 Mar 2026 06:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C7FD304A310
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Mar 2026 05:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669334A76B;
	Sat,  7 Mar 2026 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="eqiSEHkz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253130148C;
	Sat,  7 Mar 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861364; cv=none; b=EEvwg93dcKNVdlVRI2RCY2OZKR4Asd8AJSITusea13sIsYldzu5OFlwxAp8FJiMIBw67x1TLhuJ69sXpvJPkOOxa5P6TPFgkH8rwmVovBS4jusJA2yM4fJ/IHpl8z8ojRcZInRFcRFgEEH+Gxr/KICbQUfSq+vnNmcFoZGY6R9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861364; c=relaxed/simple;
	bh=DSkO3veVPwbV5RUPjq1EzwxbpITyYosbGGAoHpgTzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTa6thPZ6600pjDjsYVqaMgtqjRk+OJ4Zkbd6lvy/E6q2Ln00uflqYInOaX16HRokATB/816kA3u+cNOCJ7cT24D31OglCmbL1M/8cNq8rlHoVn1L3hdyW4DDD4t7riGEZuFZPwuAuNOTML9tN5VYvgkxVc/xKYZsSuqfgmfnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=eqiSEHkz; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=2JnLgd+KZwcv/H6Y5gFaAahwS9+prfosZbBrOjXVFjM=; 
	b=eqiSEHkzZrtmjwCE4EkqwUffgOhRn+9M/T05VQ3mO62aXB+Y1JIL2E149bK79c6lSji8q/jGEyN
	vaCho+2dlsqTG90t4K4HmB+XkNeFwL60oCFcWwqbOpvzeqrIYmRBnKzzo2+P5J3tcRZ6wWh4xN+gR
	Vd7/oEyvShi+r/xwB/5RTcKsWgO71uMkTb013ud9cyf16qqqrhOkqDYYLhyJ4r8H5lERzpfpyFH7k
	Tjtj7rSQCO3IKi/Gl9yMV+hT+nEGSXUMAM7msq8NttxTa/jqvvSVmNDOw2ahpKt/q1IgQ86nnQOeE
	KM9lbwdp2XKs2grgZ+pH/tW6VM6phFbNN4iQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vykDp-00CJWX-0I;
	Sat, 07 Mar 2026 13:29:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 07 Mar 2026 14:29:05 +0900
Date: Sat, 7 Mar 2026 14:29:05 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Paul J . Murphy" <paul.j.murphy@intel.com>,
	"Paul J . Murphy" <paul.j.murphy@linux.intel.com>,
	Prabhjot Khurana <prabhjot.khurana@intel.com>,
	Mark Gross <mgross@linux.intel.com>,
	Declan Murphy <declan.murphy@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Daniele Alessandrelli as Keem Bay
 maintainer
Message-ID: <aau3oQgauYBNWhWW@gondor.apana.org.au>
References: <20260223150622.268245-1-daniele.alessandrelli@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223150622.268245-1-daniele.alessandrelli@intel.com>
X-Rspamd-Queue-Id: DC86622A415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,arm.com,kernel.org,davemloft.net,intel.com,linux.intel.com,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21682-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:url,apana.org.au:email]
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:06:22PM +0000, Daniele Alessandrelli wrote:
> I'm leaving Intel soon. Remove myself as maintainer of Keem Bay
> architecture and related crypto drivers.
> 
> The INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER has no replacement
> maintainer available, so mark it as Orphan.
> 
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
> 
> This patch involves two subsystems (ARM and Crypto). Not sure
> who should pick it up; should I split it into two separate patches
> instead?
> 
>  MAINTAINERS | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

