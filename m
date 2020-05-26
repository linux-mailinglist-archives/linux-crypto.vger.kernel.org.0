Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD311C1AB3
	for <lists+linux-crypto@lfdr.de>; Fri,  1 May 2020 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEAQjV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 May 2020 12:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgEAQjV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 May 2020 12:39:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65AE20836;
        Fri,  1 May 2020 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588351160;
        bh=SXWlxqu7pgvATohHQ/UgvPXrCiKEtCLb5uj671OqN6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1sA58v3A2VW5QwXPr1klWxVUq6ttK7qLfrVCJCWzcCBgV+/OT6Qd8HgUJldZTc1G
         TDpYn7IYgPkNFP+I7IgI1om3TTRVigXKL4RHJFYLnJ75siOF9QAFTy2383zixoOq6e
         9BLqn8558zkddKMEGtDSlRXFY43VJqsHyTNDtY1o=
Date:   Fri, 1 May 2020 09:39:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: lib/sha256 - return void
Message-ID: <20200501163919.GA915@sol.localdomain>
References: <20200501071338.777352-1-ebiggers@kernel.org>
 <3ba66f39-e84f-43c6-a36b-17cd231f55db@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba66f39-e84f-43c6-a36b-17cd231f55db@c-s.fr>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 01, 2020 at 02:28:12PM +0200, Christophe Leroy wrote:
> > -extern int sha256_update(struct sha256_state *sctx, const u8 *input,
> > -			 unsigned int length);
> > -extern int sha256_final(struct sha256_state *sctx, u8 *hash);
> > +extern void sha256_update(struct sha256_state *sctx, const u8 *data,
> > +			  unsigned int len);
> > +extern void sha256_final(struct sha256_state *sctx, u8 *out);
> 
> The 'extern' keywork is useless in a function declaration. It should be
> removed, as recommended by 'checkpatch --strict'.

Sure I can do this, just keep in mind that a lot of kernel code still uses
'extern' (including the other function declarations in this file) and some
people still disagree about the preferred style.  That's why this warning hasn't
been enabled in 'checkpatch' by default.

- Eric
