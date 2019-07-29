Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5834D7888F
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jul 2019 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfG2Jgz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jul 2019 05:36:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56710 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfG2Jgz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jul 2019 05:36:55 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hs25J-00056l-Jn; Mon, 29 Jul 2019 19:36:49 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hs25I-0008OI-Dl; Mon, 29 Jul 2019 19:36:48 +1000
Date:   Mon, 29 Jul 2019 19:36:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] crypto: aegis128 - deal with missing simd.h header on
 some architecures
Message-ID: <20190729093648.GA32243@gondor.apana.org.au>
References: <20190729074434.21064-1-ard.biesheuvel@linaro.org>
 <20190729091204.GA32006@gondor.apana.org.au>
 <CAKv+Gu9WW_wGKZaXHjLxgUF0zNYBpEFZnjVyFy0tGmiGmb0-ag@mail.gmail.com>
 <20190729092149.GA32129@gondor.apana.org.au>
 <CAKv+Gu8sVb9HTgiyV101W1kd9fVn=2kEG+mKNePi+UKC0YQ+pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8sVb9HTgiyV101W1kd9fVn=2kEG+mKNePi+UKC0YQ+pQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 29, 2019 at 12:32:33PM +0300, Ard Biesheuvel wrote:
>
> This seems to work

Looks good to me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
