Return-Path: <linux-crypto+bounces-21465-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOHHNqAgpmkuKwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21465-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:43:28 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D01E6C3C
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D903430046A8
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6B34028B;
	Mon,  2 Mar 2026 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfF9RoqN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C232C92A;
	Mon,  2 Mar 2026 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495003; cv=none; b=ghslrgn70pKJLKl75bCb36AQsi7OQvfkx4IHkoKzziuZukbBEWPDrGIM3YwpH8zjSjPvgictWwK2U+FIrfgLGHuNDxuxzrpXwowO6RCNRaWZt1ug65Feg7jOTNCJLUKiHNxGNzpY4VHwF0wCH0NbANlq7Z4571uKSrF7P0MFmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495003; c=relaxed/simple;
	bh=frEcAm5Sb1Cb7UDQJ6+oJvgem0+Bj3jNre9w1kRD5bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPBxRv8LO1JZZUNBX9jpPxr6em4x0hSmWuVxn8BdGUVCbyctC1k/tZ42fe2BtduPderm63zAtxzNBlfdENugKmnpYjpHdUst3jLd5Pw/2X5lUvxijwmt/bkPMtN13TI2x0iBnGM9Ap76Mp51sEOddyguFxEsAqp4abEpIuWyMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfF9RoqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE6C19423;
	Mon,  2 Mar 2026 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772495002;
	bh=frEcAm5Sb1Cb7UDQJ6+oJvgem0+Bj3jNre9w1kRD5bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfF9RoqNtXK3zaSK0l/MgBBePdW41R0Gle86cjvmzgNhTjC1IHXCP+S5Zpl5Le1Or
	 CEosyRxgDnvdYPp4qRa3ywnxuehbw0G9dgZ6DZ6S7pHk7s/Ia2DSCroth055V9R4kV
	 a6XfrWTwYq01vB7ic9HNPvdDbqWQajs1WY2+SxnGfVS6OveSzDnEG5+4ZsH7jMAx2E
	 pV57efldAweLJHnekmOnODknbfHlxnmZ7+21S7WzfUQ2HgDBaQmcGgpIKztJQTwUNy
	 /F94rQu9QMf/4PZ9B0QpNlvkMYPW40yrS6IOQfKjVDd9/V379ag7FsKnaA97q9fsoR
	 +I54U/iix+BTg==
Date: Mon, 2 Mar 2026 15:43:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksander Jan Bajkowski <aleksaander@onet.pl>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: Re: [PATCH 1/5] crypto: testmgr - Add test vectors for
 authenc(hmac(sha1),rfc3686(ctr(aes)))
Message-ID: <20260302234319.GC20209@quark>
References: <20260301155351.5840-1-aleksaander@onet.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301155351.5840-1-aleksaander@onet.pl>
X-Rspamd-Queue-Id: D98D01E6C3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[onet.pl];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21465-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,wp.pl];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 04:53:38PM +0100, Aleksander Jan Bajkowski wrote:
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c4770b87551d..91831b548062 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -4136,8 +4136,12 @@ static const struct alg_test_desc alg_test_descs[] = {
>  		}
>  	}, {
>  		.alg = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
> -		.test = alg_test_null,
> +		.generic_driver = "authenc(hmac-sha1-lib,rfc3686(ctr(aes-generic)))",

aes-generic was replaced with aes-lib in v7.0-rc1.

- Eric

