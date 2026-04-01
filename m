Return-Path: <linux-crypto+bounces-22702-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCS1H3sxzWn0agYAu9opvQ
	(envelope-from <linux-crypto+bounces-22702-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 16:53:47 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7537C7BF
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62A2031225AC
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D27237C11C;
	Wed,  1 Apr 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAmC/7IJ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA57349AF6;
	Wed,  1 Apr 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054354; cv=none; b=GLOzEKPxS6jwkdmm3r3m0p1jW23GwVVbAE1QRTbNZFTOLknO5TPYdWfWNUUdfallXO5pQTU4MA8XKUga3PoXQp811r2otc6io3o+RWBj6owPqr+EO/Fm8O6zxRszZbC1MVrYrEYXMDTyUITP0Ak6T25MTp8WBJoOY6W2VlPw/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054354; c=relaxed/simple;
	bh=D2kaz8iyyaXaH6dV0VU7K2GATAPe6GOeUBXTa6PQcl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPqxG0LvJSA8v00hCQm7o2oaDyidQCVrP1uiuqqvpXvhV0QMau4x/s/HBHg0e47JAQLnBOaw8PDThQxZ9ynpaq9ILuFiycjl9e03zEwwdxrr23DA4f/FHoMeXAZ7AEGnUpt5lmZqU23FIKJROJUXAbekotrQp937Jw9ap9AMyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAmC/7IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1FFC19423;
	Wed,  1 Apr 2026 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775054354;
	bh=D2kaz8iyyaXaH6dV0VU7K2GATAPe6GOeUBXTa6PQcl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAmC/7IJTKq4152VhK0fAgtx9UwNLX3/1+gPhBZ1dr17BIlzRWJxd2TYdO36kU0nS
	 4Q5WTqfjYAdJMoZssVTOiRVNsF/5tKYPinci3l4FGOGFI1rBJiMsA/8+sRbxghuQNk
	 OcqX4EY+2cc9LRvrlHYG9lDRANOTvaEPegWAaj6cwpWEAt5na4Un1hgfFBw2yWd6ew
	 SsO6l+Qnlcr3GE/aA/AIG4OCxS0Ne/71egtENy9jQJ0w/LiX7vQXf2ij35/JuDbsVH
	 b4Zle8MMJV+joL6ZuMORCdsj0CPbgy3gOWyoOF+JwqXCfv6g7K3xCDbeeH2Y+OInNj
	 OTGp/jgPAkvdA==
Date: Wed, 1 Apr 2026 08:39:11 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kim Phillips <kim.phillips@amd.com>,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/2] crypto/ccp: skip SNP_INIT if preparation fails
Message-ID: <ac0uD9br0gnXwbFJ@tycho.pizza>
References: <20260401143552.3038979-1-tycho@kernel.org>
 <20260401143552.3038979-2-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401143552.3038979-2-tycho@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22702-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 73F7537C7BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 08:35:51AM -0600, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> During SNP_INIT, the firmware checks to see that the SNP enable bit is set
> on all CPUs. If snp_prepare() failed because not all CPUs were online,
> SNP_INIT will fail, so skip it.

Heh, you can ignore this one. Somehow it got sent out when I fixed the
capitalization in the commit message.

Tycho

