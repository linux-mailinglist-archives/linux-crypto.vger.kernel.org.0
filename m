Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8854D49D
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jun 2022 00:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349032AbiFOWeY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Jun 2022 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiFOWeX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Jun 2022 18:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB0624ECE5
        for <linux-crypto@vger.kernel.org>; Wed, 15 Jun 2022 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655332461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3n2HbXmLj/4iA1gztBdMVQdKSzJcFH9E6p9we0kk/8k=;
        b=KcMpZn1bH+68xUpnMItyd3+6SduFj+hS74WwWmHaEij+PX1zUA/r32ACJpea4FA4kROMto
        bB3ZiqCZnW6WyGqlRKhcUByUivXmxh/2wl3YdcEUGe5/nTd4ntQoUBvRib9HosDMxyilqK
        R5xuFLLpj3w87jONntyflef8PFvRlOI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-6dykG-VpPDu_2Dzp8y3jmA-1; Wed, 15 Jun 2022 18:34:20 -0400
X-MC-Unique: 6dykG-VpPDu_2Dzp8y3jmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5A53802B94;
        Wed, 15 Jun 2022 22:34:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A67540C141F;
        Wed, 15 Jun 2022 22:34:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YqleGzRD4ax4msjL@gondor.apana.org.au>
References: <YqleGzRD4ax4msjL@gondor.apana.org.au> <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Simo Sorce <simo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] certs: Add FIPS self-test for signature verification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2689860.1655332458.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jun 2022 23:34:18 +0100
Message-ID: <2689861.1655332458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> It looks OK to me.

Can I put that down as a Reviewed-by?

Thanks,
David

