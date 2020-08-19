Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4C24A027
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Aug 2020 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHSNgV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Aug 2020 09:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgHSNgL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Aug 2020 09:36:11 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BD8204EC;
        Wed, 19 Aug 2020 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597844170;
        bh=EYEELYhlPPBI2CBDzAW5l5k0sAMr4X6tY2UG4Gap+ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6Rkg5PBAjcQERps7XOwJZdaBUl+/L5XAaDyUdV5kZI4cesQFY6N/JhsKHvCHubWC
         oF6NtJIe+kaoFd2YPT8wak5+xMSMip02QkvefaWbFUO+YmKDQbr/aWHf8H6d9lsvqW
         Y6tCqVi1nxk87ZFBQBWpkfOEO/ZAOh0UAe8s/j1s=
Date:   Wed, 19 Aug 2020 21:35:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable caam crypto module
Message-ID: <20200819133555.GC7114@dragon>
References: <20200727161428.14586-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727161428.14586-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 27, 2020 at 07:14:28PM +0300, Horia Geantă wrote:
> caam crypto module is included in several ARMv7-based SoCs from
> i.MX, Layerscape, Vybrid families.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Applied, thanks.
