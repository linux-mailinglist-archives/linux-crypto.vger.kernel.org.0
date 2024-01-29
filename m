Return-Path: <linux-crypto+bounces-1728-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A2840094
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jan 2024 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C2F1C22C2A
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jan 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF754BE4;
	Mon, 29 Jan 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7vLW0EM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750754BCB
	for <linux-crypto@vger.kernel.org>; Mon, 29 Jan 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518025; cv=none; b=nofDVYQV1iliI4u15/nt5/QBImsMYbFMR0dodCoCX5QuOYlgOuzOrt5FdCpW0DNKprBYPOtR0yi62+z9f13G5WGrb9wnFcRbR6H4A0noZoKyU4Upyp/wWYdxBbpoqzvK+ny5jDH0yuyL2d2MlOQ7QrSa+etFqFr1+C67kgHqgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518025; c=relaxed/simple;
	bh=wan+/40Gb1SyAcbTJJKFngUv3lxpedgrk4APeSN8y8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwqccM6VekbO7ZzZZaqA+H6MrD28vFLhCvLd/K9ItOaiHIeUJ6AVh9KTfy1bnImpBax0ryhKOMbJpe2Qo17Z8NyUrc817Yk1WxasJsDW9ig6DhQGNV3snKKL6DhHRCx39h9sD4L+cFlQsEIRXVkbykYz9lykoZn6EXOhNDR/fuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7vLW0EM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706518022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mHx98I53Z/x+UcJL2CQPXiS0oxn65PZb6tI9zRyZW1E=;
	b=A7vLW0EMiW7253LKygrZZ6Ja3qcH5oYF03v3i/QrwNXuIukm2d/SWZnJ9m7gksByAhkics
	QNa6REbMS0c2jNsrn9XwM8v1lUBiJCa4so49/JnopShFXcG8H6z5zeFoG5Avu3DPXWDmU9
	v1x8KZykaXUZJ6Vm5GLrNJI9szt3iic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-lABFD2k9NkmzTmdVmXoy6g-1; Mon, 29 Jan 2024 03:47:01 -0500
X-MC-Unique: lABFD2k9NkmzTmdVmXoy6g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33af036e53cso221181f8f.1
        for <linux-crypto@vger.kernel.org>; Mon, 29 Jan 2024 00:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706518020; x=1707122820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHx98I53Z/x+UcJL2CQPXiS0oxn65PZb6tI9zRyZW1E=;
        b=IhXBvre5nu0K33PF86buFE2N2miiDsIyW2YLLtm2RRepLzGYpcEFXwPJP5l9olwduh
         srdRf6RGoQPSbnQ+QSR90nshDAjgKhecUPLOe9x4xZeaTzqiLqRWTp3GV3xTIQmkYpgm
         9jWeERZBUpXioOI3A1BNKLlEdBuBXCDP3EDBfLO1EqUEhZe/NQVf90zNG+I04pju34i1
         dxOseL6p135amF/sF97X563BsJHLbZoP7DMDHCXcxSl307hGHmK80RRr4ZZCdGCkVkGK
         31mcv7xrA0CqnWHYPjetfyj//cGJ3sjGXf8FpaGL2RSBrKMCmzdznELuO3S8lDFBFyiy
         Qr8Q==
X-Gm-Message-State: AOJu0YzUatGb2V1qo0aMyoebPYgw05/RB/dRCzilrYqrA3Z29sj7GCNM
	2NKURpZOOVZRwjHmQjgc74hBXvcUymEHwvPQfa3NZqv40hyxq49Cbyc2ZWm7Qp94ZZ6+Rijx4wE
	00vDlR4Ch1vJD/aiYgrd7hmbG9Ld/fS7spzncVF2nXBBhc34RjH5t2hZ6uPMnyQ==
X-Received: by 2002:a05:6000:710:b0:33a:f399:5de3 with SMTP id bs16-20020a056000071000b0033af3995de3mr576171wrb.39.1706518020235;
        Mon, 29 Jan 2024 00:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwh3LLMODSTkeFeUAQPUxU73Kw1Df+2FZWQ7IIt52Rgmjhp3f7mup1S9zJyIE8dHYQ33LIqQ==
X-Received: by 2002:a05:6000:710:b0:33a:f399:5de3 with SMTP id bs16-20020a056000071000b0033af3995de3mr576145wrb.39.1706518019789;
        Mon, 29 Jan 2024 00:46:59 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b003394495566dsm7571525wrb.22.2024.01.29.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:46:59 -0800 (PST)
Date: Mon, 29 Jan 2024 03:46:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	llvm@lists.linux.dev, keescook@chromium.org,
	arei.gonglei@huawei.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <20240129034304-mutt-send-email-mst@kernel.org>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
 <20240126223554.GA1320833@dev-arch.thelio-3990X>
 <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>

On Fri, Jan 26, 2024 at 03:55:02PM -0800, Guenter Roeck wrote:
> On 1/26/24 14:35, Nathan Chancellor wrote:
> > (slimming up the CC list, I don't think this is too relevant to the
> > wider stable community)
> > 
> > On Fri, Jan 26, 2024 at 01:01:15PM -0800, Guenter Roeck wrote:
> > > On 1/26/24 12:34, Nathan Chancellor wrote:
> > > > On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
> > > > > On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> > > > > > > On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 5.10.209 release.
> > > > > > > > There are 286 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > > 
> > > > > > > > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > > 
> > > > > > > [ ... ]
> > > > > > > 
> > > > > > > > zhenwei pi <pizhenwei@bytedance.com>
> > > > > > > >         virtio-crypto: implement RSA algorithm
> > > > > > > > 
> > > > > > > 
> > > > > > > Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> > > > > > > It is quite beyond a bug fix. Also, unless I am really missing something,
> > > > > > > the series (or at least this patch) was not applied to v5.15.y, so we now
> > > > > > > have functionality in v5.10.y which is not in v5.15.y.
> > > > > > 
> > > > > > See the commit text, it was a dependency of a later fix and documented
> > > > > > as such.
> > > > > > 
> > > > > > Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> > > > > > gladly accepted :)
> > > > > > 
> > > > > 
> > > > > We reverted the entire series from the merge because it results in a build
> > > > > failure for us.
> > > > > 
> > > > > In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
> > > > > In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
> > > > > In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
> > > > > In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
> > > > > /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> > > > >                           __read_overflow2_field(q_size_field, size);
> > > > 
> > > > For what it's worth, this is likely self inflicted for chromeos-5.10,
> > > > which carries a revert of commit eaafc590053b ("fortify: Explicitly
> > > > disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
> > > > "fortify: Explicitly disable Clang support""). I don't see the series
> > > > that added proper support for clang to fortify in 5.18 that ended with
> > > > commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
> > > > branch, so this seems somewhat expected.
> > > > 
> > > 
> > > That explains that ;-). I don't mind if the patches stay in v5.10.y,
> > > we have them reverted anyway.
> > > 
> > > The revert was a pure process issue, as you may see when looking into
> > > commit c19861d34c003, so, yes, I agree that it is self-inflicted damage.
> > > Still, that doesn't explain why the problem exists in 5.18+.
> > > 
> > > > > I also see that upstream (starting with 6.1) when trying to build it with clang,
> > > > > so I guess it is one of those bug-for-bug compatibility things. I really have
> > > > > no idea what causes it, or why we don't see the problem when building
> > > > > chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
> > > > > merging 5.10.209 into it. Making things worse, the problem isn't _always_
> > > > > seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
> > > > > I have no idea what triggers the problem.
> > > > 
> > > > Have a .config that reproduces it on upstream? I have not personally
> > > > seen this warning in my build matrix nor has our continuous-integration
> > > > matrix (I don't see it in the warning output at the bottom but that
> > > > could have missed something for some reason) in 6.1:
> > > > 
> > > 
> > > The following command sequence reproduces the problem for me with all stable
> > > branches starting with 5.18.y (plus mainline).
> > > 
> > > rm -rf /tmp/crypto-build
> > > mkdir /tmp/crypto-build
> > > make -j CC=clang-15 mrproper >/dev/null 2>&1
> > > make -j O=/tmp/crypto-build CC=clang-15 allmodconfig >/dev/null 2>&1
> > > make -j O=/tmp/crypto-build W=1 CC=clang-15 drivers/crypto/virtio/virtio_crypto_akcipher_algs.o
> > > 
> > > I tried clang versions 14, 15, and 16. This is with my home system running
> > > Ubuntu 22.04, no ChromeOS or Google specifics/internals involved. For clang-15,
> > > the version is
> > > 
> > > Ubuntu clang version 15.0.7
> > > Target: x86_64-pc-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/bin
> > 
> > Okay interesting, this warning is hidden behind W=1, which our CI does
> > not test with. Looks like it has been that way since the introduction of
> > these checks in f68f2ff91512 ("fortify: Detect struct member overflows
> > in memcpy() at compile-time").
> > 
> 
> Interestingly the warning is seen in chromeos-5.10, without this patch,
> and without W=1. I guess that must have to do with the revert which is
> finally biting us.
> 
> > I think this is a legitimate warning though. It is complaining about the
> > second memcpy() in virtio_crypto_alg_akcipher_init_session():
> > 
> >    memcpy(&ctrl->u, para, sizeof(ctrl->u));
> > 
> > where ctrl is:
> > 
> >    struct virtio_crypto_op_ctrl_req {
> >            struct virtio_crypto_ctrl_header header;         /*     0    16 */
> >            union {
> >                    struct virtio_crypto_sym_create_session_req sym_create_session; /*    16    56 */
> >                    struct virtio_crypto_hash_create_session_req hash_create_session; /*    16    56 */
> >                    struct virtio_crypto_mac_create_session_req mac_create_session; /*    16    56 */
> >                    struct virtio_crypto_aead_create_session_req aead_create_session; /*    16    56 */
> >                    struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*    16    56 */
> >                    struct virtio_crypto_destroy_session_req destroy_session; /*    16    56 */
> >                    __u8               padding[56];          /*    16    56 */
> >            } u;                                             /*    16    56 */
> >            union {
> >                    struct virtio_crypto_sym_create_session_req sym_create_session; /*     0    56 */
> >                    struct virtio_crypto_hash_create_session_req hash_create_session; /*     0    56 */
> >                    struct virtio_crypto_mac_create_session_req mac_create_session; /*     0    56 */
> >                    struct virtio_crypto_aead_create_session_req aead_create_session; /*     0    56 */
> >                    struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*     0    56 */
> >                    struct virtio_crypto_destroy_session_req destroy_session; /*     0    56 */
> >                    __u8                       padding[56];          /*     0    56 */
> >            };
> > 
> > 
> >            /* size: 72, cachelines: 2, members: 2 */
> >            /* last cacheline: 8 bytes */
> >    };
> > 
> > (so size and p_size_field should be 56) and the type of the para
> > parameter in virtio_crypto_alg_akcipher_init_session() is 'void *' but
> > the para passed by reference to
> > virtio_crypto_alg_akcipher_init_session() in virtio_crypto_rsa_set_key()
> > has a type of 'struct virtio_crypto_akcipher_session_para':
> > 
> >    struct virtio_crypto_akcipher_session_para {
> >            __le32                     algo;                 /*     0     4 */
> >            __le32                     keytype;              /*     4     4 */
> >            __le32                     keylen;               /*     8     4 */
> >            union {
> >                    struct virtio_crypto_rsa_session_para rsa; /*    12     8 */
> >                    struct virtio_crypto_ecdsa_session_para ecdsa; /*    12     8 */
> >            } u;                                             /*    12     8 */
> >            union {
> >                    struct virtio_crypto_rsa_session_para rsa;       /*     0     8 */
> >                    struct virtio_crypto_ecdsa_session_para ecdsa;   /*     0     8 */
> >            };
> > 
> > 
> >            /* size: 20, cachelines: 1, members: 4 */
> >            /* last cacheline: 20 bytes */
> >    };
> > 
> > (so q_size_field would be 20 if clang were able to do inlining to see
> > through the 'void *'...?), which would result in the
> > 
> >    __compiletime_lessthan(q_size_field, size)
> > 
> > check succeeding and triggering the warning because 20 < 56, so it does
> > seem like there is an overread of the source buffer here? Adding the
> 
> Looks like it; I think either the passed 'para' should be of type
> virtio_crypto_akcipher_create_session_req() or it should only copy
> sizeof(struct virtio_crypto_akcipher_session_para) bytes.
> 
> Anyway, how did you find that ? Is there a magic trick to find the
> actual code causing the warning ? I am asking because we had seen
> similar warnings before, and it would help to know how to find the
> problematic code.
> 
> Thanks,
> Guenter



Cc: zhenwei pi <pizhenwei@bytedance.com>

Zhenwei I think you wrote most of the code here.
Can you take a look please?
Stack overflows are plus plus ungood.




> > maintainers of the driver and subsystem in question.
> > 
> > Cheers,
> > Nathan


