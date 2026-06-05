Return-Path: <linux-crypto+bounces-24920-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBv/OVq1ImrbcQEAu9opvQ
	(envelope-from <linux-crypto+bounces-24920-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:39:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED8647C95
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:39:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=KRwptR15;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24920-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24920-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01A2530433D2
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572194D2EC4;
	Fri,  5 Jun 2026 11:35:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A918260566;
	Fri,  5 Jun 2026 11:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659358; cv=none; b=A+V3eZINpsKTJRkoxWxATfDEiyLX/P3xQll+HfXfnh2yIWVl5FYHKGzt8Ctp5pnhPewmtpPgzUV147tFRwV4VyrXHJos2LGLvaDV2R33nEAVpV+vNslB52DOuJ0BRUTwoJcm9peLiyW65RTVLqzQeZUsBKMPwMYehzZOG/n5sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659358; c=relaxed/simple;
	bh=vqlA4TraPGMdJKGiwUlrEGysF4TUK6VrV9Be0pqhhpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9CAO6GXda6d/CXtNViI83lsFURU1Kadb9o6L7QXdFAZjJ1Y8Ez6/6nv4WPlMQPAwskrhHy2BEfVaEDUP8Sqw18dkafijKju4A/OKp4PjCdIWIEp8V2hUbUg2F8paOlANxW4AABZy5nzUgeQ6ZKmtF0rqIO+Xp9kdizLo2aeh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KRwptR15; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=0zDcJGviHIr33OCr4Eatqna55CRxLBjVJZdhP7U9upY=; 
	b=KRwptR15cfWPw2FAOnFVvou0H4KGuStllf9phuxzrDLEalop+UXshk1ic0n4imLv/bC0iYlIc08
	fAxQ/05CFO/GbjTI9pQIwgWZ20YpNsf5BKYoyqIGT9+tDjSpijPlapA/897oGekgPWYWab9O1mZdd
	wHSCIUiaRgxNNdPEeQbM3k+81BguP1CoxCmswcXdQT7XuDzH1iY4p+9nLDsECoPk8GjDhs2aqrGNU
	nUyzxajdBxG1jeIGkrDqIE56yhhOGdrCUMJxKO5wSKIzTbQb4F+rmiwuzjvLBQtetL9ANqE/eP6f0
	kmrNYvHhfuM/dhb96Tcbk4qFyUPguug2Wo6A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSpR-002ogh-1H;
	Fri, 05 Jun 2026 19:35:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:35:09 +0800
Date: Fri, 5 Jun 2026 19:35:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>, Weili Qian <qianweili@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	qat-linux@intel.com
Subject: Re: [PATCH] crypto: use two-argument strscpy where destination size
 is known
Message-ID: <aiK0bZTwOkvMOvfk@gondor.apana.org.au>
References: <20260525103038.825690-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525103038.825690-4-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24920-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:thomas.lendacky@amd.com,m:john.allen@amd.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:giovanni.cabiddu@intel.com,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qat-linux@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CED8647C95

On Mon, May 25, 2026 at 12:30:41PM +0200, Thorsten Blum wrote:
> To simplify the code, drop explicit and hard-coded size arguments from
> strscpy() where the destination buffer has a fixed size and strscpy()
> can automatically determine it using sizeof().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  crypto/api.c                                             | 2 +-
>  crypto/crypto_user.c                                     | 9 ++++-----
>  crypto/hctr2.c                                           | 3 +--
>  crypto/lrw.c                                             | 2 +-
>  crypto/lskcipher.c                                       | 3 +--
>  crypto/xts.c                                             | 3 ++-
>  drivers/crypto/cavium/nitrox/nitrox_hal.c                | 3 ++-
>  drivers/crypto/ccp/ccp-crypto-sha.c                      | 2 +-
>  drivers/crypto/hisilicon/qm.c                            | 5 +----
>  drivers/crypto/intel/qat/qat_common/adf_cfg.c            | 7 ++++---
>  drivers/crypto/intel/qat/qat_common/adf_cfg_services.c   | 2 +-
>  drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c        | 3 ++-
>  drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c     | 3 ++-
>  .../crypto/intel/qat/qat_common/adf_transport_debug.c    | 3 ++-
>  drivers/crypto/intel/qat/qat_common/qat_compression.c    | 3 ++-
>  drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c        | 6 +++---
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c      | 4 ++--
>  17 files changed, 32 insertions(+), 31 deletions(-)

This patch doesn't apply.  Please split it up.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

