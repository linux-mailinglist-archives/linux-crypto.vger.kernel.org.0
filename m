Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A0763B46
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Jul 2023 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjGZPj2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Jul 2023 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjGZPj1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Jul 2023 11:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447231B8
        for <linux-crypto@vger.kernel.org>; Wed, 26 Jul 2023 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690385918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vowpWuHV+0GHYhLidQCz/tJr8CGvlY+3r6OngHZa8oI=;
        b=F4jB+eCsG8eE0z4QUH8emVPdc8Bp1PKOsGoZ8JIUyCz1JMNziImveaqTzHbEy04lxRslWH
        lbJKWDlsxP6nJdZ1mC6FMQeYP1eUSADDCxwM/hE7uW4yZrNMhw+nrFCobQOfdKeVh9ljq2
        B2GJg7bodSZ8AeZiK2flw/M6oZAKm1o=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-PQeal5gdMN-WA7t_owBKyw-1; Wed, 26 Jul 2023 11:38:35 -0400
X-MC-Unique: PQeal5gdMN-WA7t_owBKyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AD912800E88;
        Wed, 26 Jul 2023 15:38:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE16145414B;
        Wed, 26 Jul 2023 15:38:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
To:     =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc:     dhowells@redhat.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Another regression in the af_alg series (s390x-specific)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15124.1690385912.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 16:38:32 +0100
Message-ID: <15125.1690385912@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Well, I can reproduce it fairly easily.  It seems to be:

	static inline void scatterwalk_start(struct scatter_walk *walk,
					     struct scatterlist *sg)
	{
		walk->sg = sg;
		walk->offset = sg->offset;  <----
	}

Presumably sg is rubbish.

Dump of assembler code for function gcm_walk_start:
   0x0000000000000038 <+0>:     jgnop   0x38 <gcm_walk_start>
   0x000000000000003e <+6>:     xc      8(64,%r2),8(%r2)
   0x0000000000000044 <+12>:    st      %r4,32(%r2)
   0x0000000000000048 <+16>:    stg     %r3,0(%r2)
   0x000000000000004e <+22>:    l       %r1,8(%r3)
   0x0000000000000052 <+26>:    st      %r1,8(%r2)
   0x0000000000000056 <+30>:    jg      0x56 <gcm_walk_start+30>

I'm don't know much about s390x assembly, but I'm guessing %r2 has "walk" and
%r3 has "sg".

AS:0000000116d50007 R3:0000000000000024 
Fault in home space mode while using kernel ASCE.
Failing address: 0026070200000000 TEID: 0026070200000803
Unable to handle kernel pointer dereference in virtual kernel address space

Krnl GPRS: 000000000000000c 0000038000000310 00000380002a7938 0026070200000000
           0000000000000000 0000000115593cb4 0000000000000000 0000000000000010
           0000000100000000 000000017e984690 000000000000000c 0000000000000000
           000003ffaf12cf98 0000000000000000 000003ff7fc536ba 00000380002a77e0

I'm not sure what to make of the 0026070200000000.

David

