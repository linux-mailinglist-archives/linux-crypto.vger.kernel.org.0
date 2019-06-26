Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5A55CD7
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Jun 2019 02:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFZANb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Jun 2019 20:13:31 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:41771 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFZANb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Jun 2019 20:13:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 43DC71822495E;
        Wed, 26 Jun 2019 00:13:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 13,1.2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:6119:8660:10008:10400:10848:11026:11232:11658:11914:12043:12048:12295:12296:12297:12438:12740:12760:12895:13071:13141:13148:13230:13439:14096:14097:14180:14659:14721:21060:21080:21433:21451:21627:21740:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: event25_10e35e383f0f
X-Filterd-Recvd-Size: 3739
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 00:13:27 +0000 (UTC)
Message-ID: <983486e9b2daaa34f84f99a890fcedfeae22b24f.camel@perches.com>
Subject: Re: [PATCH v2 2/2] crypto: doc - Fix formatting of new crypto
 engine content
From:   Joe Perches <joe@perches.com>
To:     "Hook, Gary" <Gary.Hook@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Date:   Tue, 25 Jun 2019 17:13:25 -0700
In-Reply-To: <156150622886.22527.934327975584441429.stgit@taos>
References: <156150616764.22527.16524544899486041609.stgit@taos>
         <156150622886.22527.934327975584441429.stgit@taos>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2019-06-25 at 23:43 +0000, Hook, Gary wrote:
> Tidy up the formatting/grammar in crypto_engine.rst. Use bulleted lists
> where appropriate.

Hi again Gary.

> diff --git a/Documentation/crypto/crypto_engine.rst b/Documentation/crypto/crypto_engine.rst
[]
> +Before transferring any request, you have to fill the context enginectx by
> +providing functions for the following:
> +
> +* ``prepare_crypt_hardware``: Called once before any prepare functions are
> +  called.
> +
> +* ``unprepare_crypt_hardware``: Called once after all unprepare functions have
> +  been called.
> +
> +* ``prepare_cipher_request``/``prepare_hash_request``: Called before each
> +  corresponding request is performed. If some processing or other preparatory
> +  work is required, do it here.
> +
> +* ``unprepare_cipher_request``/``unprepare_hash_request``: Called after each
> +  request is handled. Clean up / undo what was done in the prepare function.
> +
> +* ``cipher_one_request``/``hash_one_request``: Handle the current request by
> +  performing the operation.

I again suggest not using ``<func>`` but instead use <func>()
and remove unnecessary blank lines.

i.e.:

* prepare_crypt_hardware(): Called once before any prepare functions are
  called.
* unprepare_crypt_hardware():  Called once after all unprepare functions
  have been called.
* prepare_cipher_request()/prepare_hash_request(): Called before each
  corresponding request is performed. If some processing or other preparatory
  work is required, do it here.
* unprepare_cipher_request()/unprepare_hash_request(): Called after each
  request is handled. Clean up / undo what was done in the prepare function.
* cipher_one_request()/hash_one_request(): Handle the current request by
  performing the operation.

[]
> +When your driver receives a crypto_request, you must to transfer it to
> +the crypto engine via one of:
> +
> +* crypto_transfer_ablkcipher_request_to_engine()

And removing the unnecessary blank lines below

> +
> +* crypto_transfer_aead_request_to_engine()
> +
> +* crypto_transfer_akcipher_request_to_engine()
> +
> +* crypto_transfer_hash_request_to_engine()
> +
> +* crypto_transfer_skcipher_request_to_engine()
> +
> +At the end of the request process, a call to one of the following functions is needed:
> +
> +* crypto_finalize_ablkcipher_request()
> +
> +* crypto_finalize_aead_request()
> +
> +* crypto_finalize_akcipher_request()
> +
> +* crypto_finalize_hash_request()
> +
> +* crypto_finalize_skcipher_request()


