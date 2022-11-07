Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566AA61EC39
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Nov 2022 08:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKGHjc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Nov 2022 02:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKGHjb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Nov 2022 02:39:31 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9471D56
        for <linux-crypto@vger.kernel.org>; Sun,  6 Nov 2022 23:39:30 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D24DB201481;
        Mon,  7 Nov 2022 07:39:28 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 2F07E8082C; Mon,  7 Nov 2022 08:39:06 +0100 (CET)
Date:   Mon, 7 Nov 2022 08:39:06 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3] hw_random: use add_hwgenerator_randomness() for early
 entropy
Message-ID: <Y2i2GhBjeCI6MTR0@owl.dominikbrodowski.net>
References: <Y2fJy1akGIdQdH95@zx2c4.com>
 <20221106150243.150437-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106150243.150437-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Sun, Nov 06, 2022 at 04:02:43PM +0100 schrieb Jason A. Donenfeld:
> Rather than calling add_device_randomness(), the add_early_randomness()
> function should use add_hwgenerator_randomness(), so that the early
> entropy can be potentially credited, which allows for the RNG to
> initialize earlier without having to wait for the kthread to come up.
> 
> This requires some minor API refactoring, by adding a `sleep_after`
> parameter to add_hwgenerator_randomness(), so that we don't hit a
> blocking sleep from add_early_randomness().
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
