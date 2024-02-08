Return-Path: <linux-crypto+bounces-1914-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D5284E6C6
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Feb 2024 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E7F1C25E05
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Feb 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6F823DB;
	Thu,  8 Feb 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3WR4wMs"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419E7EF19
	for <linux-crypto@vger.kernel.org>; Thu,  8 Feb 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413362; cv=none; b=Na4z06mT+IPuiq0s6OYDpNq/DmxMF/23I6rM/qwE1dxKn8FJvrHbYvhqlqaZRPOYt3GJ7baN/oTMVi3ndtA+7g3lkZj13o7sIyE6zK0nMuMHlioKd+NrrjbUlj3ocRLPiaePdDeQsFbEY5QOCX9hvFC3RDh6ZZ5kJVNB6IAqvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413362; c=relaxed/simple;
	bh=AX7TeYinvud28ImFWW86bz254UkZVLDeLl1zuOjja7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o+Nj4XWuWyLwai7Ouk84yvuPjJ3wVwaOk8O07hmyTUsSJKnDi3lvWzobLdKoUMup5/kswpEZUJ0miKgAkDKTSScc8q+r/6v9uES+AkvmfRtTcDajlcPUR6W2LFNlPyhX/VnhtQt+Y5ZW7dtaf70BMgjUktlZBUaAJTdmbKW52MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3WR4wMs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso23393276.3
        for <linux-crypto@vger.kernel.org>; Thu, 08 Feb 2024 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707413358; x=1708018158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cgRpz8693x11vAqn90eHX9IMRr7lrwTkc2QUZSb++M=;
        b=N3WR4wMsGynGy2bWzK4Czp/sVabFsDvpY9DJucUs/M4UUC+ja8aepqcdTDSMjhpUH+
         38My9oEqYCDvIOnSXJijCdl5H+yvob4kxBizwpf0/ElD5KsH3Li6v04QISFiP/z9vylh
         zJRhOqC1RT1vmmL+BBuko3kn/48AvXfqphNCM0tey9bCBog9XKmz/thyiJH2/FlglutR
         xb+KW1jfu5gUAseyFrsl4PcIPytxHz2Bgzo5QkIkBgT3wPKEBRINVF8hlFlZ5bQpqbpC
         N8PhX4ngTCX0erzCmPR2Oh/yX4N6QE6/4/UJrhZGKq5KsO0wTgV3a3FfzQnXliHgrIv4
         Dnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413358; x=1708018158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cgRpz8693x11vAqn90eHX9IMRr7lrwTkc2QUZSb++M=;
        b=aCZ/XW8CETNlTOWaIQOy8yB4MKnWOMAOJhTe6U8SRjVZdZZQypIoJSKBNiWsg0eFCh
         DGJpC4f6z61Hw91fm5yvnFz1uIKogxW4WEUzc3A9I6cDfllAAUNUzb4t27+MgRwaK0pq
         WpLY8PA5fSmLo7SdEqxhiEsuBVK5fwdAnm2cyowhqSLdw0ScDx17dEq2/cptEn+xKKxG
         RxxFdnX1iov6Hf261/DoW/BeWdGJNYP3j5vaMMj0Gb3K84Gg7L1Vjm2rTvE9TBWxCUo/
         ScduOWYs1Ke90Dqan3nfng9Di/3UTP+4/bz+sUAd+xOHJ2WBt2iuVPuJy7Spqq3JkO43
         Sy6A==
X-Forwarded-Encrypted: i=1; AJvYcCUIA2gWTR94WQqzAr+3EPGQZfnknJZ9Bujur0wnIoUPgi5hgkgEqaAy2bMbZywlxpYl/pA/KthdyR8R3d981Zkx0wyxBzw65ir8JEl0
X-Gm-Message-State: AOJu0YwgO0szB5cctjLqYpQt39itnhgFBtfuPEq1GvY7Z/k6/USlM2Z0
	Bi2iGU6RbcXq1zrUMNPqQKYyVIhBLmjNqajxTNHUBBAWkGSTOBd3+07gD/O14rKtmoDdngHJemf
	Fkg==
X-Google-Smtp-Source: AGHT+IHvm3H6o6yo8+Vn1cBwz43f6GmzmcO3Z4xZiRVKXYRGzCH9lsIFsssSc9r8mHXp4gU3C6XX9+NehWg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:70b:b0:dc6:55ac:d08d with SMTP id
 k11-20020a056902070b00b00dc655acd08dmr22497ybt.5.1707413358591; Thu, 08 Feb
 2024 09:29:18 -0800 (PST)
Date: Thu, 8 Feb 2024 09:29:16 -0800
In-Reply-To: <761a3982-c7a1-40f1-92d8-5c08dad8383a@arm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-4-michael.roth@amd.com>
 <761a3982-c7a1-40f1-92d8-5c08dad8383a@arm.com>
Message-ID: <ZcUPbO2hmf9y1Zii@google.com>
Subject: Re: [PATCH RFC gmem v1 3/8] KVM: x86: Add gmem hook for initializing memory
From: Sean Christopherson <seanjc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com, 
	vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	jroedel@suse.de, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 08, 2024, Suzuki K Poulose wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 8c5c017ab4e9..c7f82c2f1bcf 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2403,9 +2403,19 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >   #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
> >   #ifdef CONFIG_KVM_PRIVATE_MEM
> > +int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > +		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep);
> >   int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >   			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
> >   #else
> > +static inline int __kvm_gmem_get_pfn(struct kvm *kvm,
> > +				     struct kvm_memory_slot *slot, gfn_t gfn,
> > +				     kvm_pfn_t *pfn, int *max_order)
> 
> Missing "bool prep" here ?
> 
> minor nit: Do we need to export both __kvm_gmem_get_pfn and kvm_gmem_get_pfn

Minor nit on the nit: s/export/expose.  My initial reaction was "we should *never*
export any of these" :-)

> ? I don't see anyone else using the former.
> 
> We could have :
> 
> #ifdef CONFIG_KVM_PRIVATE_MEM
> int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> 		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep);
> #else
> static inline int __kvm_gmem_get_pfn(struct kvm *kvm,
> 				    struct kvm_memory_slot *slot, gfn_t gfn,
> 				    kvm_pfn_t *pfn, int *max_order,
> 				    bool prep)
> {
> 	KVM_BUG_ON(1, kvm);
> 	return -EIO;
> }
> #endif
> 
> static inline int kvm_gmem_get_pfn(struct kvm *kvm,
> 				 struct kvm_memory_slot *slot, gfn_t gfn,
> 				kvm_pfn_t *pfn, int *max_order)
> {
> 	return __kvm_gmem_get_pfn(kvm, slot, gfn, pfn, max_order, true);
> }

I suspect all of this will be moot.  As discussed on the PUCK call[1] and in the
SNP enabling series[2], the plan is to have guest_memfd do (or at least initiate)
the actual copying into the backing pages, e.g. to guarantee that the pages are
in the correct state, that the appropriate locks are held, etc.

[1] https://drive.google.com/drive/folders/116YTH1h9yBZmjqeJc03cV4_AhSe-VBkc?resourcekey=0-sOGeFEUi60-znJJmZBsTHQ&usp=drive_link
[2] https://lore.kernel.org/all/ZcLuGxZ-w4fPmFxd@google.com

