Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8364BC673
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Feb 2022 08:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiBSHTW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 19 Feb 2022 02:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBSHTV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 19 Feb 2022 02:19:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74775F251;
        Fri, 18 Feb 2022 23:19:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77C1268BEB; Sat, 19 Feb 2022 08:19:00 +0100 (CET)
Date:   Sat, 19 Feb 2022 08:19:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, cl@linux.com,
        42.hyeyoo@gmail.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, David.Laight@ACULAB.COM,
        david@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, steffen.klassert@secunet.com,
        netdev@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org, michael@walle.cc,
        linux-i2c@vger.kernel.org, wsa@kernel.org
Subject: Re: [PATCH 22/22] mtd: rawnand: Use dma_alloc_noncoherent() for
 dma buffer
Message-ID: <20220219071900.GH26711@lst.de>
References: <20220219005221.634-1-bhe@redhat.com> <20220219005221.634-23-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219005221.634-23-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Feb 19, 2022 at 08:52:21AM +0800, Baoquan He wrote:
> Use dma_alloc_noncoherent() instead of directly allocating buffer
> from kmalloc with GFP_DMA. DMA API will try to allocate buffer
> depending on devices addressing limitation.

I think it would be better to still allocate the buffer at allocation
time and then just transfer ownership using dma_sync_single* in the I/O
path to avoid the GFP_ATOMIC allocation.
