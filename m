Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9131E10DA19
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Nov 2019 20:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK2TZ6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Nov 2019 14:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfK2TZ6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Nov 2019 14:25:58 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC66207FA;
        Fri, 29 Nov 2019 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575055557;
        bh=kiF5SC2T+/XUiJjLkI//5lLepZeOcjPHT+qR5HYKPJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMh3KJQfRuKoSwE0phtng6SiN0ioGaHPOxGVUcSbjFHarP9NysiG0yuQMsYtR1Ksf
         F0SBljE8jYC/Dfhlp1cQsxjv5U90XlhSUN9cIZ+RpO0Pv9orgf8panCH9nBhiKAIhk
         GZTD9bDKTA/oSu6vkaxyH0MQfysrwxw86MXwtIDM=
Date:   Fri, 29 Nov 2019 11:25:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [v3 PATCH] crypto: pcrypt - Avoid deadlock by using per-instance
 padata queues
Message-ID: <20191129192556.GB706@sol.localdomain>
References: <20191119130556.dso2ni6qlks3lr23@gondor.apana.org.au>
 <20191119173732.GB819@sol.localdomain>
 <20191119185827.nerskpvddkcsih25@gondor.apana.org.au>
 <20191126053238.yxhtfbt5okcjycuy@ca-dmjordan1.us.oracle.com>
 <20191126075845.2v3woc3xqx2fxzqh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126075845.2v3woc3xqx2fxzqh@gondor.apana.org.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 26, 2019 at 03:58:45PM +0800, Herbert Xu wrote:
> On Tue, Nov 26, 2019 at 12:32:38AM -0500, Daniel Jordan wrote:
> > 
> > I think it's possible for a task in padata_do_parallel() racing with another in
> > padata_replace() to use a pd after free.  The synchronize_rcu() comes after the
> > pd_old->refcnt's are dec'd.
> 
> Thanks.  I've fixed this as well as the CPU mask issue you identified
> earlier.
> 
> ---8<---
> If the pcrypt template is used multiple times in an algorithm, then a
> deadlock occurs because all pcrypt instances share the same
> padata_instance, which completes requests in the order submitted.  That
> is, the inner pcrypt request waits for the outer pcrypt request while
> the outer request is already waiting for the inner.
> 
> This patch fixes this by allocating a set of queues for each pcrypt
> instance instead of using two global queues.  In order to maintain
> the existing user-space interface, the pinst structure remains global
> so any sysfs modifications will apply to every pcrypt instance.
> 
> Note that when an update occurs we have to allocate memory for
> every pcrypt instance.  Should one of the allocations fail we
> will abort the update without rolling back changes already made.
> 
> The new per-instance data structure is called padata_shell and is
> essentially a wrapper around parallel_data.
> 
> Reproducer:
> 
> 	#include <linux/if_alg.h>
> 	#include <sys/socket.h>
> 	#include <unistd.h>
> 
> 	int main()
> 	{
> 		struct sockaddr_alg addr = {
> 			.salg_type = "aead",
> 			.salg_name = "pcrypt(pcrypt(rfc4106-gcm-aesni))"
> 		};
> 		int algfd, reqfd;
> 		char buf[32] = { 0 };
> 
> 		algfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> 		bind(algfd, (void *)&addr, sizeof(addr));
> 		setsockopt(algfd, SOL_ALG, ALG_SET_KEY, buf, 20);
> 		reqfd = accept(algfd, 0, 0);
> 		write(reqfd, buf, 32);
> 		read(reqfd, buf, 16);
> 	}
> 
> Reported-by: syzbot+56c7151cad94eec37c521f0e47d2eee53f9361c4@syzkaller.appspotmail.com
> Fixes: 5068c7a883d1 ("crypto: pcrypt - Add pcrypt crypto parallelization wrapper")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 

Tested-by: Eric Biggers <ebiggers@kernel.org>
