Return-Path: <linux-crypto+bounces-1945-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B053484F843
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Feb 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6457A1F2B363
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Feb 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D686E2C1;
	Fri,  9 Feb 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4P2MYPi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02486BB5F
	for <linux-crypto@vger.kernel.org>; Fri,  9 Feb 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491597; cv=none; b=mClX2s+ASWN3KU9UN2ioVtdGpEiLtvHAx+Qh8oRP02vS5qDLqA4VlhuOqFLeKxGctbDRY6FDHb39lVjw0mzy4WeQwBTJxHpqqQdo25HNu45oMxzePyAZcypb7XHkAkGFqPk8GELcAghCcb3Cu9QXUGLKAzof9Y/Qj5/MYpCTtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491597; c=relaxed/simple;
	bh=Bug3A6ZbFfpsIwrLaT1Ik2CEiJjUByjmzkWryqfXzuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRNQMTPGV4L38cUu7PSg3Y52hDaPIGuiB+fAuLIjZjkmZxjna3zFNxVpSWc1QfrT6rKmSDuCRGxHhXrD6YNn2WCuqBXWXV/b3fLGa9ORw3xtpb0ueRu9pAARq6ZdeYIG7cK0JA/kAu54OxHG6gAWhfa0GdJEuRok3SGDIj+6vyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4P2MYPi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-297040eb356so1014439a91.0
        for <linux-crypto@vger.kernel.org>; Fri, 09 Feb 2024 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707491595; x=1708096395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgGQ0Ler+WUl/NFsNP3EozyAO4eJj17xtfp/FQdoBaA=;
        b=a4P2MYPii9U9dFha8muQhSlibGJcHS/HEg12A2KEcxd87hPxPxaZweI61ECvVY/IuK
         H99IVJxKwz9CLA/PutPa/WcXTKubDkuvaH5gJcaFtahk/lsxTIYFeoKRRJLw4k3Hjqz0
         S9g6yC1QlU8SFD/ga4KhjizWGcBCWTvNxpROC2dv/Cm6r5iQFGWaXo9MppRzx3y3Vf5L
         vX6kXt7PG43n6H2yptbJXu1+IqwGWmkKqCJgvGI8OTN6+TQIvtVoM/MyWyST7ILjhV8c
         w94xfiOtmyJxEWOYolOVEGp4bcmTXtBYlJWWxnFnypN/P8gw0b9IRoE5SJOz7m08pdsJ
         qVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707491595; x=1708096395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgGQ0Ler+WUl/NFsNP3EozyAO4eJj17xtfp/FQdoBaA=;
        b=ZOVfuhIb5TGH0+dWYqzJfGe4Dd88Arhq61UkoqSa9RPxGGFssAcQJB+xC61N/B+CH2
         2uqE3yPxXEBHxY/uP5tGz9chz1NHdescq1G71C4+g0yDMTrU92qdc/MUa13TTUOFFG97
         uZh8I078vN5TCn0J9po+WErILltrXSNGckmg67De0Z5dbM0I3b2aYQOCsMhm+QkN2qxv
         fIFGTlRm2IiO/zL6+qxJzu+8bUL8mSEPkZxGxYdsNAxFfYH71huCFGmIC2PlkIYSON+j
         tSF39UXUeSmbTK4NjO9rRepWjhDmEfyGu+12bEp2fjvwFaSrJ6ISAsizXBhTtfpDZ29w
         t1AA==
X-Forwarded-Encrypted: i=1; AJvYcCXfcoZaTHFxM3KZ0YI2lg38LO5RxnBm1/ysnp8UiwTp/8v9xY4gN5jckqkiMOc1nZwv7W80A6SvtTV4NnrgCxEIsbkHUh+HqrULbo6m
X-Gm-Message-State: AOJu0YyctbESVlfL6ikyiyNQrVypUTx3Irr/X5zxAhcdV5LJD3FhXfxd
	HVy7OkEV9F3qIClc/SwYyZzhXvOyUHgWRMZV4SAkYOgB+n+S0Op/uO3PnF0LzE3jgQdAekjQizM
	fFA==
X-Google-Smtp-Source: AGHT+IGnxQ9hUZq2I0deBQMbaG7FpVg+3DEJAeDot7uWCeqlyGYIqcr+64bku6EdOLuv7fFuPPSWAvWzMMw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2781:b0:296:aa24:8bc3 with SMTP id
 pw1-20020a17090b278100b00296aa248bc3mr23980pjb.5.1707491595319; Fri, 09 Feb
 2024 07:13:15 -0800 (PST)
Date: Fri, 9 Feb 2024 07:13:13 -0800
In-Reply-To: <84d62953-527d-4837-acf8-315391f4b225@arm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231016115028.996656-1-michael.roth@amd.com> <20231016115028.996656-5-michael.roth@amd.com>
 <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com> <ZcY2VRsRd03UQdF7@google.com> <84d62953-527d-4837-acf8-315391f4b225@arm.com>
Message-ID: <ZcZBCdTA2kBoSeL8@google.com>
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating memory
From: Sean Christopherson <seanjc@google.com>
To: Steven Price <steven.price@arm.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, "tabba@google.com" <tabba@google.com>, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pbonzini@redhat.com, isaku.yamahata@intel.com, ackerleytng@google.com, 
	vbabka@suse.cz, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	jroedel@suse.de, pankaj.gupta@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 09, 2024, Steven Price wrote:
> >> One option that I've considered is to implement a seperate CCA ioctl to
> >> notify KVM whether the memory should be mapped protected.
> > 
> > That's what KVM_SET_MEMORY_ATTRIBUTES+KVM_MEMORY_ATTRIBUTE_PRIVATE is for, no?
> 
> Sorry, I really didn't explain that well. Yes effectively this is the
> attribute flag, but there's corner cases for destruction of the VM. My
> thought was that if the VMM wanted to tear down part of the protected
> range (without making it shared) then a separate ioctl would be needed
> to notify KVM of the unmap.

No new uAPI should be needed, because the only scenario time a benign VMM should
do this is if the guest also knows the memory is being removed, in which case
PUNCH_HOLE will suffice.

> >> This 'solves' the problem nicely except for the case where the VMM
> >> deliberately punches holes in memory which the guest is using.
> > 
> > I don't see what problem there is to solve in this case.  PUNCH_HOLE is destructive,
> > so don't do that.
> 
> A well behaving VMM wouldn't PUNCH_HOLE when the guest is using it, but
> my concern here is a VMM which is trying to break the host. In this case
> either the PUNCH_HOLE needs to fail, or we actually need to recover the
> memory from the guest (effectively killing the guest in the process).

The latter.  IIRC, we talked about this exact case somewhere in the hour-long
rambling discussion on guest_memfd at PUCK[1].  And we've definitely discussed
this multiple times on-list, though I don't know that there is a single thread
that captures the entire plan.

The TL;DR is that gmem will invoke an arch hook for every "struct kvm_gmem"
instance that's attached to a given guest_memfd inode when a page is being fully
removed, i.e. when a page is being freed back to the normal memory pool.  Something
like this proposed SNP patch[2].

Mike, do have WIP patches you can share?

[1] https://drive.google.com/corp/drive/folders/116YTH1h9yBZmjqeJc03cV4_AhSe-VBkc?resourcekey=0-sOGeFEUi60-znJJmZBsTHQ
[2] https://lore.kernel.org/all/20231230172351.574091-30-michael.roth@amd.com

