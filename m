Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30BF263834
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Sep 2020 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIVJg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Sep 2020 17:09:36 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:34596 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgIIVJg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Sep 2020 17:09:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CC7DB180A7FFF;
        Wed,  9 Sep 2020 21:09:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:21080:21627:21939:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: copy43_3c134c7270e0
X-Filterd-Recvd-Size: 2033
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 21:09:33 +0000 (UTC)
Message-ID: <b0c31cbb82aa64027569dff69803ca3ec2f65501.camel@perches.com>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
From:   Joe Perches <joe@perches.com>
To:     Keith Busch <kbusch@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Kees Cook <kees.cook@canonical.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 09 Sep 2020 14:09:32 -0700
In-Reply-To: <20200909205558.GA3384631@dhcp-10-100-145-180.wdl.wdc.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
         <20200909205558.GA3384631@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 2020-09-09 at 13:55 -0700, Keith Busch wrote:
> On Wed, Sep 09, 2020 at 01:06:39PM -0700, Joe Perches wrote:
> > diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> > index eea0f453cfb6..8aac5bc60f4c 100644
> > --- a/crypto/tcrypt.c
> > +++ b/crypto/tcrypt.c
> > @@ -2464,7 +2464,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
> >  		test_hash_speed("streebog512", sec,
> >  				generic_hash_speed_template);
> >  		if (mode > 300 && mode < 400) break;
> > -		fallthrough;
> > +		break;
> >  	case 399:
> >  		break;
> 
> Just imho, this change makes the preceding 'if' look even more
> pointless. Maybe the fallthrough was a deliberate choice? Not that my
> opinion matters here as I don't know this module, but it looked a bit
> odd to me.

It does look odd to me too.

It's also just a test module though so the
code isn't particularly crucial.

Herbert/David? thoughts?


