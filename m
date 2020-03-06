Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D783917B3FC
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2020 02:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCFBvN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Mar 2020 20:51:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:46098 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFBvM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Mar 2020 20:51:12 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1jA28t-0008BS-Ks; Fri, 06 Mar 2020 09:51:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1jA28r-0006mL-En; Fri, 06 Mar 2020 09:51:09 +0800
Date:   Fri, 6 Mar 2020 09:51:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 00/12] crypto: more template instantiation cleanups
Message-ID: <20200306015109.dahx6vg7knp2hcw7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226045924.97053-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> This series simplifies error handling in the remaining crypto templates,
> taking advantage of the changes I made last release that made
> crypto_grab_*() accept ERR_PTR() names and crypto_drop_*() accept
> spawns that haven't been grabbed yet:
> https://lore.kernel.org/r/20200103035908.12048-1-ebiggers@kernel.org
> 
> Many templates were already converted to the new style by that series.
> This series just handles the remainder.
> 
> This series is an internal cleanup only; there are no changes for users
> of the crypto API.  Net change is 124 lines of code removed.
> 
> Eric Biggers (12):
>  crypto: authencesn - fix weird comma-terminated line
>  crypto: ccm - simplify error handling in crypto_rfc4309_create()
>  crypto: cryptd - simplify error handling in cryptd_create_*()
>  crypto: ctr - simplify error handling in crypto_rfc3686_create()
>  crypto: cts - simplify error handling in crypto_cts_create()
>  crypto: gcm - simplify error handling in crypto_rfc4106_create()
>  crypto: gcm - simplify error handling in crypto_rfc4543_create()
>  crypto: geniv - simply error handling in aead_geniv_alloc()
>  crypto: lrw - simplify error handling in create()
>  crypto: pcrypt - simplify error handling in pcrypt_create_aead()
>  crypto: rsa-pkcs1pad - simplify error handling in pkcs1pad_create()
>  crypto: xts - simplify error handling in ->create()
> 
> crypto/authencesn.c   |  2 +-
> crypto/ccm.c          | 29 ++++++-------------
> crypto/cryptd.c       | 37 ++++++++----------------
> crypto/ctr.c          | 29 ++++++-------------
> crypto/cts.c          | 27 ++++++------------
> crypto/gcm.c          | 66 ++++++++++++++-----------------------------
> crypto/geniv.c        | 17 ++++-------
> crypto/lrw.c          | 28 ++++++++----------
> crypto/pcrypt.c       | 33 ++++++----------------
> crypto/rsa-pkcs1pad.c | 59 +++++++++++++-------------------------
> crypto/xts.c          | 28 ++++++++----------
> kernel/padata.c       |  7 +++--
> 12 files changed, 119 insertions(+), 243 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
