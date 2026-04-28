Return-Path: <linux-crypto+bounces-23487-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHxvLYzL8GkKYwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23487-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 17:00:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B948778C
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB3A300BD87
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBAC42E000;
	Tue, 28 Apr 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrBeho8q"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047142D879E;
	Tue, 28 Apr 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388200; cv=none; b=tSmZodgj2gAFV40Ur1ShldYgpq9XHqvKhTVMxplSksMCj7iTZpvupsdKwaUAkZ4d4htqFRYsa2DgaM9IO/26pA0htcAloX7JXnEKY40Qe4TQICZtkd+CjLle1k5e+MyUqlpJ51L6FTH6Zj47y8Yx0vGoHp5ryDtOAQdceWdapg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388200; c=relaxed/simple;
	bh=es2ktWByvCTEm8JAXWWSGRiL26Au+GmCbQrFIu1jECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1ArEACOXzUMjd9xhfbYXVcG7m818pIGJAKGvguKvkxNtkawzwahpHU4Cqx9+Bn9/dk1uQmK3El5pjFv+cqViqbfvx9vaZCt58bwESm9zT1e+SdUDGJIgZxJ6ZpJPm0/SYrqZzv0UtGC8PN+WBxcKWKF6mV0MbExf/19M5JC9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrBeho8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2881BC2BCAF;
	Tue, 28 Apr 2026 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777388198;
	bh=es2ktWByvCTEm8JAXWWSGRiL26Au+GmCbQrFIu1jECI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrBeho8qrQi/9XgDXvWHNrSclWLioISeFhDAoXfi9y9QY9B0DquqlIop9C0n7WACa
	 VTbkBSIeVd4KCKTCSJ/kotlFMY1hlFJlWluSsxApnV/wBvU1IJZRKS8xgXZv7ZSHYB
	 o2zRHrAvhFPu2VYUJmDBtAd0EMmUhGkwIj3s9tgU+4VjGZJKiIOnu0heq0p6IK8QSR
	 ZjxxikfxYnAx35alfrYzrY5e6FI0WQ9aB+pQkiar82kHbxbOtWSYwdfQHkkypfaXcY
	 tfy8wzjg138EA/IAMvP0BfnfVyNK7vbtCPQhsZITRKKkDZ57anXm4NtPt4uRDyHoJ8
	 FEvOJEYmEWqQw==
Date: Tue, 28 Apr 2026 08:56:33 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kim Phillips <kim.phillips@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: SEV: Add the kvm-amd.rapl_disable module
 parameter
Message-ID: <afDJZQHNi-qdcEEe@tycho.pizza>
References: <20260427204847.112899-1-tycho@kernel.org>
 <20260427204847.112899-4-tycho@kernel.org>
 <ae_TCofu4bHP_Ch-@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae_TCofu4bHP_Ch-@google.com>
X-Rspamd-Queue-Id: 627B948778C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23487-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tycho.pizza:mid]

On Mon, Apr 27, 2026 at 02:20:10PM -0700, Sean Christopherson wrote:
> On Mon, Apr 27, 2026, Tycho Andersen wrote:
> > From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> > 
> > Add a user-visible way to set the RAPL_DIS bit for SNP init.
> > 
> > Since setting RAPL_DIS affects the whole system, put the module parameter
> > in kvm_amd instead of in the CCP driver to hopefully make it more obvious
> > to admins.
> > 
> > Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
> >  arch/x86/kvm/svm/sev.c                          | 8 ++++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 4d0f545fb3ec..2b50eed8664c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3207,6 +3207,11 @@ Kernel parameters
> >  			max_snp_asid == min_sev_asid-1, will effectively make
> >  			SEV-ES unusable.
> >  
> > +	kvm-amd.rapl_disable=	[KVM,AMD] Whether to disable RAPL
> > +			(Running Average Power Limit) when initializing the SNP
> > +			firmware. This disables the counters for the entire system until an
> > +			SNP shutdown command is issued.
> 
> I'm pretty sure I said this earlier: KVM absolutely should not be able to disable
> RAPL for the entire system.  That needs to be a power management thing.

You definitely noted "not CCP", I don't think I quite understood what
that meant though:
https://lore.kernel.org/all/aZ86BZWi-GLiHvmt@tycho.pizza/

I'm a little worried that putting it in power management will generate
some weird dependencies, or weakref symbols that can't change things
if they are loaded independently of kvm_amd or something. But let me
see what I can come up with.

> KVM then needs to communicate (and enforce?) the policy to
> userspace.

KVM doesn't need to enforce anything, the SEV firmware will generate a
launch error for policy violation if it's not supported.

For communicating to userspace if it's not a kvm module parameter, one
option is to mask it off in sev_get_snp_supported_policy() if it was
initialized without the support. Then it'll be visible via
KVM_X86_SNP_POLICY_BITS.

Thanks,

Tycho

