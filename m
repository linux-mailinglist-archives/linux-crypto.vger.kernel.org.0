Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890220EFEE
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgF3Hyj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jun 2020 03:54:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33288 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgF3Hyj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jun 2020 03:54:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jqB6B-00038y-LG; Tue, 30 Jun 2020 17:54:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Jun 2020 17:54:35 +1000
Date:   Tue, 30 Jun 2020 17:54:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
Subject: Re: [PATCHv4 3/7] crypto: sa2ul: add sha1/sha256/sha512 support
Message-ID: <20200630075435.GA3885@gondor.apana.org.au>
References: <20200615071452.25141-1-t-kristo@ti.com>
 <20200615071452.25141-4-t-kristo@ti.com>
 <20200626043155.GA2683@gondor.apana.org.au>
 <2a89ea86-3b9e-06b5-fa8e-9dc6e5ad9aeb@ti.com>
 <20200630044936.GA22565@gondor.apana.org.au>
 <b8c209cd-2b5d-54e4-9b64-94e5d1f0e60c@ti.com>
 <20200630074645.GA2449@gondor.apana.org.au>
 <ea76dad4-a29d-d211-edee-52f3699c8ab7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea76dad4-a29d-d211-edee-52f3699c8ab7@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 30, 2020 at 10:52:57AM +0300, Tero Kristo wrote:
>
> How about making the buffer size configurable during probe time via module
> param, and/or runtime via sysfs parameter? This would allow system designers
> to tune it based on expected usecases.

Why do you even need to support this? What's the use-case?

FWIW IPsec only uses digest.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
