Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1DE28C3CA
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgJLVKI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgJLVKI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 17:10:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CAC0613D0
        for <linux-crypto@vger.kernel.org>; Mon, 12 Oct 2020 14:10:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s4so18950527qkf.7
        for <linux-crypto@vger.kernel.org>; Mon, 12 Oct 2020 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WnnjEZAXIS5IQONrT2y15Vd3fdae8DlE453uAStqNs0=;
        b=MRa6Fh2WHa6j7vgaVzkf3t6LAXg6p2iX1TEAcKcXLxJfPcIJofg9n2lQUIq38Oy4tb
         zbtCbHH3aK4ejBgVV7pndfa0yz28eEN6pjjUQmk40JRzlG3mKUGhCbJxw7b650EvFabo
         sZ5xtQZeOrh++I406ny7PkyxOCkoVuyRx9QxfzYEPfpBEjmG0nfEOyr7rR8fr5wy0GWl
         937qdORD2UK6imrg2evpBKd4URBIur32RQ6PAYdmoUxCs3z1zO0gqEKwcS10E+Twxqj1
         CF7E/mPjj7E4X4IXfji3VGVEvzDvCYdioBAept+UmjVGFq7ND3VzB/n1ZDoR5lHb56gO
         RFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=WnnjEZAXIS5IQONrT2y15Vd3fdae8DlE453uAStqNs0=;
        b=qpzZwiSeAoNnwXuzpgEOMOjO9Xnqa2dTvzHca01V32F+OwNkNO+p+TMvcf47tajwty
         pJ9Y6ykPWP55o4w7KiLZffFhLgx/ahufMp4Es7uYakF8Q1q8XiTEsHlsOlSPR+alyAPz
         bu+ngm6XIwpscppG5wIKAFQGw9UMnWPiBakNzZkw4VmQzqN3yTLAW+nZ7FPjjHmZHMSZ
         bBZqU9x9MZnKtUB9ak1fv2CkZ8fiTjMWBTlgC5ZHEim2ZBTjGAyGsRmIfnkPWyDUQcra
         toJwOVLUyX2u2Qke5WTkzMFvxEa9d1wbR2068aZHJIBRNOa/4Bnln4nOAZD0WwbM5vT/
         k3Og==
X-Gm-Message-State: AOAM533woCq3e29mjBuTsyda5DyiLrknoYLsDZc79DZw7mX8d4bAd/w5
        3ki/HGTyU7czAg85+baA3pbGgzCFHeoRQVwKuwE=
X-Google-Smtp-Source: ABdhPJwZNIPwnPJXSLBHjxpGZUZq8U0ptBsSFuKVG8a3U4q3gj3ALXU4BVAhKQq0W2BDlW4RIZ6QgQVwhIeo6zsAw/I=
X-Received: by 2002:a37:a5d4:: with SMTP id o203mr12025269qke.40.1602537007056;
 Mon, 12 Oct 2020 14:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:4bcd:0:0:0:0:0 with HTTP; Mon, 12 Oct 2020 14:10:06
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   SgtKayla Manthey <gbandidakoukpa@gmail.com>
Date:   Mon, 12 Oct 2020 14:10:06 -0700
Message-ID: <CABJraztFbkHV5bULDOdZVnRTMqyz0Wu3AL0sGMxY5UFAZqbqHw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiwNCtCc0LXQvdGPINC30L7QstGD0YIg0JrQsNC50LvQsC4g
0JLRiyDQv9C+0LvRg9GH0LjQu9C4INC80L7QtSDQv9GA0LXQtNGL0LTRg9GJ0LXQtSDRgdC+0L7Q
sdGJ0LXQvdC40LU/INCd0LDQv9C40YjQuCDQvNC90LUg0L7RgtCy0LXRgi4NCg==
