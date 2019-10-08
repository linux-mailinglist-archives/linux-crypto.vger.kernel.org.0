Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C435CF51A
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Oct 2019 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJHIhL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Oct 2019 04:37:11 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:58390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730004AbfJHIhL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Oct 2019 04:37:11 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 04:37:10 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id B39C118021B8B;
        Tue,  8 Oct 2019 08:28:49 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 378B918028EB1;
        Tue,  8 Oct 2019 08:28:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3870:3871:3872:3874:4321:5007:8568:10004:10400:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13095:13255:13439:14093:14097:14659:14721:21080:21433:21451:21627:21974:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: cord46_2f84ddd429022
X-Filterd-Recvd-Size: 3536
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 08:28:46 +0000 (UTC)
Message-ID: <f7fada8a8afce542e5ac08f804df8d5c8d8a726b.camel@perches.com>
Subject: Re: [PATCH][next] crypto: inside-secure: fix spelling mistake
 "algorithmn" -> "algorithm"
From:   Joe Perches <joe@perches.com>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        Colin King <colin.king@canonical.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 01:28:45 -0700
In-Reply-To: <MN2PR20MB29735A64971670E9CE56821ECA9A0@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20191008081410.18857-1-colin.king@canonical.com>
         <MN2PR20MB29735A64971670E9CE56821ECA9A0@MN2PR20MB2973.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2019-10-08 at 08:15 +0000, Pascal Van Leeuwen wrote:
> > There is a spelling mistake in a dev_err message. Fix it.
[]
> > diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-
[]
> > @@ -437,7 +437,7 @@ static int safexcel_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
> >  			goto badkey;
> >  		break;
> >  	default:
> > -		dev_err(priv->dev, "aead: unsupported hash algorithmn");
> > +		dev_err(priv->dev, "aead: unsupported hash algorithm");
> >  		goto badkey;
> >  	}
[]
> Actually, the typing error is well spotted, but the fix is not correct.
> What actually happened here is that a \ got accidentally deleted,
> there should have been a "\n" at the end of the line ...

Other missing newlines in the same file:
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index cecc56073337..47fec8a0a4e1 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -695,21 +695,21 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 		sreq->nr_dst = sreq->nr_src;
 		if (unlikely((totlen_src || totlen_dst) &&
 		    (sreq->nr_src <= 0))) {
-			dev_err(priv->dev, "In-place buffer not large enough (need %d bytes)!",
+			dev_err(priv->dev, "In-place buffer not large enough (need %d bytes)!\n",
 				max(totlen_src, totlen_dst));
 			return -EINVAL;
 		}
 		dma_map_sg(priv->dev, src, sreq->nr_src, DMA_BIDIRECTIONAL);
 	} else {
 		if (unlikely(totlen_src && (sreq->nr_src <= 0))) {
-			dev_err(priv->dev, "Source buffer not large enough (need %d bytes)!",
+			dev_err(priv->dev, "Source buffer not large enough (need %d bytes)!\n",
 				totlen_src);
 			return -EINVAL;
 		}
 		dma_map_sg(priv->dev, src, sreq->nr_src, DMA_TO_DEVICE);
 
 		if (unlikely(totlen_dst && (sreq->nr_dst <= 0))) {
-			dev_err(priv->dev, "Dest buffer not large enough (need %d bytes)!",
+			dev_err(priv->dev, "Dest buffer not large enough (need %d bytes)!\n",
 				totlen_dst);
 			dma_unmap_sg(priv->dev, src, sreq->nr_src,
 				     DMA_TO_DEVICE);

