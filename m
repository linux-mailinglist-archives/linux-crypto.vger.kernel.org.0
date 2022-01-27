Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BD49DE4A
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jan 2022 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiA0JnF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jan 2022 04:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiA0JnF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jan 2022 04:43:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B68C061714
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jan 2022 01:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D75561B5A
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jan 2022 09:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E757C36AE2
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jan 2022 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643276583;
        bh=XffkYekYTPvLx7uojGZ4CZc4H4qD7J2xzonqeocsWXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDJMYyj/5MkiwT7JUIqH28ETqvq6c6w683+mdn98CjfaGYDtzdaZgxLx7Rgp3DOQF
         CkvFrGVPAsjqbhKTYc/4FRcgUAzZe3bNuDipHB0/pLFVjNtX/9Z9kKXllVQYTI7YJJ
         HuacgiNhwSuRZv3pJAgMJEz3f9h8cuaHHc6ycQ24CO/PgII2Ps8n1c6OutC2fo7mdg
         QB1pdbMH5y5XY4KvNhyr12dbs5DPeiUaFaPICrgwZM2wFdnfrY359O5EnB+qioz5pV
         bwB9PD1156Ky6P45GzWE8f/EvQovPU3avfshVrFdCXkdjItArGCeyYVa4JpiNPlxm8
         GsvqtXCcgu0wg==
Received: by mail-wr1-f54.google.com with SMTP id a13so3592146wrh.9
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jan 2022 01:43:03 -0800 (PST)
X-Gm-Message-State: AOAM531ArlSmjz3R9D9siXixoNXp2VWgAlrRI6w5sUS0nPvcHlWYGJyt
        T7oLzm8MqN6xam8HND74/O5U+cLtk8Ctvt5KobI=
X-Google-Smtp-Source: ABdhPJzvbOFRXnjjHndVbAhMb94VtBsq1QnF2aCdYnSu5GGucE8QNy0HMilgphjyfveE+VjRlXX4T09+LYzp4TcJQyY=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr2164266wry.417.1643276581258;
 Thu, 27 Jan 2022 01:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20220125014422.80552-1-nhuck@google.com> <20220125014422.80552-2-nhuck@google.com>
In-Reply-To: <20220125014422.80552-2-nhuck@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Jan 2022 10:42:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHCXNZEuK7hY5MfiBE2xAHbTN=ZOtm4zKzd4=dfTErgDA@mail.gmail.com>
Message-ID: <CAMj1kXHCXNZEuK7hY5MfiBE2xAHbTN=ZOtm4zKzd4=dfTErgDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] crypto: xctr - Add XCTR support
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Paul Crowley <paulcrowley@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 25 Jan 2022 at 02:46, Nathan Huckleberry <nhuck@google.com> wrote:
>
> Add a generic implementation of XCTR mode as a template.  XCTR is a
> blockcipher mode similar to CTR mode.  XCTR uses XORs and little-endian
> addition rather than big-endian arithmetic which makes it slightly
> faster on little-endian CPUs.  It is used as a component to implement
> HCTR2.
>
> More information on XCTR mode can be found in the HCTR2 paper:
> https://eprint.iacr.org/2021/1441.pdf
>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  crypto/Kconfig        |   9 +
>  crypto/Makefile       |   1 +
>  crypto/tcrypt.c       |   1 +
>  crypto/testmgr.c      |   6 +
>  crypto/testmgr.h      | 546 ++++++++++++++++++++++++++++++++++++++++++
>  crypto/xctr.c         | 202 ++++++++++++++++
>  include/crypto/xctr.h |  19 ++
>  7 files changed, 784 insertions(+)
>  create mode 100644 crypto/xctr.c
>  create mode 100644 include/crypto/xctr.h
>
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 94bfa32cc6a1..b00de5f22eaf 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -452,6 +452,15 @@ config CRYPTO_PCBC
>           PCBC: Propagating Cipher Block Chaining mode
>           This block cipher algorithm is required for RxRPC.
>
> +config CRYPTO_XCTR
> +       tristate
> +       select CRYPTO_SKCIPHER
> +       select CRYPTO_MANAGER
> +       help
> +         XCTR: XOR Counter mode. This blockcipher mode is a variant of CTR mode
> +         using XORs and little-endian addition rather than big-endian arithmetic.
> +         XCTR mode is used to implement HCTR2.
> +
>  config CRYPTO_XTS
>         tristate "XTS support"
>         select CRYPTO_SKCIPHER
> diff --git a/crypto/Makefile b/crypto/Makefile
> index d76bff8d0ffd..6b3fe3df1489 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_CRYPTO_CTS) += cts.o
>  obj-$(CONFIG_CRYPTO_LRW) += lrw.o
>  obj-$(CONFIG_CRYPTO_XTS) += xts.o
>  obj-$(CONFIG_CRYPTO_CTR) += ctr.o
> +obj-$(CONFIG_CRYPTO_XCTR) += xctr.o
>  obj-$(CONFIG_CRYPTO_KEYWRAP) += keywrap.o
>  obj-$(CONFIG_CRYPTO_ADIANTUM) += adiantum.o
>  obj-$(CONFIG_CRYPTO_NHPOLY1305) += nhpoly1305.o
> diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> index 00149657a4bc..da7848f84d12 100644
> --- a/crypto/tcrypt.c
> +++ b/crypto/tcrypt.c
> @@ -1750,6 +1750,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
>                 ret += tcrypt_test("rfc3686(ctr(aes))");
>                 ret += tcrypt_test("ofb(aes)");
>                 ret += tcrypt_test("cfb(aes)");
> +               ret += tcrypt_test("xctr(aes)");
>                 break;
>
>         case 11:
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 5831d4bbc64f..5acf92354543 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -5454,6 +5454,12 @@ static const struct alg_test_desc alg_test_descs[] = {
>                 .suite = {
>                         .cipher = __VECS(xchacha20_tv_template)
>                 },
> +       }, {
> +               .alg = "xctr(aes)",
> +               .test = alg_test_skcipher,
> +               .suite = {
> +                       .cipher = __VECS(aes_xctr_tv_template)
> +               }
>         }, {
>                 .alg = "xts(aes)",
>                 .generic_driver = "xts(ecb(aes-generic))",
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index a253d66ba1c1..e1ebbb3c4d4c 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -32800,4 +32800,550 @@ static const struct hash_testvec blakes2s_256_tv_template[] = {{
>                           0xd5, 0x06, 0xb5, 0x3a, 0x7c, 0x7a, 0x65, 0x1d, },
>  }};
>
> +/*
> + * Test vectors generated using https://github.com/google/hctr2
> + */
> +static const struct cipher_testvec aes_xctr_tv_template[] = {
> +       {
> +               .key    = "\x06\x20\x5d\xba\x50\xb5\x12\x8e"
> +                         "\xee\x65\x3c\x59\x80\xa1\xfe\xb1",
> +               .iv     = "\x16\x52\x22\x0d\x1c\x76\x94\x9f"
> +                         "\x74\xba\x41\x0c\xc4\xc4\xaf\xb9",
> +               .ptext  = "\x02\x62\x54\x87\x28\x8f\xa1\xd3"
> +                         "\x8f\xd8\xc6\xab\x08\xef\xea\x83"
> +                         "\xa3\xbd\xf4\x85\x47\x66\x74\x11"
> +                         "\xf1\x58\x9f\x9f\xe8\xb9\x95\xc9",
> +               .ctext  = "\x11\xfe\xef\xb4\x9e\xed\x5b\xe5"
> +                         "\x92\x9b\x03\xa7\x6d\x8e\xf9\x7a"
> +                         "\xaa\xfa\x33\x4a\xf7\xd9\xb2\xeb"
> +                         "\x73\xa1\x85\xbc\x45\xbc\x42\x70",
> +               .klen   = 16,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\x19\x0e\xea\x30\x59\x8e\x39\x35"
> +                         "\x93\x63\xcc\x8b\x5f\x98\x4f\x43",
> +               .iv     = "\x4b\x9f\xf4\xd8\xaa\xcf\x99\xdc"
> +                         "\xc5\x07\xe0\xde\xb2\x6d\x85\x12",
> +               .ptext  = "\x23\x2d\x48\x15\x89\x34\x54\xf9"
> +                         "\x2b\x38\xd1\x62\x06\x98\x21\x59"
> +                         "\xd4\x3a\x45\x6f\x12\x27\x08\xa9"
> +                         "\x3e\x0f\x21\x3d\xda\x80\x92\x3f",
> +               .ctext  = "\x01\xa7\xe5\x9e\xf8\x49\xbb\x36"
> +                         "\x49\xb8\x59\x7a\x77\x3f\x5a\x10"
> +                         "\x2e\x8f\xe7\xc9\xc4\xb8\xdb\x86"
> +                         "\xe4\xc0\x6b\x60\x2f\x79\xa0\x91",
> +               .klen   = 16,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\x17\xa6\x01\x3d\x5d\xd6\xef\x2d"
> +                         "\x69\x8f\x4c\x54\x5b\xae\x43\xf0",
> +               .iv     = "\xa9\x1b\x47\x60\x26\x82\xf7\x1c"
> +                         "\x80\xf8\x88\xdd\xfb\x44\xd9\xda",
> +               .ptext  = "\xf7\x67\xcd\xa6\x04\x65\x53\x99"
> +                         "\x90\x5c\xa2\x56\x74\xd7\x9d\xf2"
> +                         "\x0b\x03\x7f\x4e\xa7\x84\x72\x2b"
> +                         "\xf0\xa5\xbf\xe6\x9a\x62\x3a\xfe"
> +                         "\x69\x5c\x93\x79\x23\x86\x64\x85"
> +                         "\xeb\x13\xb1\x5a\xd5\x48\x39\xa0"
> +                         "\x70\xfb\x06\x9a\xd7\x12\x5a\xb9"
> +                         "\xbe\xed\x2c\x81\x64\xf7\xcf\x80"
> +                         "\xee\xe6\x28\x32\x2d\x37\x4c\x32"
> +                         "\xf4\x1f\x23\x21\xe9\xc8\xc9\xbf"
> +                         "\x54\xbc\xcf\xb4\xc2\x65\x39\xdf"
> +                         "\xa5\xfb\x14\x11\xed\x62\x38\xcf"
> +                         "\x9b\x58\x11\xdd\xe9\xbd\x37\x57"
> +                         "\x75\x4c\x9e\xd5\x67\x0a\x48\xc6"
> +                         "\x0d\x05\x4e\xb1\x06\xd7\xec\x2e"
> +                         "\x9e\x59\xde\x4f\xab\x38\xbb\xe5"
> +                         "\x87\x04\x5a\x2c\x2a\xa2\x8f\x3c"
> +                         "\xe7\xe1\x46\xa9\x49\x9f\x24\xad"
> +                         "\x2d\xb0\x55\x40\x64\xd5\xda\x7e"
> +                         "\x1e\x77\xb8\x29\x72\x73\xc3\x84"
> +                         "\xcd\xf3\x94\x90\x58\x76\xc9\x2c"
> +                         "\x2a\xad\x56\xde\x33\x18\xb6\x3b"
> +                         "\x10\xe9\xe9\x8d\xf0\xa9\x7f\x05"
> +                         "\xf7\xb5\x8c\x13\x7e\x11\x3d\x1e"
> +                         "\x02\xbb\x5b\xea\x69\xff\x85\xcf"
> +                         "\x6a\x18\x97\x45\xe3\x96\xba\x4d"
> +                         "\x2d\x7a\x70\x78\x15\x2c\xe9\xdc"
> +                         "\x4e\x09\x92\x57\x04\xd8\x0b\xa6"
> +                         "\x20\x71\x76\x47\x76\x96\x89\xa0"
> +                         "\xd9\x29\xa2\x5a\x06\xdb\x56\x39"
> +                         "\x60\x33\x59\x04\x95\x89\xf6\x18"
> +                         "\x1d\x70\x75\x85\x3a\xb7\x6e",
> +               .ctext  = "\xe1\xe7\x3f\xd3\x6a\xb9\x2f\x64"
> +                         "\x37\xc5\xa4\xe9\xca\x0a\xa1\xd6"
> +                         "\xea\x7d\x39\xe5\xe6\xcc\x80\x54"
> +                         "\x74\x31\x2a\x04\x33\x79\x8c\x8e"
> +                         "\x4d\x47\x84\x28\x27\x9b\x3c\x58"
> +                         "\x54\x58\x20\x4f\x70\x01\x52\x5b"
> +                         "\xac\x95\x61\x49\x5f\xef\xba\xce"
> +                         "\xd7\x74\x56\xe7\xbb\xe0\x3c\xd0"
> +                         "\x7f\xa9\x23\x57\x33\x2a\xf6\xcb"
> +                         "\xbe\x42\x14\x95\xa8\xf9\x7a\x7e"
> +                         "\x12\x53\x3a\xe2\x13\xfe\x2d\x89"
> +                         "\xeb\xac\xd7\xa8\xa5\xf8\x27\xf3"
> +                         "\x74\x9a\x65\x63\xd1\x98\x3a\x7e"
> +                         "\x27\x7b\xc0\x20\x00\x4d\xf4\xe5"
> +                         "\x7b\x69\xa6\xa8\x06\x50\x85\xb6"
> +                         "\x7f\xac\x7f\xda\x1f\xf5\x37\x56"
> +                         "\x9b\x2f\xd3\x86\x6b\x70\xbd\x0e"
> +                         "\x55\x9a\x9d\x4b\x08\xb5\x5b\x7b"
> +                         "\xd4\x7c\xb4\x71\x49\x92\x4a\x1e"
> +                         "\xed\x6d\x11\x09\x47\x72\x32\x6a"
> +                         "\x97\x53\x36\xaf\xf3\x06\x06\x2c"
> +                         "\x69\xf1\x59\x00\x36\x95\x28\x2a"
> +                         "\xb6\xcd\x10\x21\x84\x73\x5c\x96"
> +                         "\x86\x14\x2c\x3d\x02\xdb\x53\x9a"
> +                         "\x61\xde\xea\x99\x84\x7a\x27\xf6"
> +                         "\xf7\xc8\x49\x73\x4b\xb8\xeb\xd3"
> +                         "\x41\x33\xdd\x09\x68\xe2\x64\xb8"
> +                         "\x5f\x75\x74\x97\x91\x54\xda\xc2"
> +                         "\x73\x2c\x1e\x5a\x84\x48\x01\x1a"
> +                         "\x0d\x8b\x0a\xdf\x07\x2e\xee\x77"
> +                         "\x1d\x17\x41\x7a\xc9\x33\x63\xfa"
> +                         "\x9f\xc3\x74\x57\x5f\x03\x4c",
> +               .klen   = 16,
> +               .len    = 255,
> +       },
> +       {
> +               .key    = "\xd1\x87\xd3\xa1\x97\x6a\x4b\xf9"
> +                         "\x5d\xcb\x6c\x07\x6e\x2d\x48\xad",
> +               .iv     = "\xe9\x8c\x88\x40\xa9\x52\xe0\xbc"
> +                         "\x8a\x47\x3a\x09\x5d\x60\xdd\xb2",
> +               .ptext  = "\x67\x80\x86\x46\x18\xc6\xed\xd2"
> +                         "\x99\x0f\x7a\xc3\xa5\x0b\x80\xcb"
> +                         "\x8d\xe4\x0b\x4c\x1e\x4c\x98\x46"
> +                         "\x87\x8a\x8c\x76\x75\xce\x2c\x27"
> +                         "\x74\x88\xdc\x37\xaa\x77\x53\x14"
> +                         "\xd3\x01\xcf\xb5\xcb\xdd\xb4\x8e"
> +                         "\x6b\x54\x68\x01\xc3\xdf\xbc\xdd"
> +                         "\x1a\x08\x4c\x11\xab\x25\x4b\x69"
> +                         "\x25\x21\x78\xb1\x91\x1b\x75\xfa"
> +                         "\xd0\x10\xf3\x8a\x65\xd3\x8d\x2e"
> +                         "\xf8\xb6\xce\x29\xf9\x1e\x45\x5f"
> +                         "\x4e\x41\x63\x6f\xf9\xca\x59\xd7"
> +                         "\xc8\x9c\x97\xda\xff\xab\x42\x47"
> +                         "\xfb\x2b\xca\xed\xda\x6c\x96\xe4"
> +                         "\x59\x0d\xc6\x4a\x26\xde\xa8\x50"
> +                         "\xc5\xbb\x13\xf8\xd1\xb9\x6b\xf4"
> +                         "\x19\x30\xfb\xc0\x4f\x6b\x96\xc4"
> +                         "\x88\x0b\x57\xb3\x43\xbd\xdd\xe2"
> +                         "\x06\xae\x88\x44\x41\xdf\xa4\x29"
> +                         "\x31\xd3\x38\xeb\xe9\xf8\xa2\xe4"
> +                         "\x6a\x55\x2f\x56\x58\x19\xeb\xf7"
> +                         "\x5f\x4b\x15\x52\xe4\xaa\xdc\x31"
> +                         "\x4a\x32\xc9\x31\x96\x68\x3b\x80"
> +                         "\x20\x4f\xe5\x8f\x87\xc9\x37\x58"
> +                         "\x79\xfd\xc9\xc1\x9a\x83\xe3\x8b"
> +                         "\x6b\x57\x07\xef\x28\x8d\x55\xcb"
> +                         "\x4e\xb6\xa2\xb6\xd3\x4f\x8b\x10"
> +                         "\x70\x10\x02\xf6\x74\x71\x20\x5a"
> +                         "\xe2\x2f\xb6\x46\xc5\x22\xa3\x29"
> +                         "\xf5\xc1\x25\xb0\x4d\xda\xaf\x04"
> +                         "\xca\x83\xe6\x3f\x66\x6e\x3b\xa4"
> +                         "\x09\x40\x22\xd7\x97\x12\x1e",
> +               .ctext  = "\xd4\x6d\xfa\xc8\x6e\x54\x31\x69"
> +                         "\x47\x51\x0f\xb8\xfa\x03\xa2\xe1"
> +                         "\x57\xa8\x4f\x2d\xc5\x4e\x8d\xcd"
> +                         "\x92\x0f\x71\x08\xdd\xa4\x5b\xc7"
> +                         "\x69\x3a\x3d\x93\x29\x1d\x87\x2c"
> +                         "\xfa\x96\xd2\x4d\x72\x61\xb0\x9e"
> +                         "\xa7\xf5\xd5\x09\x3d\x43\x32\x82"
> +                         "\xd2\x9a\x58\xe3\x4c\x84\xc2\xad"
> +                         "\x33\x77\x9c\x5d\x37\xc1\x4f\x95"
> +                         "\x56\x55\xc6\x76\x62\x27\x6a\xc7"
> +                         "\x45\x80\x9e\x7c\x48\xc8\x14\xbb"
> +                         "\x32\xbf\x4a\xbb\x8d\xb4\x2c\x7c"
> +                         "\x01\xfa\xc8\xde\x10\x55\xa0\xae"
> +                         "\x29\xed\xe2\x3d\xd6\x26\xfa\x3c"
> +                         "\x7a\x81\xae\xfd\xc3\x2f\xe5\x3a"
> +                         "\x00\xa3\xf0\x66\x0f\x3a\xd2\xa3"
> +                         "\xaf\x0e\x75\xbb\x79\xad\xcc\xe0"
> +                         "\x98\x10\xfb\xf1\xc0\x0c\xb9\x03"
> +                         "\x07\xee\x46\x6a\xc0\xf6\x17\x8f"
> +                         "\x7f\xc9\xad\x16\x58\x54\xb0\xd5"
> +                         "\x67\x73\x9f\xce\xea\x4b\x60\x57"
> +                         "\x1d\x62\x72\xec\xab\xe3\xd8\x32"
> +                         "\x29\x48\x37\x1b\x5c\xd6\xd0\xb7"
> +                         "\xc3\x39\xef\xf6\x1b\x18\xf6\xd1"
> +                         "\x2d\x76\x7c\x68\x50\x37\xfa\x8f"
> +                         "\x16\x87\x5e\xf8\xb1\x79\x82\x52"
> +                         "\xc7\x3e\x0e\xa3\x61\xb9\x00\xe0"
> +                         "\x2e\x03\x80\x6e\xc0\xbf\x63\x78"
> +                         "\xdf\xab\xc2\x3b\xf0\x4c\xb0\xcb"
> +                         "\x91\x6a\x26\xe6\x3a\x86\xef\x1a"
> +                         "\x4e\x4d\x23\x2d\x59\x3a\x02\x3a"
> +                         "\xf3\xda\xd1\x9d\x68\xf6\xef",
> +               .klen   = 16,
> +               .len    = 255,
> +       },
> +       {
> +               .key    = "\x17\xe6\xb1\x85\x40\x24\xbe\x80"
> +                         "\x99\xc7\xa1\x0c\x0f\x72\x31\xb8"
> +                         "\x10\xb5\x11\x21\x3a\x99\x9e\xc8",
> +               .iv     = "\x6b\x5f\xe1\x6a\xe1\x21\xfc\x62"
> +                         "\xd9\x85\x2e\x0b\xbd\x58\x79\xd1",
> +               .ptext  = "\xea\x3c\xad\x9d\x92\x05\x50\xa4"
> +                         "\x68\x56\x6b\x33\x95\xa8\x24\x6c"
> +                         "\xa0\x9d\x91\x15\x3a\x26\xb7\xeb"
> +                         "\xb4\x5d\xf7\x0c\xec\x91\xbe\x11",
> +               .ctext  = "\x6a\xac\xfc\x24\x64\x98\x28\x33"
> +                         "\xa4\x39\xfd\x72\x46\x56\x7e\xf7"
> +                         "\xd0\x7f\xee\x95\xd8\x68\x44\x67"
> +                         "\x70\x80\xd4\x69\x7a\xf5\x8d\xad",
> +               .klen   = 24,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\x02\x81\x0e\xb1\x97\xe0\x20\x0c"
> +                         "\x46\x8c\x7b\xde\xac\xe6\xe0\xb5"
> +                         "\x2e\xb3\xc0\x40\x0e\xb7\x3d\xd3",
> +               .iv     = "\x37\x15\x1c\x61\xab\x95\x8f\xf3"
> +                         "\x11\x3a\x79\xe2\xf7\x33\x96\xb3",
> +               .ptext  = "\x05\xd9\x7a\xc7\x08\x79\xba\xd8"
> +                         "\x4a\x63\x54\xf7\x4e\x0c\x98\x8a"
> +                         "\x5d\x40\x05\xe4\x7a\x7a\x14\x0c"
> +                         "\xa8\xa7\x53\xf4\x3e\x66\x81\x38",
> +               .ctext  = "\x43\x66\x70\x51\xd9\x7c\x6f\x80"
> +                         "\x82\x8e\x34\xda\x5d\x3c\x47\xd1"
> +                         "\xe0\x67\x76\xb5\x78\x98\x47\x26"
> +                         "\x41\x31\xfa\x97\xc9\x79\xeb\x15",
> +               .klen   = 24,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\x9a\xef\x58\x01\x4c\x1e\xa2\x33"
> +                         "\xce\x1f\x32\xae\xc8\x69\x1f\xf5"
> +                         "\x82\x1b\x74\xf4\x8b\x1b\xce\x30",
> +               .iv     = "\xb1\x72\x52\xa8\xc4\x8f\xb5\xec"
> +                         "\x95\x12\x14\x5f\xd2\x29\x14\x0f",
> +               .ptext  = "\x8a\xbc\x20\xbd\x67\x76\x8d\xd8"
> +                         "\xa6\x70\xf0\x74\x8c\x8d\x9c\x00"
> +                         "\xdd\xaf\xef\x28\x5d\x8d\xfa\x87"
> +                         "\x81\x39\x8c\xb1\x6e\x0a\xcf\x3c"
> +                         "\xe8\x3b\xc0\xff\x6e\xe7\xd1\xc6"
> +                         "\x70\xb8\xdf\x27\x62\x72\x8e\xb7"
> +                         "\x6b\xa7\xb2\x74\xdd\xc6\xb4\xc9"
> +                         "\x4c\xd8\x4f\x2c\x09\x75\x6e\xb7"
> +                         "\x41\xb3\x8f\x96\x09\x0d\x40\x8e"
> +                         "\x0f\x49\xc2\xad\xc4\xf7\x71\x0a"
> +                         "\x76\xfb\x45\x97\x29\x7a\xaa\x98"
> +                         "\x22\x55\x4f\x9c\x26\x01\xc8\xb9"
> +                         "\x41\x42\x51\x9d\x00\x5c\x7f\x02"
> +                         "\x9b\x00\xaa\xbd\x69\x47\x9c\x26"
> +                         "\x5b\xcb\x08\xf3\x46\x33\xf9\xeb"
> +                         "\x79\xdd\xfe\x38\x08\x84\x8c\x81"
> +                         "\xb8\x51\xbd\xcd\x72\x00\xdb\xbd"
> +                         "\xf5\xd6\xb4\x80\xf7\xd3\x49\xac"
> +                         "\x9e\xf9\xea\xd5\xad\xd4\xaa\x8f"
> +                         "\x97\x60\xce\x60\xa7\xdd\xc0\xb2"
> +                         "\x51\x80\x9b\xae\xab\x0d\x62\xab"
> +                         "\x78\x1a\xeb\x8c\x03\x6f\x30\xbf"
> +                         "\xe0\xe1\x20\x65\x74\x65\x54\x43"
> +                         "\x92\x57\xd2\x73\x8a\xeb\x99\x38"
> +                         "\xca\x78\xc8\x11\xd7\x92\x1a\x05"
> +                         "\x55\xb8\xfa\xa0\x82\xb7\xd6\x16"
> +                         "\x84\x4d\x25\xc4\xd5\xe4\x55\xf3"
> +                         "\x6c\xb3\xe4\x6e\x66\x31\x5c\x41"
> +                         "\x98\x46\x28\xd8\x71\x05\xf2\x3b"
> +                         "\xd1\x3e\x0f\x79\x7f\xf3\x30\x3f"
> +                         "\xbe\x36\xf4\x50\xbd\x0c\x89\xd5"
> +                         "\xcb\x53\x9f\xeb\x56\xf4\x3f",
> +               .ctext  = "\xee\x90\xe1\x45\xf5\xab\x04\x23"
> +                         "\x70\x0a\x54\x49\xac\x34\xb8\x69"
> +                         "\x3f\xa8\xce\xef\x6e\x63\xc1\x20"
> +                         "\x7a\x41\x43\x5d\xa2\x29\x71\x1d"
> +                         "\xd2\xbb\xb1\xca\xb4\x3a\x5a\xf3"
> +                         "\x0a\x68\x0b\x9d\x6f\x68\x60\x9e"
> +                         "\x9d\xb9\x23\x68\xbb\xdd\x12\x31"
> +                         "\xc6\xd6\xf9\xb3\x80\xe8\xb5\xab"
> +                         "\x84\x2a\x8e\x7b\xb2\x4f\xee\x31"
> +                         "\x83\xc4\x1c\x80\x89\xe4\xe7\xd2"
> +                         "\x00\x65\x98\xd1\x57\xcc\xf6\x87"
> +                         "\x14\xf1\x23\x22\x78\x61\xc7\xb6"
> +                         "\xf5\x90\x97\xdd\xcd\x90\x98\xd8"
> +                         "\xbb\x02\xfa\x2c\xf0\x89\xfc\x7e"
> +                         "\xe7\xcd\xee\x41\x3f\x73\x4a\x08"
> +                         "\xf8\x8f\xf3\xbf\x3a\xd5\xce\xb7"
> +                         "\x7a\xf4\x49\xcd\x3f\xc7\x1f\x77"
> +                         "\x98\xd0\x9d\x82\x20\x8a\x04\x5d"
> +                         "\x9f\x77\xcb\xf4\x38\x92\x47\xce"
> +                         "\x6d\xc3\x51\xc1\xd9\xf4\x2f\x65"
> +                         "\x67\x01\xf4\x46\x3b\xd2\x90\x5d"
> +                         "\x2a\xcb\xc5\x39\x1c\x72\xa5\xba"
> +                         "\xaf\x80\x9b\x87\x01\x85\xa1\x02"
> +                         "\xdf\x79\x4c\x27\x77\x3e\xfc\xb3"
> +                         "\x96\xbc\x42\xad\xdf\xa4\x16\x1e"
> +                         "\x77\xe7\x39\xcc\x78\x2c\xc1\x00"
> +                         "\xe5\xa6\xb5\x9b\x0c\x12\x19\xc5"
> +                         "\x8b\xbe\xae\x4b\xc3\xa3\x91\x8f"
> +                         "\x5b\x82\x0f\x20\x30\x35\x45\x26"
> +                         "\x29\x84\x2e\xc8\x2d\xce\xae\xac"
> +                         "\xbe\x93\x50\x7a\x6a\x01\x08\x38"
> +                         "\xf5\x49\x4d\x8b\x7e\x96\x70",
> +               .klen   = 24,
> +               .len    = 255,
> +       },
> +       {
> +               .key    = "\x2c\x3c\x6c\x78\xaa\x83\xed\x14"
> +                         "\x4e\xe5\xe2\x3e\x1e\x89\xcb\x2f"
> +                         "\x19\x5a\x70\x50\x09\x81\x43\x75",
> +               .iv     = "\xa5\x57\x8e\x3c\xba\x52\x87\x4f"
> +                         "\xb7\x45\x26\xab\x31\xb9\x58\xfa",
> +               .ptext  = "\x43\x29\x69\x02\xf0\xc0\x64\xf3"
> +                         "\xe1\x85\x75\x25\x11\x5d\x18\xf8"
> +                         "\xdc\x96\x82\x1b\xee\x4d\x01\xd2"
> +                         "\x28\x83\xbb\xfe\xe1\x72\x14\x3c"
> +                         "\xe9\xe5\x9f\x8c\x40\xb5\x0a\xaa"
> +                         "\x9f\xb8\xc5\xf1\x01\x05\x65\x79"
> +                         "\x90\x05\xeb\xac\xa8\x52\x35\xc4"
> +                         "\x2d\x56\x0d\xe1\x37\x09\xb8\xec"
> +                         "\x51\xd8\x79\x13\x5b\x85\x8c\x14"
> +                         "\x77\xe3\x64\xea\x89\xb1\x04\x9d"
> +                         "\x6c\x58\x1b\x51\x54\x1f\xc7\x2f"
> +                         "\xc8\x3d\xa6\x93\x39\xce\x77\x3a"
> +                         "\x93\xc2\xaa\x88\xcc\x09\xfa\xc4"
> +                         "\x5e\x92\x3b\x46\xd2\xd6\xd4\x5d"
> +                         "\x31\x58\xc5\xc6\x30\xb8\x7f\x77"
> +                         "\x0f\x1b\xf8\x9a\x7d\x3f\x56\x90"
> +                         "\x61\x8f\x08\x8f\x61\x64\x8e\xf4"
> +                         "\xaa\x7c\xf8\x4c\x0b\xab\x47\x2a"
> +                         "\x0d\xa7\x24\x36\x59\xfe\x94\xfc"
> +                         "\x38\x38\x32\xdf\x73\x1b\x75\xb1"
> +                         "\x6f\xa2\xd8\x0b\xa1\xd4\x31\x58"
> +                         "\xaa\x24\x11\x22\xc9\xf7\x83\x3c"
> +                         "\x6e\xee\x75\xc0\xdd\x3b\x21\x99"
> +                         "\x9f\xde\x81\x9c\x2a\x70\xc4\xb8"
> +                         "\xc6\x27\x4e\x5d\x9a\x4a\xe1\x75"
> +                         "\x01\x95\x47\x87\x3f\x9a\x69\x20"
> +                         "\xb4\x66\x70\x1a\xe2\xb3\x6c\xfa"
> +                         "\x1f\x6e\xf9\xc3\x8a\x1f\x0b\x0b"
> +                         "\xc5\x92\xba\xd9\xf8\x27\x6b\x97"
> +                         "\x01\xe2\x38\x01\x7f\x06\xde\x54"
> +                         "\xb7\x78\xbc\x7d\x6a\xa1\xf2\x6f"
> +                         "\x62\x42\x30\xbf\xb1\x6d\xc7",
> +               .ctext  = "\x53\xc0\xb3\x13\x8f\xbf\x88\x1a"
> +                         "\x6f\xda\xad\x0b\x33\x8b\x82\x9d"
> +                         "\xca\x17\x32\x65\xaa\x72\x24\x1b"
> +                         "\x95\x33\xcc\x5b\x58\x5d\x08\x58"
> +                         "\xe5\x52\xc0\xb7\xc6\x97\x77\x66"
> +                         "\xbd\xf4\x50\xde\xe1\xf0\x70\x61"
> +                         "\xc2\x05\xce\xe0\x90\x2f\x7f\xb3"
> +                         "\x04\x7a\xee\xbe\xb3\xb7\xaf\xda"
> +                         "\x3c\xb8\x95\xb4\x20\xba\x66\x0b"
> +                         "\x97\xcc\x07\x3f\x22\x07\x0e\xea"
> +                         "\x76\xd8\x32\xf9\x34\x47\xcb\xaa"
> +                         "\xb3\x5a\x06\x68\xac\x94\x10\x39"
> +                         "\xf2\x70\xe1\x7b\x98\x5c\x0c\xcb"
> +                         "\x8f\xd8\x48\xfa\x2e\x15\xa1\xf1"
> +                         "\x2f\x85\x55\x39\xd8\x24\xe6\xc1"
> +                         "\x6f\xd7\x52\x97\x42\x7a\x2e\x14"
> +                         "\x39\x74\x16\xf3\x8b\xbd\x38\xb9"
> +                         "\x54\x20\xc6\x31\x1b\x4c\xb7\x26"
> +                         "\xd4\x71\x63\x97\xaa\xbf\xf5\xb7"
> +                         "\x17\x5e\xee\x14\x67\x38\x14\x11"
> +                         "\xf6\x98\x3c\x70\x4a\x89\xf4\x27"
> +                         "\xb4\x72\x7a\xc0\x5d\x58\x3d\x8b"
> +                         "\xf6\xf7\x80\x7b\xa9\xa7\x4d\xf8"
> +                         "\x1a\xbe\x07\x0c\x06\x97\x25\xc8"
> +                         "\x5a\x18\xae\x21\xa6\xe4\x77\x13"
> +                         "\x5a\xe5\xf5\xe0\xd5\x48\x73\x22"
> +                         "\x68\xde\x70\x05\xc4\xdf\xd5\x7c"
> +                         "\xa0\x2b\x99\x9c\xa8\x21\xd7\x6c"
> +                         "\x55\x97\x09\xd6\xb0\x62\x93\x90"
> +                         "\x14\xb1\xd1\x83\x5a\xb3\x17\xb9"
> +                         "\xc7\xcc\x6b\x51\x23\x44\x4b\xef"
> +                         "\x48\x0f\x0f\xf0\x0e\xa1\x8f",
> +               .klen   = 24,
> +               .len    = 255,
> +       },
> +       {
> +               .key    = "\xed\xd1\xcf\x81\x1c\xf8\x9d\x56"
> +                         "\xd4\x3b\x86\x4b\x65\x96\xfe\xe8"
> +                         "\x8a\xd4\x3b\xd7\x76\x07\xab\xf4"
> +                         "\xe9\xae\xd1\x4d\x50\x9b\x94\x1c",
> +               .iv     = "\x09\x90\xf3\x7c\x15\x99\x7d\x94"
> +                         "\x88\xf4\x99\x19\xd1\x62\xc4\x65",
> +               .ptext  = "\xa2\x06\x41\x55\x60\x2c\xe3\x76"
> +                         "\xa9\xaf\xf9\xe1\xd7\x0d\x65\x49"
> +                         "\xda\x27\x0d\xf8\xec\xdc\x09\x2b"
> +                         "\x06\x24\xe4\xd5\x15\x29\x6b\x5f",
> +               .ctext  = "\xad\x5c\xd0\xc1\x03\x45\xba\x9d"
> +                         "\xab\x6d\x82\xae\xf7\x8e\x2b\x8b"
> +                         "\xd8\x61\xe6\x96\x5c\x5c\xe2\x70"
> +                         "\xe5\x19\x0a\x04\x60\xca\x45\xfc",
> +               .klen   = 32,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\xf8\x75\xa6\xba\x7b\x00\xf0\x71"
> +                         "\x24\x5d\xdf\x93\x8b\xa3\x7d\x6d"
> +                         "\x8e\x0f\x65\xf4\xe2\xbe\x2b\xaa"
> +                         "\x2a\x0d\x9e\x00\x6a\x94\x80\xa1",
> +               .iv     = "\xb9\xb7\x55\x26\x5f\x96\x16\x68"
> +                         "\x5c\x5f\x58\xbb\x4e\x5a\xe1\x3b",
> +               .ptext  = "\x2f\xd9\x2c\xc2\x98\x1e\x81\x5e"
> +                         "\x89\xc8\xec\x1f\x56\x3e\xd9\xa4"
> +                         "\x92\x48\xec\xfc\x5d\xeb\x7f\xad"
> +                         "\x7a\x47\xe6\xda\x71\x1b\x2e\xfa",
> +               .ctext  = "\x25\x5e\x38\x20\xcf\xbe\x4c\x6c"
> +                         "\xe6\xce\xfc\xe2\xca\x6a\xa1\x62"
> +                         "\x3a\xb7\xdf\x21\x3e\x49\xa6\xb8"
> +                         "\x22\xd2\xc8\x37\xa4\x55\x09\xe6",
> +               .klen   = 32,
> +               .len    = 32,
> +       },
> +       {
> +               .key    = "\x32\x37\x2b\x8f\x7b\xb1\x23\x79"
> +                         "\x05\x52\xde\x05\xf1\x68\x3f\x6c"
> +                         "\xa4\xae\xbc\x21\xc2\xc6\xf0\xbd"
> +                         "\x0f\x20\xb7\xa4\xc5\x05\x7b\x64",
> +               .iv     = "\xff\x26\x4e\x67\x48\xdd\xcf\xfe"
> +                         "\x42\x09\x04\x98\x5f\x1e\xfa\x80",
> +               .ptext  = "\x99\xdc\x3b\x19\x41\xf9\xff\x6e"
> +                         "\x76\xb5\x03\xfa\x61\xed\xf8\x44"
> +                         "\x70\xb9\xf0\x83\x80\x6e\x31\x77"
> +                         "\x77\xe4\xc7\xb4\x77\x02\xab\x91"
> +                         "\x82\xc6\xf8\x7c\x46\x61\x03\x69"
> +                         "\x09\xa0\xf7\x12\xb7\x81\x6c\xa9"
> +                         "\x10\x5c\xbb\x55\xb3\x44\xed\xb5"
> +                         "\xa2\x52\x48\x71\x90\x5d\xda\x40"
> +                         "\x0b\x7f\x4a\x11\x6d\xa7\x3d\x8e"
> +                         "\x1b\xcd\x9d\x4e\x75\x8b\x7d\x87"
> +                         "\xe5\x39\x34\x32\x1e\xe6\x8d\x51"
> +                         "\xd4\x1f\xe3\x1d\x50\xa0\x22\x37"
> +                         "\x7c\xb0\xd9\xfb\xb6\xb2\x16\xf6"
> +                         "\x6d\x26\xa0\x4e\x8c\x6a\xe6\xb6"
> +                         "\xbe\x4c\x7c\xe3\x88\x10\x18\x90"
> +                         "\x11\x50\x19\x90\xe7\x19\x3f\xd0"
> +                         "\x31\x15\x0f\x06\x96\xfe\xa7\x7b"
> +                         "\xc3\x32\x88\x69\xa4\x12\xe3\x64"
> +                         "\x02\x30\x17\x74\x6c\x88\x7c\x9b"
> +                         "\xd6\x6d\x75\xdf\x11\x86\x70\x79"
> +                         "\x48\x7d\x34\x3e\x33\x58\x07\x8b"
> +                         "\xd2\x50\xac\x35\x15\x45\x05\xb4"
> +                         "\x4d\x31\x97\x19\x87\x23\x4b\x87"
> +                         "\x53\xdc\xa9\x19\x78\xf1\xbf\x35"
> +                         "\x30\x04\x14\xd4\xcf\xb2\x8c\x87"
> +                         "\x7d\xdb\x69\xc9\xcd\xfe\x40\x3e"
> +                         "\x8d\x66\x5b\x61\xe5\xf0\x2d\x87"
> +                         "\x93\x3a\x0c\x2b\x04\x98\x05\xc2"
> +                         "\x56\x4d\xc4\x6c\xcd\x7a\x98\x7e"
> +                         "\xe2\x2d\x79\x07\x91\x9f\xdf\x2f"
> +                         "\x72\xc9\x8f\xcb\x0b\x87\x1b\xb7"
> +                         "\x04\x86\xcb\x47\xfa\x5d\x03",
> +               .ctext  = "\x0b\x00\xf7\xf2\xc8\x6a\xba\x9a"
> +                         "\x0a\x97\x18\x7a\x00\xa0\xdb\xf4"
> +                         "\x5e\x8e\x4a\xb7\xe0\x51\xf1\x75"
> +                         "\x17\x8b\xb4\xf1\x56\x11\x05\x9f"
> +                         "\x2f\x2e\xba\x67\x04\xe1\xb4\xa5"
> +                         "\xfc\x7c\x8c\xad\xc6\xb9\xd1\x64"
> +                         "\xca\xbd\x5d\xaf\xdb\x65\x48\x4f"
> +                         "\x1b\xb3\x94\x5c\x0b\xd0\xee\xcd"
> +                         "\xb5\x7f\x43\x8a\xd8\x8b\x66\xde"
> +                         "\xd2\x9c\x13\x65\xa4\x47\xa7\x03"
> +                         "\xc5\xa1\x46\x8f\x2f\x84\xbc\xef"
> +                         "\x48\x9d\x9d\xb5\xbd\x43\xff\xd2"
> +                         "\xd2\x7a\x5a\x13\xbf\xb4\xf6\x05"
> +                         "\x17\xcd\x01\x12\xf0\x35\x27\x96"
> +                         "\xf4\xc1\x65\xf7\x69\xef\x64\x1b"
> +                         "\x6e\x4a\xe8\x77\xce\x83\x01\xb7"
> +                         "\x60\xe6\x45\x2a\xcd\x41\x4a\xb5"
> +                         "\x8e\xcc\x45\x93\xf1\xd6\x64\x5f"
> +                         "\x32\x60\xe4\x29\x4a\x82\x6c\x86"
> +                         "\x16\xe4\xcc\xdb\x5f\xc8\x11\xa6"
> +                         "\xfe\x88\xd6\xc3\xe5\x5c\xbb\x67"
> +                         "\xec\xa5\x7b\xf5\xa8\x4f\x77\x25"
> +                         "\x5d\x0c\x2a\x99\xf9\xb9\xd1\xae"
> +                         "\x3c\x83\x2a\x93\x9b\x66\xec\x68"
> +                         "\x2c\x93\x02\x8a\x8a\x1e\x2f\x50"
> +                         "\x09\x37\x19\x5c\x2a\x3a\xc2\xcb"
> +                         "\xcb\x89\x82\x81\xb7\xbb\xef\x73"
> +                         "\x8b\xc9\xae\x42\x96\xef\x70\xc0"
> +                         "\x89\xc7\x3e\x6a\x26\xc3\xe4\x39"
> +                         "\x53\xa9\xcf\x63\x7d\x05\xf3\xff"
> +                         "\x52\x04\xf6\x7f\x23\x96\xe9\xf7"
> +                         "\xff\xd6\x50\xa3\x0e\x20\x71",
> +               .klen   = 32,
> +               .len    = 255,
> +       },
> +       {
> +               .key    = "\x49\x85\x84\x69\xd4\x5f\xf9\xdb"
> +                         "\xf2\xc4\x1c\x62\x20\x88\xea\x8a"
> +                         "\x5b\x69\xe6\x3b\xe2\x5c\xfe\xce"
> +                         "\xe1\x7a\x27\x7b\x1c\xc9\xb4\x43",
> +               .iv     = "\xae\x98\xdb\xef\x5c\x6b\xe9\x27"
> +                         "\x1a\x2f\x51\x17\x97\x7d\x4f\x10",
> +               .ptext  = "\xbe\xf2\x8f\x8a\x51\x9e\x3d\xff"
> +                         "\xd7\x68\x0f\xd2\xf2\x5b\xe3\xa5"
> +                         "\x59\x3e\xcd\xab\x46\xc6\xe9\x24"
> +                         "\x43\xbc\xb8\x37\x1f\x55\x7f\xb5"
> +                         "\xc0\xa6\x68\xdf\xbf\x21\x1e\xed"
> +                         "\x67\x73\xb7\x06\x47\xff\x67\x07"
> +                         "\x5b\x94\xab\xef\x43\x95\x52\xce"
> +                         "\xe7\x71\xbd\x72\x5b\x3a\x25\x01"
> +                         "\xed\x7d\x02\x2d\x72\xd6\xc4\x3d"
> +                         "\xd2\xf5\xe5\xb3\xf2\xd7\xa1\x8d"
> +                         "\x12\x0d\x3b\x4a\x58\xf4\x1b\xfd"
> +                         "\xcd\x2c\x13\x05\x07\x3d\x30\x8a"
> +                         "\x1f\xc6\xed\xfc\x7c\x3c\xa6\x1c"
> +                         "\x64\x2c\x36\xa8\x5d\xe2\xfa\x12"
> +                         "\xd7\x17\xa9\x39\x43\x63\xbf\x44"
> +                         "\xd0\xcb\x4c\xf0\xab\xe6\x75\xd6"
> +                         "\x60\xd1\x64\x9e\x01\x2b\x97\x52"
> +                         "\x97\x24\x32\xb0\xfa\x22\xf4\x04"
> +                         "\xe6\x98\x6a\xbc\xba\xe8\x65\xad"
> +                         "\x60\x08\xfc\xd7\x40\xf8\x2a\xf2"
> +                         "\x5e\x32\x32\x82\x24\x12\xda\xbc"
> +                         "\x8f\x1c\xd4\x06\x81\x08\x80\x35"
> +                         "\x20\xa5\xa8\x3a\x6e\x3e\x2f\x78"
> +                         "\xe4\x7d\x9e\x81\x43\xb8\xfe\xa7"
> +                         "\x3b\xa9\x9b\x1a\xe7\xce\xd2\x3d"
> +                         "\xc1\x27\x26\x22\x35\x12\xa2\xc6"
> +                         "\x59\x51\x22\x31\x7b\xc8\xca\xa6"
> +                         "\xa9\xf3\x16\x57\x72\x3d\xfa\x24"
> +                         "\x66\x56\x5d\x21\x29\x9e\xf2\xff"
> +                         "\xae\x0c\x71\xcf\xc5\xf0\x98\xe5"
> +                         "\xa1\x05\x96\x94\x3e\x36\xed\x97"
> +                         "\xc7\xee\xcd\xc2\x54\x35\x5c",
> +               .ctext  = "\xde\x7f\x5e\xac\x6f\xec\xed\x2a"
> +                         "\x3a\x3b\xb3\x36\x19\x46\x26\x27"
> +                         "\x09\x7b\x49\x47\x1b\x88\x43\xb7"
> +                         "\x65\x67\xef\x0b\xe4\xde\x0a\x97"
> +                         "\x7f\xab\x32\x7c\xa2\xde\x4e\xba"
> +                         "\x11\x9b\x19\x12\x7d\x03\x01\x15"
> +                         "\xa3\x90\x9f\x52\x9d\x29\x3d\x5c"
> +                         "\xc6\x71\x59\x2c\x44\x8f\xb7\x8c"
> +                         "\x0d\x75\x81\x76\xe2\x11\x96\x41"
> +                         "\xae\x48\x27\x0e\xbc\xaf\x1d\xf5"
> +                         "\x51\x68\x5a\x34\xe5\x6d\xdf\x60"
> +                         "\xc7\x9d\x4e\x1a\xaa\xb5\x1a\x57"
> +                         "\x58\x6a\xa4\x79\x0a\xa9\x50\x8d"
> +                         "\x93\x59\xef\x5b\x23\xdb\xc8\xb3"
> +                         "\x38\x96\x8c\xdf\x7d\x6a\x3d\x53"
> +                         "\x84\x9d\xb0\xf0\x07\x5f\xff\x67"
> +                         "\xff\x5b\x3c\x8b\x1f\xa2\x3b\xcf"
> +                         "\xf5\x86\x7c\xbc\x98\x38\x7a\xe5"
> +                         "\x96\x56\xba\x44\x85\x29\x4f\x3a"
> +                         "\x64\xde\xec\xc6\x53\xf0\x30\xca"
> +                         "\xa4\x90\x4f\x9c\x2e\x0e\xec\x2d"
> +                         "\x8c\x38\x1c\x93\x9a\x5d\x5d\x98"
> +                         "\xf9\x2c\xf7\x27\x71\x3c\x69\xa9"
> +                         "\x0b\xec\xd9\x9c\x6c\x69\x09\x47"
> +                         "\xd9\xc2\x84\x6e\x3e\x2d\x9f\x1f"
> +                         "\xb6\x13\x62\x4c\xf3\x33\x44\x13"
> +                         "\x6c\x43\x0a\xae\x8e\x89\xd6\x27"
> +                         "\xdd\xc3\x5b\x37\x62\x09\x47\x94"
> +                         "\xe3\xea\x7d\x08\x14\x70\xb1\x8e"
> +                         "\x83\x4a\xcb\xc0\xa9\xf2\xa3\x02"
> +                         "\xe9\xa0\x44\xfe\xcf\x5a\x15\x50"
> +                         "\xc4\x5a\x6f\xc8\xd6\xf1\x83",
> +               .klen   = 32,
> +               .len    = 255,
> +       },
> +};
> +
>  #endif /* _CRYPTO_TESTMGR_H */
> diff --git a/crypto/xctr.c b/crypto/xctr.c
> new file mode 100644
> index 000000000000..dfb44c092cc4
> --- /dev/null
> +++ b/crypto/xctr.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * XCTR: XOR Counter mode - Adapted from ctr.c
> + *
> + * (C) Copyright IBM Corp. 2007 - Joy Latten <latten@us.ibm.com>
> + * Copyright 2021 Google LLC
> + */
> +
> +/*
> + * XCTR mode is a blockcipher mode of operation used to implement HCTR2. XCTR is
> + * closely related to the CTR mode of operation; the main difference is that CTR
> + * generates the keystream using E(CTR + IV) whereas XCTR generates the
> + * keystream using E(CTR ^ IV).
> + *
> + * See the HCTR2 paper for more details:
> + *     Length-preserving encryption with HCTR2
> + *      (https://eprint.iacr.org/2021/1441.pdf)
> + */
> +
> +#include <crypto/algapi.h>
> +#include <crypto/xctr.h>
> +#include <crypto/internal/cipher.h>
> +#include <crypto/internal/skcipher.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +static void crypto_xctr_crypt_final(struct skcipher_walk *walk,
> +                                  struct crypto_cipher *tfm, u32 byte_ctr)
> +{
> +       unsigned int bsize = crypto_cipher_blocksize(tfm);
> +       unsigned long alignmask = crypto_cipher_alignmask(tfm);
> +       u8 ctr[MAX_CIPHER_BLOCKSIZE];
> +       u8 ctrblk[MAX_CIPHER_BLOCKSIZE];
> +       u8 tmp[MAX_CIPHER_BLOCKSIZE + MAX_CIPHER_ALIGNMASK];
> +       u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
> +       u8 *src = walk->src.virt.addr;
> +       u8 *dst = walk->dst.virt.addr;
> +       unsigned int nbytes = walk->nbytes;
> +       u32 ctr32 = byte_ctr / bsize + 1;
> +
> +       u32_to_le_block(ctr, ctr32, bsize);
> +       crypto_xor_cpy(ctrblk, ctr, walk->iv, bsize);
> +       crypto_cipher_encrypt_one(tfm, keystream, ctrblk);
> +       crypto_xor_cpy(dst, keystream, src, nbytes);
> +}
> +
> +static int crypto_xctr_crypt_segment(struct skcipher_walk *walk,
> +                                   struct crypto_cipher *tfm, u32 byte_ctr)
> +{
> +       void (*fn)(struct crypto_tfm *, u8 *, const u8 *) =
> +                  crypto_cipher_alg(tfm)->cia_encrypt;
> +       unsigned int bsize = crypto_cipher_blocksize(tfm);
> +       u8 ctr[MAX_CIPHER_BLOCKSIZE];
> +       u8 ctrblk[MAX_CIPHER_BLOCKSIZE];
> +       u8 *src = walk->src.virt.addr;
> +       u8 *dst = walk->dst.virt.addr;
> +       unsigned int nbytes = walk->nbytes;
> +       u32 ctr32 = byte_ctr / bsize + 1;
> +
> +       do {
> +               /* create keystream */
> +               u32_to_le_block(ctr, ctr32, bsize);
> +               crypto_xor_cpy(ctrblk, ctr, walk->iv, bsize);
> +               fn(crypto_cipher_tfm(tfm), dst, ctrblk);
> +               crypto_xor(dst, src, bsize);
> +
> +               ctr32++;
> +
> +               src += bsize;
> +               dst += bsize;
> +       } while ((nbytes -= bsize) >= bsize);
> +
> +       return nbytes;
> +}
> +
> +static int crypto_xctr_crypt_inplace(struct skcipher_walk *walk,
> +                                   struct crypto_cipher *tfm, u32 byte_ctr)
> +{
> +       void (*fn)(struct crypto_tfm *, u8 *, const u8 *) =
> +                  crypto_cipher_alg(tfm)->cia_encrypt;
> +       unsigned int bsize = crypto_cipher_blocksize(tfm);
> +       unsigned long alignmask = crypto_cipher_alignmask(tfm);
> +       unsigned int nbytes = walk->nbytes;
> +       u8 ctr[MAX_CIPHER_BLOCKSIZE];
> +       u8 ctrblk[MAX_CIPHER_BLOCKSIZE];
> +       u8 *src = walk->src.virt.addr;
> +       u8 tmp[MAX_CIPHER_BLOCKSIZE + MAX_CIPHER_ALIGNMASK];
> +       u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
> +       u32 ctr32 = byte_ctr / bsize + 1;
> +
> +       u32_to_le_block(ctr, ctr32, bsize);
> +       do {
> +               /* create keystream */
> +               u32_to_le_block(ctr, ctr32, bsize);
> +               crypto_xor_cpy(ctrblk, ctr, walk->iv, bsize);
> +               fn(crypto_cipher_tfm(tfm), keystream, ctrblk);
> +               crypto_xor(src, keystream, bsize);
> +
> +               ctr32++;
> +
> +               src += bsize;
> +       } while ((nbytes -= bsize) >= bsize);
> +
> +       return nbytes;
> +}
> +
> +static int crypto_xctr_crypt(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct crypto_cipher *cipher = skcipher_cipher_simple(tfm);
> +       const unsigned int bsize = crypto_cipher_blocksize(cipher);
> +       struct skcipher_walk walk;
> +       unsigned int nbytes;
> +       int err;
> +       u32 byte_ctr = 0;
> +
> +       err = skcipher_walk_virt(&walk, req, false);
> +
> +       while (walk.nbytes >= bsize) {
> +               if (walk.src.virt.addr == walk.dst.virt.addr)
> +                       nbytes = crypto_xctr_crypt_inplace(&walk, cipher, byte_ctr);
> +               else
> +                       nbytes = crypto_xctr_crypt_segment(&walk, cipher, byte_ctr);
> +
> +               byte_ctr += walk.nbytes - nbytes;
> +               err = skcipher_walk_done(&walk, nbytes);
> +       }
> +
> +       if (walk.nbytes) {
> +               crypto_xctr_crypt_final(&walk, cipher, byte_ctr);
> +               err = skcipher_walk_done(&walk, 0);
> +       }
> +
> +       return err;
> +}
> +
> +static int crypto_xctr_create(struct crypto_template *tmpl, struct rtattr **tb)
> +{
> +       struct skcipher_instance *inst;
> +       struct crypto_alg *alg;
> +       int err;
> +
> +       inst = skcipher_alloc_instance_simple(tmpl, tb);
> +       if (IS_ERR(inst))
> +               return PTR_ERR(inst);
> +
> +       alg = skcipher_ialg_simple(inst);
> +
> +       /* Block size must be >= 4 bytes. */
> +       err = -EINVAL;
> +       if (alg->cra_blocksize < 4)
> +               goto out_free_inst;
> +
> +       /* XCTR mode is a stream cipher. */
> +       inst->alg.base.cra_blocksize = 1;
> +
> +       /*
> +        * To simplify the implementation, configure the skcipher walk to only
> +        * give a partial block at the very end, never earlier.
> +        */
> +       inst->alg.chunksize = alg->cra_blocksize;
> +
> +       inst->alg.encrypt = crypto_xctr_crypt;
> +       inst->alg.decrypt = crypto_xctr_crypt;
> +
> +       err = skcipher_register_instance(tmpl, inst);
> +       if (err) {
> +out_free_inst:
> +               inst->free(inst);
> +       }
> +
> +       return err;
> +}
> +
> +static struct crypto_template crypto_xctr_tmpl[] = {
> +       {
> +               .name = "xctr",
> +               .create = crypto_xctr_create,
> +               .module = THIS_MODULE,
> +       }
> +};
> +
> +static int __init crypto_xctr_module_init(void)
> +{
> +       return crypto_register_template(crypto_xctr_tmpl);
> +}
> +
> +static void __exit crypto_xctr_module_exit(void)
> +{
> +       crypto_unregister_template(crypto_xctr_tmpl);
> +}
> +
> +subsys_initcall(crypto_xctr_module_init);
> +module_exit(crypto_xctr_module_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("XCTR block cipher mode of operation");
> +MODULE_ALIAS_CRYPTO("xctr");
> +MODULE_IMPORT_NS(CRYPTO_INTERNAL);
> diff --git a/include/crypto/xctr.h b/include/crypto/xctr.h
> new file mode 100644
> index 000000000000..0d025e08ca26
> --- /dev/null
> +++ b/include/crypto/xctr.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * XCTR: XOR Counter mode
> + *
> + * Copyright 2021 Google LLC
> + */
> +
> +#include <asm/unaligned.h>
> +
> +#ifndef _CRYPTO_XCTR_H
> +#define _CRYPTO_XCTR_H
> +
> +static inline void u32_to_le_block(u8 *a, u32 x, unsigned int size)
> +{
> +       memset(a, 0, size);
> +       put_unaligned(cpu_to_le32(x), (u32 *)a);

Please use put_unaligned_le32() here.

And casting 'a' to (u32 *) is invalid C, so just pass 'a' directly.
Otherwise, the compiler might infer that 'a' is guaranteed to be
aligned after all, and use an aligned access instead.


> +}
> +
> +#endif  /* _CRYPTO_XCTR_H */
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
