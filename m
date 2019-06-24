Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2651C4E
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Jun 2019 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfFXU3s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Jun 2019 16:29:48 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:38887 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfFXU3s (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Jun 2019 16:29:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 586A3182CED2A;
        Mon, 24 Jun 2019 20:29:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2691:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6691:7903:7904:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12663:12740:12760:12895:12986:13069:13071:13311:13357:13439:14180:14181:14659:14721:21060:21080:21433:21451:21611:21627:21811:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: road72_1ae72be6d3a1a
X-Filterd-Recvd-Size: 3216
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 20:29:44 +0000 (UTC)
Message-ID: <977bc7c484ef55ff78de51d7555afcc3c3350b1e.camel@perches.com>
Subject: Re: [PATCH 0/3] Clean up crypto documentation
From:   Joe Perches <joe@perches.com>
To:     Gary R Hook <ghook@amd.com>, "Hook, Gary" <Gary.Hook@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Date:   Mon, 24 Jun 2019 13:29:42 -0700
In-Reply-To: <d8b359ff-5891-7bb8-d292-9f10cca04f17@amd.com>
References: <156140322426.29777.8610751479936722967.stgit@taos>
         <23a5979082c89d7028409ad9ae082840411e1ca6.camel@perches.com>
         <d8b359ff-5891-7bb8-d292-9f10cca04f17@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 2019-06-24 at 20:06 +0000, Gary R Hook wrote:

Hi Gary.

> On 6/24/19 2:30 PM, Joe Perches wrote:
> > On Mon, 2019-06-24 at 19:07 +0000, Hook, Gary wrote:
> > > Tidy up the crypto documentation by filling in some variable
> > > descriptions, make some grammatical corrections, and enhance
> > > formatting.
> > 
> > While this seems generally OK, please try not to make the
> > readability of the source _text_ less intelligible just
> > to enhance the output formatting of the html.
> > 
> > e.g.:
> > 
> > Unnecessary blank lines separating function descriptions
> > Removing space alignment from bullet point descriptions
> 
> Apologies. I generally consider white space a Good Thing,
> but will take your note and not do that. The blank lines I
> added do not affect the output, so I should not have done
> that.
> 
> Also, I turned sentences into bulleted lists here, so I'm not
> clear on whether that was a Bad Thing or not.

To me, using bulleted lists are not a bad thing at all
but are quite the opposite for humans to read.

> Seems more legible
> to me all the way around, but I clearly could be incorrect.

Not at all.

> I agree that mucking with alignment is a bad thing, and would not
> intentionally do so. That said, if you would please elaborate on
> any mistakes I've made?
> 
> Finally, would you prefer a v2 of the patch set? Happy to do
> whatever is preferred, of course.

Whatever Jonathan decides is fine with me.
Mine was just a plea to avoid unnecessarily
making the source text harder to read as
that's what I mostly use.

I don't know if this extension is valid yet, but
I believe just using <function_name>() is more
readable as text than ``<function_name>`` or
:c:func:`<function_name>`

https://lore.kernel.org/lkml/20190425200125.12302-1-corbet@lwn.net/T/

I prefer the automatic approach over the manual
marking of functions as ideally sphinx formatting
should not overly impact the source text.


