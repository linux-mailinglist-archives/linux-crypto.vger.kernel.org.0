Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827A81DE88C
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2020 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgEVONr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 May 2020 10:13:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39538 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVONq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 May 2020 10:13:46 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jc8QD-0008Fn-G8; Sat, 23 May 2020 00:13:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 23 May 2020 00:13:13 +1000
Date:   Sat, 23 May 2020 00:13:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolas Toromanoff <nicolas.toromanoff@st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] STM32 CRC update
Message-ID: <20200522141313.GA859@gondor.apana.org.au>
References: <20200512141113.18972-1-nicolas.toromanoff@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512141113.18972-1-nicolas.toromanoff@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 12, 2020 at 04:11:08PM +0200, Nicolas Toromanoff wrote:
> This set of patches update the STM32 CRC driver.
> It contains bug fix.
> 
> First fixes issue if we enable STM32 CRC32 hardware accelerator with
> ext4 (with metadata-chksum enable) and other fs that use same direct
> access to update crc32 API without previous init.
> Second fixes some issues raise by the extra self-test.
> Third fixes wrong hw usage if there is multiple IP on the SOC.
> Forth fixes "sleep while atomic" in tcrypt test, and some other places
> (ext4)
> Last fixes concurrent accesses. As state is saved in the hardware cell
> and not in stack as other CRC32 drivers, we need to create atomic
> section to protect concurrent CRC32 calculus.
> 
> This patch series applies to cryptodev/master.
> 
> Nicolas Toromanoff (5):
>   crypto: stm32/crc: fix ext4 chksum BUG_ON()
>   crypto: stm32/crc: fix run-time self test issue.
>   crypto: stm32/crc: fix multi-instance
>   crypto: stm32/crc: don't sleep in runtime pm
>   crypto: stm32/crc: protect from concurrent accesses
> 
>  drivers/crypto/stm32/stm32-crc32.c | 230 ++++++++++++++++++++---------
>  1 file changed, 161 insertions(+), 69 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
