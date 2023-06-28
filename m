Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D980741948
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Jun 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjF1UK0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 28 Jun 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjF1UKW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 28 Jun 2023 16:10:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C01BEA
        for <linux-crypto@vger.kernel.org>; Wed, 28 Jun 2023 13:10:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a152a933so3599401fa.1
        for <linux-crypto@vger.kernel.org>; Wed, 28 Jun 2023 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687983019; x=1690575019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qSvBLBYpZuuz4eEfb9EgOEcdzuOPHgtqP5O4l7UwFR4=;
        b=TMW3VGndLImf+jYiCOseUyyX2GF8rDxPCjsUsg4RQIFkABsPUOhI7D6pDNpB5/29qa
         VVkjTcOP+xlPfupfAiVmWpb7oZ8UiSRzDIBxYvyPhlqIb2LxAdTz97INO+gCvfVgvb8L
         1U1/FZ6jtWNTZgWQucJHkJ3Q3p1NlihbkeWu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983019; x=1690575019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSvBLBYpZuuz4eEfb9EgOEcdzuOPHgtqP5O4l7UwFR4=;
        b=H7ubA6ayUaBriunEl8IPaW3njHbsXXlxozqzJMTf8gA7KfHgFkTAJc0zRHMjSUhdVn
         SVayfCWc/m/y9HL1ZMsDKeDQ+gc0VDlnk/Xd+AchwoIfYHewrOV/roie9cKf/N8t0RdY
         czvdYXG4EZzjDFE9EqoxuaiERRXBps95gkUISSUMwqlHzZdWNU/NQjS24GhygFypHeE7
         wD18CfTJucgxTDk3Trl5sTxCDF/3rB89NwvA3AeyPrhHNc7IyanSE7s452ZIZeUMHgQO
         BBaT99iEIk4tEwvGYImdIHgMhGbFQ3QO/rEhKJANnbR+cubGR3Jvcfh7LFTXym/Kwk/P
         kUKQ==
X-Gm-Message-State: AC+VfDwY8fqWx/xMKVm+vpFgpvmKUGFS/o6pktFeLVhyh07EaDYTC9SH
        As7qb4l/6kA9fpqt1rkUJwgqbr1gx5QF8qiAwburegkl
X-Google-Smtp-Source: ACHHUZ6+bk3hob1D/VjHi9I60KB1UiGpfH2LcFijHSaVOFpUvTSx8bE3lmHmDu4Jf2SEdDJhVk9Qiw==
X-Received: by 2002:a2e:2c0f:0:b0:2b4:765b:f6f0 with SMTP id s15-20020a2e2c0f000000b002b4765bf6f0mr20767501ljs.28.1687983019607;
        Wed, 28 Jun 2023 13:10:19 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id bo8-20020a0564020b2800b005184165f1fasm4957942edb.5.2023.06.28.13.10.18
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:10:19 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so6602861a12.3
        for <linux-crypto@vger.kernel.org>; Wed, 28 Jun 2023 13:10:18 -0700 (PDT)
X-Received: by 2002:a05:6402:148e:b0:51d:7fa6:62ca with SMTP id
 e14-20020a056402148e00b0051d7fa662camr10124675edv.14.1687983018674; Wed, 28
 Jun 2023 13:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <ZIg4b8kAeW7x/oM1@gondor.apana.org.au> <570802.1686660808@warthog.procyon.org.uk>
 <ZIrnPcPj9Zbq51jK@gondor.apana.org.au> <CAMj1kXHcDrL5YexGjwvHHY0UE1ES-KG=68ZJr7U=Ub5gzbaePg@mail.gmail.com>
 <ZJlf6VoKRf+OZJEo@gondor.apana.org.au> <CAMj1kXHQKN+mkXavvR1A57nXWpDBTiqZ+H3T65CSkJN0NmjfrQ@mail.gmail.com>
 <ZJlk2GkN8rp093q9@gondor.apana.org.au> <20230628062120.GA7546@sol.localdomain>
 <CAMj1kXEki6pK+6Gm-oHLVU3t=GzF8Kfz9QebTMKQcwtuqCsUgw@mail.gmail.com>
 <20230628173346.GA6052@sol.localdomain> <CAMj1kXGBrNZ6-WCGH7Bbw_T_2Og8JGErZPdLHLQVB58z+vrZ8A@mail.gmail.com>
 <CAHk-=wi5D7drbmMrdA+8rMGGvA-R1fUK3ZqZ=r1ccNMiDT8atA@mail.gmail.com> <3695542.1687977261@warthog.procyon.org.uk>
In-Reply-To: <3695542.1687977261@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 13:10:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2-sXtHKGTsKfcMXLkvHRDiU1nQBYwB8sLo3jXfzq+cw@mail.gmail.com>
Message-ID: <CAHk-=wg2-sXtHKGTsKfcMXLkvHRDiU1nQBYwB8sLo3jXfzq+cw@mail.gmail.com>
Subject: Re: [v2 PATCH 0/5] crypto: Add akcipher interface without SGs
To:     David Howells <dhowells@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 28 Jun 2023 at 11:34, David Howells <dhowells@redhat.com> wrote:
>
> What about something like the Intel on-die accelerators (e.g. IAA and QAT)?  I
> think they can do async compression.

I'm sure they can. And for some made-up benchmark it might even help.
Do people use it in real life?

The *big* wins come from being able to do compression/encryption
inline, when you don't need to do double-buffering etc.

Anything else is completely broken, imnsho. Once you need to
double-buffer your IO, you've already lost the whole point.

           Linus
