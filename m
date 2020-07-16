Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D4221D38
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 09:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGPHVi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 03:21:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39588 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPHVh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 03:21:37 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jvyCz-0003RY-BT; Thu, 16 Jul 2020 17:21:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 17:21:33 +1000
Date:   Thu, 16 Jul 2020 17:21:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/1] inside-secure irq balance
Message-ID: <20200716072133.GA28028@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708150844.2626m3pgdo5oidzm@SvensMacBookAir.sven.lan>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Sven Auhagen <sven.auhagen@voleatech.de> wrote:
>
> +       // Set affinity
> +       cpu = ring_id % num_online_cpus();
> +       irq_set_affinity_hint(irq, get_cpu_mask(cpu));
> +

This doesn't look right.  There is no guarantee that the online
CPUs are the lowest bits in the bitmask.  Also, what are you going
to do when the CPUs go down (or up)?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
