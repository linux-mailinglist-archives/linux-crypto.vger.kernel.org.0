Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB525E222
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIDTp5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 15:45:57 -0400
Received: from smtprelay0028.hostedemail.com ([216.40.44.28]:43038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbgIDTp4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 15:45:56 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 15:45:55 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id AAA521800EC27
        for <linux-crypto@vger.kernel.org>; Fri,  4 Sep 2020 19:37:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D6807181D3028;
        Fri,  4 Sep 2020 19:37:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:3872:4321:5007:7875:7903:10004:10400:10466:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: meat92_0910680270b4
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Sep 2020 19:37:21 +0000 (UTC)
Message-ID: <906c2ffb0ef6b2d87d6aecdf60b61833ea79e4fb.camel@perches.com>
Subject: Re: [PATCH v6 18/18] crypto: sun8i-ce: fix some style issue
From:   Joe Perches <joe@perches.com>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Fri, 04 Sep 2020 12:37:19 -0700
In-Reply-To: <1599217803-29755-19-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
         <1599217803-29755-19-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 2020-09-04 at 11:10 +0000, Corentin Labbe wrote:
> This patch fix a double empty line issue reported by checkpatch.
> While at it, since now the maximum line length is now 100, reorder some
> wrapped line.
[]
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
[]
> @@ -164,12 +164,10 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
>  				goto theend_key;
>  			}
>  			offset = areq->cryptlen - ivsize;
> -			scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
> -						 offset, ivsize, 0);
> +			scatterwalk_map_and_copy(rctx->backup_iv, areq->src, offset, ivsize, 0);
>  		}
>  		memcpy(rctx->bounce_iv, areq->iv, ivsize);
> -		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
> -					 DMA_TO_DEVICE);
> +		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen, DMA_TO_DEVICE);

coding-style.rst:

   Statements longer than 80 columns should be broken into sensible chunks,
   unless exceeding 80 columns significantly increases readability and does
   not hide information.

Do these longer lines make the code significantly more readable?
I don't think they do.


