Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B033A4809
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Jun 2021 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFKRqQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Jun 2021 13:46:16 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41820 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKRqP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Jun 2021 13:46:15 -0400
Received: by mail-pf1-f171.google.com with SMTP id x73so5031442pfc.8
        for <linux-crypto@vger.kernel.org>; Fri, 11 Jun 2021 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=H90Q8HQv3r87PSkgndEiRHLarWPDw/QxWChQ/DnKR8o=;
        b=U6exQY7Yg9T8TYkOj40iFmJLnF+hck/6g7w0cdImsSSCABV2XYLA89dRnD3LP711KV
         IRvHk5Sms1QQ2DF79EIoxKOtH/i/cdBH8bLnZ5WjkKHBzBLlJJ0bd9U+/CQIw7WupKLn
         STNV7VQ9GHcuCF7L3RofpDNVLIhp7Cp9/v3ko5vdyJGCHQo3SU8gd0ZMc9C4OwGZeCsm
         zJNnXT45YP80k3oMkF8LC93jPQaTRGYFlO2ZWgmFIcQwe/iCROzhlU4Mdu6nNxJVBWpV
         mTqhipLQoqTTNKw5EjLdOQdPDA7RUXaX/l+CoNx3iS2H/bx91hUvyydSWUSw1wz5euEw
         i1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=H90Q8HQv3r87PSkgndEiRHLarWPDw/QxWChQ/DnKR8o=;
        b=lxu+gcjJzKwTRNoCp1isbXryOfos2+gw/r11cSq7VhBH7u77segn9VcGLnXuCPcv20
         eiKkXyvuQ8pqdVz6WjwOa3F9uOKG34viuUR7isUMr6ZD0nkbjuFqgkkUeOmSTRCICp6v
         +K41P9/FuINRDfH3fUwcV1IycCBm84m8HzAg9tGQXrrhdoRFcaOUf8Zm98nCi/Ply+OK
         249Rgbr5EQzR5eDPUTSfXrERIrJ+uY//e37gJWEZ3pxPsVbSG62qL9MXqvwKbuEpvoEh
         2Eq2ihgI2/r8R/+7P6ZVqXPFFQoFA7mra0zig5nke6ahskzfj42Br0P0rGyMJsCW5szH
         8DXg==
X-Gm-Message-State: AOAM532VZHJmHiIZM5+rbTbv7ZMzcfusFbpAQIDv2TESqaiqkgAgmMDx
        ffzVnwTCB1056FEjnGZFzYqME1fr5HwDRhOgidM=
X-Google-Smtp-Source: ABdhPJy5YeivD86YOiExX135TxEZcHkQ0GILQ0YYQjo81Sj90MyTYktNm2BrXA3jh671MYNUaHWdtjCQtFIGea4/ZoQ=
X-Received: by 2002:a63:530a:: with SMTP id h10mr4819411pgb.98.1623433389060;
 Fri, 11 Jun 2021 10:43:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:6b42:0:0:0:0 with HTTP; Fri, 11 Jun 2021 10:43:08
 -0700 (PDT)
Reply-To: banqueatlantiquetogobranch@gmail.com
In-Reply-To: <CADRB3KqTsLw9JgQLeuROgaM=JeXS0te0HZD-ux2fLFkMSwn+fA@mail.gmail.com>
References: <CADRB3KrL=mGJhbPJZG7Rs74ctSnta=2nUm8F4j5Lapi9QiOjkA@mail.gmail.com>
 <CADRB3KqTsLw9JgQLeuROgaM=JeXS0te0HZD-ux2fLFkMSwn+fA@mail.gmail.com>
From:   "Ms. Kristalina Georgieva" <tonywoodto@gmail.com>
Date:   Fri, 11 Jun 2021 19:43:08 +0200
Message-ID: <CADRB3KrExkkfTg-BnYH2Xy_ZJNMX27vByn+9z2QcC_mLTXi_6g@mail.gmail.com>
Subject: 11/06/2021
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear email owner / fund recipient,
I am Mrs.Kristalina Georgieva the Executive Director and President of
the International Monetary Fund Washington D.C, We have indeed
reviewed all the obstacles and problems that accompanied your
incomplete transaction and your inability to cope with the transfer
fees charged for past the transfer options, visit our confirmation
page 38 =C2=B0 53'56 "N 77 =C2=B0 2" 39 =E2=80=B3 F.

The Board of Directors World Bank and International Monetary Fund
(IMF) Washington D.C in cooperation with the US Treasury Department
and some other relevant investigative agencies here in the United
States has ordered our Foreign Transfer Unit BANQUE ATLANTIQUE
INTERNATIONAL TOGO to convert a compensation fund worth =E2=82=AC761,000.00
into an ATM master card and send to you.

During our investigation we were horrified to find that your fund was
unnecessarily delayed by corrupt bank officials whom was trying to
redirect your funds to their private accounts for their selfish
interest, today we would like to inform you that your fund has been
deposited in BANQUEATLANTIQUE INTERNATIONAL TOGO also ready for
delivery, now contact Prof.Susan Robinson the foreign remittance
director BANQUE ATLANTIQUE INTERNATIONAL TOGO,
email:biainquirettg@hotmail.com, Send her the following information to
enable her remit your total compensation fund worth =E2=82=AC761,000.00 int=
o
an ATM  master card and send to you without any mistake or delay.

(1) Your full name......................................
(2) Your home address..............................
(3) A copy of your national identity card or passport........
(4) Your country.........................................
(5) Postcode=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=
=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6.
(6) Your private phone number........................

Sincerely
Mrs.Kristalina Georgieva
Managing Director of International monetary fund.
