Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1A40EA4F
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Sep 2021 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIPS42 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Sep 2021 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbhIPS4H (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Sep 2021 14:56:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE6C03D751
        for <linux-crypto@vger.kernel.org>; Thu, 16 Sep 2021 11:00:36 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so8901895ioj.8
        for <linux-crypto@vger.kernel.org>; Thu, 16 Sep 2021 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=huhNuZXvVwCDh/uHN3eoBKv07jlczuhkmd89LL3gVks=;
        b=mxuTzm0Nrt4TrdFuPrIx4QhN5HQkx25fE+uX/3EJUTJ26sGxX2A0SNHWTNvvJGcr0u
         kUlsfaLrz9O28czYrpW8mXWRfyzDObUSkOIF8z0JWob9397Gz41ByiutrLIXh6o+deY/
         0r0JrGnOfUigYmbMHcA27YGzw6B59VY1aY1dn0uV0A3YlkxUcfOo4k7NryxeMmaP72wS
         FYrspCspx7Cih9uVwhhdfTv3f4stCQIZNaHAFOfs9klzzWw1AC6vpqwfJfM3w+xyAETz
         t7foAaKTb8++EVkLCOV7q3FeAOEMYJ2XYGAysg1t58mHO6Sqc25Q9hTEPLUqLqVrTJpc
         LNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=huhNuZXvVwCDh/uHN3eoBKv07jlczuhkmd89LL3gVks=;
        b=71oFT4U98LVvAgq+7pDcYuEncZsEavetRc0xInxMhMwRyErLPP/S7N86dtzJqqkdQW
         Y9VorrdHGYJngQefRJiuoNo224IQJZI4dZHg03u9/QuhE5hIjzivV5Livvut4wqc6arP
         6qVat4k4qwJSSLhZjixnWyCy31Kf+0Hy2aqEkNSWInRRME5FAssaRvcvMnQAPGaZppvX
         1ubqtWEZMOYU3/Y2k0vcRiFz+tPglex6JegWtZVdK0PDO7eCcxr/RfkAITdDelOgi1Fx
         +vWOIRHvYtVKxWVQeQ2yxSOkEN+9JsdxAIskt0lb/98YyNnlYUCa50Jb+4gZbi9Zp12j
         xH5A==
X-Gm-Message-State: AOAM533e0Zp51G9E3cikZh0oA/bWeigRpJFTczxeEnBKUtsMQcljrqjn
        pFtMW0p16AQK6f6M7CL8MqXi3EeEzT9PN1qF2YQ=
X-Google-Smtp-Source: ABdhPJyzH7OxC2vhpBNNFJ9dqq6bsNhpCaDJppbvLHtF+XIPMr+OBYuECwRIXVWYLGySALvGnGeqo/YWZBf88JW85tM=
X-Received: by 2002:a5e:c603:: with SMTP id f3mr1811321iok.14.1631815235765;
 Thu, 16 Sep 2021 11:00:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7113:0:0:0:0:0 with HTTP; Thu, 16 Sep 2021 11:00:34
 -0700 (PDT)
Reply-To: db.bankdirecttg@gmail.com
In-Reply-To: <CAFmzXQTxq4tqe5YRpjHFfxNm4a2o-S8DKd=FZP6439qW+UUDGw@mail.gmail.com>
References: <CAFmzXQSw9C+5Kw0MUz6UHz7UR9Fa3fznJNKxWcX=oiKx_beUUQ@mail.gmail.com>
 <CAFmzXQTxq4tqe5YRpjHFfxNm4a2o-S8DKd=FZP6439qW+UUDGw@mail.gmail.com>
From:   "db.bankdirecttg@gmail.com" <mdialo008@gmail.com>
Date:   Thu, 16 Sep 2021 18:00:34 +0000
Message-ID: <CAFmzXQSRQEJ12Q+yWQaNrB6FSAOeazBD+1AaDmmVNfC4dstDvA@mail.gmail.com>
Subject: wu
To:     mdialo008@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Our office contact, 2554 Road Of Kpalime Face Pharmacy Bet, Lome, Gulf.

This is WU bank director bring notice for you that  International
monetary fund (IMF) who compensation you sum of $850,000.00 because
they found your email address in the list of scam victim . Do you
willing to get this fund or not?

We look forward to hear from you urgently.

Yours faithfully
Tony  Albert
BANK DIRECTOR
Whatsapp, +22870248258
