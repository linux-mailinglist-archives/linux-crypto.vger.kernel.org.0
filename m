Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD355188C32
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2020 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQRfA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Mar 2020 13:35:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45918 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCQRfA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Mar 2020 13:35:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id 9so4600834oiq.12
        for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2020 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32N5kM8wn4tDAmjs6gedFa/sANcD7GCBYoh5b7duodg=;
        b=E7/PuPojEcN00+7o57owhlRnsJgcbwlFFc3V2M1Eqo3KTf2sDWkBQDH0Bk9/6murg/
         EqrgV+pRniu/EmQ24cYhdtRGEwPw/o0TKpeYy0ozj5KWvBb+bv1mNYEa+MmlpmaSgmF+
         VYUNve1/9bS/0SlC4hgHE//iIhVQ7u3a1gqJ2E5jDWFXQC90gSsu2FkmQ9iMNc+klK7b
         SQSFqZDMXOQxMLmZnrTPaL+dZh71UgMvDuh7oO8U080ShIju1cwhDxz7T1ZMOS7R1Uhp
         niBTyCUASpgJoW6gKXubPZ0GNOZ8hNOWnaVINp2093j0DXZFXjjhT2DKFHXxOGGNlaXT
         7uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32N5kM8wn4tDAmjs6gedFa/sANcD7GCBYoh5b7duodg=;
        b=KrweOTH4awBPsK5emMkGKGaaJtNoMWLBjfQcPM8Fr8dkrvToZXxqvu7WKNmE6anFk8
         i6WaUDedZhotRwjtoBQaVQ8Rs3g76xuvTHuGO2/sQ6mfQBkxCxQshF3jNZ3oER0hofge
         5MQK+XQK30DfqOkrIvp2f1in3+VmtHR39RgKSouMpfPGiHyKwJmZBJoRMN8VC60kAk73
         rZfKE9fFAIg4VVNCx5i6LucAHUBksqv813KRNvd9CZHrzQ1ss30ZP/hEwiP7zTZ+ra/y
         ZIo5Gb2eLBfUg/4PbYCN7/iqoijzVvF8v/yS1coHiNgU816hsEX6EK0PLJxRg6eJ13KU
         jvSA==
X-Gm-Message-State: ANhLgQ0pu3fMig3wH1IlXSvY3o6FGg6fVGTFGUskqER6XXsgXLSAwqiD
        eK9U+GhM8d+KFPMhzJCdQj7ZMmta6mCI7NSIlHaGzw==
X-Google-Smtp-Source: ADFU+vtKUOyY/n5MZWbhQpMLm27X+KBPsGUNtLxdhT2Fk9bGhFCI5PQnOf/a6tkQBL4/TXn9s+2FBVt/vHx8rUs++9M=
X-Received: by 2002:a54:418a:: with SMTP id 10mr365540oiy.105.1584466499710;
 Tue, 17 Mar 2020 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com> <20200317061522.12685-2-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <20200317061522.12685-2-rayagonda.kokatanur@broadcom.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Mar 2020 10:34:48 -0700
Message-ID: <CAPcyv4i17m6qDQtbNfPs+hVGF7CCdR59x04T5UdOwosTB5=OiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] async_tx: return error instead of BUG_ON
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 16, 2020 at 11:16 PM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> Return error upon failure instead of using BUG_ON().
> BUG_ON() will crash the kernel.
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

I don't think this patch is worth it, it has 2 problems:

- These conversions are buggy. Upper layers assume that the calls will
fall back to synchronous operation internally if they return NULL.

- These assertions indicate a major programming error that should not
be silently ignored. They need to be WARN_ON_ONCE() at a minimum, but
only if the above issue is solved.

These assertions are validating the raid implementation in raid5.c
which has been correctly handling this path for several years. The
risk of the code reorganization to "fix" this is higher than the
benefit given zero reports of these actually triggering in production.
