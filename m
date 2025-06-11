Return-Path: <linux-crypto+bounces-13816-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C4AD5B54
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Jun 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F5E17BBB8
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Jun 2025 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CC51E51FB;
	Wed, 11 Jun 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5XLWUhT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B21DEFC8
	for <linux-crypto@vger.kernel.org>; Wed, 11 Jun 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657612; cv=none; b=iUnHBDXy11cNECzBxGY21iwQ/iXUgR7YIWtfFfmlejBM2LrRjSdpLQLSDntgfzGAvdEVAUbpJwJ+OOYbbR4HyZE4RBD/Wm0xPMej1oo2xBR2+bCxZIswBqm2A42aOfXmNeI+kSLlfhFjcvQDL38uZlvZHMfhjYbGttD2vwr9ARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657612; c=relaxed/simple;
	bh=IiDuuTRA2M2+3sZDk9eXLa4R/goATGNp2RX+nSQAtoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nazaq6bqDlIPxBwYVY8/u0XarN+mCFLcSFM6TnRoTIaWp9BfnZn91M3jMcL9ov64GgDYNg1C50yFu5p1CwF4ZyxsdzoPmr4g2qwrnptE2MgEZYogDJrtXyENUR60Mf7EQy+TEPyrjhhOWChR5PeaPjT/UtnzymWbdYpjcD1nsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5XLWUhT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749657608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWl4ZRI+eTYAyrnyoF354Y0MWsELzMtlOfF1z/VHP4s=;
	b=I5XLWUhT3cXb8bjnNu4oWy/HyJZPqrAgV6M7Z8G50nGUohxALce9whOIRJKGzg7J2In3yU
	RT4jsMKH2bYcvMWQhHPKVQNBKyRXh9sXidfxqSu5rfQXHAtkqSKAekXaGLFDUt/UWN+3gu
	wlne3WhbS+isq7dM2ZlhyqGeWB1UCNE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-a3Y41qYbMxeA1fxzpmnU9g-1; Wed, 11 Jun 2025 12:00:07 -0400
X-MC-Unique: a3Y41qYbMxeA1fxzpmnU9g-1
X-Mimecast-MFC-AGG-ID: a3Y41qYbMxeA1fxzpmnU9g_1749657606
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddcfb7b921so23175ab.1
        for <linux-crypto@vger.kernel.org>; Wed, 11 Jun 2025 09:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657606; x=1750262406;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWl4ZRI+eTYAyrnyoF354Y0MWsELzMtlOfF1z/VHP4s=;
        b=kS//hBL65B9EOpUtjLmcABQfnAo7A5cW0oU1aOCfghT7AwlBe3aQSp5P0PyBXRCjm9
         mAV6gT163PWIdD27XV+WpxPr3YjsxLj9CDgOXyxwJ7uCoTcyWyAGMNM1f6N8kGvOYXug
         rMXdSA1PwO3LcjVhEMsuXY8hlinUK6AaW97bN3U481sba/8jBNKTDc6ArZdx/+HrjiIJ
         GGNT22K5zAb2WGR31SP7dhsjQijO6905lTKePUTuqz3iYQcMgc6yb0hCo0BIU4KS1DeY
         nPsQUMLvuNvS8L4ICMPGU5UQ02LjO/NbEfeLQ3jmRXaj94N6EkQZDxN0Gedgr/kkI1oj
         FIqg==
X-Forwarded-Encrypted: i=1; AJvYcCXoiKUyxfGLiEEnOQxbMz5+YqF/J+VxoHyAzqyuC8Y7r6UviTeKoFPqBUZJRrb4XsaR0gYtoWnncSw5+ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0oYYc8EU246UBj/brRAVie7atRuACS3zIQdSBMvAG8CVjG31
	AywH8XlofrZn+Js8t2TF/QmBpKTbl7YYDWMjLXODP34T4k474xtLF3Pm2XMgV6fcNS3iAuBKZW2
	cBKoIP5oPHaqDRPofBMPFEZaPydi2XHk4RWRwWx/9KXYxcFdeksDjOK3P8wtG+vchXg==
X-Gm-Gg: ASbGnct7//1lWxm3zcOBrI1OitKdoNyrOSp8/9zo+rTpunKWqIq1xGKSn577o5C8/ZD
	7zht8xS9YbKaUpVALRxqgEifVXnRe8uYrPb8LfEvsLJ96i0hdLWOz9e37PYM43RPzByP15uGZC1
	evCWDyuU4VQkwg6+0j1J4Ds4sCe6+FPSCnwssaWPjAZTx2d8WdfmFKUertG9YowprcZYfaZVzdd
	laOmHMqI/Jdakzjp9gvFb1T26yE01+hnTvi8D+1eDuZ6S1drvpO1SW2oA/mtXB7ucXKYDnPSOB7
	WUAwEQ2+x/GmuUfZyC/D/O/CEQ==
X-Received: by 2002:a05:6602:1606:b0:875:a894:8343 with SMTP id ca18e2360f4ac-875bc3cce9amr143173439f.1.1749657606425;
        Wed, 11 Jun 2025 09:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0gvvgK8mJjl2VAWjvOdFvpWcy2sB+ud7IQ/bdWVB5kYZmkmHpNEBhk66PrewRuy5I5Lbl+Q==
X-Received: by 2002:a05:6602:1606:b0:875:a894:8343 with SMTP id ca18e2360f4ac-875bc3cce9amr143171539f.1.1749657606047;
        Wed, 11 Jun 2025 09:00:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5012aaa23c6sm438160173.80.2025.06.11.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:00:04 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:00:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>, bhelgaas@google.com,
 mario.limonciello@amd.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu,
 linux-pci@vger.kernel.org, mike.ximing.chen@intel.com,
 ahsan.atta@intel.com, suman.kumar.chakraborty@intel.com,
 kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when
 initializing - Bug report
Message-ID: <20250611100002.1e14381a.alex.williamson@redhat.com>
In-Reply-To: <56d0e247-8095-4793-a5a9-0b5cf2565b88@kernel.org>
References: <aEl8J3kv6HAcAkUp@gcabiddu-mobl.ger.corp.intel.com>
	<56d0e247-8095-4793-a5a9-0b5cf2565b88@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 06:50:59 -0700
Mario Limonciello <superm1@kernel.org> wrote:

> On 6/11/2025 5:52 AM, Cabiddu, Giovanni wrote:
> > Hi Mario, Bjorn and Alex,
> > 
> > On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote:  
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> AMD BIOS team has root caused an issue that NVME storage failed to come
> >> back from suspend to a lack of a call to _REG when NVME device was probed.
> >>
> >> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> >> added support for calling _REG when transitioning D-states, but this only
> >> works if the device actually "transitions" D-states.
> >>
> >> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> >> devices") added support for runtime PM on PCI devices, but never actually
> >> 'explicitly' sets the device to D0.
> >>
> >> To make sure that devices are in D0 and that platform methods such as
> >> _REG are called, explicitly set all devices into D0 during initialization.
> >>
> >> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---  
> > Through a bisect, we identified that this patch, in v6.16-rc1,
> > introduces a regression on vfio-pci across all Intel QuickAssist (QAT)
> > devices. Specifically, the ioctl VFIO_GROUP_GET_DEVICE_FD call fails
> > with -EACCES.
> > 
> > Upon further investigation, the -EACCES appears to originate from the
> > rpm_resume() function, which is called by pm_runtime_resume_and_get()
> > within vfio_pci_core_enable(). Here is the exact call trace:
> > 
> >      drivers/base/power/runtime.c: rpm_resume()
> >      drivers/base/power/runtime.c: __pm_runtime_resume()
> >      include/linux/pm_runtime.h: pm_runtime_resume_and_get()
> >      drivers/vfio/pci/vfio_pci_core.c: vfio_pci_core_enable()
> >      drivers/vfio/pci/vfio_pci.c: vfio_pci_open_device()
> >      drivers/vfio/vfio_main.c: device->ops->open_device()
> >      drivers/vfio/vfio_main.c: vfio_df_device_first_open()
> >      drivers/vfio/vfio_main.c: vfio_df_open()
> >      drivers/vfio/group.c: vfio_df_group_open()
> >      drivers/vfio/group.c: vfio_device_open_file()
> >      drivers/vfio/group.c: vfio_group_ioctl_get_device_fd()
> >      drivers/vfio/group.c: vfio_group_fops_unl_ioctl(..., VFIO_GROUP_GET_DEVICE_FD, ...)
> > 
> > Is this a known issue that affects other devices? Is there any ongoing
> > discussion or fix in progress?
> > 
> > Thanks,
> >   
> 
> This is the first I've heard about an issue with that patch.
> 
> Does setting the VFIO parameter disable_idle_d3 help?
> 
> If so; this feels like an imbalance of runtime PM calls in the VFIO 
> stack that this patch exposed.
> 
> Alex, any ideas?

Does the device in question have a PM capability?  I note that
4d4c10f763d7 makes the sequence:

       pm_runtime_forbid(&dev->dev);
       pm_runtime_set_active(&dev->dev);
       pm_runtime_enable(&dev->dev);

Dependent on the presence of a PM capability.  The PM capability is
optional on SR-IOV VFs.  This feels like a bug in the original patch,
we should be able to use pm_runtime ops on a device without
specifically checking if the device supports PCI PM.

vfio-pci also has a somewhat unique sequence versus other drivers, we
don't call pci_enable_device() until the user opens the device, but we
want to put the device into low power before that occurs.  Historically
PCI-core left device in an unknown power state between driver uses, so
we've needed to manually move the device to D0 before calling
pm_runtime_allow() and pm_runtime_put() (see
vfio_pci_core_register_device()).  Possibly this is redundant now but
we're using pci_set_power_state() which shouldn't interact with
pm_runtime, so my initial guess is that we might be unbalanced because
this is a VF w/o a PM capability and we've missed the expected
pm_runtime initialization sequence.  Thanks,

Alex


