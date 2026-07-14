Return-Path: <linux-crypto+bounces-25971-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZeinAmCDVmp47wAAu9opvQ
	(envelope-from <linux-crypto+bounces-25971-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 20:43:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0B757EA8
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 20:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rNCK1ue6;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25971-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25971-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B03A3121436
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD641A919;
	Tue, 14 Jul 2026 18:42:03 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47141A92C
	for <linux-crypto@vger.kernel.org>; Tue, 14 Jul 2026 18:41:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054521; cv=none; b=B6giA1dNdWjMp2CnIEpUsF+gvb75DwjWJz7Q3Jj3CCmshUK7ZN/zPPMfCillUL6L3HOt08lZJKQY9bPLoMZkYV8RZ00tVIBWFDTn11FvF+woen+o/Fn37DrLAe0GYK+suLWHtS5QfvHFrxMlJbi+bZWnWMB6RD6nIREyMtqhNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054521; c=relaxed/simple;
	bh=PaQBkS90a4rPCv/dq+YRWwLuz5fATYts+TOoZzoPZj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dp2o7FXtyNrG+Iif8kPIC5Ngt+qhIsdLxqezFYr5hQe27dpIfGDExNSiRxXcdHIcLROLEoWSXQBFoplpHBmwWt8eIsPTdCpPUWLGDKjwHGAuP7dLF81uUjfJVN3bzDV3bj4ZHw3Q90Z0GtEZvdYwSbHX5KK3XxhsTohse7+Vkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNCK1ue6; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848860def2cso4842343b3a.2
        for <linux-crypto@vger.kernel.org>; Tue, 14 Jul 2026 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054517; x=1784659317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=rNCK1ue6708Vv/JHVtlGRjDGmBg7q7721OgtbVuL7BIIm4HkNGVJG1vYzTGM9MDe5z
         1OUpxXC0cOGbLG+Jzn1WMctTPA+1IfA1i77sPtNKFgOEjmuSt06dIks3incEeubf428m
         zSITgaZnP86MMavZ181GykbtaURT2oBdYUpnDPxXERg/EWu+mul+RMoxZll7Pjf9AEfo
         Vm/SyCa5dOmFVfkZOWFptvYLO38cjr/ZZBMFQdzRv6KzEGbecMfb8ryqEBDI8RTMYfZS
         mZjgu9H3fKEOon8Rr9RbYgQaJAGn8urwRUCOqbTNxWJAs0meHhowCK3PmlfZYDb8nqci
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054517; x=1784659317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=iHyerWcuEeSUsPE7bn1FXSsTs2gr83xM3uzj7Xs+mGAgHnZD0YHEw72+lG+2dRa/YZ
         nyi2i/vCkmeG8BaLtuBFmXLpynWCY1SbhZAmiuWtGckPM2mK7c9N/UHQKc1VNduOQBjN
         62GGSzdKmeRIBZnZz86BxLpMOefKuPX3TP9+MrS2pUtt1ubQ4RNX37Uee8hfYV4QIQTT
         YezLdF0IZQi/ZdvrGoVBLu2lnFuKzTuHcfzqg9ZEJ6IKjdaBPWSvPcUqrRbP3vmZMbrs
         w1CAq62G0M3bR3RUFTQspk2KvHz5AElrGyTw67L7BsbSv68NtV9ra3bKujeQb3S80g0b
         H2OA==
X-Forwarded-Encrypted: i=1; AHgh+RpvjP7Rd2jc8cCV2MGsoTT3MTFFhNnspgk+O0VbxKIEliffPekcotaYcUHWklBPVVLqkaFKbeRZY1ONCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+21Id3pTmqzjN2BqETjNDljD7wvr3WJAU0TGGbRqSO7R1ggw
	dKmRvyTPlJPbZZZvqXufl49+5vxLkXKeu9FExJpoEJXEjhHZZpLCygfBivju8nV7y6BPLVmRrS6
	Ng8I38Q==
X-Received: from pfmy4.prod.google.com ([2002:aa7:8044:0:b0:848:56a2:f6a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9289:b0:848:2ae4:d2ba
 with SMTP id d2e1a72fcca58-84889687b36mr12770821b3a.28.1784054516663; Tue, 14
 Jul 2026 11:41:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:01 -0700
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405419095.3137257.15966365152304045590.b4-ty@google.com>
Subject: Re: [PATCH v3 0/4] KVM: Miscellaneous SEV/SNP related fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Atish Patra <atish.patra@linux.dev>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:atish.patra@linux.dev,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-crypto@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-25971-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CC0B757EA8

On Tue, 02 Jun 2026 15:36:31 -0700, Atish Patra wrote:
> This series addresses a few issues found during code audit of the
> KVM SEV/SNP and CCP driver code. The fixes include a incorrect lock state
> and incomplete state handling during intra-host migration for SNP VMs.
> 
> To: Sean Christopherson <seanjc@google.com>
> To: Paolo Bonzini <pbonzini@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Tom Lendacky <thomas.lendacky@amd.com>
> To: Peter Gonda <pgonda@google.com>
> To: Brijesh Singh <brijesh.singh@amd.com>
> To: Youngjae Lee <youngjaelee@meta.com>
> To: Ashish Kalra <ashish.kalra@amd.com>
> To: Michael Roth <michael.roth@amd.com>
> To: John Allen <john.allen@amd.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: clm@meta.com
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> [...]

Applied patches 1 and 2 to kvm-x86 fixes, thanks!

[1/4] KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      https://github.com/kvm-x86/linux/commit/6ee414078823
[2/4] KVM: selftests: Verify SNP VMs are rejected from migration and mirroring
      https://github.com/kvm-x86/linux/commit/df371f2c6244

--
https://github.com/kvm-x86/linux/tree/next

