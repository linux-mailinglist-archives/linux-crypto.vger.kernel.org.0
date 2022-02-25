Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DDB4C49F6
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Feb 2022 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiBYQCc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Feb 2022 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiBYQCb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Feb 2022 11:02:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CB1F1255;
        Fri, 25 Feb 2022 08:01:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CA7268AA6; Fri, 25 Feb 2022 17:01:55 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:01:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 01/10] block: support pi with extended metadata
Message-ID: <20220225160155.GA13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
