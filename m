Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F52A361C
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Nov 2020 22:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgKBVlc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Nov 2020 16:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgKBVlc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Nov 2020 16:41:32 -0500
Received: from lt-jalone-7480.mtl.com (c-24-6-56-119.hsd1.ca.comcast.net [24.6.56.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE4921D40;
        Mon,  2 Nov 2020 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604353291;
        bh=CT78URbf8GWUrauRnN7DRJ5X5z820SmGZe8HhrCPyTY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F3ka5x6N19Rp7WtfdR4oM2thWJyW5uF0CpRDHZKTIn7zaFGSn5bBL4vkRh0550qnI
         lGZrPKMm2fJzhc/aBEQzYjjML/1g3PbMMvddAbtL2uE0wIGZ5ooLgSMaeua6X1a1Pk
         UF2VWhVZnZ67yk5X5Estw6tnPoHhELfjpb7ZTFk0=
Message-ID: <5940727ec6361becbac13d5dcbdc995c1fa3353b.camel@kernel.org>
Subject: Re: [PATCH net-next 04/15] net: mlx5: Replace in_irq() usage.
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, Aymen Sghaier <aymen.sghaier@nxp.com>,
        Daniel Drake <dsd@gentoo.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jon Mason <jdmason@kudzu.us>, Jouni Malinen <j@w1.fi>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Rain River <rain.1986.08.12@gmail.com>,
        Samuel Chessman <chessman@tux.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 02 Nov 2020 13:41:29 -0800
In-Reply-To: <20201031095938.3878412e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
References: <20201027225454.3492351-1-bigeasy@linutronix.de>
         <20201027225454.3492351-5-bigeasy@linutronix.de>
         <20201031095938.3878412e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, 2020-10-31 at 09:59 -0700, Jakub Kicinski wrote:
> On Tue, 27 Oct 2020 23:54:43 +0100 Sebastian Andrzej Siewior wrote:
> > mlx5_eq_async_int() uses in_irq() to decide whether eq::lock needs
> > to be
> > acquired and released with spin_[un]lock() or the irq
> > saving/restoring
> > variants.
> > 
> > The usage of in_*() in drivers is phased out and Linus clearly
> > requested
> > that code which changes behaviour depending on context should
> > either be
> > seperated or the context be conveyed in an argument passed by the
> > caller,
> > which usually knows the context.
> > 
> > mlx5_eq_async_int() knows the context via the action argument
> > already so
> > using it for the lock variant decision is a straight forward
> > replacement
> > for in_irq().
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-rdma@vger.kernel.org
> 
> Saeed, please pick this up into your tree.

Ack

