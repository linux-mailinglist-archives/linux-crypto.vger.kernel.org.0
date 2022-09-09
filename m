Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585745B4191
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Sep 2022 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiIIVmQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Sep 2022 17:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIIVmN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Sep 2022 17:42:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B213B132
        for <linux-crypto@vger.kernel.org>; Fri,  9 Sep 2022 14:42:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso2614733wme.5
        for <linux-crypto@vger.kernel.org>; Fri, 09 Sep 2022 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+7gUZTKN1RNnN3ci9/lyNR5cvcW0J68JTLhQ3vnxCGE=;
        b=KI3FNKqXtOXA+08GsDYcQfo20rsDbEVGbB9PTviUFUhu87d38jUzyfdBaEdvr9wTu1
         7YKzd0mtg8I2iVZxoQdRz+P8/MBaXB9JK8SPryzEvjv1NpXd18HwAkF4b9yEQ3Sn1n0F
         yALnIP1cJimHIF/KBYvP49bxkem7XhcpEibS24SebYzxl4Y/k46SZ4yEdeSQywRRkAx0
         tX/JfQ7kEjUQX6JYho7VjazrzbWkEj734S/ALCvkNqwCADJdyNhAXUxG5PqSEhSTtonG
         yEtCgCC8ComGUSz+QpMvrTm4eteY323vBAUpb9X48G9Mpp7MR3HHlBM09JYELhydtXLG
         dmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+7gUZTKN1RNnN3ci9/lyNR5cvcW0J68JTLhQ3vnxCGE=;
        b=MQuM0uvu3TOALSWclC1lLz+z1JMA/3oiqsrjEjPwakTzV2+gNhPZojObc6/DeYGI/v
         jrQGiprKTzQG94MAAjAxNuF1idCkvSAUz7oKuaepTX8+KDJCl5fKxCtLjXZfHJ5XzTFl
         +6X/jU7EUUauE/VyGaEdVrhgfh9VEnE2EDcD9CK2/7lllW9WDdo7hmIZQoxYB7QFlmxs
         CxBqHxPig02EoVeFxfIck3nhTKRburlivYQq+63rGPcYXmTuFQ7z09SCuLp/XmenMogl
         mVVINI+eWpywUz7tyHpsoZkNUbHojnm3crXRPrjmaBCQ4apF+ATMyxURPhnwBcGcZcO+
         yKrQ==
X-Gm-Message-State: ACgBeo3Uld+Zxs9V78dr0xZ3vDjX9Zq4v+B08lDkwfQrowmEIwzSPXJJ
        ZW5msiQgqfjYqP+dO2R9ril59lb5mXBc2s2O5nNrjg==
X-Google-Smtp-Source: AA6agR6Us7LvGpTuE9bFLm53J4mE8TTx9hyp2wzRef3J/SA5Qz3Gfd+lkzE27Upvavl5JzDThz4Jf4TwvGXPEtb50QY=
X-Received: by 2002:a7b:c056:0:b0:3b4:5f7f:16b6 with SMTP id
 u22-20020a7bc056000000b003b45f7f16b6mr2718359wmc.135.1662759729393; Fri, 09
 Sep 2022 14:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662361354.git.cdleonard@gmail.com>
In-Reply-To: <cover.1662361354.git.cdleonard@gmail.com>
From:   Salam Noureddine <noureddine@arista.com>
Date:   Fri, 9 Sep 2022 14:41:58 -0700
Message-ID: <CAO7SqHBGMY4u6H6+H8iy_aZEy3F55JkW05JfrB9HsLGNOjmFyA@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] tcp: Initial support for RFC5925 auth option
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Philip Paeps <philip@trouble.is>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Caowangbao <caowangbao@huawei.com>,
        Priyaranjan Jha <priyarjha@google.com>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Leonard,

On Mon, Sep 5, 2022 at 12:06 AM Leonard Crestez <cdleonard@gmail.com> wrote=
:
>
> This is similar to TCP-MD5 in functionality but it's sufficiently
> different that packet formats and interfaces are incompatible.
> Compared to TCP-MD5 more algorithms are supported and multiple keys
> can be used on the same connection but there is still no negotiation
> mechanism.
...
>
> A completely unrelated series that implements the same features was poste=
d
> recently: https://lore.kernel.org/netdev/20220818170005.747015-1-dima@ari=
sta.com/
>
> The biggest difference is that this series puts TCP-AO key on a global
> instead of per-socket list and that it attempts to make kernel-mode
> key selection decisions instead of very strictly requiring userspace
> to make all decisions.
>

This is a departure from how md5 is implemented and the interface that
BGP developers are used to. The reason you switched your implementation
to a global database was to fix a minor race between key addition/deletion
and connections being accepted on a listening socket. This race can be
easily solved with a getsockopt() in user space. Thus it doesn=E2=80=99t ju=
stify
the complexity that a global key database brings to the implementation.
I have a few issues with that design that I would like to point out.

- Currently, a setsockopt on a given socket that adds a key will add it to =
the
global database. That opens up the door for buggy/malicious apps to install
bogus keys and mess up the connections of other apps. Also, it seems unusua=
l
for a setsockopt to affect all sockets in a namespace. This requires all us=
er
space apps to play nicely together.

- Having the keys be per-socket takes advantage of the existing socket lock=
,
simplifying synchronization and avoiding extra locks in the TCP stack.

- Caching of traffic keys becomes much easier with per-socket keys. Once
a connection is established it will typically have one or two keys on its l=
ist
with traffic keys cached. In your current implementation, a linked list of
potentially thousands of keys has to be linearly searched for each packet
and the traffic key has to be calculated before doing the actual hashing of
the packet. We believe a linear search with the extra hashing to calculate
the traffic keys will be detrimental to the performance of real world
deployments.

- Using a global database might have a benefit if the goal is to have
user space apps use tcp-ao transparently without any modifications.
This would require key matching on the local and remote ports.
But again, do we expect any apps other than BGP/LDP using tcp-ao?
If not, why the extra complexity in the kernel?


> I believe my approach greatly simplifies userspace implementation.
> The biggest difference in this iteration of the patch series is adding
> per-key lifetime values based on RFC8177 in order to implement
> kernel-mode key rollover.
>

We believe that key rotation should be done in user-space. One reason is th=
at
different vendors might have slightly different behaviors during key rotati=
on
and having the logic be in user-space is more flexible for fixing issues. I=
t=E2=80=99s
not fun having to patch the kernel every time an interop issue is discovere=
d.


> Older versions still required userspace to tweak the NOSEND/NORECV flags
> and always pick rnextkeyid explicitly, but now no active "key management"
> should be required on established socket - Just set correct flags and
> expiration dates and the kernel can perform key rollover itself. You can
> see a (simple) test of that behavior here:
>
...

Best,

Salam
