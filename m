Return-Path: <linux-crypto+bounces-8171-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E79D5208
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Nov 2024 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9200C1F21519
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Nov 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3F1ABEB0;
	Thu, 21 Nov 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTTTOVg2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C761BC068
	for <linux-crypto@vger.kernel.org>; Thu, 21 Nov 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210927; cv=none; b=u/WXAQ+KN2bxurY5rwGovAzsnKOx0kIzGvtBGNPI7Q9Jd7S+b0Dr1Y+ljd4HcBMruOWDzROg+foVVPyoD7i9ZxAcbHFenVfuvTdijl40+xU4fqRjcWTpT1lOBoExSlvqVL4oiDa+ANm2u0nA2164Aczy45FxYWaOd7sBPidb5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210927; c=relaxed/simple;
	bh=oXFkZxIE0Oi6N4As1P6ZRkKGfXKz4LuGRbnSKRPtroI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sN5M2FGRNPtzMKUEeYdXZWPrVp93r2Pg1E9nTjxLmEYSUtkF28oZ2Jqdt1g25aUOSUAUZkGar7zftIy7Ve/GA+hht1Pb+kF9zIZnxZdofVbqyjOs7DJrUT0EczT1Zx/+g7HfCgajJirHAFd8j2FUm78CvW1uMx/XTuh4rz0/fuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTTTOVg2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3886f4cee2so2812359276.0
        for <linux-crypto@vger.kernel.org>; Thu, 21 Nov 2024 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732210925; x=1732815725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwZmK6L5i6ITrmKBxlG4fTIrOa1+fXmBLZLshHxbeSk=;
        b=DTTTOVg2Zmtmq5vjrf37u938uuvdroAJYWrbr5ckrZGGT8z5ssmL5Uz/V99BJR7I+z
         CVaHaOsnaZG47F3maNEjcXjFCJQ7X+tszK/HnfkZRaUqfPHjcJSTXQzRM8fkLktc80BX
         xDzspSiSMwN79WIlAv7tiqMLj06xCnoqzzsaAd7W9+uSfd90wp4BVRCq9l0Uy7OVzwl2
         TNbLQkdBSPE8AbaU9uQBzO8DOJvc3YghzhwCg7Mp77eRFtIlL3OO138aaXm+bcFH3nc+
         Z8FLn1cbMS/GA1QcHkFB0WHVj87H/XyTBgSqWhQQ/ktiJxCMb5usbW3VgAuqdYqI0nzi
         /pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210925; x=1732815725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwZmK6L5i6ITrmKBxlG4fTIrOa1+fXmBLZLshHxbeSk=;
        b=NSA1TPA/nHJAnnehOqVn4bE+8d7rIkGrSVVUCMIyn3FzlEDKxLwjLzD2BfMfvdF41C
         aPo/BwfZisdnZwGHBXRCoN01gxr3xcnI2QHjTu8bc/0a2mQnH1su3xFSqKbakgTN/Odu
         K1CkA5HrXlWmwj1OA3lSr7gbBOdfu4xcYvAwR9j+ibrH9w/YpZrSVuTPTa/waUT1eBAU
         1xwXNEX7DOTb7SBukNS2c6TPonlAL3547AEcVzIpFKhDBjANGHyIyEITwxJS4UmMpnp1
         l9Rf7EiqXzg1oo6qUEtm8qbZTC2KsNIW0zNGW1P+qWRspNW/HVmLTlK+/akulx6rw+nK
         3h9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy2uLFsq8v1LB7BB4kJJfP79/xPPFLXof36yNfVM56TNbrXqNaG/7ZiywjxI3g/TTFyVEKlkDp8OHXx5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdMfE3iGX1zJRl0JGrboS3K1QGIKEOtBLgD4gIIJYb9GpYtqs
	zBjBXOvznFyQwO12mdSZ7i82t8n9hyWgdu5mG3mHmzjzqnAcwz3GyLVWUsOwg6wi7oOyk/ETdAI
	oOg==
X-Google-Smtp-Source: AGHT+IHuElYuHVEN+YhgX7s/c+tdZRN29qEHHm04YMZ6V+lminlkgWG0Zi1wJVFCail9JOLgLm7Mgi69Xts=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:72f:b0:e26:3788:9ea2 with SMTP id
 3f1490d57ef6-e38f6c6a7a2mr83276.0.1732210924917; Thu, 21 Nov 2024 09:42:04
 -0800 (PST)
Date: Thu, 21 Nov 2024 09:42:03 -0800
In-Reply-To: <cb62940c-b2f7-0f3e-1710-61b92cc375e5@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f2b12d3c76b4e40a85da021ee2b7eaeda1dd69f0.1726602374.git.ashish.kalra@amd.com>
 <CAMkAt6o_963tc4fiS4AFaD6Zb3-LzPZiombaetjFp0GWHzTfBQ@mail.gmail.com>
 <3319bfba-4918-471e-9ddd-c8d08f03e1c4@amd.com> <ZwlMojz-z0gBxJfQ@google.com>
 <1e43dade-3fa7-4668-8fd8-01875ef91c2b@amd.com> <Zz5aZlDbKBr6oTMY@google.com>
 <d3e78d92-29f0-4f56-a1fe-f8131cbc2555@amd.com> <d3de477d-c9bc-40b9-b7db-d155e492981a@amd.com>
 <Zz9mIBdNpJUFpkXv@google.com> <cb62940c-b2f7-0f3e-1710-61b92cc375e5@amd.com>
Message-ID: <Zz9w67Ajxb-KQFZZ@google.com>
Subject: Re: [PATCH v2 3/3] x86/sev: Add SEV-SNP CipherTextHiding support
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>, Peter Gonda <pgonda@google.com>, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, herbert@gondor.apana.org.au, 
	x86@kernel.org, john.allen@amd.com, davem@davemloft.net, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 21, 2024, Tom Lendacky wrote:
> On 11/21/24 10:56, Sean Christopherson wrote:
> > On Thu, Nov 21, 2024, Ashish Kalra wrote:
> > Actually, IMO, the behavior of _sev_platform_init_locked() and pretty much all of
> > the APIs that invoke it are flawed, and make all of this way more confusing and
> > convoluted than it needs to be.
> > 
> > IIUC, SNP initialization is forced during probe purely because SNP can't be
> > initialized if VMs are running.  But the only in-tree user of SEV-XXX functionality
> > is KVM, and KVM depends on whatever this driver is called.  So forcing SNP
> > initialization because a hypervisor could be running legacy VMs make no sense.
> > Just require KVM to initialize SEV functionality if KVM wants to use SEV+.
> 
> When we say legacy VMs, that also means non-SEV VMs. So you can't have any
> VM running within a VMRUN instruction.

Yeah, I know.  But if KVM initializes the PSP SEV stuff when KVM is loaded, then
KVM can't possibly be running VMs of any kind.

> Or...
> 
> > 
> > 	/*
> > 	 * Legacy guests cannot be running while SNP_INIT(_EX) is executing,
> > 	 * so perform SEV-SNP initialization at probe time.
> > 	 */
> > 	rc = __sev_snp_init_locked(&args->error); 
> > 
> > Rather than automatically init SEV+ functionality, can we instead do something
> > like the (half-baked pseudo-patch) below?  I.e. delete all paths that implicitly
> > init the PSP, and force KVM to explicitly initialize the PSP if KVM wants to use
> > SEV+.  Then we can put the CipherText and SNP ASID params in KVM.
> 
> ... do you mean at module load time (based on the module parameters)? Or
> when the first SEV VM is run? I would think the latter, as the parameters
> are all true by default. If the latter, that would present a problem of
> having to ensure no VMs are active while performing the SNP_INIT.

kvm-amd.ko load time.

> > That would also allow (a) registering the SNP panic notifier if and only if SNP
> > is actually initailized and (b) shutting down SEV+ in the PSP when KVM is unloaded.
> > Arguably, the PSP should be shutdown when KVM is unloaded, irrespective of the
> > CipherText and SNP ASID knobs.  But with those knobs, it becomes even more desirable,
> > because it would allow userspace to reload *KVM* in order to change the CipherText
> > and SNP ASID module params.  I.e. doesn't require unloading the entire CCP driver.
> > 
> > If dropping the implicit initialization in some of the ioctls would break existing
> > userspace, then maybe we could add a module param (or Kconfig?) to preserve that
> > behavior?  I'm not familiar with what actually uses /dev/sev.
> > 
> > Side topic #1, sev_pci_init() is buggy.  It should destroy SEV if getting the
> > API version fails after a firmware update.
> 
> True, we'll look at doing a fix for that.
> 
> > 
> > Side topic #2, the version check is broken, as it returns "success" when
> > initialization quite obviously failed.
> 
> That is ok because you can still initialize SEV / SEV-ES support.

Right, but as I've complained elsewhere, KVM shouldn't think SNP is supported
when in reality firmware is effectively too old.

