Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E9213A71
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2020 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGCNAR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Jul 2020 09:00:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41678 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgGCNAQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Jul 2020 09:00:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jrLID-0006qi-Jf; Fri, 03 Jul 2020 22:59:50 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2020 22:59:49 +1000
Date:   Fri, 3 Jul 2020 22:59:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jian Cai <caij2003@gmail.com>, jiancai@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        manojgupta@google.com, maskray@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] crypto, x86: aesni: add compatibility with IAS
Message-ID: <20200703125949.GA28373@gondor.apana.org.au>
References: <20200622232434.162730-1-caij2003@gmail.com>
 <20200703044832.GD23200@gondor.apana.org.au>
 <CA+icZUWwpY9rnfgyy81-78fH+PH4wmAS-+yZFBDCjBbARabQfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWwpY9rnfgyy81-78fH+PH4wmAS-+yZFBDCjBbARabQfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 03, 2020 at 10:36:43AM +0200, Sedat Dilek wrote:
>
> Can you please apply my patch, too?

Please repost your patch without the 5.7 tag.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
