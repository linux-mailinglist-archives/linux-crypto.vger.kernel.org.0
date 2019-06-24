Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6466F51E72
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Jun 2019 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfFXWhr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Jun 2019 18:37:47 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:55905 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbfFXWhr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Jun 2019 18:37:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 72975181D3402;
        Mon, 24 Jun 2019 22:37:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:421:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2689:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:8531:9108:10004:10400:10848:10967:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: rod05_7db6cd2afbd24
X-Filterd-Recvd-Size: 2664
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 22:37:43 +0000 (UTC)
Message-ID: <74833f93f6082c7b44f4fa8a3093ea1a751d5539.camel@perches.com>
Subject: Re: [PATCH 0/3] Clean up crypto documentation
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Gary R Hook <ghook@amd.com>, "Hook, Gary" <Gary.Hook@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Date:   Mon, 24 Jun 2019 15:37:42 -0700
In-Reply-To: <20190624143748.7fcfe623@lwn.net>
References: <156140322426.29777.8610751479936722967.stgit@taos>
         <23a5979082c89d7028409ad9ae082840411e1ca6.camel@perches.com>
         <d8b359ff-5891-7bb8-d292-9f10cca04f17@amd.com>
         <977bc7c484ef55ff78de51d7555afcc3c3350b1e.camel@perches.com>
         <20190624143748.7fcfe623@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 2019-06-24 at 14:37 -0600, Jonathan Corbet wrote:
> On Mon, 24 Jun 2019 13:29:42 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > Finally, would you prefer a v2 of the patch set? Happy to do
> > > whatever is preferred, of course.  
> > 
> > Whatever Jonathan decides is fine with me.
> > Mine was just a plea to avoid unnecessarily
> > making the source text harder to read as
> > that's what I mostly use.
> 
> Usually Herbert seems to take crypto docs, so it's not necessarily up to
> me :)
> 
> I don't see much that's objectionable here.  But...
> 
> > I don't know if this extension is valid yet, but
> > I believe just using <function_name>() is more
> > readable as text than ``<function_name>`` or
> > :c:func:`<function_name>`
> 
> It's been "valid" since I wrote it...it's just not upstream yet :)  I
> expect it to be in 5.3, though.  So the best way to refer to a kernel
> function, going forward, is just function() with no markup needed.

When that's actually "valid" I suggest doing:

$ git ls-files -- 'Documentation/*.rst' | \
 xargs perl -pi -e 's/:c:func:`(\w+)(?:\(\))?`/\1()/g; s/``(\w+)\(\)``/\1()/g'

so function designations in Documentation are simpler to read.

Right now that's:

$ git diff --shortstat Documentation/
 125 files changed, 1680 insertions(+), 1680 deletions(-)


