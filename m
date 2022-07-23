Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3757F06C
	for <lists+linux-crypto@lfdr.de>; Sat, 23 Jul 2022 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiGWQWx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 23 Jul 2022 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiGWQWu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 23 Jul 2022 12:22:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A26140EC
        for <linux-crypto@vger.kernel.org>; Sat, 23 Jul 2022 09:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65D80B80B8F
        for <linux-crypto@vger.kernel.org>; Sat, 23 Jul 2022 16:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F2CC341C0;
        Sat, 23 Jul 2022 16:22:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gHmbLuyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658593363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=seQzy75JrVdtoEI8fvcy884GFXRdPiCP5Hc5jYTFtuI=;
        b=gHmbLuyUVCb9wJ95QS2XKCVpSB8fIVKBFTA4X9smqVFJpV2eWVlFuycoPRTw+I22vAlvFh
        fOlarOHzITVHyQLQEpOSaUEMCXz0Lcde63tHT8q6UsPl7I8W4Xrv/SqJrDDnfl+bjCSIpW
        nIuBCF/6Rwyl2LQb3Ede5uAAmRTvxYo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 55564dd9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Jul 2022 16:22:42 +0000 (UTC)
Date:   Sat, 23 Jul 2022 18:22:39 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     gibc-alpha@sourceware.org,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Yann Droneaud <ydroneaud@opteya.com>, jann@thejh.net,
        Michael@phoronix.com
Cc:     linux-crypto@vger.kernel.org
Subject: arc4random - are you sure we want these?
Message-ID: <YtwgTySJyky0OcgG@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi glibc developers,

I learned about the addition of the arc4random functions in glibc this
morning, thanks to Phoronix. I wish somebody would have CC'd me into
those discussions before it got committed, but here we are.

I really wonder whether this is a good idea, whether this is something
that glibc wants, and whether it's a design worth committing to in the
long term.

Firstly, for what use cases does this actually help? As of recent
changes to the Linux kernels -- now backported all the way to 4.9! --
getrandom() and /dev/urandom are extremely fast and operate over per-cpu
states locklessly. Sure you avoid a syscall by doing that in userspace,
but does it really matter? Who exactly benefits from this?

Seen that way, it seems like a lot of complexity for nothing, and
complexity that will lead to bugs and various oversights eventually.

For example, the kernel reseeds itself when virtual machines fork using
an identifier passed to the kernel via ACPI. It also reseeds itself on
system resume, both from ordinary S3 sleep but also, more importantly,
from hibernation. And in general, being the arbiter of entropy, the
kernel is much better poised to determine when it makes sense to reseed.

Glibc, on the other hand, can employ some heuristics and make some
decisions -- on fork, after 16 MiB, and the like -- but in general these
are lacking, compared to the much wider array of information the kernel
has.

You miss out on this with arc4random, and if that information _is_ to be
exported to userspace somehow in the future, it would be awfully nice to
design the userspace interface alongside the kernel one.

For that reason, past discussion of having some random number generation
in userspace libcs has geared toward doing this in the vDSO, somehow,
where the kernel can be part and parcel of that effort.

Seen from this perspective, going with OpenBSD's older paradigm might be
rather limiting. Why not work together, between the kernel and libc, to
see if we can come up with something better, before settling on an
interface with semantics that are hard to walk back later?

As-is, it's hard to recommend that anybody really use these functions.
Just keep using getrandom(2), which has mostly favorable semantics.

Yes, I get it: it's fun to make a random number generator, and so lots
of projects figure out some way to make yet another one somewhere
somehow. But the tendency to do so feels like a weird computer tinkerer
disease rather something that has ever helped the overall ecosystem.

So I'm wondering: who actually needs this, and why? What's the
performance requirement like, and why is getrandom(2) insufficient? And
is this really the best approach to take? If this is something needed,
how would you feel about working together on a vDSO approach instead? Or
maybe nobody actually needs this in the first place?

And secondly, is there anyway that glibc can *not* do this, or has that
ship fully sailed, and I really missed out by not being part of that
discussion whenever it was happening?

Thanks,
Jason
