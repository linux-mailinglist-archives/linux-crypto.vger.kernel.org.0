Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9445F7A90
	for <lists+linux-crypto@lfdr.de>; Fri,  7 Oct 2022 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJGPbA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 7 Oct 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJGPa7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 7 Oct 2022 11:30:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF88263A
        for <linux-crypto@vger.kernel.org>; Fri,  7 Oct 2022 08:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2285B82369
        for <linux-crypto@vger.kernel.org>; Fri,  7 Oct 2022 15:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAAAC433C1;
        Fri,  7 Oct 2022 15:30:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ac0lfxJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665156653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LvctwWh59x04o6QvggrjHW4fwKOToje16pPaZcjYBSc=;
        b=Ac0lfxJMtAn39FVFvj7IRdU9t/ZWzSWuuilczXKgyhS1H1FOMEw0VyKQRYA9uLSE2sGlp8
        yUx2Kt3GUYAX0SwIaD81ymxP8mTCWxf1o14/FQMzr/C88aAL33kFznh5yPHDj5qkI81JnL
        SMG7gJmCkFSnyF7pIQhB68MuF6wdwnc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f44fcbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Oct 2022 15:30:53 +0000 (UTC)
Date:   Fri, 7 Oct 2022 17:30:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, keescook@chromium.org,
        "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH] crypto: gcm - Provide minimal library implementation
Message-ID: <Y0BGLKzJ1tzuYgxf@zx2c4.com>
References: <20221007152105.3057788-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221007152105.3057788-1-ardb@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I haven't looked at this in depth yet, but one thing jumped out:

On Fri, Oct 07, 2022 at 05:21:05PM +0200, Ard Biesheuvel wrote:
> Implement a minimal library version of GCM based on the existing library
>  include/crypto/gcm.h |  61 ++
>  lib/crypto/gcm.c     | 714 ++++++++++++++++++++
> +void gcm_encrypt(const struct gcm_ctx *ctx, u8 *dst, const u8 *src,
> +		 int crypt_len, const u8 *assoc, int assoc_len,
> +		 const u8 iv[GCM_AES_IV_SIZE], u8 *authtag);

This should probably all be aes_gcm, aes-gcm.[ch] LIB_AES_GCM and so
forth, since GCM is something that works with different block ciphers.

Jason
