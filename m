Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6581534C22
	for <lists+linux-crypto@lfdr.de>; Thu, 26 May 2022 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiEZJBB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 May 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbiEZJBA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 May 2022 05:01:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD43A7E39
        for <linux-crypto@vger.kernel.org>; Thu, 26 May 2022 02:01:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 912DD68AA6; Thu, 26 May 2022 11:00:56 +0200 (CEST)
Date:   Thu, 26 May 2022 11:00:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Message-ID: <20220526090056.GA27050@lst.de>
References: <20220518112234.24264-1-hare@suse.de> <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 25, 2022 at 11:54:54AM +0200, Hannes Reinecke wrote:
> How do we proceed here?
> This has been lingering for quite some time now, without any real progress. 

As said it is a high priority for the upcoming merge window.  But we
also really need reviews from the crypto maintainers for the crypto
patches, without that I can't merge the series even if I'd like to.
