Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728F525F40
	for <lists+linux-crypto@lfdr.de>; Fri, 13 May 2022 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378959AbiEMJfg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 May 2022 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346611AbiEMJfg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 May 2022 05:35:36 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F838297403
        for <linux-crypto@vger.kernel.org>; Fri, 13 May 2022 02:35:35 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1npRhr-00DHF9-1y; Fri, 13 May 2022 19:35:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 May 2022 17:35:31 +0800
Date:   Fri, 13 May 2022 17:35:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] crypto: cryptd - Protect per-CPU resource by disabling
 BH.
Message-ID: <Yn4mY9ydSqto7oF5@gondor.apana.org.au>
References: <YnKWuLQZdPwSdRTh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKWuLQZdPwSdRTh@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 04, 2022 at 05:07:36PM +0200, Sebastian Andrzej Siewior wrote:
> The access to cryptd_queue::cpu_queue is synchronized by disabling
> preemption in cryptd_enqueue_request() and disabling BH in
> cryptd_queue_worker(). This implies that access is allowed from BH.
> 
> If cryptd_enqueue_request() is invoked from preemptible context _and_
> soft interrupt then this can lead to list corruption since
> cryptd_enqueue_request() is not protected against access from
> soft interrupt.
> 
> Replace get_cpu() in cryptd_enqueue_request() with local_bh_disable()
> to ensure BH is always disabled.
> Remove preempt_disable() from cryptd_queue_worker() since it is not
> needed because local_bh_disable() ensures synchronisation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  crypto/cryptd.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Good catch! This bug has been around for a while.  Did you detect
this in the field or was it through code-review?

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
