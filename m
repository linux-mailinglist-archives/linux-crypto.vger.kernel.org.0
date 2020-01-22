Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C3214526C
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jan 2020 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAVKTF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jan 2020 05:19:05 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:38943 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAVKTF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jan 2020 05:19:05 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 880dc2b6
        for <linux-crypto@vger.kernel.org>;
        Wed, 22 Jan 2020 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=CKdyer9VXzR2bfA8y6FKuP9tj5I=; b=EAlcmO
        nPlT6Bxuf6c/xWYwqtK+BHk5f6NrmFSXva0yH+k1ZZKL3L8RvDHlvnkvbQvwrftS
        P1SV6oDNmozjG5wfIdO3iGHxgnirtrMNbjnrgbgFOpmQ+38Byx+qfT4YO+7OX2Gm
        AM3mW8nR3JVFuk8VvtrhecoLolZktK1/rFtGJv0AClG8Sy/dMTQQTylq4jBcbmwD
        XCQKXNFJi5jG8oyC0jDukjWUS9t6obWSQ5RQEHDKxWmOnnCd+4Q+D6tv5PFLioKO
        ff2xKqMo3Kv66wa3qEJE0HCucZEJebgWg+1vV8SUVMh7/haf5eCaVjDP2mxRdNMQ
        Xp1+023m7MZJO6qA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83b2b535 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-crypto@vger.kernel.org>;
        Wed, 22 Jan 2020 09:18:00 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id z2so5576537oih.6
        for <linux-crypto@vger.kernel.org>; Wed, 22 Jan 2020 02:19:04 -0800 (PST)
X-Gm-Message-State: APjAAAVr8TH7aB309HhmZoaRKz7tQw9bmlgJ1VMptgNXq9EN4/9ejNRU
        lSvohbcYgN5uGxkaISYDQklksKm+7NkIXIf34MU=
X-Google-Smtp-Source: APXvYqxo8QA+7glLILF44JFIyWnTvdKvK3Pm3Q4P/WyzRwu0Sakx4iFWXwtzUm/fRd6cr1DbB9SIj+jz2etKWpEmSEQ=
X-Received: by 2002:aca:815:: with SMTP id 21mr6451572oii.52.1579688343540;
 Wed, 22 Jan 2020 02:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20200117110136.305162-1-Jason@zx2c4.com> <20200122064821.dbjwljxoxo245vnp@gondor.apana.org.au>
In-Reply-To: <20200122064821.dbjwljxoxo245vnp@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 22 Jan 2020 11:18:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9p8T_1V+3FfUeAMjBLShQk08xR7RQqijov8zWS286hTNg@mail.gmail.com>
Message-ID: <CAHmME9p8T_1V+3FfUeAMjBLShQk08xR7RQqijov8zWS286hTNg@mail.gmail.com>
Subject: Re: [PATCH] crypto: allow tests to be disabled when manager is disabled
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jan 22, 2020 at 7:48 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > The library code uses CRYPTO_MANAGER_DISABLE_TESTS to conditionalize its
> > tests, but the library code can also exist without CRYPTO_MANAGER. That
> > means on minimal configs, the test code winds up being built with no way
> > to disable it.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> I think we still want to keep the extra tests option within the
> if block unless you have plans on using that option in the lib
> code as well?

I think this would be useful for the library code as well.
