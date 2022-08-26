Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AE5A1F21
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Aug 2022 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiHZCwz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 25 Aug 2022 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZCwz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 25 Aug 2022 22:52:55 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440FCCE3B
        for <linux-crypto@vger.kernel.org>; Thu, 25 Aug 2022 19:52:52 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oRPSf-00FHsU-1c; Fri, 26 Aug 2022 12:52:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Aug 2022 10:52:44 +0800
Date:   Fri, 26 Aug 2022 10:52:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Taehee Yoo <ap420073@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Wright, Randy (HPE Servers Linux)" <rwright@hpe.com>
Subject: Re: [PATCH] crypto: x86/sha512 - load based on CPU features
Message-ID: <Ywg1fKiTGyNk78tB@gondor.apana.org.au>
References: <20220813230431.2666-1-elliott@hpe.com>
 <Yv9ubekvQiL3UGwd@gondor.apana.org.au>
 <MW5PR84MB18425E5211BD4EAF09D0CE3EAB6C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 26, 2022 at 02:40:58AM +0000, Elliott, Robert (Servers) wrote:
>
> Suggestion: please revert the sha512-x86 patch for a while.

This problem would have existed anyway if the module was built
into the kernel.

> Do these functions need to break up their processing into smaller chunks
> (e.g., a few Megabytes), calling kernel_fpu_end() periodically to 
> allow the scheduler to take over the CPUs if needed? If so, what
> chunk size would be appropriate?

Yes these should be limited to 4K each.  It appears that all the
sha* helpers in arch/x86/crypto have the same problem.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
