Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3440C20D63F
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2020 22:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgF2TSZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 15:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732016AbgF2TSY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 15:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+A60OaYSKQfoFPbCowvu2GaNu7uEQw80AdN699By4g=;
        b=JW1oBc1wFcVC+uf1flpa+W22pyWP04j2WVCtRQp8y8PXlJ7dZKE2IYW9VtXUI+S6ITmeq0
        3H3m9v23sl0+ZhUzDEXqNla+MKOwUzo6BVJ/4D2d/qClBlMrcdK5egQOnxOLqieBcAzWxv
        7EIYjmqo1ZgmebG0xeAX2UlgjiajXqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-R5iFLdihOc-M61CgFCZKcg-1; Mon, 29 Jun 2020 09:17:15 -0400
X-MC-Unique: R5iFLdihOc-M61CgFCZKcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3640518FF662;
        Mon, 29 Jun 2020 13:17:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 062BD2B47C;
        Mon, 29 Jun 2020 13:17:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05TDH9li012066;
        Mon, 29 Jun 2020 09:17:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05TDH8JV012062;
        Mon, 29 Jun 2020 09:17:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 29 Jun 2020 09:17:08 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Eric Biggers <ebiggers@kernel.org>
cc:     Mike Snitzer <msnitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, dm-devel@redhat.com,
        George Cherian <gcherian@marvell.com>,
        linux-crypto@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/3 v2] crypto: introduce the flag
 CRYPTO_ALG_ALLOCATES_MEMORY
In-Reply-To: <20200628200022.GE11197@sol.localdomain>
Message-ID: <alpine.LRH.2.02.2006290905340.11293@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com> <20200616173620.GA207319@gmail.com> <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626044534.GA2870@gondor.apana.org.au> <alpine.LRH.2.02.2006261109520.11899@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006261215480.13882@file01.intranet.prod.int.rdu2.redhat.com> <20200626164617.GA211634@gmail.com>
 <20200626170039.GB211634@gmail.com> <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com> <20200628200022.GE11197@sol.localdomain>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On Sun, 28 Jun 2020, Eric Biggers wrote:

> On Sun, Jun 28, 2020 at 03:07:49PM -0400, Mikulas Patocka wrote:
> > > 
> > > cryptd_create_skcipher(), cryptd_create_hash(), cryptd_create_aead(), and
> > > crypto_rfc4309_create() are also missing setting the mask.
> > > 
> > > pcrypt_create_aead() is missing both setting the mask and inheriting the flags.
> > 
> > I added CRYPTO_ALG_ALLOCATES_MEMORY there.
> 
> I don't see where the cryptd request processing functions allocate memory.
> 
> It seems that cryptd should just inherit the flag, like most other templates.
> 
> Likewise for pcrypt.
> 
> And also likewise for rfc4309.
> 
> Where are you seeing the memory allocations that would require
> CRYPTO_ALG_ALLOCATES_MEMORY to always be enabled for these?
> 
> - Eric

This was some misunderstanding. You said "cryptd_create_skcipher ... is 
missing both setting the mask and inheriting the flags.", so I understood 
it so that it should inherit CRYPTO_ALG_INHERITED_FLAGS and set 
CRYPTO_ALG_ALLOCATES_MEMORY unconditionally.

Mikulas

