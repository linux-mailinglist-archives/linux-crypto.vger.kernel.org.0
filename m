Return-Path: <linux-crypto+bounces-22226-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ69Ksn6wGkwPAQAu9opvQ
	(envelope-from <linux-crypto+bounces-22226-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 09:33:13 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158042EE492
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 09:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA88302D08D
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2026 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78236E47A;
	Mon, 23 Mar 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iize5N0n"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30F5C613;
	Mon, 23 Mar 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254443; cv=none; b=Gfzuo3B7klI35jo34GSbyNeGIVa00E/TFoUygRgyV2Zv9h065hrEdmqsjdCosMOrCJY6kqMKk/MEJM0nupTltgFDX5lBiiPxpFJ9kh7+7rK23kIDI+xuvTnUYpvFxY1r5u8HWcUWzw0vxJ/o1wWm03XLUCQEatht721W1k5aK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254443; c=relaxed/simple;
	bh=crnHTMlgrjt6xapPoUD7HwX7+0Wg0IlKTWONyvTZOL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1UHJ8SjbgRNytomNyfwyJzn84suE7dzHvr23z1jBtQ6I6uWne/uTQObB/BQemD0+J5/nJ/Xnsf5be+IZcNeADIfkqGoPa/ELKway44wlFDUT5WmhPWY4vx6VFo3kqrxoPGAmv4fWb5rv/P8Iyit7pus2xpWwqCuxfXWXAME90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iize5N0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF340C4CEF7;
	Mon, 23 Mar 2026 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774254442;
	bh=crnHTMlgrjt6xapPoUD7HwX7+0Wg0IlKTWONyvTZOL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iize5N0na+6gEe8m+TdTFUD3/3moDCrlLsuDDsLaMgkPpVyKblCx/CQpo/o+pPAxN
	 tfWAFXXCITLhFgHe7cNbCp9pEdPa3fgNPtdjKSXkXKN+Lmer36tTGg22BNnou4BPci
	 0bx5B/pKSZiADvG7v/2GUDVkbTw9TD5gDD1DtMMel3byFZbJRivA224l/500EFDu1J
	 S+SVbQ9jdxkZG10ijpHDivWREocofWPd3vN0DfFt2318W2YFqoXqYtALCn/reD97wy
	 b/6Ct2j407r+jAoB7I+aG7oD+v5l/RGhyHBDaAxPiOEW2y9NYqnWylESXl8ldUIzZs
	 Ds2I1sEEi/L9w==
Date: Mon, 23 Mar 2026 09:27:18 +0100
From: Antoine Tenart <atenart@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: naseefkm@gmail.com, cjd@cjdns.fr, ansuelsmth@gmail.com, 
	atenart@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: inside-secure/eip93 - make it selectable for
 ECONET
Message-ID: <acD5Sdd6w63ixSsD@kwain>
References: <20260320211931.829476-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320211931.829476-1-olek2@wp.pl>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22226-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl];
	FREEMAIL_CC(0.00)[gmail.com,cjdns.fr,kernel.org,gondor.apana.org.au,davemloft.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 158042EE492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:19:23PM +0100, Aleksander Jan Bajkowski wrote:
> Econet SoCs feature an integrated EIP93 in revision 3.0p1. It is identical
> to the one used by the Airoha AN7581 and the MediaTek MT7621. Ahmed reports
> that the EN7528 passes testmgr's self-tests. This driver should also work
> on other little endian Econet SoCs.
> 
> CC: Ahmed Naseef <naseefkm@gmail.com>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!

> ---
>  drivers/crypto/inside-secure/eip93/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/inside-secure/eip93/Kconfig b/drivers/crypto/inside-secure/eip93/Kconfig
> index 8353d3d7ec9b..29523f6927dd 100644
> --- a/drivers/crypto/inside-secure/eip93/Kconfig
> +++ b/drivers/crypto/inside-secure/eip93/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config CRYPTO_DEV_EIP93
>  	tristate "Support for EIP93 crypto HW accelerators"
> -	depends on SOC_MT7621 || ARCH_AIROHA ||COMPILE_TEST
> +	depends on SOC_MT7621 || ARCH_AIROHA || ECONET || COMPILE_TEST
>  	select CRYPTO_LIB_AES
>  	select CRYPTO_LIB_DES
>  	select CRYPTO_SKCIPHER
> -- 
> 2.51.0
> 

