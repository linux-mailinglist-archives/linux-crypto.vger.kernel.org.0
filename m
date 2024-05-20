Return-Path: <linux-crypto+bounces-4267-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341728CA172
	for <lists+linux-crypto@lfdr.de>; Mon, 20 May 2024 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37DC280DE7
	for <lists+linux-crypto@lfdr.de>; Mon, 20 May 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136D137C3D;
	Mon, 20 May 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4RFvwV1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CD137C37
	for <linux-crypto@vger.kernel.org>; Mon, 20 May 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226527; cv=none; b=Wa7jvphJZAXI8J/P/TOv47ZUWtgXYLWILHmXJVP4egOYDRrf5O5389CV00o8JwhIYQFmWudMP5uNz/skjyXdACLA0fqi3syje8JKmbLjcviToIS5pn7v74Jf0lGjM1HhT1ZYEOyTq9S8MqsQKjl8MJ5sNcQAD2cnCShCBAa0RP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226527; c=relaxed/simple;
	bh=+Tf6AAgN6OqFWz2TdMAtSycAZVzTLTZBPFUHsMMEnjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UnCNw8Fri2jgHV4doPOlQirIUERQ3Vs7PYYtqwew0RIgmJZjpvq9ZUCfGzTDX+FH9iBla7bCw3MlgdBNcczdmYtaSe8O06WdQRTvrLsfU9Ll6F154+74tjgoUmz6VkRluneQrKBsGe9cHTV8V4VPb/h3LrKNmJKvcf13CXBznyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4RFvwV1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1edf507b9e4so135438175ad.1
        for <linux-crypto@vger.kernel.org>; Mon, 20 May 2024 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716226525; x=1716831325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaUIcbCxnT+V1tXho+s6VK2LQCpbrcFbVlZAjQNTw9w=;
        b=A4RFvwV11ah0NUHZkhQzSuK0Huh1Kaoup5Vx7rYkt6wzr5iJiUUEoYKhpKCqgpVF3i
         OVk0SVoT3Or2WHHZx/oUsscTB3iGIt43RRxZ8WELvdfdDKv60yHkCh/kWTOTQAXyz2Q1
         59n2ci8qjslUU5NHX1IcEiN4c8s+UjjVGQjoWdIm8tsMxXqqcIOan/LMTPmT7Um2FT1v
         BiTkdxo2/NOkPOLkCBNNvNKtdJNI6BGVZi/jFoNx7yrwYvlv+8f2s3pj2qlBBeQRfyGr
         LnlQE2J8HquqbVG8QX4M7OoJng2W9YyXlbRYogeBNNHUsp87NJKqp2V2XfFHIfQmn0Wp
         kCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226525; x=1716831325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaUIcbCxnT+V1tXho+s6VK2LQCpbrcFbVlZAjQNTw9w=;
        b=sB3sYk2FKCqzAPfDQQA/OfafHDBwtpe+UycHcEHfDeLNWPSRsKOem5ZpKeCw7+R44w
         jH+jGpQgH0qDHM5duHTeSFM+yLEQzDImKXW+WNP71vA7XeO3Lxm2Tac41FHNsLZVCUwv
         Q8Y9mqjnGAO9hDonRVcrCe6HQGr7ZGGeDcF7Uo6NgaY6If1QGkrysu0c37hj+YBaBezJ
         1VRBowwv+viJn9Em+EgbSF5HHjeq3UmAhJhnzLQWJy8CRxORs03ptU5yZCCb0VeB0iIs
         BXCJMIOY2tFULbCCy24c+IN6flTJsriUdAiPocD0mMpJAitVXp+4VwPrp7T96c4oYGAr
         Z62w==
X-Forwarded-Encrypted: i=1; AJvYcCXJRsP7yLFDGf8t0KCAsHX/PMsPnqiF6H70Du850Vhc/NN82HYlhYVWe64WhGo13k+eb3coi7ePUfCg2pnu40UV6lPW0kJBEqBZj+/+
X-Gm-Message-State: AOJu0Yz84ubGLMpGGUWhwOPaCYrCIKWnQQrLu4YRecmIhqjdbIO41DRS
	XwoLMINZP6osqmVN7YMfJGrbQc60NMcv40l0XoFGwPF11DmEfAKBEjDQi7J2yWx/QYiC81SDpgV
	g6A==
X-Google-Smtp-Source: AGHT+IF1taDRJctSSVr2IasIIziXIfKJNIigxZpYaoBlxwyY2AZlY80I/q2z0jdfLZJ5lT9JqTpQH1/QQSk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e749:b0:1f3:95f:ba6d with SMTP id
 d9443c01a7336-1f3095fc09fmr1015685ad.5.1716226525207; Mon, 20 May 2024
 10:35:25 -0700 (PDT)
Date: Mon, 20 May 2024 10:35:23 -0700
In-Reply-To: <41d8ba3a48d33de82baa67ef5ee88e5f8995aea8.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501085210.2213060-1-michael.roth@amd.com>
 <20240501085210.2213060-14-michael.roth@amd.com> <41d8ba3a48d33de82baa67ef5ee88e5f8995aea8.camel@intel.com>
Message-ID: <ZkuJ27DKOCkqogHn@google.com>
Subject: Re: [PATCH v15 13/20] KVM: SEV: Implement gmem hook for initializing
 private pages
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"tobin@ibm.com" <tobin@ibm.com>, "liam.merwick@oracle.com" <liam.merwick@oracle.com>, 
	"alpergun@google.com" <alpergun@google.com>, Tony Luck <tony.luck@intel.com>, 
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org" <luto@kernel.org>, 
	"ak@linux.intel.com" <ak@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"pgonda@google.com" <pgonda@google.com>, 
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "slp@redhat.com" <slp@redhat.com>, 
	"rientjes@google.com" <rientjes@google.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"nikunj.dadhania@amd.com" <nikunj.dadhania@amd.com>, Jorg Rodel <jroedel@suse.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "kirill@shutemov.name" <kirill@shutemov.name>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 20, 2024, Kai Huang wrote:
> On Wed, 2024-05-01 at 03:52 -0500, Michael Roth wrote:
> > This will handle the RMP table updates needed to put a page into a
> > private state before mapping it into an SEV-SNP guest.
> > 
> > 
> 
> [...]
> 
> > +int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)

...

> +Rick, Isaku,
> 
> I am wondering whether this can be done in the KVM page fault handler?

No, because the state of a pfn in the RMP is tied to the guest_memfd inode, not
to the file descriptor, i.e. not to an individual VM.  And the NPT page tables
are treated as ephemeral for SNP.

