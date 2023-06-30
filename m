Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218EE743621
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jun 2023 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjF3Hq2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Jun 2023 03:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjF3HqZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Jun 2023 03:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE619B5;
        Fri, 30 Jun 2023 00:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C55E0616EC;
        Fri, 30 Jun 2023 07:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD814C433C8;
        Fri, 30 Jun 2023 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688111176;
        bh=FEyFCEh9AVWYVR5/3aJ4Wq2M5vu3WP7EgYsC+YbQcXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCPcaVZGkOE/wdNx6lzkn6tm0El2fEy6PYCEevjGu10ZsFRHzHJIovamvvMhvarN3
         dv6DXzwZsM9uCZ2/GuPATK9gFi3HWzOJUelhZHTHQ8+Z+3oMJUwElLTkaJqGfPzxcW
         6fvQDdIEcZtfLGz8R/j1OSkPb5WsYABSiiggqMs9rVIMtiovXuHO5DgWWQl5ugx+ey
         dHus8JVOF8QMBRnF/UbmYu6zS7ln3hk8MajwN9rnazSba/PhUILtr//l0u/gvph2Bp
         CGEk4FKGFsziIaregYiPbwu1BXpv7jMp+ixpzIe+TUNWDIwz/7IkAy0a8XMJq1O6tm
         +knllFsylLZdQ==
Date:   Fri, 30 Jun 2023 00:46:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     syzbot <syzbot+94a8c779c6b238870393@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Howells <dhowells@redhat.com>
Subject: Re: [syzbot] [ext4?] general protection fault in
 ext4_put_io_end_defer
Message-ID: <20230630074614.GC36542@sol.localdomain>
References: <0000000000002a0b1305feeae5db@google.com>
 <20230629035714.GJ8954@mit.edu>
 <20230630074111.GB36542@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630074111.GB36542@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 30, 2023 at 12:41:11AM -0700, Eric Biggers wrote:
> On Wed, Jun 28, 2023 at 11:57:14PM -0400, Theodore Ts'o wrote:
> > #syz set subsystems: crypto
> > 
> > On Sat, Jun 24, 2023 at 07:21:44PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=152e89f3280000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=94a8c779c6b238870393
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116af1eb280000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e22d2f280000
> > 
> > If you look at the reproducer, it's creating an AF_ALG (algorithm)
> > socket and messing with it.  This is easier to see in the syz
> > reproducer, but you can see exactly what it's doing in the C
> > reproducer above:
> > 
> > # https://syzkaller.appspot.com/bug?id=4ee7656695de92cbd5820111379ae0698af0f475
> > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > #{"threaded":true,"repeat":true,"procs":1,"slowdown":1,"sandbox":"none","sandbox_arg":0,"netdev":true,"binfmt_misc":true,"close_fds":true,"vhci":true,"ieee802154":true,"sysctl":true,"swap":true,"tmpdir":true}
> > r0 = socket$alg(0x26, 0x5, 0x0)
> > bind$alg(r0, &(0x7f0000000280)={0x26, 'hash\x00', 0x0, 0x0, 'sha3-256-generic\x00'}, 0x58)
> > r1 = accept4(r0, 0x0, 0x0, 0x0)
> > recvmmsg$unix(r1, &(0x7f0000003700)=[{{0x0, 0x700, 0x0}}], 0x600, 0x0, 0x0)
> > sendmsg$can_bcm(r1, &(0x7f0000000180)={0x0, 0x0, &(0x7f0000000140)={0x0}}, 0x400c800)
> > 
> > (0x26 is 38, or AF_ALG)
> > 
> > From looking at the stack trace, it looks like this is triggering a
> > coredump, which presumably is the ext4 write that triggers the GPF in
> > ext4_put_io_end_defer.  But given that the syz and C reproducer isn't
> > doing anything ext4 related at all, and it's purely trying to use the
> > AF_ALG socket to calculate SHA3 in the kernel (and the greek chorus
> > cries out, "WHY?"[1]), I'm going to send this over to the crypto folks to
> > investigate.
> 
> Just a couple weeks ago, commit c662b043cdca ("crypto: af_alg/hash: Support
> MSG_SPLICE_PAGES") had many syzbot reports against it.  This particular report
> is against next-20230616 which didn't include the fix commit b6d972f68983
> ("crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)").  So there's a
> high chance this report is no longer valid.  I'll go ahead and invalidate it:
> 
> #syz invalid
> 
> > 
> > Cheers,
> > 
> > 					- Ted
> > 
> > [1] TIL that AF_ALG exists.  Inquiring minds want to know:
> >    * Why do we expose the AF_ALG userspace interface?
> >    * Who uses it?
> >    * Why do they use it?
> >    * Is there a CONFIG option to disable it in the name of decreasing
> >      the attack surface of the kernel?
> >    * If not, should we add one?  :-)
> 
> AF_ALG has existed since 2010.  My understanding that its original purpose was
> to expose hardware crypto accelerators to userspace.  Unfortunately, support for
> exposing *any* crypto algorithm was included as well, which IMO was a mistake.
> 
> There are quite a few different userspace programs that use AF_ALG purely to get
> at the CPU-based algorithm implementations, without any sort of intention to use
> hardware crypto accelerator.  Probably because it seemed "easy".  Or "better"
> because everything in the kernel is better, right?
> 
> It's controlled by the CONFIG_CRYPTO_USER_API_* options, with the hash support
> in particular controlled by CONFIG_CRYPTO_USER_API_HASH.  Though good luck
> disabling it on most systems, as systemd depends on it...
> 

Actually it turns out systemd has finally seen the light:
https://github.com/systemd/systemd/commit/2c3794f4228162c9bfd9e10886590d9f5b1920d7

- Eric
