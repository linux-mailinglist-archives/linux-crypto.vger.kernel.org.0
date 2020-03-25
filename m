Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21F192DA1
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCYQBS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 12:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbgCYQBR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 12:01:17 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59EF520409
        for <linux-crypto@vger.kernel.org>; Wed, 25 Mar 2020 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585152077;
        bh=r/oObLrDMZ3JrcgcvqwRJGnXD9NqHTQStgZUmVh4zqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBKHEMAVmoeuUYUTNWh/RavXmW1/tmcJm84XLHlM3/5C3K+ohdSDeRRUeh92KXfvA
         zoOGXiQ8OdAMN1CaAQXoaN268H14CoGDQHkQF7ipKFnLZwXlU/9tvCZAHvxrohxuWu
         33zlygiViRH66wp0EZQvqey0IqUvO3D1mA98jqu4=
Received: by mail-io1-f53.google.com with SMTP id h131so2782617iof.1
        for <linux-crypto@vger.kernel.org>; Wed, 25 Mar 2020 09:01:17 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0Vrwl9NdCN+hcr/8Ag7i9elnyrRr+P8OO8BnX1gidKVxvqkZaN
        3iP5M6bvoAtxsd6EGK/qlZL33jHKghTSI/3O/Y8=
X-Google-Smtp-Source: ADFU+vvZi1/bh1TXJoWFrdebLRX9gzthf/8XNnlz+UUNpphsQiUYlQ3Pduo0v77Yr5BONht3+oPq92weGro9g4iRzN0=
X-Received: by 2002:a02:c85a:: with SMTP id r26mr3681833jao.74.1585152069745;
 Wed, 25 Mar 2020 09:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200325135522.7782-1-broonie@kernel.org>
In-Reply-To: <20200325135522.7782-1-broonie@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Mar 2020 17:00:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGGTvn0r_jLuUxXJmuO+nvV0o_K=kZ++csZJ1Z6rU+a+g@mail.gmail.com>
Message-ID: <CAMj1kXGGTvn0r_jLuUxXJmuO+nvV0o_K=kZ++csZJ1Z6rU+a+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: Make extension enablement consistent
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 25 Mar 2020 at 14:55, Mark Brown <broonie@kernel.org> wrote:
>
> Currently we use a mix of .arch and .cpu to enable architecture
> extensions, make things consistent by converting the two instances of
> .cpu to .arch which is more common and a bit more idiomatic for our
> goal.
>
> Mark Brown (2):
>   arm64: crypto: Consistently enable extension
>   arm64: lib: Consistently enable crc32 extension
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/arm64/crypto/crct10dif-ce-core.S | 2 +-
>  arch/arm64/lib/crc32.S                | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
