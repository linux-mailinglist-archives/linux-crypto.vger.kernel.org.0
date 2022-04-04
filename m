Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E14F203D
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Apr 2022 01:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiDDX3o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Apr 2022 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiDDX3n (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Apr 2022 19:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5572B243;
        Mon,  4 Apr 2022 16:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA6D61741;
        Mon,  4 Apr 2022 23:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0764C2BBE4;
        Mon,  4 Apr 2022 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649114866;
        bh=BHAEMEC2Xzqxff2phETmd0GsUVbEpBkIHHNgkUNSvu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/Z+2E7DJBPTZr3ZFQvWbfIGaH5MFEGfzD1Svs3K+jCtjQ0qa5gdwj0tMJnzpMG0n
         VQMlvfCqT0wUSNuvHmbPdB6aZSvFauzCmrbs7X5Oqs91uR7ppmmUFwH+QW8W0P1Yrz
         b/Gpag0GZcTZCGCzJ8pOO88fFcpRujT+IAPFA5Ci5z9vPu0iIQFdy7kKkoqGoGvFXy
         MrXmfT7/RHSQSCeyTdRHarWXKsHpSkRjwW/SY3mtdu+JP6cPbVUYlIXOkZ7Ymwdjxr
         3QjuCofrGzFTwI3QhBncmRfsPV3B9FGhiTv8ASQ3ucOVzRS5tXJwzNSg/t3tNzQyl1
         AhcVHINzNL9cA==
Date:   Mon, 4 Apr 2022 16:27:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] random: mix build-time latent entropy into pool at
 init
Message-ID: <Ykt+8Fk9QP45XBmI@sol.localdomain>
References: <20220331150706.124075-1-Jason@zx2c4.com>
 <20220331152641.169301-1-Jason@zx2c4.com>
 <CACXcFm=vw6XCnO8peYH4V+sPR076O-Gav46r83+CZJ8oXM8iHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXcFm=vw6XCnO8peYH4V+sPR076O-Gav46r83+CZJ8oXM8iHA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 02, 2022 at 12:44:42PM +0800, Sandy Harris wrote:
> Yarrow is a good design, but it has limitations; in particular
> the Yarrow paper says the cryptographic strength is limited
> to the size of the hash context, 160 bits for their SHA-1 &
> 512 for our Blake.
> 
> 512 bits is more than enough for nearly all use cases, but
> we may have some where it is not. How many random bits
> are needed to generate a 4k-bit PGP key?
> 
> Will some users try to generate one-time pads from /dev/random?
> The OTP security proof requires truly random data as long as the
> message; with anything short of that the proof fails & you get
> a stream cipher.

All the data from /dev/{u,}random is generated by ChaCha20, which is a 256-bit
stream cipher.  We don't target, or need to target, more than 256-bit security.
So the entropy pool itself doesn't need to be more than 256 bits, provided that
it is implemented properly using a cryptographic hash function, which it now is.

- Eric
