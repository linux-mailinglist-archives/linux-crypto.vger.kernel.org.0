Return-Path: <linux-crypto+bounces-21597-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAVyDNGuqGmfwQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21597-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 23:14:41 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B02085E6
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDE26309008C
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2026 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D0D33688E;
	Wed,  4 Mar 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+GL1VxL"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D3383C67;
	Wed,  4 Mar 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661835; cv=none; b=lXmlPmGKA/Erzm1OKQcXIrCvQZDKH9x3STVmLGI3uGzi8H1qbG1HdgNLw1zKIuPCTm4JciPDglb8i2R9TtCdZYrGLalucbS9cCm57asdAmwUUmpNSb8t8FPT5aMr1YKeurOY2dJPFZNwPGVlvVWW6SZMwv0MNGSqLdwfmZsjUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661835; c=relaxed/simple;
	bh=X4//Yj2/Ujl1m4VEwBvnjqeL8UvhG9m6vISP+WwMes8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOoZ08+0qrg1hKaNUuaJYaRRkTiCYD0Un4iCIsNMPlwbrUcYveDsSgxkQ4FAIPRip6be+SVt/RfxzzedRRkpOrcCZMKdLBTFF8OYTrxWfwkI8OIe/HkEMgE/8OWPYZ9iUah7J1XJyQNGcj7LjAB3FsEqt3bu6EIn/CiUsRFCEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+GL1VxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B18C4CEF7;
	Wed,  4 Mar 2026 22:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661835;
	bh=X4//Yj2/Ujl1m4VEwBvnjqeL8UvhG9m6vISP+WwMes8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+GL1VxL0JOpaK3ciGujI74BWHA3IA2+LahDawxYRDVMu8sUvy0SAVqhYOsEPVQut
	 ErWsq5RUYzZ6Wt90jpqwiWd6tUctzkeniJZaEO8ovdKmBaR4ar3qfjupOPOe23fRN3
	 t4yfusgekeV/IYio4BHvkO6YbUKN+gLroZL2ovL2Y4PhkKx13tr+291DiinjwcuiOS
	 HZ8ugNNz7jkWJTgmiYpfp34P7rI7yGBZ41X3RjaVEPsXF1XcWaMP3p8QJ3XSRmCBP7
	 b0K9JAfvN0CRk7YTRXULrsHHcX+eA07c0dG+ksJ4mPqFoEoPsTiUIo2e4gInqDNH48
	 dHIvUKUT7Z8sA==
Date: Wed, 4 Mar 2026 15:03:53 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] crypto: ccp - Fix leaking the same page twice
Message-ID: <aaisSe6VBchOUqVF@tycho.pizza>
References: <20260304203934.3217058-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304203934.3217058-1-linux@roeck-us.net>
X-Rspamd-Queue-Id: 341B02085E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21597-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tycho.pizza:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 12:39:34PM -0800, Guenter Roeck wrote:
> Commit 551120148b67 ("crypto: ccp - Fix a case where SNP_SHUTDOWN is
> missed") fixed a case where SNP is left in INIT state if page reclaim
> fails. It removes the transition to the INIT state for this command and
> adjusts the page state management.
> 
> While doing this, it added a call to snp_leak_pages() after a call to
> snp_reclaim_pages() failed. Since snp_reclaim_pages() already calls
> snp_leak_pages() internally on the pages it fails to reclaim, calling
> it again leaks the exact same page twice.
> 
> Fix by removing the extra call to snp_leak_pages().

Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>

