Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9616814BA
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2019 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfHEJH1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Aug 2019 05:07:27 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40475 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJH1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Aug 2019 05:07:27 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 97E02200008;
        Mon,  5 Aug 2019 09:07:25 +0000 (UTC)
Date:   Mon, 5 Aug 2019 11:07:25 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv3 4/4] crypto: inside-secure - add support for using the
 EIP197 without vendor firmware
Message-ID: <20190805090725.GH14470@kwain>
References: <1564586959-9963-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564586959-9963-5-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564586959-9963-5-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

Just a small comment below,

On Wed, Jul 31, 2019 at 05:29:19PM +0200, Pascal van Leeuwen wrote:
> 
> -	/* Release engine from reset */
> -	val = readl(EIP197_PE(priv) + ctrl);
> -	val &= ~EIP197_PE_ICE_x_CTRL_SW_RESET;
> -	writel(val, EIP197_PE(priv) + ctrl);
> +	for (pe = 0; pe < priv->config.pes; pe++) {
> +		base = EIP197_PE_ICE_SCRATCH_RAM(pe);
> +		pollcnt = EIP197_FW_START_POLLCNT;
> +		while (pollcnt &&
> +		       (readl_relaxed(EIP197_PE(priv) + base +
> +			      pollofs) != 1)) {
> +			pollcnt--;

You might want to use readl_relaxed_poll_timeout() here, instead of a
busy polling.

Thanks,
Antoine

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
