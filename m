Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4221C17F0F3
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2020 08:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJHJr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Mar 2020 03:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJHJr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Mar 2020 03:09:47 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D79824677;
        Tue, 10 Mar 2020 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583824186;
        bh=L11SdzzQTyUNNRxclnarGF3ZTYF1cI+qdg4ZV5PcXDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lktXBtD6NO4hhBukLkC1l8I8yzsKD/dc7CaQMdMGMOzA4WGkwh1vxYWNAdBOX6pdL
         rpE4An+4S7gMURXu7b5U8rg3/FeD4IFeAJ2PZQ/I9BXgyGsGrr4HZaIWpekUVEbRsx
         xZOjrneNU3I8yx18lXvfWSMZSbOzyMRkkYLoJEvk=
Date:   Tue, 10 Mar 2020 15:09:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: add crypto node
Message-ID: <20200310070939.GD17772@dragon>
References: <20200224125023.29780-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224125023.29780-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 24, 2020 at 02:50:23PM +0200, Horia Geantă wrote:
> Add node for CAAM - Cryptographic Acceleration and Assurance Module.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Applied, thanks.
