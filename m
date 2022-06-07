Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E788953FBCA
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jun 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiFGKqH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Jun 2022 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbiFGKpx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251BED72D
        for <linux-crypto@vger.kernel.org>; Tue,  7 Jun 2022 03:45:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78E4367373; Tue,  7 Jun 2022 12:45:42 +0200 (CEST)
Date:   Tue, 7 Jun 2022 12:45:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Message-ID: <20220607104541.GA25515@lst.de>
References: <20220518112234.24264-1-hare@suse.de> <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de> <20220526090056.GA27050@lst.de> <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de> <YpCis+8bv/EJqdlc@gondor.apana.org.au> <c1114e13-79cd-364c-b9d2-7a149a642919@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1114e13-79cd-364c-b9d2-7a149a642919@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 27, 2022 at 12:21:59PM +0200, Hannes Reinecke wrote:
> Christoph, you can pick either v12 or v13; the difference is just the check 
> for available hash and kpp functions. v12 has the dynamic version
> using the crypto helpers, v13 has the static version checking compile-time 
> configuration.
> Either way would work.

Please resend with these helpers included and any other fixups after rc2
is released.
