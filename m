Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00A2DF7F
	for <lists+linux-crypto@lfdr.de>; Wed, 29 May 2019 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2OSa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 May 2019 10:18:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:35002 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2OS3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 May 2019 10:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559139504;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=hEg459JKNjMZU93JrKXvFePGJVmrCgpuxqZhr0jzbp8=;
        b=MoTNBWxWOJMYve8LSVFmJmi5Xoi//VRDxfPTEM7kJ+N5+yCmktvX7CfusM3BMIjjAx
        25DTHCrshPODC8kAcABML59xo/ahklHSyrn+MC4/QfqiqqmLCO3mAqlWf9t4NQkvjS8I
        pdWG1xYBDAXERUcUmLPReJ1MNHS6oQEw9adiqS0OnyQRImIoCEGobXljpSH26Dmv9pUZ
        OyeARhHi43VHp/4YoCRMTW/GrU8gn2jn9hLzcfrQ83tbr7tedfaqnPFlu1GHwV68Hcno
        D0Whax7kDeWnHFgB7iid3dJo/E6qaIwniIUP+c46LF10jYqiRhPm7I32orQLMnBoUcyt
        koVg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbLvSf34ur"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id R0373fv4TEIIvuo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 29 May 2019 16:18:18 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     David Gstir <david@sigma-star.at>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: Can an ahash driver be used through shash API?
Date:   Wed, 29 May 2019 16:18:18 +0200
Message-ID: <4256916.YlTHG9RRyR@tauon.chronox.de>
In-Reply-To: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at>
References: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Mittwoch, 29. Mai 2019, 16:04:47 CEST schrieb David Gstir:

Hi David,

> Hi!
> 
> I've done some testing with hardware acceleration of hash functions
> and noticed that, when using the synchronous message digest API (shash),
> some drivers are not usable. In my case the CAAM driver for SHA256.
> Using the asynchronous interface (ahash), everything works as expected.
> Looking at the driver source, the CAAM driver only implements the ahash
> interface.
> 
> I'm wondering if there a way to use an ahash driver through the shash
> interface?

Short: no.
> 
> I've seen that it does actually work the other way around, since
> crypto_init_shash_ops_async() in crypto/shash.c takes care of translating
> calls from ahash to shash and that's how the *-generic drivers are usable
> through the ahash API.

The crypto_alloc_shash will only identify cipher implementations that were 
registered with the CRYPTO_ALG_TYPE_SHASH flag. That flag is set when a cipher 
is registered using crypto_register_shash.

Thus, ciphers registered with crypto_register_ahash will not bear this flag 
and thus will not be found by the allocation function.

Ciao
Stephan


