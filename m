Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B76D92B5
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Oct 2019 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391969AbfJPNji (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Oct 2019 09:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391938AbfJPNji (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Oct 2019 09:39:38 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D5D2168B;
        Wed, 16 Oct 2019 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571233178;
        bh=dDExEC2557cmtq3X/4XRJPOkG/r/cnDMPOGXwrWXLoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+FbZCkdkd9GpK7nEZefieerlnRs7S6ZXE6J7iRlAmUzCy5s6bxANCkhxRUWZGaKI
         sBeLWzxWO4IglbGp0fJVwJQB3DSlTbZ+iVw1IhX0xQvB+Uno4HRiWKjmkaYR9jpDX0
         yX5gKWGo/5MvUHFZt7/oeBJu1lkFh0OKHV7dWFbY=
Date:   Wed, 16 Oct 2019 15:39:35 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/4] crypto: add sun8i-ss driver for Allwinner Security
 System
Message-ID: <20191016133935.e67kevjyugxn5rki@gilmour>
References: <20191016133345.9076-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016133345.9076-1-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 16, 2019 at 03:33:41PM +0200, Corentin Labbe wrote:
> Hello
>
> This patch serie adds support for the second version of Allwinner Security System.
> The first generation of the Security System is already handled by the sun4i-ss driver.
> Due to major change, the first driver cannot handle the second one.
> This new Security System is present on A80 and A83T SoCs.
>
> For the moment, the driver support only DES3/AES in ECB/CBC mode.
> Patchs for CTR/CTS, RSA and RNGs will came later.
>
> This serie is tested with CRYPTO_MANAGER_EXTRA_TESTS
> and tested on:
> sun8i-a83t-bananapi-m3
> sun9i-a80-cubieboard4
>
> This serie is based on top of the "crypto: add sun8i-ce driver for
> Allwinner crypto engine" serie.

For the crypto part,
Acked-by: Maxime Ripard <mripard@kernel.org>

I'll apply patches 3 and 4 once Herbert will have merged the patches 1 and 2

Thanks!
Maxime
