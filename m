Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47539DBE2C
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Oct 2019 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfJRHR6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Oct 2019 03:17:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43690 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfJRHR6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Oct 2019 03:17:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id r9so3765516edl.10;
        Fri, 18 Oct 2019 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGiNQDSIY7V5wf3Wwkmcj/zczw0jkTCmEF2SqSQNw0w=;
        b=Om+UXzNLlCF8TQBVuo0s9jY8DvJsMoSBB9Mnw5VKwz2UH62ZAL3P7oD+5KfZ/auo5l
         oubPUdvE1LZr5rgppDu0eQrWbWYGfX8pI1GoLh7tR9gYtyg6FmBrwUtaZq3HPHZWR8xD
         TRDPmgg/RQdCbVb/LzBmN4HnbUnWHp54rTwfaKiIMUCZj61BP6DebvQZVUCFA02Lvu65
         DRpt6G8z+Ja0MK7zgsp36wDV8IITyelydaS6DgoOEUzC1LdSJ6RLn7fmfnB2xHYwehP8
         GpxCQ24enLOoYLCjN2B7S/bUTkxzPJ+4n9so9k86Yipo1fYJNV4wTaLArS5myifZ5mIM
         KQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGiNQDSIY7V5wf3Wwkmcj/zczw0jkTCmEF2SqSQNw0w=;
        b=lnA+fiwUHNZoY7hsraT/GKbps58ucC0JtT8Ep27YsG6WnGzA6JR6zmHERC43G+F5Ns
         yVZwMjYyFKK997OFOYve9yjDyAbWAJhKl3DbIj5MnzpyWKV9+sIq1CKvOsH1g+D44ASd
         35+o8oEfYDLYG8Ri0Dwf1QjxG9TSD25QmUjbsH55a6Sb5FZxwBOp9o8DOCxHmRZJuyK5
         KMK/tFf3lumAGLPVRUAcV/tcK7vjE+FnRiOF6sQqyeal7afFju0xcPuO6qRiypOWKbav
         eiQOaaIVY0g4O55bu2gsaHUXlTySh9nIRBA7dHF9J+gN7CpVJg9Mm+AE3K2voX+1FYWW
         V8yg==
X-Gm-Message-State: APjAAAWVLE6OgwDoy1YtPF2Mdkw9tp8pcGjWAiPWCQoPOBRMCjDS/w9y
        PYYbehKKvvQ6d5UC7LdWqry001zhNxME3Enu3Nw=
X-Google-Smtp-Source: APXvYqyHWdDqkLfxvWqcn5MNZEL+Til1mRmU5emMz+XxQPsSQKzbmaJ32ZldFQVl5BN2vJnVrg1WnGSbj4KRz+OZGk4=
X-Received: by 2002:a05:6402:12d4:: with SMTP id k20mr8118556edx.241.1571383074426;
 Fri, 18 Oct 2019 00:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191012043850.340957-1-ebiggers@kernel.org>
In-Reply-To: <20191012043850.340957-1-ebiggers@kernel.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 18 Oct 2019 10:17:42 +0300
Message-ID: <CADxRZqzJmLKn8s2e+s7+PrXwiDgHAsbFQvRZEW53=-oMfvaLRg@mail.gmail.com>
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: multipart/mixed; boundary="000000000000f594b705952a21b6"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--000000000000f594b705952a21b6
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 12, 2019 at 7:47 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series converts the glue code for the SPARC64 crypto opcodes
> implementations of AES, Camellia, DES, and 3DES modes from the
> deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> order for the blkcipher API to be removed.
>
> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor are SPARC64 crypto opcodes supported by QEMU.
> So I really need someone with the hardware to test it.  You can do so by
> setting:
>
> CONFIG_CRYPTO_AES_SPARC64=y
> CONFIG_CRYPTO_CAMELLIA_SPARC64=y
> CONFIG_CRYPTO_DES_SPARC64=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_CAMELLIA=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_ECB=y
>
> Then boot and check for crypto self-test failures by running
> 'dmesg | grep alg'.
>
> If there are test failures, please also check whether they were already
> failing prior to this patchset.


Eric,

just a quick report.

Attached /proc/crypto files before and after patch applied. As i can
see there's no selftests failure , kernel boots normally.

Thanks.

--000000000000f594b705952a21b6
Content-Type: text/plain; charset="US-ASCII"; name="proc-crypto-after-patch.txt"
Content-Disposition: attachment; filename="proc-crypto-after-patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k1vsv8o80>
X-Attachment-Id: f_k1vsv8o80

bmFtZSAgICAgICAgIDogbWQ1CmRyaXZlciAgICAgICA6IG1kNS1zcGFyYzY0Cm1vZHVsZSAgICAg
ICA6IG1kNV9zcGFyYzY0CnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApi
bG9ja3NpemUgICAgOiA2NApkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAgIDogc2hhNTEy
CmRyaXZlciAgICAgICA6IHNoYTUxMi1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IHNoYTUxMl9zcGFy
YzY0CnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBh
c3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAg
OiAxMjgKZGlnZXN0c2l6ZSAgIDogNjQKCm5hbWUgICAgICAgICA6IHNoYTM4NApkcml2ZXIgICAg
ICAgOiBzaGEzODQtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBzaGE1MTJfZ2VuZXJpYwpwcmlvcml0
eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMTI4CmRpZ2Vz
dHNpemUgICA6IDQ4CgpuYW1lICAgICAgICAgOiBzaGE1MTIKZHJpdmVyICAgICAgIDogc2hhNTEy
LWdlbmVyaWMKbW9kdWxlICAgICAgIDogc2hhNTEyX2dlbmVyaWMKcHJpb3JpdHkgICAgIDogMTAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEyOApkaWdlc3RzaXplICAgOiA2
NAoKbmFtZSAgICAgICAgIDogc2hhMzg0CmRyaXZlciAgICAgICA6IHNoYTM4NC1zcGFyYzY0Cm1v
ZHVsZSAgICAgICA6IHNoYTUxMl9zcGFyYzY0CnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAg
ICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAg
ICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNDgKCm5hbWUgICAg
ICAgICA6IHNoYTI1Ngpkcml2ZXIgICAgICAgOiBzaGEyNTYtc3BhcmM2NAptb2R1bGUgICAgICAg
OiBzaGEyNTZfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gK
YmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMzIKCm5hbWUgICAgICAgICA6IHNoYTIy
NApkcml2ZXIgICAgICAgOiBzaGEyMjQtc3BhcmM2NAptb2R1bGUgICAgICAgOiBzaGEyNTZfc3Bh
cmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBw
YXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAg
IDogNjQKZGlnZXN0c2l6ZSAgIDogMjgKCm5hbWUgICAgICAgICA6IHNoYTEKZHJpdmVyICAgICAg
IDogc2hhMS1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IHNoYTFfc3BhcmM2NApwcmlvcml0eSAgICAg
OiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAg
IDogMjAKCm5hbWUgICAgICAgICA6IGNyYzMyYwpkcml2ZXIgICAgICAgOiBjcmMzMmMtc3BhcmM2
NAptb2R1bGUgICAgICAgOiBjcmMzMmNfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250
ICAgICAgIDogNApzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAg
ICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMQpkaWdlc3RzaXplICAgOiA0CgpuYW1lICAg
ICAgICAgOiBnY20oYWVzKQpkcml2ZXIgICAgICAgOiBnY21fYmFzZShjdHIoYWVzLWdlbmVyaWMp
LGdoYXNoLWdlbmVyaWMpCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAK
cmVmY250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2
c2l6ZSAgICAgICA6IDEyCm1heGF1dGhzaXplICA6IDE2Cmdlbml2ICAgICAgICA6IDxub25lPgoK
bmFtZSAgICAgICAgIDogZ2NtKGFlcykKZHJpdmVyICAgICAgIDogZ2NtX2Jhc2UoY3RyLWFlcy1z
cGFyYzY0LGdoYXNoLWdlbmVyaWMpCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAg
OiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAg
OiAxCml2c2l6ZSAgICAgICA6IDEyCm1heGF1dGhzaXplICA6IDE2Cmdlbml2ICAgICAgICA6IDxu
b25lPgoKbmFtZSAgICAgICAgIDogaml0dGVyZW50cm9weV9ybmcKZHJpdmVyICAgICAgIDogaml0
dGVyZW50cm9weV9ybmcKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApy
ZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0
eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDogY2JjKGNh
bWVsbGlhKQpkcml2ZXIgICAgICAgOiBjYmMoY2FtZWxsaWEtZ2VuZXJpYykKbW9kdWxlICAgICAg
IDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3lu
YyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5
c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAg
ICAgOiAxNgoKbmFtZSAgICAgICAgIDogY2JjKGNhbWVsbGlhKQpkcml2ZXIgICAgICAgOiBjYmMt
Y2FtZWxsaWEtc3BhcmM2NAptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMzAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6
IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBrZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDE2
CmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBlY2Io
Y2FtZWxsaWEpCmRyaXZlciAgICAgICA6IGVjYihjYW1lbGxpYS1nZW5lcmljKQptb2R1bGUgICAg
ICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3Qg
ICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFz
eW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBr
ZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUg
ICAgIDogMTYKCm5hbWUgICAgICAgICA6IGVjYihjYW1lbGxpYSkKZHJpdmVyICAgICAgIDogZWNi
LWNhbWVsbGlhLXNwYXJjNjQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDMw
MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBu
bwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAg
OiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAw
CmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBjYW1l
bGxpYQpkcml2ZXIgICAgICAgOiBjYW1lbGxpYS1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGtlcm5l
bApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6
IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBrZXlzaXplICA6IDMyCgpuYW1lICAgICAgICAgOiBj
YmMoZGVzM19lZGUpCmRyaXZlciAgICAgICA6IGNiYyhkZXMzX2VkZS1nZW5lcmljKQptb2R1bGUg
ICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRl
c3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVy
CmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogMjQKbWF4
IGtleXNpemUgIDogMjQKaXZzaXplICAgICAgIDogOApjaHVua3NpemUgICAgOiA4CndhbGtzaXpl
ICAgICA6IDgKCm5hbWUgICAgICAgICA6IGNiYyhkZXMzX2VkZSkKZHJpdmVyICAgICAgIDogY2Jj
LWRlczNfZWRlLXNwYXJjNjQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDMw
MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBu
bwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAg
OiA4Cm1pbiBrZXlzaXplICA6IDI0Cm1heCBrZXlzaXplICA6IDI0Cml2c2l6ZSAgICAgICA6IDgK
Y2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAgOiBlY2IoZGVz
M19lZGUpCmRyaXZlciAgICAgICA6IGVjYihkZXMzX2VkZS1nZW5lcmljKQptb2R1bGUgICAgICAg
OiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5j
ICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogMjQKbWF4IGtleXNp
emUgIDogMjQKaXZzaXplICAgICAgIDogMApjaHVua3NpemUgICAgOiA4CndhbGtzaXplICAgICA6
IDgKCm5hbWUgICAgICAgICA6IGVjYihkZXMzX2VkZSkKZHJpdmVyICAgICAgIDogZWNiLWRlczNf
ZWRlLXNwYXJjNjQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDMwMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cm1p
biBrZXlzaXplICA6IDI0Cm1heCBrZXlzaXplICA6IDI0Cml2c2l6ZSAgICAgICA6IDAKY2h1bmtz
aXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAgOiBjYmMoZGVzKQpkcml2
ZXIgICAgICAgOiBjYmMoZGVzLWdlbmVyaWMpCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0
eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxv
Y2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA4Cm1heCBrZXlzaXplICA6IDgKaXZzaXplICAg
ICAgIDogOApjaHVua3NpemUgICAgOiA4CndhbGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6
IGNiYyhkZXMpCmRyaXZlciAgICAgICA6IGNiYy1kZXMtc3BhcmM2NAptb2R1bGUgICAgICAgOiBr
ZXJuZWwKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAg
ICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogOAptYXgga2V5c2l6ZSAg
OiA4Cml2c2l6ZSAgICAgICA6IDgKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4Cgpu
YW1lICAgICAgICAgOiBlY2IoZGVzKQpkcml2ZXIgICAgICAgOiBlY2IoZGVzLWdlbmVyaWMpCm1v
ZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tj
aXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA4
Cm1heCBrZXlzaXplICA6IDgKaXZzaXplICAgICAgIDogMApjaHVua3NpemUgICAgOiA4CndhbGtz
aXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IGVjYihkZXMpCmRyaXZlciAgICAgICA6IGVjYi1k
ZXMtc3BhcmM2NAptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNu
dCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUg
ICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWlu
IGtleXNpemUgIDogOAptYXgga2V5c2l6ZSAgOiA4Cml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXpl
ICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAgOiBkZXMzX2VkZQpkcml2ZXIg
ICAgICAgOiBkZXMzX2VkZS1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAg
ICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwg
ICAgIDogbm8KdHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNp
emUgIDogMjQKbWF4IGtleXNpemUgIDogMjQKCm5hbWUgICAgICAgICA6IGRlcwpkcml2ZXIgICAg
ICAgOiBkZXMtc3BhcmM2NAptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMzAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDgK
bWF4IGtleXNpemUgIDogOAoKbmFtZSAgICAgICAgIDogY3RyKGFlcykKZHJpdmVyICAgICAgIDog
Y3RyKGFlcy1nZW5lcmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAw
CnJlZmNudCAgICAgICA6IDIKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6
IDEKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMTYK
Y2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IGN0cihh
ZXMpCmRyaXZlciAgICAgICA6IGN0ci1hZXMtc3BhcmM2NAptb2R1bGUgICAgICAgOiBrZXJuZWwK
cHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6
IG5vCmJsb2Nrc2l6ZSAgICA6IDEKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIK
aXZzaXplICAgICAgIDogMTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5h
bWUgICAgICAgICA6IGNiYyhhZXMpCmRyaXZlciAgICAgICA6IGNiYyhhZXMtZ2VuZXJpYykKbW9k
dWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2Np
cGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAx
NgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAgOiAxNgp3
YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogY2JjKGFlcykKZHJpdmVyICAgICAgIDog
Y2JjLWFlcy1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAzMDAK
cmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDog
MTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMTYK
Y2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IGVjYihh
ZXMpCmRyaXZlciAgICAgICA6IGVjYihhZXMtZ2VuZXJpYykKbW9kdWxlICAgICAgIDoga2VybmVs
CnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3Nl
ZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAg
OiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAz
MgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2Cgpu
YW1lICAgICAgICAgOiBlY2IoYWVzKQpkcml2ZXIgICAgICAgOiBlY2ItYWVzLXNwYXJjNjQKbW9k
dWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2Np
cGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAx
NgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDE2Cndh
bGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBhZXMKZHJpdmVyICAgICAgIDogYWVzLXNw
YXJjNjQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAg
ICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAg
ICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNp
emUgIDogMzIKCm5hbWUgICAgICAgICA6IGdoYXNoCmRyaXZlciAgICAgICA6IGdoYXNoLWdlbmVy
aWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAg
OiAzCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAg
OiBzaGFzaApibG9ja3NpemUgICAgOiAxNgpkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAg
IDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9obWFjX3NoYTI1Ngptb2R1bGUgICAg
ICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMjA3CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3Qg
ICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6
ZSAgICAgOiAwCgpuYW1lICAgICAgICAgOiBzdGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19ub3By
X2htYWNfc2hhNTEyCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDYKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpk
cml2ZXIgICAgICAgOiBkcmJnX25vcHJfaG1hY19zaGEzODQKbW9kdWxlICAgICAgIDoga2VybmVs
CnByaW9yaXR5ICAgICA6IDIwNQpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3Nl
ZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoK
bmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9obWFjX3NoYTEK
bW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDIwNApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBy
bmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6
IGRyYmdfcHJfaG1hY19zaGEyNTYKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6
IDIwMwpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDog
c3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfcHJfaG1hY19zaGE1MTIKbW9kdWxlICAgICAgIDog
a2VybmVsCnByaW9yaXR5ICAgICA6IDIwMgpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAg
IDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfcHJfaG1hY19z
aGEzODQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDIwMQpyZWZjbnQgICAg
ICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAg
ICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAg
ICAgICA6IGRyYmdfcHJfaG1hY19zaGExCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAg
ICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwg
ICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAg
ICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBhbnNpX2Nwcm5nCm1vZHVsZSAgICAgICA6IGtlcm5l
bApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDQ4
CgpuYW1lICAgICAgICAgOiBsem8tcmxlCmRyaXZlciAgICAgICA6IGx6by1ybGUtc2NvbXAKbW9k
dWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2NvbXAK
Cm5hbWUgICAgICAgICA6IGx6by1ybGUKZHJpdmVyICAgICAgIDogbHpvLXJsZS1nZW5lcmljCm1v
ZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNvbXBy
ZXNzaW9uCgpuYW1lICAgICAgICAgOiBsem8KZHJpdmVyICAgICAgIDogbHpvLXNjb21wCm1vZHVs
ZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRl
c3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNjb21wCgpu
YW1lICAgICAgICAgOiBsem8KZHJpdmVyICAgICAgIDogbHpvLWdlbmVyaWMKbW9kdWxlICAgICAg
IDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAg
OiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogY29tcHJlc3Npb24KCm5h
bWUgICAgICAgICA6IGNyY3QxMGRpZgpkcml2ZXIgICAgICAgOiBjcmN0MTBkaWYtZ2VuZXJpYwpt
b2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDIK
c2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNo
YXNoCmJsb2Nrc2l6ZSAgICA6IDEKZGlnZXN0c2l6ZSAgIDogMgoKbmFtZSAgICAgICAgIDogY3Jj
MzJjCmRyaXZlciAgICAgICA6IGNyYzMyYy1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApw
cmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQK
aW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMQpk
aWdlc3RzaXplICAgOiA0CgpuYW1lICAgICAgICAgOiBjYW1lbGxpYQpkcml2ZXIgICAgICAgOiBj
YW1lbGxpYS1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAK
cmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2
Cm1heCBrZXlzaXplICA6IDMyCgpuYW1lICAgICAgICAgOiBhZXMKZHJpdmVyICAgICAgIDogYWVz
LWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQg
ICAgICAgOiAyCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtl
eXNpemUgIDogMzIKCm5hbWUgICAgICAgICA6IGRlczNfZWRlCmRyaXZlciAgICAgICA6IGRlczNf
ZWRlLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiAyNAptYXgg
a2V5c2l6ZSAgOiAyNAoKbmFtZSAgICAgICAgIDogZGVzCmRyaXZlciAgICAgICA6IGRlcy1nZW5l
cmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogOAptYXgga2V5c2l6ZSAg
OiA4CgpuYW1lICAgICAgICAgOiBzaGEyMjQKZHJpdmVyICAgICAgIDogc2hhMjI0LWdlbmVyaWMK
bW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBz
aGFzaApibG9ja3NpemUgICAgOiA2NApkaWdlc3RzaXplICAgOiAyOAoKbmFtZSAgICAgICAgIDog
c2hhMjU2CmRyaXZlciAgICAgICA6IHNoYTI1Ni1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5l
bApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDog
NjQKZGlnZXN0c2l6ZSAgIDogMzIKCm5hbWUgICAgICAgICA6IHNoYTEKZHJpdmVyICAgICAgIDog
c2hhMS1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVm
Y250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMjAKCm5h
bWUgICAgICAgICA6IG1kNQpkcml2ZXIgICAgICAgOiBtZDUtZ2VuZXJpYwptb2R1bGUgICAgICAg
OiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUg
ICAgOiA2NApkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAgIDogZWNiKGNpcGhlcl9udWxs
KQpkcml2ZXIgICAgICAgOiBlY2ItY2lwaGVyX251bGwKbW9kdWxlICAgICAgIDoga2VybmVsCnBy
aW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBu
bwpibG9ja3NpemUgICAgOiAxCm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMAppdnNp
emUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDEKd2Fsa3NpemUgICAgIDogMQoKbmFtZSAgICAg
ICAgIDogZGlnZXN0X251bGwKZHJpdmVyICAgICAgIDogZGlnZXN0X251bGwtZ2VuZXJpYwptb2R1
bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApi
bG9ja3NpemUgICAgOiAxCmRpZ2VzdHNpemUgICA6IDAKCm5hbWUgICAgICAgICA6IGNvbXByZXNz
X251bGwKZHJpdmVyICAgICAgIDogY29tcHJlc3NfbnVsbC1nZW5lcmljCm1vZHVsZSAgICAgICA6
IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNvbXByZXNzaW9uCgpuYW1l
ICAgICAgICAgOiBjaXBoZXJfbnVsbApkcml2ZXIgICAgICAgOiBjaXBoZXJfbnVsbC1nZW5lcmlj
Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEK
c2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNp
cGhlcgpibG9ja3NpemUgICAgOiAxCm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMAoK
--000000000000f594b705952a21b6
Content-Type: text/plain; charset="US-ASCII"; name="proc-crypto-before.txt"
Content-Disposition: attachment; filename="proc-crypto-before.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k1vsve9f1>
X-Attachment-Id: f_k1vsve9f1

bmFtZSAgICAgICAgIDogY2JjKGNhbWVsbGlhKQpkcml2ZXIgICAgICAgOiBjYmMtY2FtZWxsaWEt
c3BhcmM2NAptb2R1bGUgICAgICAgOiBjYW1lbGxpYV9zcGFyYzY0CnByaW9yaXR5ICAgICA6IDMw
MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBu
bwp0eXBlICAgICAgICAgOiBibGtjaXBoZXIKYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUg
IDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMTYKZ2VuaXYgICAgICAgIDog
PGRlZmF1bHQ+CgpuYW1lICAgICAgICAgOiBlY2IoY2FtZWxsaWEpCmRyaXZlciAgICAgICA6IGVj
Yi1jYW1lbGxpYS1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGNhbWVsbGlhX3NwYXJjNjQKcHJpb3Jp
dHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVy
bmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGJsa2NpcGhlcgpibG9ja3NpemUgICAgOiAxNgpt
aW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmdlbml2
ICAgICAgICA6IDxkZWZhdWx0PgoKbmFtZSAgICAgICAgIDogY2FtZWxsaWEKZHJpdmVyICAgICAg
IDogY2FtZWxsaWEtc3BhcmM2NAptb2R1bGUgICAgICAgOiBjYW1lbGxpYV9zcGFyYzY0CnByaW9y
aXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRl
cm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogMTYKbWlu
IGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKCm5hbWUgICAgICAgICA6IGNiYyhkZXMz
X2VkZSkKZHJpdmVyICAgICAgIDogY2JjLWRlczNfZWRlLXNwYXJjNjQKbW9kdWxlICAgICAgIDog
ZGVzX3NwYXJjNjQKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3Qg
ICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGJsa2NpcGhlcgpi
bG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDI0Cm1heCBrZXlzaXplICA6IDI0Cml2c2l6
ZSAgICAgICA6IDgKZ2VuaXYgICAgICAgIDogPGRlZmF1bHQ+CgpuYW1lICAgICAgICAgOiBlY2Io
ZGVzM19lZGUpCmRyaXZlciAgICAgICA6IGVjYi1kZXMzX2VkZS1zcGFyYzY0Cm1vZHVsZSAgICAg
ICA6IGRlc19zcGFyYzY0CnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBibGtjaXBo
ZXIKYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiAyNAptYXgga2V5c2l6ZSAgOiAyNApp
dnNpemUgICAgICAgOiAwCmdlbml2ICAgICAgICA6IDxkZWZhdWx0PgoKbmFtZSAgICAgICAgIDog
ZGVzM19lZGUKZHJpdmVyICAgICAgIDogZGVzM19lZGUtc3BhcmM2NAptb2R1bGUgICAgICAgOiBk
ZXNfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nr
c2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogMjQKbWF4IGtleXNpemUgIDogMjQKCm5hbWUgICAg
ICAgICA6IGNiYyhkZXMpCmRyaXZlciAgICAgICA6IGNiYy1kZXMtc3BhcmM2NAptb2R1bGUgICAg
ICAgOiBkZXNfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYmxrY2lw
aGVyCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogOAptYXgga2V5c2l6ZSAgOiA4Cml2
c2l6ZSAgICAgICA6IDgKZ2VuaXYgICAgICAgIDogPGRlZmF1bHQ+CgpuYW1lICAgICAgICAgOiBl
Y2IoZGVzKQpkcml2ZXIgICAgICAgOiBlY2ItZGVzLXNwYXJjNjQKbW9kdWxlICAgICAgIDogZGVz
X3NwYXJjNjQKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGJsa2NpcGhlcgpibG9j
a3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDgKbWF4IGtleXNpemUgIDogOAppdnNpemUgICAg
ICAgOiAwCmdlbml2ICAgICAgICA6IDxkZWZhdWx0PgoKbmFtZSAgICAgICAgIDogZGVzCmRyaXZl
ciAgICAgICA6IGRlcy1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGRlc19zcGFyYzY0CnByaW9yaXR5
ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogOAptaW4ga2V5
c2l6ZSAgOiA4Cm1heCBrZXlzaXplICA6IDgKCm5hbWUgICAgICAgICA6IGRlczNfZWRlCmRyaXZl
ciAgICAgICA6IGRlczNfZWRlLWdlbmVyaWMKbW9kdWxlICAgICAgIDogZGVzX2dlbmVyaWMKcHJp
b3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmlu
dGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1p
biBrZXlzaXplICA6IDI0Cm1heCBrZXlzaXplICA6IDI0CgpuYW1lICAgICAgICAgOiBkZXMKZHJp
dmVyICAgICAgIDogZGVzLWdlbmVyaWMKbW9kdWxlICAgICAgIDogZGVzX2dlbmVyaWMKcHJpb3Jp
dHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVy
bmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1pbiBr
ZXlzaXplICA6IDgKbWF4IGtleXNpemUgIDogOAoKbmFtZSAgICAgICAgIDogY3RyKGFlcykKZHJp
dmVyICAgICAgIDogY3RyLWFlcy1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGFlc19zcGFyYzY0CnBy
aW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBibGtjaXBoZXIKYmxvY2tzaXplICAgIDog
MQptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpn
ZW5pdiAgICAgICAgOiA8ZGVmYXVsdD4KCm5hbWUgICAgICAgICA6IGNiYyhhZXMpCmRyaXZlciAg
ICAgICA6IGNiYy1hZXMtc3BhcmM2NAptb2R1bGUgICAgICAgOiBhZXNfc3BhcmM2NApwcmlvcml0
eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYmxrY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDE2Cm1p
biBrZXlzaXplICA6IDE2Cm1heCBrZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDE2Cmdlbml2
ICAgICAgICA6IDxkZWZhdWx0PgoKbmFtZSAgICAgICAgIDogZWNiKGFlcykKZHJpdmVyICAgICAg
IDogZWNiLWFlcy1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IGFlc19zcGFyYzY0CnByaW9yaXR5ICAg
ICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiBubwp0eXBlICAgICAgICAgOiBibGtjaXBoZXIKYmxvY2tzaXplICAgIDogMTYKbWluIGtl
eXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMApnZW5pdiAgICAg
ICAgOiA8ZGVmYXVsdD4KCm5hbWUgICAgICAgICA6IGFlcwpkcml2ZXIgICAgICAgOiBhZXMtc3Bh
cmM2NAptb2R1bGUgICAgICAgOiBhZXNfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250
ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAg
ICAgICAgIDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBr
ZXlzaXplICA6IDMyCgpuYW1lICAgICAgICAgOiBtZDUKZHJpdmVyICAgICAgIDogbWQ1LXNwYXJj
NjQKbW9kdWxlICAgICAgIDogbWQ1X3NwYXJjNjQKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAg
ICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDY0CmRpZ2VzdHNpemUgICA6IDE2CgpuYW1lICAg
ICAgICAgOiBzaGE1MTIKZHJpdmVyICAgICAgIDogc2hhNTEyLXNwYXJjNjQKbW9kdWxlICAgICAg
IDogc2hhNTEyX3NwYXJjNjQKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNo
CmJsb2Nrc2l6ZSAgICA6IDEyOApkaWdlc3RzaXplICAgOiA2NAoKbmFtZSAgICAgICAgIDogc2hh
Mzg0CmRyaXZlciAgICAgICA6IHNoYTM4NC1zcGFyYzY0Cm1vZHVsZSAgICAgICA6IHNoYTUxMl9z
cGFyYzY0CnByaW9yaXR5ICAgICA6IDMwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUg
ICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNDgKCm5hbWUgICAgICAgICA6IHNoYTI1Ngpkcml2ZXIg
ICAgICAgOiBzaGEyNTYtc3BhcmM2NAptb2R1bGUgICAgICAgOiBzaGEyNTZfc3BhcmM2NApwcmlv
cml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGln
ZXN0c2l6ZSAgIDogMzIKCm5hbWUgICAgICAgICA6IHNoYTIyNApkcml2ZXIgICAgICAgOiBzaGEy
MjQtc3BhcmM2NAptb2R1bGUgICAgICAgOiBzaGEyNTZfc3BhcmM2NApwcmlvcml0eSAgICAgOiAz
MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDog
MjgKCm5hbWUgICAgICAgICA6IHNoYTEKZHJpdmVyICAgICAgIDogc2hhMS1zcGFyYzY0Cm1vZHVs
ZSAgICAgICA6IHNoYTFfc3BhcmM2NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDog
MQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDog
c2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMjAKCm5hbWUgICAgICAgICA6
IGNyYzMyYwpkcml2ZXIgICAgICAgOiBjcmMzMmMtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBjcmMz
MmNfZ2VuZXJpYwpwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tz
aXplICAgIDogMQpkaWdlc3RzaXplICAgOiA0CgpuYW1lICAgICAgICAgOiBjcmMzMmMKZHJpdmVy
ICAgICAgIDogY3JjMzJjLXNwYXJjNjQKbW9kdWxlICAgICAgIDogY3JjMzJjX3NwYXJjNjQKcHJp
b3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDUKc2VsZnRlc3QgICAgIDogcGFzc2VkCmlu
dGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEKZGln
ZXN0c2l6ZSAgIDogNAoKbmFtZSAgICAgICAgIDogcGtjczFwYWQocnNhLHNoYTI1NikKZHJpdmVy
ICAgICAgIDogcGtjczFwYWQocnNhLWdlbmVyaWMsc2hhMjU2KQptb2R1bGUgICAgICAgOiBrZXJu
ZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFrY2lwaGVyCgpuYW1lICAgICAg
ICAgOiBsem8tcmxlCmRyaXZlciAgICAgICA6IGx6by1ybGUtc2NvbXAKbW9kdWxlICAgICAgIDog
a2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBw
YXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2NvbXAKCm5hbWUgICAgICAg
ICA6IGx6by1ybGUKZHJpdmVyICAgICAgIDogbHpvLXJsZS1nZW5lcmljCm1vZHVsZSAgICAgICA6
IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNvbXByZXNzaW9uCgpuYW1l
ICAgICAgICAgOiBsem8KZHJpdmVyICAgICAgIDogbHpvLXNjb21wCm1vZHVsZSAgICAgICA6IGtl
cm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNjb21wCgpuYW1lICAgICAgICAg
OiBsem8KZHJpdmVyICAgICAgIDogbHpvLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnBy
aW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMzMKc2VsZnRlc3QgICAgIDogcGFzc2VkCmlu
dGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNvbXByZXNzaW9uCgpuYW1lICAgICAgICAg
OiBjcmN0MTBkaWYKZHJpdmVyICAgICAgIDogY3JjdDEwZGlmLWdlbmVyaWMKbW9kdWxlICAgICAg
IDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAyCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3Np
emUgICAgOiAxCmRpZ2VzdHNpemUgICA6IDIKCm5hbWUgICAgICAgICA6IGFlcwpkcml2ZXIgICAg
ICAgOiBhZXMtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAx
NgptYXgga2V5c2l6ZSAgOiAzMgoKbmFtZSAgICAgICAgIDogc2hhMjI0CmRyaXZlciAgICAgICA6
IHNoYTIyNC1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAK
cmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMjgK
Cm5hbWUgICAgICAgICA6IHNoYTI1Ngpkcml2ZXIgICAgICAgOiBzaGEyNTYtZ2VuZXJpYwptb2R1
bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDI1Nwpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hh
c2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMzIKCm5hbWUgICAgICAgICA6IHNo
YTEKZHJpdmVyICAgICAgIDogc2hhMS1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlv
cml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMjU5CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiA2NApk
aWdlc3RzaXplICAgOiAyMAoKbmFtZSAgICAgICAgIDogbWQ1CmRyaXZlciAgICAgICA6IG1kNS1n
ZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDY0CmRpZ2VzdHNpemUgICA6IDE2CgpuYW1lICAgICAg
ICAgOiBlY2IoY2lwaGVyX251bGwpCmRyaXZlciAgICAgICA6IGVjYi1jaXBoZXJfbnVsbAptb2R1
bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lw
aGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKbWluIGtleXNpemUgIDogMApt
YXgga2V5c2l6ZSAgOiAwCml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogMQp3YWxrc2l6
ZSAgICAgOiAxCgpuYW1lICAgICAgICAgOiBkaWdlc3RfbnVsbApkcml2ZXIgICAgICAgOiBkaWdl
c3RfbnVsbC1nZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJl
ZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5
cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEKZGlnZXN0c2l6ZSAgIDogMAoKbmFt
ZSAgICAgICAgIDogY29tcHJlc3NfbnVsbApkcml2ZXIgICAgICAgOiBjb21wcmVzc19udWxsLWdl
bmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogY29tcHJlc3Npb24KCm5hbWUgICAgICAgICA6IGNpcGhlcl9udWxsCmRyaXZlciAgICAgICA6
IGNpcGhlcl9udWxsLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6
IDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nrc2l6ZSAgICA6IDEKbWluIGtleXNpemUgIDog
MAptYXgga2V5c2l6ZSAgOiAwCgpuYW1lICAgICAgICAgOiByc2EKZHJpdmVyICAgICAgIDogcnNh
LWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBha2NpcGhlcgoKbmFtZSAgICAgICAgIDogZGgKZHJpdmVyICAgICAgIDogZGgtZ2Vu
ZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IGtwcAoK
--000000000000f594b705952a21b6--
