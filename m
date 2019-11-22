Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD6106E95
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfKVLCY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 06:02:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53202 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbfKVLCU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 06:02:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6hf-0004O4-1a; Fri, 22 Nov 2019 19:02:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6hc-0002cg-FO; Fri, 22 Nov 2019 19:02:16 +0800
Date:   Fri, 22 Nov 2019 19:02:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2 0/7] BLAKE2b cleanups
Message-ID: <20191122110216.4quahkxnkd3w67dg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573553665.git.dsterba@suse.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

David Sterba <dsterba@suse.com> wrote:
> Hi,
> 
> the patchset implements cleanups suggested by Eric in
> https://lore.kernel.org/linux-crypto/20191025051550.GA103313@sol.localdomain/
> 
> The diff is almost the same, split into pieces with some additional
> comments where it would help understand the simplifications. This is
> based on v7 of the BLAKE2b patchset.
> 
> The self-tests have been run for each patch on x86_64.
> 
> V2:
> - rename digest_setkey to blake2b_setkey, this is in patch 7 that also
>  does a rename, to avoid a too-trivial separate patch
> - minor withespace fix in patch 6
> 
> David Sterba (7):
>  crypto: blake2b: merge _final implementation to callback
>  crypto: blake2b: merge blake2 init to api callback
>  crypto: blake2b: simplify key init
>  crypto: blake2b: delete unused structs or members
>  crypto: blake2b: open code set last block helper
>  crypto: blake2b: merge _update to api callback
>  crypto: blake2b: rename tfm context and _setkey callback
> 
> crypto/blake2b_generic.c | 279 ++++++++++++---------------------------
> 1 file changed, 82 insertions(+), 197 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
