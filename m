Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16061A4F7B
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Apr 2020 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDKLHv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 11 Apr 2020 07:07:51 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:41940 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgDKLHv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 11 Apr 2020 07:07:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0D25D181D337B;
        Sat, 11 Apr 2020 11:07:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3867:3868:3871:3872:3874:4250:4321:5007:7903:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:13071:13095:13439:14180:14181:14659:14721:21060:21080:21212:21433:21627:21660:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: force52_270ea654bb131
X-Filterd-Recvd-Size: 3427
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 11:07:48 +0000 (UTC)
Message-ID: <d40b2b993d8e9764c5e7f6fd3f8ca037a9520b6e.camel@perches.com>
Subject: Re: [PATCH] crypto: marvell/octeontx - Add missing '\n' in log
 messages
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        lbartosik@marvell.com, colin.king@canonical.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sat, 11 Apr 2020 04:05:43 -0700
In-Reply-To: <20200411104458.21526-1-christophe.jaillet@wanadoo.fr>
References: <20200411104458.21526-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, 2020-04-11 at 12:44 +0200, Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> While at it, I've introduced a few pr_cont that looked logical to me.

Hi again Christophe.

> diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
[]
> @@ -629,15 +629,15 @@ static void print_dbg_info(struct device *dev,
>  				pr_debug("Slot%d: %s", j, engs_info);
>  				bitmap_to_arr32(mask, engs->bmap,
>  						eng_grps->engs_num);
> -				pr_debug("Mask:  %8.8x %8.8x %8.8x %8.8x",
> -					 mask[3], mask[2], mask[1], mask[0]);
> +				pr_cont(" Mask: %8.8x %8.8x %8.8x %8.8x\n",
> +					mask[3], mask[2], mask[1], mask[0]);

Unfortunately, a pr_debug cannot reasonably be followed by pr_cont.

pr_debug is conditionally compiled and if CONFIG_DYNAMIC_DEBUG
is enabled, conditionally emitted.

pr_cont is not conditionally compiled and is always emitted.

So this is fine as is (or with terminating newlines added)

> @@ -1147,8 +1147,9 @@ static int delete_engine_group(struct device *dev,
>  		for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
>  			if (eng_grp->g->grp[i].mirror.is_ena &&
>  			    eng_grp->g->grp[i].mirror.idx == eng_grp->idx)
> -				dev_err(dev, "engine_group%d", i);
> +				pr_cont(" engine_group%d", i);
>  		}
> +		pr_cont("\n");
>  		return -EINVAL;
>  	}

This one is probably reasonable, but I suggest that "engine_group%d"
is a bit redundant and this might be better as something like:

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index d04baa3..a6bb6c7 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1142,13 +1143,14 @@ static int delete_engine_group(struct device *dev,
 		return -EINVAL;
 
 	if (eng_grp->mirror.ref_count) {
-		dev_err(dev, "Can't delete engine_group%d as it is used by:",
+		dev_err(dev, "Can't delete engine_group%d as it is used by engine_group(s):",
 			eng_grp->idx);
 		for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
 			if (eng_grp->g->grp[i].mirror.is_ena &&
 			    eng_grp->g->grp[i].mirror.idx == eng_grp->idx)
-				dev_err(dev, "engine_group%d", i);
+				pr_cont(dev, " %d", i);
 		}
+		pr_cont("\n");
 		return -EINVAL;
 	}
 

