Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBA3EA495
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhHLMZq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 08:25:46 -0400
Received: from verein.lst.de ([213.95.11.211]:44106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233613AbhHLMZp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 08:25:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B43868B05; Thu, 12 Aug 2021 14:25:18 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:25:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 13/13] nvme: add non-standard ECDH and curve25517
 algorithms
Message-ID: <20210812122518.GA19050@lst.de>
References: <20210810124230.12161-1-hare@suse.de> <20210810124230.12161-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810124230.12161-14-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 10, 2021 at 02:42:30PM +0200, Hannes Reinecke wrote:
> TLS 1.3 specifies ECDH and curve25517 in addition to the FFDHE
> groups, and these are already implemented in the kernel.
> So add support for these non-standard groups for NVMe in-band
> authentication to validate the augmented challenge implementation.

If you think these are useful please add them to the standard.
