Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC657FBA3E
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2019 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKMUvh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Nov 2019 15:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMUvh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Nov 2019 15:51:37 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B6A20409;
        Wed, 13 Nov 2019 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573678297;
        bh=2XvNEMAmuFO661hf+gZ7B30cLQf52GcdiS/usLWKRBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbPf9PcbXqnalb7fN/0PK9rckbi692oIoJgQlY3ykI6ajmHpwN/Wm0T/s6qhT/ffA
         Fcbu+jxcHvC0Jm+GASQ/FaRvfyaiXkZGp4H9IviCkvrdF2Sc055h8VQwPC1SN2HBh5
         hMKowCwKYr3hb4+/SJrZd+t2noor/8NgqG66G+Hs=
Date:   Wed, 13 Nov 2019 12:51:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/7] BLAKE2b cleanups
Message-ID: <20191113205134.GJ221701@gmail.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        linux-crypto@vger.kernel.org
References: <cover.1573553665.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573553665.git.dsterba@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 12, 2019 at 11:20:23AM +0100, David Sterba wrote:
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
>   does a rename, to avoid a too-trivial separate patch
> - minor withespace fix in patch 6
> 
> David Sterba (7):
>   crypto: blake2b: merge _final implementation to callback
>   crypto: blake2b: merge blake2 init to api callback
>   crypto: blake2b: simplify key init
>   crypto: blake2b: delete unused structs or members
>   crypto: blake2b: open code set last block helper
>   crypto: blake2b: merge _update to api callback
>   crypto: blake2b: rename tfm context and _setkey callback
> 
>  crypto/blake2b_generic.c | 279 ++++++++++++---------------------------
>  1 file changed, 82 insertions(+), 197 deletions(-)

For the series:

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
