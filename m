Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B2A7DBC4C
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Oct 2023 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjJ3PDO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Oct 2023 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJ3PDN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Oct 2023 11:03:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B06D9
        for <linux-crypto@vger.kernel.org>; Mon, 30 Oct 2023 08:03:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FFBC433C8;
        Mon, 30 Oct 2023 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698678187;
        bh=yycAgp2NnUVNke1Fr3RlVfSDjyPhoJ5zWLXggicfNK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aishvX/EedZSTyi6JKlva9cX/u8ikxWV036JVb5w2p/pKZaPjrgFzGfI7/gqNM4HM
         qmgt1GaDsjHrPVST0yixiR2OBVUnsHRxNa21hhdMMGkNise/VJrPc6J92tUuaRhUGh
         KAVmIJuYdSEr6BRorUfavzUYM6G6kPa2gDADwcHijFYkZjdff+F4HfwCJ5SRc/xR5L
         2wOjDcrpSeaWOpb5e7L1+5vPfGwdenjHv2KtgkhgCC9lTgFbS3aTLTqzCcXWNB83+t
         FXp7pmyGZBooAyKZYiaZDxbgFyAUOJ4J0rehIA3TlynLMUY34jUTNCbgHmLWmuUSrh
         8H4YVT0bjtRjg==
Date:   Mon, 30 Oct 2023 09:03:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: use crypto_shash_tfm_digest()
Message-ID: <ZT_FqTrckF3TOc7U@kbusch-mbp.dhcp.thefacebook.com>
References: <20231029050040.154563-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029050040.154563-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Oct 28, 2023 at 10:00:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Simplify nvme_auth_augmented_challenge() by using
> crypto_shash_tfm_digest() instead of an alloc+init+update+final
> sequence.  This should also improve performance.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied to nvme-6.7.
