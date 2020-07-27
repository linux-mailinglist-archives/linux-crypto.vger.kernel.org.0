Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F116022F384
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jul 2020 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgG0PLB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jul 2020 11:11:01 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:53361 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgG0PLA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jul 2020 11:11:00 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id de4b7e5c
        for <linux-crypto@vger.kernel.org>;
        Mon, 27 Jul 2020 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Ekx2i94PiIvBd2Dn4s8i4AV8+Jk=; b=bW55JS
        QQ9yDFBh6UaCQqOQ0PgeH/vBl1Ieb2sSjRhABLtZ+An1Kl+bLg67bWK7AWDz2peX
        pLORzV3j28m4CnSbckju/0tqcNispzZZCRzEuSJEd4UWZaiogCF3oAoLc0UFn4rU
        +4piafStkMopJPJ+1JAWL0IV8ZVu7Lm0teJNB3wYrAw0WOErwcgULWPtK0n7LD0j
        YO3ZvAi3OWHK4bukm2Ovc5KvxpJNAZIBJaquObxouknCSeNYVcEX/1hCee5QRjLq
        wZrHO7hB0SDjqhjcndVVQhjEVk+I/FqJ5tb3iX8zSolW+UUVToRgo+Mwccajno0p
        Q1BP153DZJO/oJ+g==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a03670be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-crypto@vger.kernel.org>;
        Mon, 27 Jul 2020 14:47:39 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id v6so2078463iow.11
        for <linux-crypto@vger.kernel.org>; Mon, 27 Jul 2020 08:10:59 -0700 (PDT)
X-Gm-Message-State: AOAM532Vv5JJx3O19L87NFOT1VHF5VwMtrSxNJAjRpAa/j1qvyGCYMOP
        dTPFk72n9TN3Dj7f2XJkXon0qaJNkT+NF7FohLs=
X-Google-Smtp-Source: ABdhPJz3Z8OzsTOL2a5/BmHj/j2M86n7SKEmQTBz+AmLEHnXsdbYIGWBV4NsY2i04DyCkxQOOLiFaAgS7FPJX5rWNQE=
X-Received: by 2002:a05:6638:1027:: with SMTP id n7mr13691557jan.86.1595862658755;
 Mon, 27 Jul 2020 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200723075048.GA10966@gondor.apana.org.au> <CAHmME9rg-_2-Zj19zSZa6sujgfJcOdm6=L1N07Dif9aWJE7eQQ@mail.gmail.com>
 <4DE9D3CD-E934-49CE-A122-F536721ADF72@inria.fr>
In-Reply-To: <4DE9D3CD-E934-49CE-A122-F536721ADF72@inria.fr>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 27 Jul 2020 17:10:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9q+Bnf3kmPOp56eD1UgiHeW1cgHM3Mjk4hCX-DScQxYjQ@mail.gmail.com>
Message-ID: <CAHmME9q+Bnf3kmPOp56eD1UgiHeW1cgHM3Mjk4hCX-DScQxYjQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/curve25519 - Remove unused carry variables
To:     Karthik Bhargavan <karthikeyan.bhargavan@inria.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 27, 2020 at 5:08 PM Karthik Bhargavan
<karthikeyan.bhargavan@inria.fr> wrote:
>
> Removing unused variables is harmless. (GCC would do this automaticelly.)
> So this change seems fine.

Thanks for confirming.  Hopefully we can get that change upstream in
HACL* too, so that the code comes out the same.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
