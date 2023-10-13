Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD87C7D53
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Oct 2023 07:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjJMF5x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Oct 2023 01:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMF5w (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Oct 2023 01:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72CB7
        for <linux-crypto@vger.kernel.org>; Thu, 12 Oct 2023 22:57:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F2C433CC
        for <linux-crypto@vger.kernel.org>; Fri, 13 Oct 2023 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697176670;
        bh=gmdsrlwg1urFkxOOlkg+HR32FfjE4y2eewFEIvf6e/s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=eaq3rzvxDkp58Y1PMfGIFN+2Cs1odRcm0VteKyIEZDW0xhDh68dwOcXeguOWR9uzw
         3WTP/HsQiIh+AoDIn1L4FWdA57JrGAbeSVhWZ6iUKn/xJb1wFNsn7z391PcMPBMoEK
         HqcRqkUax4XEntCFJeATzgGEZBXxVVNRc9+BflJ+BSDteWUO6TgVooTSbL+3FfvPrv
         vOkc3OWnvIvf0P+NT8AHK8OqvS2qFRiCmUdwvjJhEfBkq1fkFrY+knIFkslaVrho3a
         xiNmDwErik1PAf1HRwnrREu5QS5HNN5zQTc8QNufaLBcsLtcU74/p2ur7eK/uM9zTp
         vnqMj+Cf2W9oA==
Date:   Thu, 12 Oct 2023 22:57:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: skcipher - fix weak key check for lskciphers
Message-ID: <20231013055748.GA52471@sol.localdomain>
References: <20231009033750.279307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009033750.279307-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Oct 08, 2023 at 08:37:50PM -0700, Eric Biggers wrote:
> -int crypto_lskcipher_setkey_sg(struct crypto_skcipher *tfm, const u8 *key,
> -			       unsigned int keylen)
> -{
> -	struct crypto_lskcipher **ctx = crypto_skcipher_ctx(tfm);
> -
> -	return crypto_lskcipher_setkey(*ctx, key, keylen);
> -}

Forgot to remove the prototype for crypto_lskcipher_setkey_sg().  Just sent out
v2 with this.

- Eric
