Return-Path: <linux-crypto+bounces-9900-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E3A3BD5E
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B73D189C80C
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1ED1DF732;
	Wed, 19 Feb 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUKlXN2f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFD1C3C07
	for <linux-crypto@vger.kernel.org>; Wed, 19 Feb 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965595; cv=none; b=UGEbu1Sii0aTpah3M6R+6yQ7jsZBW3jSfmDE0gToFLRqgSmkObcKoq2/kzspQD5SnIh4/F7ul4ZlXKjrYNRtS4h/QFsg0YUKejX/Y40jddLfUYRREKaYTa0AY57JmsCcQXumhDzjvbte8LGj0BGPV8TPzAgqroWFqGKOH4tqOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965595; c=relaxed/simple;
	bh=W5u1FrXnUB5o2ySGCDV+bt2qhFs4I8vgtzJs7ugYWFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyKSOFWjKvEApxm7FdMzakDPhbDLUS7+GSSRUaYTI0s7vcyfV++cxd/VZ0yWY6OPHVnOg8vZCxLQKaHK8OVuvIqbfvgu0pHvj+fgb06m7z8jffH5UHHRjseO4pw3PF0Zv4ul4ZkgPFNtRWWH1YE2B3UZftIDs9U4ThcZoAyXnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUKlXN2f; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4be6599024cso1842460137.3
        for <linux-crypto@vger.kernel.org>; Wed, 19 Feb 2025 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739965592; x=1740570392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HAi+JPAWVvmwhTEypy4+thacQq13MfYR6lEe+X0Q8c=;
        b=bUKlXN2fmNTmjGisVZM7kb0RubGXqzQz3RJgwR6z3z5V7nmjVnypJqcPW2I+9yn2hK
         FdNc7WF5l/X6kF7GQHBeekKVh0J3Ipnj8AfX1eV/CEaE1fcf5n2BB3y49njcnvJvdJfw
         3CUV45bIP8+hdry0HG+4w0N41d016/rgx/xQEaXX9p8HFnSDTzJZLJpKWWg3CzZMd60c
         rxYqBJjnKz8ZQoF0lZoY5ImfnTttBgzfHSC83FTNmq1POT1YwhBIbdbnj6fIorYNulQZ
         0lZc6+jVUCITR3jPehKhpD038mlMoH7Yt4wbztthRyiiY5pubJWCAlDFxIezVRzt4UIZ
         nAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965592; x=1740570392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HAi+JPAWVvmwhTEypy4+thacQq13MfYR6lEe+X0Q8c=;
        b=JpN6Wm3gxP/XTTMYyb5pZK53oipS7bPS6utqBDFlD4emlMHTyucbOuahUu5FeiXyCO
         ADxXLpA1FioUmNOUllsiTzJHkb5GFVD+n7Bt4+CPt78mahf/Y+7GP0NjxPLJriqyttPl
         7xWgAjCLnU5ZyTIsohAGxKScUtn27GecSASBHqlKAw62xQWWBdEXEAhfadzbwP/75TAq
         YMx9shHP4+vCfbHbGr5SLQArnl+/hJoLSos+M+G/bHjiSAEV7EmocKvetRQ0kOiNgZnD
         kiRdFigaZcLxDOWf/hdlz05tkh2o8zknirvT9SxifMbSeQnIkIpTUtG2Q+U420lC4wjl
         zDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIsViDiVOvlMUNtMxueuhQ+oK8M+vMjrKGM/wZnO8CHINl8nzHT2bPdRH0i+xytlS423NbvtdolGakaUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gvYnpahILC03/IPRgIcqmaOxqvkOQSo5EQ0o0BfZeKWWEmCW
	KHYQO+A27fwK6nr9z53ELw3IRr2lOQc8/qZIZucwirJ40tbEwn+iX6RgycBx0TFgd1On4gtEuH5
	ob/vyQ6vs4lrVZAEqcRtCUURcRZ8FGKKpv588gA==
X-Gm-Gg: ASbGncvwPFPVPlc5VLO8YntY0G0LP1h+I2eQqCj9uw6oxOm0IjDl5jrC8VvG/+eP2OH
	J7TmmcaxmlbJESOYg++V6Bkeca8O9AYkhzCWe7rDx2EeqBGb9LMYbeYDolvICNrQplYfJ0dFITT
	4=
X-Google-Smtp-Source: AGHT+IEZMwel+bdv06rxq65I3rJQXcMsB1FE/5DSKjDmaNs3ziyhRih3YYHUPsKR/IZQx53GRqU+Jzw+0+WRrQS8RNc=
X-Received: by 2002:a05:6102:3f9e:b0:4bc:de7e:415d with SMTP id
 ada2fe7eead31-4be85c05531mr1674046137.13.1739965591759; Wed, 19 Feb 2025
 03:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206155234.095034647@linuxfoundation.org> <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com> <2025021739-jackpot-lip-09f9@gregkh>
In-Reply-To: <2025021739-jackpot-lip-09f9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Feb 2025 17:16:19 +0530
X-Gm-Features: AWEUYZlyd4o7hzsRTR-wDg8_BLL7BUQwlm0UHAZOQ22uI97jC6UQqnJWmLWSRIs
Message-ID: <CA+G9fYtJzD8+BkyBZEss9Vvv2f=8tJUcSyWDGjyOshj1D5hMyA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org, 
	Pankaj Raghav <p.raghav@samsung.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 17:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 17, 2025 at 05:00:43PM +0530, Naresh Kamboju wrote:
> > On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 6 Feb 2025 at 21:36, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 6.6.76 release.
> > > > There are 389 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sat, 08 Feb 2025 15:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc2.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > >
> > > There are three different regressions found and reporting here,
> > > We are working on bisecting and investigating these issues,
> >
> > We observed a kernel warning on QEMU-ARM64 and FVP while running the
> > newly added selftest: arm64: check_hugetlb_options. This issue appears
> > on 6.6.76 onward and 6.12.13 onward, as reported in the stable review [1].
> > However, the test case passes successfully on stable 6.13.
> >
> > The selftests: arm64: check_hugetlb_options test was introduced following
> > the recent upgrade of kselftest test sources to the stable 6.13 branch.
> > As you are aware, LKFT runs the latest kselftest sources (from stable
> > 6.13.x) on 6.12.x, 6.6.x, and older kernels for validation purposes.
> >
> > >From Anders' bisection results, we identified that the missing patch on
> > 6.12 is likely causing this regression:
> >
> > First fixed commit:
> > [25c17c4b55def92a01e3eecc9c775a6ee25ca20f]
> > hugetlb: arm64: add MTE support
> >
> > Could you confirm whether this patch is eligible for backporting to
> > 6.12 and 6.6 kernels?
> > If backporting is not an option, we will need to skip running this
> > test case on older kernels.
>
> The test case itself should properly "skip" if the feature is not
> present in the kernel.  Why not fix that up instead?

The reported test gets PASS at the end, but generates kernel warning
while running the test case (always reproducible) on 6.12 and 6.6.

The reported warning was not seen on stable 6.13.

# Test log:

# selftests: arm64: check_hugetlb_options
# 1..12
# ok 1 Check hugetlb memory with private mapping, sync error mode,
mmap memory and tag check off
# ok 2 Check hugetlb memory with private mapping, no error mode, mmap
memory and tag check off
# ok 3 Check hugetlb memory with private mapping, sync error mode,
mmap memory and tag check on
# ok 4 Check hugetlb memory with private mapping, sync error mode,
mmap/mprotect memory and tag check on
# ok 5 Check hugetlb memory with private mapping, async error mode,
mmap memory and tag check on
# ok 6 Check hugetlb memory with private mapping, async error mode,
mmap/mprotect memory and tag check on
# ok 7 Check clear PROT_MTE flags with private mapping, sync error
mode and mmap memory
# ok 8 Check clear PROT_MTE flags with private mapping and sync error
mode and mmap/mprotect memory
# ok 9 Check child hugetlb memory with private mapping, precise mode
and mmap memory
------------[ cut here ]------------
[   96.920028] WARNING: CPU: 1 PID: 3611 at
arch/arm64/mm/copypage.c:29 copy_highpage
(arch/arm64/include/asm/mte.h:87)
[   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
[   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
[   96.926956] Hardware name: linux,dummy-virt (DT)
[   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.929037] lr : copy_highpage
(arch/arm64/include/asm/alternative-macros.h:232
arch/arm64/include/asm/cpufeature.h:443
arch/arm64/include/asm/cpufeature.h:504
arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
[   96.929399] sp : ffff800088aa3ab0
[   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
[   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
[   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
[   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
[   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
[   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
[   96.939431] Call trace:
[   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
[   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
[   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
[   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
[   96.942344] handle_mm_fault (mm/memory.c:5330)
[   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
arch/arm64/mm/fault.c:626)
[   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
[   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:547)
[   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
[   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
[ 96.945383] ---[ end trace 0000000000000000 ]---#
ok 10 Check child hugetlb memory with private mapping, precise mode
and mmap memory
# ok 11 Check child hugetlb memory with private mapping, precise mode
and mmap/mprotect memory
# ok 12 Check child hugetlb memory with private mapping, precise mode
and mmap/mprotect memory
# # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: arm64: check_hugetlb_options

Links:
 - https://lore.kernel.org/all/CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com/

>
> thanks,
>
> greg k-h

- Naresh

