Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54651B6A
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Jun 2019 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfFXTao (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Jun 2019 15:30:44 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:37207 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729180AbfFXTao (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Jun 2019 15:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 03618181D3403;
        Mon, 24 Jun 2019 19:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:4321:5007:6119:6691:7903:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:21080:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: leaf43_5d60cb96f485f
X-Filterd-Recvd-Size: 1576
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 19:30:41 +0000 (UTC)
Message-ID: <23a5979082c89d7028409ad9ae082840411e1ca6.camel@perches.com>
Subject: Re: [PATCH 0/3] Clean up crypto documentation
From:   Joe Perches <joe@perches.com>
To:     "Hook, Gary" <Gary.Hook@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Date:   Mon, 24 Jun 2019 12:30:40 -0700
In-Reply-To: <156140322426.29777.8610751479936722967.stgit@taos>
References: <156140322426.29777.8610751479936722967.stgit@taos>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 2019-06-24 at 19:07 +0000, Hook, Gary wrote:
> Tidy up the crypto documentation by filling in some variable
> descriptions, make some grammatical corrections, and enhance
> formatting.

While this seems generally OK, please try not to make the
readability of the source _text_ less intelligible just
to enhance the output formatting of the html.

e.g.:

Unnecessary blank lines separating function descriptions
Removing space alignment from bullet point descriptions

etc..,



