Return-Path: <linux-crypto+bounces-3810-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868208AF8F8
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Apr 2024 23:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF6C1C220BC
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Apr 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873014388A;
	Tue, 23 Apr 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N64hL5x3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559020B3E;
	Tue, 23 Apr 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908188; cv=none; b=qRpV4cSreDPUruTIcr+3HXowL2KHmV3O7u3dUpw+Awpc6ZJbR8piFT1vsbmlQeRUGWjUZIZLX8taasuuIdz7t4qH26H4wkMfM+ai/R4SkpsPMuz2K0nQV6kuQrVsKAUG/gYQByfZaB8egkJnRAAE5zRw0BVXJPf0VTxkW1Ckq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908188; c=relaxed/simple;
	bh=kRU/X/dR1S85QfdEA379AVH9Oh6pbj0vz6VEE2p37BI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hR6EpbTInubxmtZ3DB+/xUA1x3NWkDhDJKlp6omyqQ4Y6Opn8sGAdHE4ykKsQiCkjimVtvJ/6MPQZxCfAfv5pp0NSbcLHa00MZCIz6tZ0pJGCeQbDDBT3Yvl8n+ZJxD5Y6X+xbdbGY7fMCzpGgnk97bsuC1vyhxnGNa+9cVIkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N64hL5x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA55C116B1;
	Tue, 23 Apr 2024 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713908188;
	bh=kRU/X/dR1S85QfdEA379AVH9Oh6pbj0vz6VEE2p37BI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=N64hL5x31SGXexnFBS8oye91xqW8qUmC4XtebvTle1CkwE2vK/QxH5HuvgZAj7qmf
	 mTemwU1pQsIGhRf/RXiaZpSH2CO0ckAqN9UJnW1p/okvqvH9D5+f+iVIIukrx09DK6
	 EaYnwb8ioGwRK/ewhLyw2d/1wxBNc3DOupbttAw6dJDaAxblnKQIDeDqZPzrRxlid7
	 3T/jwcpBOYDgbb9S/nCF0rlPn8LyPH39Dgx65fAt0yyFdCY7QS4q6goRSIafjB73HM
	 SrILFGr9P/iu+QHCpBrAuLs08JIOEBf+KTkfWkgm0jYMBca5mzyU2RCpHEj44Qhhtv
	 FZtYXCueW4bSg==
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 00:36:18 +0300
Message-Id: <D0RTQRSRDNAZ.LG7O2824KXOW@kernel.org>
Cc: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
 <linux-crypto@vger.kernel.org>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <jroedel@suse.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>,
 <ardb@kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>,
 <vkuznets@redhat.com>, <jmattson@google.com>, <luto@kernel.org>,
 <dave.hansen@linux.intel.com>, <slp@redhat.com>, <pgonda@google.com>,
 <peterz@infradead.org>, <srinivas.pandruvada@linux.intel.com>,
 <rientjes@google.com>, <dovmurik@linux.ibm.com>, <tobin@ibm.com>,
 <bp@alien8.de>, <vbabka@suse.cz>, <kirill@shutemov.name>,
 <ak@linux.intel.com>, <tony.luck@intel.com>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <alpergun@google.com>,
 <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>, <pankaj.gupta@amd.com>,
 <liam.merwick@oracle.com>
Subject: Re: [PATCH v14 28/22] [SQUASH] KVM: SEV: Provide support for
 SNP_EXTENDED_GUEST_REQUEST NAE event
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Michael Roth" <michael.roth@amd.com>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240421180122.1650812-1-michael.roth@amd.com>
 <20240423162144.1780159-1-michael.roth@amd.com>
 <20240423162144.1780159-6-michael.roth@amd.com>
In-Reply-To: <20240423162144.1780159-6-michael.roth@amd.com>

On Tue Apr 23, 2024 at 7:21 PM EEST, Michael Roth wrote:
> Ensure an error is returned if a non-SNP guest attempts to issue an
> Extended Guest Request. Also add input validation for RAX/RBX.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 2b30b3b0eec8..ff64ed8df301 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3297,6 +3297,11 @@ static int sev_es_validate_vmgexit(struct vcpu_svm=
 *svm)
>  			goto vmgexit_err;
>  		break;
>  	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
> +		if (!sev_snp_guest(vcpu->kvm))
> +			goto vmgexit_err;
> +		if (!kvm_ghcb_rax_is_valid(svm) ||
> +		    !kvm_ghcb_rbx_is_valid(svm))
> +			goto vmgexit_err;

Hmm... maybe I'm ignoring something but why this is not just:

	if (!sev_snp_guest(vcpu->kvm) ||
	    !kvm_ghcb_rax_is_valid(svm) ||
	    !kvm_ghcb_rbx_is_valid(svm)))

since they branch to the same location.

BR, Jarkko

