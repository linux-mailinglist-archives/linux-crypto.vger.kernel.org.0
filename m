Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE315129344
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Dec 2019 09:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfLWIsi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Dec 2019 03:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfLWIsi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Dec 2019 03:48:38 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D646B206B7;
        Mon, 23 Dec 2019 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577090917;
        bh=maq4XvFtmO8+dOb8fi20iKVg4RvaZlE9zzoHO189vc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVAgmKHzVEIZAD+rA5FOaWnfhl3Nu8LbN0n4IBSb+jIUPNmkdsMeqlGdv7FGKY2jN
         fiD5TLN50S1afqMLqCHccZSiMIhKwzLyOni/TP45Q62ZcA931Zn4SO2f0hLNYLeIc5
         2jqCPfkjObVGBJTx+AzEBaZOPKKKTnKgntMuB21E=
Date:   Mon, 23 Dec 2019 16:48:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mm: Add Crypto CAAM support
Message-ID: <20191223084812.GV11523@dragon>
References: <20191218130616.13860-1-aford173@gmail.com>
 <20191218130616.13860-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218130616.13860-2-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 18, 2019 at 07:06:15AM -0600, Adam Ford wrote:
> The i.MX8M Mini supports the same crypto engine as what is in
> the i.MX8MQ, but it is not currently present in the device tree.
> 
> This patch places it into the device tree.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>

Applied, thanks.
