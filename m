Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE8580712
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Jul 2022 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiGYWHQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 25 Jul 2022 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGYWHP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 25 Jul 2022 18:07:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B45240AA;
        Mon, 25 Jul 2022 15:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38617B810A4;
        Mon, 25 Jul 2022 22:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75246C341C6;
        Mon, 25 Jul 2022 22:07:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DL2uBo4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658786828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JiBsNFVRjeNVnFt4XoHyRMML0uxPgR4I33Zphb+N4MU=;
        b=DL2uBo4hCrI+tRNDNVp9cEcuPFAwqTPG9UIiwpEAofxEU49vTrJkA8+sbd38Nx2Tb8il/M
        ka0Ysvwd5XHCZ28j3lgAyTj8DtUoLbS1gIzHvW0tY6S79C26mfwxspTXvPT3Ops1VaCUSf
        ZmMmiRnu5sps1PHICYrrvSakBmlpJKA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df60f27a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 22:07:08 +0000 (UTC)
Date:   Tue, 26 Jul 2022 00:07:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ
Message-ID: <Yt8UCsYkH3O6RnFd@zx2c4.com>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725183636.97326-4-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 25, 2022 at 11:36:36AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> No architecture actually defines this, so it's unneeded.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
 
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Aside: out of curiosity, I wonder what was originally intended with
this, which magic arch-specific instructions were thought to be
potentially of aid.
