Return-Path: <linux-crypto+bounces-22957-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DOyFERd22mWAwkAu9opvQ
	(envelope-from <linux-crypto+bounces-22957-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 10:52:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129C3E325A
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 657E3301077B
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736230F95F;
	Sun, 12 Apr 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Wdmf0Y4J"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0B339A8;
	Sun, 12 Apr 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775983847; cv=none; b=GH2ioDlcLCMSKdAhL0LpOqo7QltJjkHuO26qv7fMkAc9j0PbewjwXSv9NYmx+SCA76KrdpQMtxXAd58dbPThqfnbfKIcnTZARTpQecCL4nPzy1JO+RhfYAytRwm/SsaFVtZzGylnHbxUtZAWYYDSFw0cDLD/kgIFYHz9rl8F/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775983847; c=relaxed/simple;
	bh=KtNwlP/JGUElW7AHjkUMdkOeCVq+hTQ9PCYGkBjibbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpVPTBt7tynIhfFYuTnggiM6LCcW63PNFMJRkxdjxoGG2MVEtSWKTyL0ObT/6I0eSjYbz540cmGIDsjsdjhxsNP7Tp6G0yc166Bkp2DzZGoGYqbVNUlvkZcqBbmPrCENzaehjTBica3MPKW/BFtsLlOpIXgQ6qEdNrPI5RfBWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Wdmf0Y4J; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=G3SgEWiSUFM4n/Wbv/0cAL9oVLgOLjSdedAzpcqIh1g=; 
	b=Wdmf0Y4JidAM84SoyOWi+aD+FwxpKVXsibFlmeDPDO/AcMo23pel7t6tROOnX/tbBfyTDCNnDae
	0PEaQ7z+ZoCllm9808462MuUf0oM49jOFl0jky/zBmKIHEpgCkaRKGBsgknxXczdGttP8AAV/VB+t
	enaz6xWur7z6E7RcJclhGXhhZ51aQ+6TIXcqd66kUQRyEArBQWqlzNuG9kT/X/QQPYruLEFD555Ju
	mqWqs9BUt3FW8wHVPpDBUOz0p2SNfof6/0HWlTMUD0+OHgc8yGLVN63UFSdXUtcfVZOKDB/RaaoQG
	KmrvMh9nrnQ/iUvu3csHEXilVw9P0fYjc5iQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBq7C-005UEm-1U;
	Sun, 12 Apr 2026 16:50:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Apr 2026 16:50:41 +0800
Date: Sun, 12 Apr 2026 16:50:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, qianweili@huawei.com,
	wangzhou1@hisilicon.com, yinzhushuai@huawei.com
Subject: Re: [PATCH 0/5] crypto: hisilicon - series of cleanups and format
 fixes for hisilicon driver
Message-ID: <adtc4QQ3HcvruE7s@gondor.apana.org.au>
References: <20260330062531.2976138-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330062531.2976138-1-huangchenghai2@huawei.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22957-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4129C3E325A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:25:26PM +0800, Chenghai Huang wrote:
> 1.Fixed a format string type mismatch issue identified through static
> analysis and code review, which could have caused display errors.
> 2.A const qualifier addition to improve type safety.
> 3.Removing unnecessary else statements after a return.
> 4.Removal of redundant variable initializations that are overwritten
> before their first use.
> 5.A cleanup of unused and non-public APIs to shrink the public interface
> and remove dead code.
> 
> Chenghai Huang (4):
>   crypto: hisilicon/qm - add const qualifier to info_name in struct
>     qm_cmd_dump_item
>   crypto: hisilicon/qm - remove else after return
>   crypto: hisilicon/qm - drop redundant variable initialization
>   crypto: hisilicon - remove unused and non-public APIs for qm and sec
> 
> Zhushuai Yin (1):
>   crypto: hisilicon - fix the format string type error
> 
>  drivers/crypto/hisilicon/debugfs.c       | 22 +++++++++++-----------
>  drivers/crypto/hisilicon/qm.c            | 16 ++++++++--------
>  drivers/crypto/hisilicon/sec2/sec.h      |  2 --
>  drivers/crypto/hisilicon/sec2/sec_main.c |  2 +-
>  include/linux/hisi_acc_qm.h              |  2 --
>  5 files changed, 20 insertions(+), 24 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

