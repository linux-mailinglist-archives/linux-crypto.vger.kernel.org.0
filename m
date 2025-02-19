Return-Path: <linux-crypto+bounces-9940-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5266A3CA24
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2025 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4A33A4D3C
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2025 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C223E22B;
	Wed, 19 Feb 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UUouOAth"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AD23C8CC
	for <linux-crypto@vger.kernel.org>; Wed, 19 Feb 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997433; cv=none; b=Uucf5V7t46X7tSxTW1I3hf2IC+67ZdgrkQVStnbEBHslpvu6de6dNr01T9VNM84p/5svyqt0XGs7O9yvw1TylkmLDVTMAnVxyg8WAegQESjljKStyeUv0slGufCtHxpYdRrr+LCgdItpLmRcQljDwOoelUbmXB/gNlCqJfY4weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997433; c=relaxed/simple;
	bh=yKjrUDxi3dkFLFUc55Tgy0oxRUHV39lyNPsgf4nGVB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpZb+92PMiwPPlc7cWXAQnMcSN3ESBBu9lgzYPV0cCIF0TvqiyG45k5pxKqmF03oAyWj48x81zD7T82A+E1cQ72loWfr0OC0Mc4mpgJviA3k4XTt5n4NJYcv1ILd36SqKryPuqhbPtJcvNuBCyIBX8mALvTupePctnkE9rwYuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UUouOAth; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471f7261f65so2978431cf.0
        for <linux-crypto@vger.kernel.org>; Wed, 19 Feb 2025 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739997430; x=1740602230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dy6Nbly0xz+HIc0W3Ixx9GKeMksXztaJI1bUpLuF4hY=;
        b=UUouOAthLz/ozXbUs4QeSLL9jDxYe5oDV+JimcS6LZVGO3hiHwPBhQRIweOqddPmzU
         2w7ExWc9G7r0Rqd+Qt6j6hRYzCPS0+mYHGb3FeHhn1F4051/Vm0OgeDPb/jMceQBTlfn
         wl/SOl+zbAWjNEbAh2Gfnw6e/1iyL5dhqGabNVEyPQ6BMU5mdiRlgoEw3OaFhbFaK+xn
         SCbZjjK6L2GrVkk6gfAhSSGw5lgdRof3qWHxnHFsNb4mju0hkGfvnYZML3vgKLxgGoea
         Dpzz/V9WuIqEKVzSXLcSouG8s9lk1tXxZKXzgnF2314jFHk/552g8VR+pkTjVUpkFIYr
         vi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997430; x=1740602230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy6Nbly0xz+HIc0W3Ixx9GKeMksXztaJI1bUpLuF4hY=;
        b=UGex6s0C5zwvfL5bJzsYrS4WzdDEtty2ly7dk6cF21UQ3H4HuWDv8GbSuPQX64bKio
         P37HibiVHQNvZmYmO8znYNDb398faLz/I6i/6TgXIeJQrtTSQjSL4xbD3QLDK5w4LOgl
         pqbgCOBYzvFPuONFZ7ECYO/OTPmGbPmha4f8A2LwjUCZ+tqWCYqxIMwfoNDfC90zMQMP
         OiNpQuSIdZr+FfLBvSzuzORXq3QsR3zN3+/3io40PhahLExDn5MNwnQP+EAyNvx84XtT
         e8KC1ej8VnRVJ8I9Ps2/GnDQQLuFHYoVHMSiWioU0VQIbvzpygIASKt8umMlW4U8kAmc
         s8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXSTV0HlqR++SopcxMBHi75Jj4DMVc1P6mrk0GlG03+cD/62EjpiMgkyWJGrfktXeqgUUJXI0Ze1aA5sYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrp2uPNMWHvBf3zhvQ+mF3tTardHtm4ToszcoemihqwFZHlmB
	pgs75vmh7sF4VUu45Fvm7IVxJKZvBEd0sD6LZBujUXy7NlqGIvCT2dER7L7sQWE=
X-Gm-Gg: ASbGnct9NJfcJ3MhO+Xrjuky3u/MCQbkSE5f2ALbiZlEvrEelif+xeBP2D0cDJj/xb+
	Wr2u7u7jyuT6/EnLEwGyh9VYolU8QPuZE3b9ytBdOfu8TpofKpftOPpI8m2TBUSH2Ei9FzV9ric
	VnFpy7N1e3SK5MoXiU79bg6JIOKMZuSlbI1LfzNu+GqRNTjdY8u4Zk7VxHpgP8BTrubQNsvA1DZ
	SIKgSnzSUkJEC5WzDZ/j5F+iqGbsA78Mxh2L0oeyZkZS9A4sLoGVU2mc8NMg9qZsIeHXzEDbw7g
	GWRpu2+97NQE1muE3Au2jlZSX9mJ/CE6bVMhFPp7UQFsCrW4T6VHjqjKLJHsF6gt
X-Google-Smtp-Source: AGHT+IGaUTz7ZR5mTsPN8ZqZQSlW5yPd5NDczzm4gie81ewyfyxQiY2YHx+YPUrCb2CsYgW0NA6WJA==
X-Received: by 2002:ac8:5fc1:0:b0:471:fa1c:3cbb with SMTP id d75a77b69052e-47215123e44mr12524791cf.22.1739997430338;
        Wed, 19 Feb 2025 12:37:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471feb82ecesm25021711cf.63.2025.02.19.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkqoe-00000000BJo-3Lm8;
	Wed, 19 Feb 2025 16:37:08 -0400
Date: Wed, 19 Feb 2025 16:37:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Roth <michael.roth@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250219203708.GO3696814@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
 <20250219202324.uq2kq27kmpmptbwx@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219202324.uq2kq27kmpmptbwx@amd.com>

On Wed, Feb 19, 2025 at 02:23:24PM -0600, Michael Roth wrote:
> Just for clarity: at least for normal/nested page table (but I'm
> assuming the same applies to IOMMU mappings), 1G mappings are
> handled similarly as 2MB mappings as far as RMP table checks are
> concerned: each 2MB range is checked individually as if it were
> a separate 2MB mapping:

Well, IIRC we are dealing with the AMDv1 IO page table here which
supports more sizes than 1G and we likely start to see things like 4M
mappings and the like. So maybe there is some issue if the above
special case really only applies to 1G and only 1G.

> But the point still stands for 4K RMP entries and 2MB mappings: a 2MB
> mapping either requires private page RMP entries to be 2MB, or in the
> case of 2MB mapping of shared pages, every page in the range must be
> shared according to the corresponding RMP entries.

 Is 4k RMP what people are running?

> I think, for the non-SEV-TIO use-case, it had more to do with inability
> to unmap a 4K range once a particular 4K page has been converted

Yes, we don't support unmap or resize. The entire theory of operation
has the IOPTEs cover the guest memory and remain static at VM boot
time. The RMP alone controls access and handles the static/private.

Assuming the host used 2M pages the IOPTEs in an AMDv1 table will be
sized around 2M,4M,8M just based around random luck.

So it sounds like you can get to a situation with a >=2M mapping in
the IOPTE but the guest has split it into private/shared at lower
granularity and the HW cannot handle this?

> from shared to private if it was originally installed via a 2MB IOPTE,
> since the guest could actively be DMA'ing to other shared pages in
> the 2M range (but we can be assured it is not DMA'ing to a particular 4K
> page it has converted to private), and the IOMMU doesn't (AFAIK) have
> a way to atomically split an existing 2MB IOPTE to avoid this. 

The iommu can split it (with SW help), I'm working on that
infrastructure right now..

So you will get a notification that the guest has made a
private/public split and the iommu page table can be atomically
restructured to put an IOPTE boundary at the split.

Then the HW will not see IOPTEs that exceed the shared/private
granularity of the VM.

Jason

