Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E6CBF7A
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfJDPls (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:41:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42494 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDPls (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:41:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPiA-0001Ja-HB; Sat, 05 Oct 2019 01:41:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:41:40 +1000
Date:   Sat, 5 Oct 2019 01:41:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 0/2] crypto: inside-secure: [URGENT] Fix stability issue
Message-ID: <20191004154140.GO5148@gondor.apana.org.au>
References: <1568714119-29945-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568714119-29945-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 17, 2019 at 11:55:17AM +0200, Pascal van Leeuwen wrote:
> This patchset fixes some issues with the TRC RAM probing that caused
> instability (random failures) on the Macchiatobin board and incorrect
> configuration of the TRC for some other corner case RAM configuration.
> 
> The patchset has been tested with the eip197c_iewxkbc configuration with
> 163840 bytes of TRC data RAM and 4096 words of TRC admin RAM on the
> Xilinx VCU118 development board as well as on the Macchiatobin board
> (Marvell A8K: EIP197b-ieswx w/ 15350 bytes data RAM & 80 words admin RAM),
> including the testmgr extra tests.
> 
> Pascal van Leeuwen (2):
>   crypto: inside-secure: [URGENT] Fix stability issue with Macchiatobin
>   crypto: inside-secure - Fixed corner case TRC admin RAM probing issue
> 
>  drivers/crypto/inside-secure/safexcel.c | 52 +++++++++++++++++++++------------
>  drivers/crypto/inside-secure/safexcel.h |  2 ++
>  2 files changed, 36 insertions(+), 18 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
