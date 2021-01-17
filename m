Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F482F91B4
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Jan 2021 11:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbhAQKSI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 17 Jan 2021 05:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAQKRn (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 17 Jan 2021 05:17:43 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD18C061573
        for <linux-crypto@vger.kernel.org>; Sun, 17 Jan 2021 02:17:02 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so15131784ljo.13
        for <linux-crypto@vger.kernel.org>; Sun, 17 Jan 2021 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:cc:date:message-id:in-reply-to:references:reply-to
         :user-agent:mime-version;
        bh=q4iXOQ9KLNsrDv/yyQYEEqn5Do0mjBvQWSeyN3VzFTk=;
        b=knSPxZh7EeO+z5Pr+GYL9vDTvrhGDTAyVIU6IGv94FrNjX8+YPZDkzkdJz7aOn4New
         EsEqQR0hEWMUp4EK0/wok32XXpfyCImim29HxdyP1jDWGF6Tjd8UzmcOFZ9UPZdH+fAY
         I22lUAwnwk1upCPp4gdrKpOgsYNrc9UOtQdTOk70kKw0nOHnzKpmLInL8aqYUrnJUZCN
         yV4+JooxtYMwjSUJz4z+7lWMhca1EwNg68asZPd9uw3z4wetcB60Z6HhLWgf7FH71Xri
         u3wU/PewNzAr9Vg8iKTcBMAa+A8cqh/aD1WWv6JNMGVaT7D9z2DITj2V03HHaaeDPqry
         +U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:cc:date:message-id:in-reply-to
         :references:reply-to:user-agent:mime-version;
        bh=q4iXOQ9KLNsrDv/yyQYEEqn5Do0mjBvQWSeyN3VzFTk=;
        b=SbmCO40ea4BCaFz09vsyCXUV6xMo8d7Rkx7LlQmRfRNNvhrWVhopmqZfAqCmoE4xWn
         YDePHK2sZvT8MqXfZ9/7NA3V5mYLBamoBsQt6V/zCwEdV7qLHx1b86rwDA+GU+B1DYoL
         DxvU+cN1VOWGI13iAXfQam/Ka6ICTkQ7eGwOs2lMN3x+JHcDIgQCcjay7REys8tXkEfY
         2RlWgHsy8B7HSHujwhILZDxOUfeMmXTei9J9Moz3WYcHfplokrRahbE3XhiM5HTawG53
         PrR+8Jr/lzLwwUSGELq2mRH66DHRHhOxlBoirZRT8Gjgu7Js1/uuQWjSd4jB2wqU5gfD
         hEJA==
X-Gm-Message-State: AOAM5323vGvUhT3d3m3TI//VFuvhOUYXRjpepMAPyxFSH6FeZEf4+nTr
        yMqqKhrmO2oN7fNDFt66vIkGjQDBu/GXLw==
X-Google-Smtp-Source: ABdhPJywdMaIEkbbT7nd8p7+TVmzDhvUSEP/+2K9T6eKPgioFvPNJeRSly/l4qBDhcQmZzSx/VwcYw==
X-Received: by 2002:a2e:95ca:: with SMTP id y10mr8739554ljh.440.1610878621127;
        Sun, 17 Jan 2021 02:17:01 -0800 (PST)
Received: from [10.0.0.6] (213-229-210.static.cytanet.com.cy. [213.7.229.210])
        by smtp.gmail.com with ESMTPSA id y21sm1213534lfl.84.2021.01.17.02.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 02:16:59 -0800 (PST)
From:   "Domen Stangar" <domen.stangar@gmail.com>
To:     "John Allen" <john.allen@amd.com>
Subject: Re[2]: problem with ccp-crypto module on apu
Cc:     "Tom Lendacky" <thomas.lendacky@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Date:   Sun, 17 Jan 2021 10:16:58 +0000
Message-Id: <emf3681a05-10b5-44ad-b516-c8492fdf8f3a@domen-5950x>
In-Reply-To: <20210107151050.GA30454@nikka.amd.com>
References: <em96a2a8ae-80a7-4608-905e-5d932c0cf9bb@domen1-pc>
 <20201228152245.GA90548@nikka.amd.com>
 <95c0d9f7-e8e9-0b71-1f0a-44230c3dbfe5@amd.com>
 <eme43aecb9-708c-4fda-ba76-a446ecc12790@domen-5950x>
 <20210107151050.GA30454@nikka.amd.com>
Reply-To: "Domen Stangar" <domen.stangar@gmail.com>
User-Agent: eM_Client/8.1.979.0
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------=_MB1E820B19-11F7-48CB-9725-98C3DFC4E7F3"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--------=_MB1E820B19-11F7-48CB-9725-98C3DFC4E7F3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Sorry for late answer, somewhat missed mail.

dmesg last lines that where added

[  325.691756] ccp 0000:0a:00.2: enabling device (0000 -> 0002)
[  325.692217] ccp 0000:0a:00.2: ccp enabled
[  325.702401] ccp 0000:0a:00.2: tee enabled
[  325.702405] ccp 0000:0a:00.2: psp enabled

  /sys/kernel/debug/ccp/ccp-1/stats
Total Interrupts Handled: 0
         Total Operations: 1
                      AES: 0
                  XTS AES: 0
                      SHA: 0
                      SHA: 0
                      RSA: 0
                Pass-Thru: 1
                      ECC: 0

interrupts output attached.

Domen

------ Original Message ------
From: "John Allen" <john.allen@amd.com>
To: "Domen Stangar" <domen.stangar@gmail.com>
Cc: "Tom Lendacky" <thomas.lendacky@amd.com>;=20
"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Sent: 07/01/2021 17:10:50
Subject: Re: problem with ccp-crypto module on apu

>On Mon, Jan 04, 2021 at 04:10:26PM +0000, Domen Stangar wrote:
>>  Device name: ccp-1
>>     RNG name: ccp-1-rng
>>     # Queues: 3
>>       # Cmds: 0
>>      Version: 5
>>      Engines: AES 3DES SHA RSA ECC ZDE TRNG
>>       Queues: 5
>>  LSB Entries: 128
>>
>>  Let me know if you need anything else.
>
>Hi Domen,
>
>Looks like we may have a lead on this problem.
>
>Could you provide the following when you're loading the module?
>
>dmesg
>/proc/interrupts
>/sys/kernel/debug/ccp/ccp-1/stats
>
>Thanks,
>John
>
>>  Domen
>>
>>  > Domen, do you have the debugfs support enabled? Could you supply the=
 output from /sys/kernel/debug/ccp/ccp-X/info (where X is replaced with each =
of the present ccp ordinal values)?
>>  >
>>  > Thanks,
>>  > Tom
>>  >
>>
--------=_MB1E820B19-11F7-48CB-9725-98C3DFC4E7F3
Content-Type: application/octet-stream; name=interrupts
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=interrupts

ICAgICAgICAgICAgQ1BVMCAgICAgICBDUFUxICAgICAgIENQVTIgICAgICAgQ1BVMyAgICAgICAK
ICAgMDogICAgICAgICAzMyAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItSU8t
QVBJQyAgICAyLWVkZ2UgICAgICB0aW1lcgogICA4OiAgICAgICAgICAwICAgICAgICAgIDEgICAg
ICAgICAgMCAgICAgICAgICAwICBJUi1JTy1BUElDICAgIDgtZWRnZSAgICAgIHJ0YzAKICAgOTog
ICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItSU8tQVBJQyAg
ICA5LWZhc3Rlb2kgICBhY3BpCiAgMjU6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAgICBQQ0ktTVNJIDQwOTYtZWRnZSAgICAgIEFNRC1WaQogIDI2OiAgICAgICAg
ICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDIwNDgwLWVk
Z2UgICAgICBQQ0llIFBNRSwgYWVyZHJ2LCBQQ0llIEJXIG5vdGlmCiAgMjc6ICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgMjI1MjgtZWRnZSAg
ICAgIFBDSWUgUE1FLCBhZXJkcnYsIFBDSWUgQlcgbm90aWYKICAyODogICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSAxMzMxMjAtZWRnZSAgICAg
IFBDSWUgUE1FLCBQQ0llIEJXIG5vdGlmCiAgMjk6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgMTM1MTY4LWVkZ2UgICAgICBQQ0llIFBNRSwg
YWVyZHJ2LCBQQ0llIEJXIG5vdGlmCiAgMzM6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgMTA0ODU3Ni1lZGdlICAgICAgUENJZSBCVyBub3Rp
ZgogIDM1OiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1Q
Q0ktTVNJIDEwNjQ5NjAtZWRnZSAgICAgIFBDSWUgQlcgbm90aWYKICAzNjogICAgICAgICAgMCAg
ICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSAxMTE0MTEyLWVkZ2Ug
ICAgICBQQ0llIEJXIG5vdGlmCiAgMzc6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAgIElSLVBDSS1NU0kgMTEzMDQ5Ni1lZGdlICAgICAgUENJZSBCVyBub3RpZgog
IDM4OiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0kt
TVNJIDExNDY4ODAtZWRnZSAgICAgIFBDSWUgQlcgbm90aWYKICA0MDogICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSAxMTYzMjY0LWVkZ2UgICAg
ICBQQ0llIEJXIG5vdGlmCiAgNDI6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgMTkgIElSLVBDSS1NU0kgNDcxODU5Mi1lZGdlICAgICAgbnZtZTBxMAogIDQzOiAgICAg
ICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDUyNjMz
Ni1lZGdlICAgICAgYWhjaVswMDAwOjAxOjAwLjFdCiAgNDU6ICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgNTc2NzE2OC1lZGdlICAgICAgYWhj
aTAKICA0NjogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVIt
UENJLU1TSSA1NzY3MTY5LWVkZ2UgICAgICBhaGNpMQogIDQ3OiAgICAgICAgICAxICAgICAgICAg
IDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDQxOTQzMDQtZWRnZSAgICAgIGV0
aDAKICA0ODogICAgICAgICAgMCAgICAgICAgODE3ICAgICAgICAgIDAgICAgICAgICAgMCAgSVIt
UENJLU1TSSA0MTk0MzA1LWVkZ2UgICAgICBldGgwLXJ4LTAKICA0OTogICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAxOTAgICAgICAgICAgMCAgSVItUENJLU1TSSA0MTk0MzA2LWVkZ2UgICAg
ICBldGgwLXJ4LTEKICA1MDogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
IDY5MSAgSVItUENJLU1TSSA0MTk0MzA3LWVkZ2UgICAgICBldGgwLXR4LTAKICA1MTogICAgICAg
IDIyMyAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSA0MTk0MzA4
LWVkZ2UgICAgICBldGgwLXR4LTEKICA1MjogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAg
MzIgICAgICAgICAgMCAgSVItUENJLU1TSSA1MjQyODgtZWRnZSAgICAgIHhoY2lfaGNkCiAgNTQ6
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kg
NTI0OTAyNC1lZGdlICAgICAgeGhjaV9oY2QKICA1NTogICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSA1MjQ5MDI1LWVkZ2UgICAgICB4aGNpX2hj
ZAogIDU2OiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1Q
Q0ktTVNJIDUyNDkwMjYtZWRnZSAgICAgIHhoY2lfaGNkCiAgNTc6ICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgNTI0OTAyNy1lZGdlICAgICAg
eGhjaV9oY2QKICA1ODogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgSVItUENJLU1TSSA1MjQ5MDI4LWVkZ2UgICAgICB4aGNpX2hjZAogIDYwOiAgICAgICAgICAw
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDUyNTEwNzItZWRn
ZSAgICAgIHhoY2lfaGNkCiAgNjE6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgIElSLVBDSS1NU0kgNTI1MTA3My1lZGdlICAgICAgeGhjaV9oY2QKICA2MjogICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSA1MjUx
MDc0LWVkZ2UgICAgICB4aGNpX2hjZAogIDYzOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDUyNTEwNzUtZWRnZSAgICAgIHhoY2lfaGNkCiAg
NjQ6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1N
U0kgNTI1MTA3Ni1lZGdlICAgICAgeGhjaV9oY2QKICA2NjogICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgODQgICAgICAgICAgMCAgSVItUENJLU1TSSA1MjQ0OTI4LWVkZ2UgICAgICBzbmRf
aGRhX2ludGVsOmNhcmQwCiAgNjc6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICA3MjYgIElSLVBDSS1NU0kgNTI1NTE2OC1lZGdlICAgICAgc25kX2hkYV9pbnRlbDpjYXJk
MQogIDY4OiAgICAgICAgMzMyICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1Q
Q0ktTVNJIDQ3MTg1OTMtZWRnZSAgICAgIG52bWUwcTEKICA2OTogICAgICAgICAgMCAgICAgICA0
MjY4ICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSA0NzE4NTk0LWVkZ2UgICAgICBu
dm1lMHEyCiAgNzA6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgNTE5ICAgICAgICAgIDAg
IElSLVBDSS1NU0kgNDcxODU5NS1lZGdlICAgICAgbnZtZTBxMwogIDcxOiAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgICAgIDE4ODQyICBJUi1QQ0ktTVNJIDQ3MTg1OTYtZWRnZSAg
ICAgIG52bWUwcTQKICA3MjogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgSVItUENJLU1TSSA0NzE4NTk3LWVkZ2UgICAgICBudm1lMHE1CiAgNzM6ICAgICAgICAg
IDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgNDcxODU5OC1l
ZGdlICAgICAgbnZtZTBxNgogIDc0OiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAg
ICAgICAgICAwICBJUi1QQ0ktTVNJIDQ3MTg1OTktZWRnZSAgICAgIG52bWUwcTcKICA3NTogICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSA0NzE4
NjAwLWVkZ2UgICAgICBudm1lMHE4CiAgNzY6ICAgICAgICAgIDAgICAgICAgIDUwOSAgICAgICAg
ICAwICAgICAgICAgIDAgIElSLVBDSS1NU0kgNTI0Mjg4MC1lZGdlICAgICAgYW1kZ3B1CiAgNzc6
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgIDI5ICAgICAgICAgIDAgIElSLVBDSS1NU0kg
MzE0NTcyOC1lZGdlICAgICAgaXdsd2lmaTogZGVmYXVsdCBxdWV1ZQogIDc4OiAgICAgICAgICAw
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDMxNDU3MjktZWRn
ZSAgICAgIGl3bHdpZmk6IHF1ZXVlIDEKICA3OTogICAgICAgICAgMCAgICAgICAgICAwICAgICAg
ICAgIDAgICAgICAgICAgMCAgSVItUENJLU1TSSAzMTQ1NzMwLWVkZ2UgICAgICBpd2x3aWZpOiBx
dWV1ZSAyCiAgODA6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAg
IElSLVBDSS1NU0kgMzE0NTczMS1lZGdlICAgICAgaXdsd2lmaTogcXVldWUgMwogIDgxOiAgICAg
ICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDMxNDU3
MzItZWRnZSAgICAgIGl3bHdpZmk6IHF1ZXVlIDQKICA4MjogICAgICAgICAgMCAgICAgICAgICAw
ICAgICAgICAgIDAgICAgICAgICAxMSAgSVItUENJLU1TSSAzMTQ1NzMzLWVkZ2UgICAgICBpd2x3
aWZpOiBleGNlcHRpb24KICA4MzogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICAgICAgMCAgSVItUENJLU1TSSA1MjQ2OTc2LWVkZ2UgICAgICBwc3AtMQogIDg0OiAgICAgICAg
ICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJUi1QQ0ktTVNJIDUyNDY5Nzct
ZWRnZSAgICAgIGNjcC0xCiBOTUk6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICBOb24tbWFza2FibGUgaW50ZXJydXB0cwogTE9DOiAgICAgMjk1MDczICAgICAx
Nzg0MTUgICAgIDIyODIyOCAgICAgMjY0NDUxICAgTG9jYWwgdGltZXIgaW50ZXJydXB0cwogU1BV
OiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgU3B1cmlvdXMg
aW50ZXJydXB0cwogUE1JOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAwICAgUGVyZm9ybWFuY2UgbW9uaXRvcmluZyBpbnRlcnJ1cHRzCiBJV0k6ICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBJUlEgd29yayBpbnRlcnJ1cHRzCiBS
VFI6ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICBBUElDIElD
UiByZWFkIHJldHJpZXMKIFJFUzogICAgICAxMzk3NCAgICAgIDE1Njg5ICAgICAgMTMwNDcgICAg
ICAxMTU0NSAgIFJlc2NoZWR1bGluZyBpbnRlcnJ1cHRzCiBDQUw6ICAgICAgICAzNzMgICAgICAg
IDM4MCAgICAgICAgMjc3ICAgICAgICAyNTcgICBGdW5jdGlvbiBjYWxsIGludGVycnVwdHMKIFRM
QjogICAgICAgICA3OCAgICAgICAgMjM1ICAgICAgICAgMzggICAgICAgIDE1NSAgIFRMQiBzaG9v
dGRvd25zCiBUUk06ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAg
ICBUaGVybWFsIGV2ZW50IGludGVycnVwdHMKIFRIUjogICAgICAgICAgMCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgIFRocmVzaG9sZCBBUElDIGludGVycnVwdHMKIERGUjogICAg
ICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIERlZmVycmVkIEVycm9y
IEFQSUMgaW50ZXJydXB0cwogTUNFOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAg
ICAgICAgICAwICAgTWFjaGluZSBjaGVjayBleGNlcHRpb25zCiBNQ1A6ICAgICAgICAgIDIgICAg
ICAgICAgMiAgICAgICAgICAyICAgICAgICAgIDIgICBNYWNoaW5lIGNoZWNrIHBvbGxzCiBFUlI6
ICAgICAgICAzMDUKIE1JUzogICAgICAgICAgMAogUElOOiAgICAgICAgICAwICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwICAgUG9zdGVkLWludGVycnVwdCBub3RpZmljYXRpb24gZXZl
bnQKIE5QSTogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgIE5l
c3RlZCBwb3N0ZWQtaW50ZXJydXB0IGV2ZW50CiBQSVc6ICAgICAgICAgIDAgICAgICAgICAgMCAg
ICAgICAgICAwICAgICAgICAgIDAgICBQb3N0ZWQtaW50ZXJydXB0IHdha2V1cCBldmVudAo=
--------=_MB1E820B19-11F7-48CB-9725-98C3DFC4E7F3--

