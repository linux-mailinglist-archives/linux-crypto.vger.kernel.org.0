Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3924CE3E
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHUGu1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 02:50:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgHUGu0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 02:50:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6486AB663;
        Fri, 21 Aug 2020 06:50:53 +0000 (UTC)
Date:   Fri, 21 Aug 2020 08:50:24 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ltp@lists.linux.it, linux-crypto@vger.kernel.org
Subject: Re: [LTP] [LTP PATCH 0/2] ltp: fix af_alg02 to specify control data
Message-ID: <20200821065024.GA11908@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820181918.404758-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820181918.404758-1-ebiggers@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Eric,

> It isn't clearly defined what happens if you read from an AF_ALG request
> socket without previously sending the control data to begin an
> encryption or decryption operation.  On some kernels the read will
> return 0, while on others it will block.

> Testing this corner case isn't the purpose of af_alg02; it just wants to
> try to encrypt a zero-length message.  So, change it to explicitly send
> a zero-length message with control data.

> This fixes the test failure reported at
> https://lkml.kernel.org/r/CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com

> Fixing the test in this way was also previously suggested at
> https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au

> Note, this patch doesn't change the fact that the read() still blocks on
> pre-4.14 kernels (which is a kernel bug), and thus the timeout logic in
> the test is still needed.

Thanks for the fix, merged!

Kind regards,
Petr
