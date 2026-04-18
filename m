Return-Path: <linux-crypto+bounces-23156-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE4PN5uD42nCHwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23156-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Apr 2026 15:14:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3E421273
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Apr 2026 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69D76302A7C7
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Apr 2026 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBD35C1BD;
	Sat, 18 Apr 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="jgbqtO+u"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62833993;
	Sat, 18 Apr 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518036; cv=none; b=HpaVMFQZj7bWwjDBPpj3onAUsKKXZNCn8O8PdkLW6qHEudGOusSpH/UoH6NhdiUyuzIN6B8GPJE1WSJSrOTGHhJamN5JFHxQj/3eAAWQHEZloyA28rhBo+d8mxQXBTswpa9vPmz4kuuVA1Mgk4ONLzrH2oZne/BRfsQFfhFKlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518036; c=relaxed/simple;
	bh=//b6NVNpakvcw3vOInqkQCFfRSMxiv0440tTPM8T5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGg2wo0Ce+1crUJTbJAFZKFZQ8aMD8DAS7NiIBIDMhrj0n5CswFwpoc8C73UV9HOtxTagcPydfWuJ5YlulADqMrMDnlIZ2TQIilF9OjDJzwujUOHol51StK+PM10pgkHx0efxBP/AYqRZ62OLbnJmVbaYRR3CGP1dkfLPdnl/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=jgbqtO+u; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=KK88PVxehulQrHdPiHXJmT815/4f0NmtiEI64lthY5w=; 
	b=jgbqtO+up7OTHnog3meDxkO/WqJKkJlrueH6I4iI/6E9wFt8rhPU9O0DpOsEig2byznXw7A/G3S
	2VbJWrSRZApQ9ssGy3sndfniLJ92RMMNWS00+P54E/nMURo52BZVqW8o/KiBsyHH4QueRAECoDlL+
	wFITYBfcNL1ZHS4Kx9ff4jvY3yUW0a7Ndm6GNfdLbtsIvnoGL1BmLdbssLN4sJAzU/jxs1w0ixHLZ
	KtlOHLEWpHdO7SSrake2ZY89xX/2TjkPVVeHv6gwfhSft+gZm9KcToi+arbr9aDEwBCPLPv3+l4Sy
	Xdgu193dxa77TBngeB7AiF2PhDfdHIuhNbEA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wE5UX-0070ya-2R;
	Sat, 18 Apr 2026 21:13:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 Apr 2026 21:13:45 +0800
Date: Sat, 18 Apr 2026 21:13:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@kernel.org>
Subject: Re: [PATCH v3 2/7] crypto/ccp: export firmware supported vm types
Message-ID: <aeODiabFhYV711fF@gondor.apana.org.au>
References: <20260416232329.3408497-1-seanjc@google.com>
 <20260416232329.3408497-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416232329.3408497-3-seanjc@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23156-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 52A3E421273
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 04:23:24PM -0700, Sean Christopherson wrote:
> From: Tycho Andersen <tycho@kernel.org>
> 
> In some configurations, the firmware does not support all VM types. The SEV
> firmware has an entry in the TCB_VERSION structure referred to as the
> Security Version Number in the SEV-SNP firmware specification and referred
> to as the "SPL" in SEV firmware release notes. The SEV firmware release
> notes say:
> 
>     On every SEV firmware release where a security mitigation has been
>     added, the SNP SPL gets increased by 1. This is to let users know that
>     it is important to update to this version.
> 
> The SEV firmware release that fixed CVE-2025-48514 by disabling SEV-ES
> support on vulnerable platforms has this SVN increased to reflect the fix.
> The SVN is platform-specific, as is the structure of TCB_VERSION.
> 
> Check CURRENT_TCB instead of REPORTED_TCB, since the firmware behaves with
> the CURRENT_TCB SVN level and will reject SEV-ES VMs accordingly.
> 
> Parse the SVN, and mask off the SEV_ES supported VM type from the list of
> supported types if it is above the per-platform threshold for the relevant
> platforms.
> 
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 70 ++++++++++++++++++++++++++++++++++++
>  include/linux/psp-sev.h      | 37 +++++++++++++++++++
>  2 files changed, 107 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

