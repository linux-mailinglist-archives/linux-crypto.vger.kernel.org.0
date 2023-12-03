Return-Path: <linux-crypto+bounces-511-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24363802643
	for <lists+linux-crypto@lfdr.de>; Sun,  3 Dec 2023 19:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1C71F20FC3
	for <lists+linux-crypto@lfdr.de>; Sun,  3 Dec 2023 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2217985
	for <lists+linux-crypto@lfdr.de>; Sun,  3 Dec 2023 18:33:27 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8615FC
	for <linux-crypto@vger.kernel.org>; Sun,  3 Dec 2023 08:52:36 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VxgSxzN_1701622352;
Received: from 30.27.64.151(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxgSxzN_1701622352)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 00:52:34 +0800
Message-ID: <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
Date: Mon, 4 Dec 2023 00:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Weird EROFS data corruption
To: Juhyung Park <qkrwngud825@gmail.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 Yann Collet <yann.collet.73@gmail.com>
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Juhyung,

On 2023/12/4 00:22, Juhyung Park wrote:
> (Cc'ing f2fs and crypto as I've noticed something similar with f2fs a
> while ago, which may mean that this is not specific to EROFS:
> https://lore.kernel.org/all/CAD14+f2nBZtLfLC6CwNjgCOuRRRjwzttp3D3iK4Of+1EEjK+cw@mail.gmail.com/
> )
> 
> Hi.
> 
> I'm encountering a very weird EROFS data corruption.
> 
> I noticed when I build an EROFS image for AOSP development, the device
> would randomly not boot from a certain build.
> After inspecting the log, I noticed that a file got corrupted.

Is it observed on your laptop (i7-1185G7), yes? or some other arm64
device?

> 
> After adding a hash check during the build flow, I noticed that EROFS
> would randomly read data wrong.
> 
> I now have a reliable method of reproducing the issue, but here's the
> funny/weird part: it's only happening on my laptop (i7-1185G7). This
> is not happening with my 128 cores buildfarm machine (Threadripper
> 3990X).> 
> I first suspected a hardware issue, but:
> a. The laptop had its motherboard replaced recently (due to a failing
> physical Type-C port).
> b. The laptop passes memory test (memtest86).
> c. This happens on all kernel versions from v5.4 to the latest v6.6
> including my personal custom builds and Canonical's official Ubuntu
> kernels.
> d. This happens on different host SSDs and file-system combinations.
> e. This only happens on LZ4. LZ4HC doesn't trigger the issue.
> f. This only happens when mounting the image natively by the kernel.
> Using fuse with erofsfuse is fine.

I think it's a weird issue with inplace decompression because you said
it depends on the hardware.  In addition, with your dataset sadly I
cannot reproduce on my local server (Xeon(R) CPU E5-2682 v4).

What is the difference between these two machines? just different CPU or
they have some other difference like different compliers?

Thanks,
Gao Xiang

