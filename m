Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168C8723D3E
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Jun 2023 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjFFJZo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Jun 2023 05:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFFJZo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Jun 2023 05:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122FE49
        for <linux-crypto@vger.kernel.org>; Tue,  6 Jun 2023 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686043505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FjaNZ7+M8ixgklXKY7vWvF9ET0ANZmsx5DhZNKDjLs=;
        b=Rx0hf1JA3jaTb8gqEvPVy1fCrVF5vPw/KsKAy6UFz8hV/18fOnSMK+gToHQp0img9kiHNK
        /iHKinTiOgmngz3IoEiEGnlZswpTIos5Y9f1suJBfd9rukTxSwkEYsn4+i+VdtJUgv6J2J
        PH4iqXPBgyHXMcyBq4CP35nsrxfvOGM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-THFJdaEpPA-GwDd5F7Zibg-1; Tue, 06 Jun 2023 05:25:01 -0400
X-MC-Unique: THFJdaEpPA-GwDd5F7Zibg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D65A1C068EC;
        Tue,  6 Jun 2023 09:25:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E5E492B00;
        Tue,  6 Jun 2023 09:24:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZH7xzYfwQoWZLUYa@gondor.apana.org.au>
References: <ZH7xzYfwQoWZLUYa@gondor.apana.org.au> <20230530141635.136968-1-dhowells@redhat.com> <20230530141635.136968-11-dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] crypto: af_alg/hash: Support MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1845448.1686043495.1@warthog.procyon.org.uk>
Date:   Tue, 06 Jun 2023 10:24:55 +0100
Message-ID: <1845449.1686043495@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > -	if (limit > sk->sk_sndbuf)
> > -		limit = sk->sk_sndbuf;
> > +	/* Don't limit to ALG_MAX_PAGES if the pages are all already pinned. */
> > +	if (!user_backed_iter(&msg->msg_iter))
> > +		max_pages = INT_MAX;

If the iov_iter is a kernel-backed type (BVEC, KVEC, XARRAY) then (a) all the
pages it refers to must already be pinned in memory and (b) the caller must
have limited it in some way (splice is limited by the pipe capacity, for
instance).  In which case, it seems pointless taking more than one pass of the
while loop if we can avoid it - at least from the point of view of memory
handling; granted there might be other criteria such as hogging crypto offload
hardware.

> > +	else
> > +		max_pages = min_t(size_t, max_pages,
> > +				  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
> 
> What's the purpose of relaxing this limit?

If the iov_iter is a user-backed type (IOVEC or UBUF) then it's not relaxed.
max_pages is ALG_MAX_PAGES here (actually, I should just move that here so
that it's clearer).

I am, however, applying the sk_sndbuf limit here also - there's no point
extracting more pages than we need to if ALG_MAX_PAGES of whole pages would
overrun the byte limit.

> Even if there is a reason for this shouldn't this be in a patch by itself?

I suppose I could do it as a follow-on patch; use ALG_MAX_PAGES and sk_sndbuf
before that as for user-backed iterators.

Actually, is it worth paying attention to sk_sndbuf for kernel-backed
iterators?

David

