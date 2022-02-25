Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4A4C4A00
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Feb 2022 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiBYQDj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Feb 2022 11:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbiBYQDh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Feb 2022 11:03:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13CB8EB51;
        Fri, 25 Feb 2022 08:03:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB19E68AA6; Fri, 25 Feb 2022 17:03:01 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:03:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220225160300.GC13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
