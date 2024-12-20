Return-Path: <linux-crypto+bounces-8669-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2699F8E31
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498B716C413
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394531A83FE;
	Fri, 20 Dec 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT5UAg49"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9E1A707D
	for <linux-crypto@vger.kernel.org>; Fri, 20 Dec 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684615; cv=none; b=By/+mhZW8nCeqKqjuTafHwhCK8tV9RsIitQRp1iGryFV57rCRyx8gdjii1Zf8deNc1HHqt3uL0R8lFXf8uc7PqNqVpjaWmJJbyrkHlmwoXn5e7oY/lKcDD/EBSIubnJzRMhlC7kriNmZFDaMmuS1eLNmoe8//l1wMb/xzRecXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684615; c=relaxed/simple;
	bh=rNRZpmgraUANDH2jZ6sUmUZn3g5rRxPqAWkAjC2sBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLmi+fcezfX0xUiowsX5CEiYVbzkxrbvXza59u4crIXwMIyPzHAG++f15T9bkq/5uEXhZDWt0UkIyYSiQtDmmgausJ+5P21G3j5R79mG/kyELOi+c9Ma0D/qoSAPP8cPr5ygcfSCKSnoBP8/fmQUESnQTOtBvVtL1W3aJ5/DZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT5UAg49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734684612;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MakEP/4RexV/dDE7ZdqDPKSl2XmZLeyzYBNKEexLSo=;
	b=VT5UAg49g63D2ahTVm9SZKGXpG+jwb+dbh9cHOsk9Ke3kJwsOT8WpAo97BTqR9VqRHS6fT
	F20l8PN+oNSk/1xmfjxOSOr11YQyKqxQxvMT/T4O5gZGxOwUiOaOwCBo7Pc2UlyeSVPDeO
	+CqfSpMxrNolyN889YtCeWocQk1mvhM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-cCkXZFqqM1SD8GX2JakT2Q-1; Fri,
 20 Dec 2024 03:50:07 -0500
X-MC-Unique: cCkXZFqqM1SD8GX2JakT2Q-1
X-Mimecast-MFC-AGG-ID: cCkXZFqqM1SD8GX2JakT2Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5CE61956072;
	Fri, 20 Dec 2024 08:50:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6885A1956096;
	Fri, 20 Dec 2024 08:49:57 +0000 (UTC)
Date: Fri, 20 Dec 2024 08:49:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, pbonzini@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	thomas.lendacky@amd.com, john.allen@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	michael.roth@amd.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v2 0/9] Move initializing SEV/SNP functionality to KVM
Message-ID: <Z2UvlXeG6Iqd9eFQ@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1734392473.git.ashish.kalra@amd.com>
 <CAAH4kHa2msL_gvk12h_qv9h2M43hVKQQaaYeEXV14=R3VtqsPg@mail.gmail.com>
 <cc27bfe2-de7c-4038-86e3-58da65f84e50@amd.com>
 <Z2HvJESqpc7Gd-dG@google.com>
 <57d43fae-ab5e-4686-9fed-82cd3c0e0a3c@amd.com>
 <Z2MeN9z69ul3oGiN@google.com>
 <3ef3f54c-c55f-482d-9c1f-0d40508e2002@amd.com>
 <d0ba5153-3d52-4481-82af-d5c7ee18725f@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0ba5153-3d52-4481-82af-d5c7ee18725f@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Dec 19, 2024 at 04:04:45PM -0600, Kalra, Ashish wrote:
> 
> 
> On 12/18/2024 7:11 PM, Kalra, Ashish wrote:
> > 
> > On 12/18/2024 1:10 PM, Sean Christopherson wrote:
> >> On Tue, Dec 17, 2024, Ashish Kalra wrote:
> >>> On 12/17/2024 3:37 PM, Sean Christopherson wrote:
> >>>> On Tue, Dec 17, 2024, Ashish Kalra wrote:
> >>>>> On 12/17/2024 10:00 AM, Dionna Amalie Glaze wrote:
> >>>>>> On Mon, Dec 16, 2024 at 3:57 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> >>>>>>>
> >>>>>>> From: Ashish Kalra <ashish.kalra@amd.com>
> >>>>>>
> >>>>>>> The on-demand SEV initialization support requires a fix in QEMU to
> >>>>>>> remove check for SEV initialization to be done prior to launching
> >>>>>>> SEV/SEV-ES VMs.
> >>>>>>> NOTE: With the above fix for QEMU, older QEMU versions will be broken
> >>>>>>> with respect to launching SEV/SEV-ES VMs with the newer kernel/KVM as
> >>>>>>> older QEMU versions require SEV initialization to be done before
> >>>>>>> launching SEV/SEV-ES VMs.
> >>>>>>>
> >>>>>>
> >>>>>> I don't think this is okay. I think you need to introduce a KVM
> >>>>>> capability to switch over to the new way of initializing SEV VMs and
> >>>>>> deprecate the old way so it doesn't need to be supported for any new
> >>>>>> additions to the interface.
> >>>>>>
> >>>>>
> >>>>> But that means KVM will need to support both mechanisms of doing SEV
> >>>>> initialization - during KVM module load time and the deferred/lazy
> >>>>> (on-demand) SEV INIT during VM launch.
> >>>>
> >>>> What's the QEMU change?  Dionna is right, we can't break userspace, but maybe
> >>>> there's an alternative to supporting both models.
> >>>
> >>> Here is the QEMU fix : (makes a SEV PLATFORM STATUS firmware call via PSP
> >>> driver ioctl to check if SEV is in INIT state)
> >>>  
> >>> diff --git a/target/i386/sev.c b/target/i386/sev.c
> >>> index 1a4eb1ada6..4fa8665395 100644
> >>> --- a/target/i386/sev.c
> >>> +++ b/target/i386/sev.c
> >>> @@ -1503,15 +1503,6 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >>>          }
> >>>      }
> >>>
> >>> -    if (sev_es_enabled() && !sev_snp_enabled()) {
> >>> -        if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> >>> -            error_setg(errp, "%s: guest policy requires SEV-ES, but "
> >>> -                         "host SEV-ES support unavailable",
> >>> -                         __func__);
> >>> -            return -1;
> >>> -        }
> >>> -    }
> >>
> >> Aside from breaking userspace, removing a sanity check is not a "fix".
> > 
> > Actually this sanity check is not really required, if SEV INIT is not done before 
> > launching a SEV/SEV-ES VM, then LAUNCH_START will fail with invalid platform state
> > error as below:
> > 
> > ...
> > qemu-system-x86_64: sev_launch_start: LAUNCH_START ret=1 fw_error=1 'Platform state is invalid'
> > ...
> > 
> > So we can safely remove this check without causing a SEV/SEV-ES VM to blow up or something.
> > 
> >>
> >> Can't we simply have the kernel do __sev_platform_init_locked() on-demand for
> >> SEV_PLATFORM_STATUS?  The goal with lazy initialization is defer initialization
> >> until it's necessary so that userspace can do firmware updates.  And it's quite
> >> clearly necessary in this case, so...
> > 
> > I don't think we want to do that, probably want to return "raw" status back to userspace,
> > if SEV INIT has not been done we probably need to return back that status, otherwise
> > it may break some other userspace tool.
> > 
> > Now, looking at this qemu check we will always have issues launching SEV/SEV-ES VMs
> > with SEV INIT on demand as this check enforces SEV INIT to be done before launching
> > the VMs. And then this causes issues with SEV firmware hotloading as the check 
> > enforces SEV INIT before launching VMs and once SEV INIT is done we can't do 
> > firmware  hotloading.
> > 
> > But, i believe there is another alternative approach : 
> > 
> > - PSP driver can call SEV Shutdown right before calling DLFW_EX and then do
> > a SEV INIT after successful DLFW_EX, in other words, we wrap DLFW_EX with 
> > SEV_SHUTDOWN prior to it and SEV INIT post it. This approach will also allow
> > us to do both SNP and SEV INIT at KVM module load time, there is no need to
> > do SEV INIT lazily or on demand before SEV/SEV-ES VM launch.
> > 
> > This approach should work without any changes in qemu and also allow 
> > SEV firmware hotloading without having any concerns about SEV INIT state.
> > 
> 
> And to add here that SEV Shutdown will succeed with active SEV and SNP guests. 
> 
> SEV Shutdown (internally) marks all SEV asids as invalid and decommission all
> SEV guests and does not affect SNP guests. 
> 
> So any active SEV guests will be implicitly shutdown and SNP guests will not be 
> affected after SEV Shutdown right before doing SEV firmware hotloading and
> calling DLFW_EX command. 
> 
> It should be fine to expect that there are no active SEV guests or any active
> SEV guests will be shutdown as part of SEV firmware hotloading while keeping 
> SNP guests running.

That's a pretty subtle distinction that I don't think host admins will
be likely to either learn about or remember. IMHO if there are active
SEV guests, the kernel should refuse the run the operation, rather
than kill running guests. The host admin must decide whether it is
appropriate to shutdown the guests in order to be able to run the
upgrade.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


