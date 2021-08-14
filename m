Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676EE3EC3C8
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Aug 2021 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhHNQXY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 14 Aug 2021 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhHNQXY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 14 Aug 2021 12:23:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB22C061764;
        Sat, 14 Aug 2021 09:22:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1db900ce77af1d85349a0a.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:b900:ce77:af1d:8534:9a0a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F29E81EC0570;
        Sat, 14 Aug 2021 18:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628958168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/brh2LY3ZxgqLfUVFe3O+xJ1nWBytl741a1Y0kx+hZ8=;
        b=b8PJl1yU5zBqaA2/nWRJwh/Y1GFQpGr8U9i00b3uXAK038Jc2Z1POSCalShC5L7ljhom/o
        fCO7xRLVffdQF0GweIKtmdPFvymLaNoyum8xoYvWOvNqL9K4onwtHo7DlZohuGq0Zs3adS
        HqvSQaPyaR3nR1KdMycZfdDQxct9Lyg=
Date:   Sat, 14 Aug 2021 18:23:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephan Mueller <smueller@chronox.de>, sachinp@linux.vnet.ibm.com,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: DRBG - select SHA512
Message-ID: <YRft/tuKE6MjHhY7@zn.tnic>
References: <304ee0376383d9ceecddbfd216c035215bbff861.camel@chronox.de>
 <20210716081411.GA2062@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210716081411.GA2062@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 16, 2021 at 04:14:12PM +0800, Herbert Xu wrote:
> Stephan Mueller <smueller@chronox.de> wrote:
> > With the swtich to use HMAC(SHA-512) as the default DRBG type, the
> > configuration must now also select SHA-512.
> > 
> > Fixes: 9b7b94683a9b "crypto: DRBG - switch to HMAC SHA512 DRBG as default
> > DRBG"
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.com>
> > ---
> > crypto/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Patch applied.  Thanks.

Is that patch going to Linus anytime soon?

I still see it on latest rc5+:

DRBG: could not allocate digest TFM handle: hmac(sha512)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_hmac_sha512
------------[ cut here ]------------
alg: self-tests for drbg_nopr_hmac_sha512 (stdrng) failed (rc=-22)
WARNING: CPU: 3 PID: 76 at crypto/testmgr.c:5652 alg_test.part.0+0x132/0x3c0
Modules linked in:
CPU: 3 PID: 76 Comm: cryptomgr_test Not tainted 5.14.0-rc5+ #1
Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
RIP: 0010:alg_test.part.0+0x132/0x3c0
Code: c0 74 2e 80 3d 7f 61 ad 02 00 0f 85 c0 64 5f 00 44 89 c1 4c 89 f2 4c 89 ee 44 89 44 24 04 48 c7 c7 f8 0a 11 82 e8 8c 57 5e 00 <0f> 0b 44 8b 44 24 04 48 8b 84 24 98 00 00 00 65 48 2b 04 25 28 00
RSP: 0000:ffffc9000078fe38 EFLAGS: 00010292
RAX: 0000000000000042 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff810f520f RDI: ffffffff810f520f
RBP: 0000000000000053 R08: 0000000000000001 R09: 0000000000000001
R10: ffff888219df9000 R11: 3fffffffffffffff R12: 0000000000000053
R13: ffff888100c0ee00 R14: ffff888100c0ee80 R15: 00000000000014c0
FS:  0000000000000000(0000) GS:ffff888211f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000002412001 CR4: 00000000001706e0
Call Trace:
 ? lock_is_held_type+0xd5/0x130
 ? find_held_lock+0x2b/0x80
 ? preempt_count_sub+0x9b/0xd0
 ? crypto_acomp_scomp_free_ctx+0x30/0x30
 cryptomgr_test+0x27/0x50
 kthread+0x144/0x170
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
irq event stamp: 411
hardirqs last  enabled at (419): [<ffffffff810f6972>] console_unlock+0x332/0x570
hardirqs last disabled at (426): [<ffffffff810f6a1f>] console_unlock+0x3df/0x570
softirqs last  enabled at (234): [<ffffffff81c00329>] __do_softirq+0x329/0x496
softirqs last disabled at (151): [<ffffffff8108248d>] irq_exit_rcu+0xdd/0x130
---[ end trace edfdfd51982deb2d ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
