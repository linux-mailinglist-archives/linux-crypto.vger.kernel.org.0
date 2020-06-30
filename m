Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3720F67C
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgF3N7U (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jun 2020 09:59:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28284 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgF3N7S (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593525556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rx2Ty9dbcHfa4jUKO+LyJ3ZRouWvsmFljH2KKyJISoI=;
        b=HjXN2aZ6QCtDjQLoJvU/0udresBeP3T+kWG4kOU4yjjGG/DA3g44sz/tV8YK3NrW8P0jWl
        avgRCuu8Nta6rVSOxR1n8noIHKclo8XHpXhulJf+3AnMOUoopMZgMS8utEgZUYfbNFAb4B
        z8gnRDnGZeXjEySQKsPb+/duwEVdLeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-p2dogTSgNMutjGXsZe6rpA-1; Tue, 30 Jun 2020 09:59:10 -0400
X-MC-Unique: p2dogTSgNMutjGXsZe6rpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D17CD8C5A73;
        Tue, 30 Jun 2020 13:57:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C79547BEAF;
        Tue, 30 Jun 2020 13:57:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05UDvY55016787;
        Tue, 30 Jun 2020 09:57:34 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05UDvYBS016783;
        Tue, 30 Jun 2020 09:57:34 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 Jun 2020 09:57:34 -0400 (EDT)
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
In-Reply-To: <20200628195035.GD11197@sol.localdomain>
Message-ID: <alpine.LRH.2.02.2006300957020.15237@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com> <20200616173620.GA207319@gmail.com> <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626044534.GA2870@gondor.apana.org.au> <alpine.LRH.2.02.2006261109520.11899@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2006261215480.13882@file01.intranet.prod.int.rdu2.redhat.com> <20200626164617.GA211634@gmail.com>
 <20200626170039.GB211634@gmail.com> <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com> <20200628195035.GD11197@sol.localdomain>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On Sun, 28 Jun 2020, Eric Biggers wrote:

> On Sun, Jun 28, 2020 at 03:07:49PM -0400, Mikulas Patocka wrote:
> > 
> > > Also, "seqiv" instances can be created without CRYPTO_ALG_ALLOCATES_MEMORY set,
> > > despite seqiv_aead_encrypt() allocating memory.
> > > 
> 
> This comment wasn't addressed.
> 
> - Eric

I've sent version 4 of the patch that adds CRYPTO_ALG_ALLOCATES_MEMORY to 
seqiv.

Mikulas

