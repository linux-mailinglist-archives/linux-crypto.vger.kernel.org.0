Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5163C849
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Nov 2022 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiK2TZC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 29 Nov 2022 14:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiK2TYb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:31 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C56E54C
        for <linux-crypto@vger.kernel.org>; Tue, 29 Nov 2022 11:22:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so36194146ejb.9
        for <linux-crypto@vger.kernel.org>; Tue, 29 Nov 2022 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar/RYsQiETTjjxvJHozBvp1MbTSOUxcuqSLEZv8K3bo=;
        b=IZYwoODGdd+jwA/cpGNGwv5RVNFFusI8KtBABIIbcRkVrJJzhiK5zIEiLspZbzaaGV
         oDqhcwPKD170JD0iiSgVyx0TsbAg7frOFJ8dsJE96I066PsCjGnHiSSFtTGxXmHY2pGJ
         KWokkMaojB7NcgoV7YICB5tu9WMwDvVV028vLwOvTaAVGK7/TQPYjd2c6hmwOhX74zTa
         GHI9zhXKwwBa3HfHwW6hAfKSBN3o1bN3JzI0Djl4bJv73ol6x54lpqcT2rY1Cff3vJYv
         M4aXg73DQBVbhTZdxdtFDCAW0ufVEp5RfUmSVsJVJ+0fbUExxf9ymveozQBAX1zUZtqg
         OEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ar/RYsQiETTjjxvJHozBvp1MbTSOUxcuqSLEZv8K3bo=;
        b=0E5EvQNjUk5OEIomwfQLrNKUZbF+Koft1KS2cc6+8PRHiz+SoE3EwqVvmAC5QIy9Pm
         CxshtdSe7fGqxAXtBWI3aX2zy5VcmmKvqwDiraIm3JroUAk4XAXCvqNKam0Q5UnOFJ/H
         6xpdCUE+/nXhZNWPvSLVxGvDMdia8XZCbYPa251Ro0/uOguC87rmmlW4CdhSKSkN1oDp
         PPgGuYlWg+Kbyd4xNP71REnJwOqhCoZQgJLFlbT59HEsH97IUb4AZrSY9AWPBjCoZvdA
         GD5B7nE/RArlEi/fTBJTBeW3aizCOI7JKnWmC/kFBimkdo0Et2C6vdDwVHzU3rE4QaCy
         UPqg==
X-Gm-Message-State: ANoB5pmqwoPgD2wsOOoFRbXJ9s0+Ui+xfYjx9PP6is5AV+6+5Fo+BL1B
        s1aY7D2sk7gl2zLuG6tP7mzTC3/OMRfZGo+99p7y9g==
X-Google-Smtp-Source: AA0mqf4qO90v/zRQdgdyCplcsQ+yuw299RAUrvggn/40wCgn8ZzFOwXKlOY48E7OUmgZx4s0SleJmYDAXCRbrO5Gw/U=
X-Received: by 2002:a17:907:72d2:b0:7bc:15fc:5398 with SMTP id
 du18-20020a17090772d200b007bc15fc5398mr21465243ejc.438.1669749721411; Tue, 29
 Nov 2022 11:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20221129190123.872394-1-nathan@kernel.org>
In-Reply-To: <20221129190123.872394-1-nathan@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 29 Nov 2022 11:21:25 -0800
Message-ID: <CABCJKud96Jrz-NXeW+EW8VwcgYyd1WA=b+H0f-kcWSxkd8PzKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix lack of section mismatch warnings with LTO
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 29, 2022 at 11:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
>
> Hi all,
>
> Vincent recently reported an issue with lack of section mismatch
> warnings with LTO. This is due to commit 6c730bfc894f ("modpost: handle
> -ffunction-sections"), which ignores all function sections for modpost.
>
> I believe this is incorrect, as these function sections may still refer
> to symbols in other sections and they will ultimately be coalesced into
> .text by vmlinux.lds anyways.
>
> The first patch fixes a warning that I see with allmodconfig + ThinLTO
> builds after applying the second patch. The second patch moves ".text.*"
> into TEXT_SECTIONS so that modpost audits them for mismatches.
>
> I expect this to go via the kbuild tree with an ack from the padata
> maintainers.
>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: linux-crypto@vger.kernel.org
>
> Nathan Chancellor (2):
>   padata: Do not mark padata_mt_helper() as __init
>   modpost: Include '.text.*' in TEXT_SECTIONS
>
>  kernel/padata.c       | 4 ++--
>  scripts/mod/modpost.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

These look good to me. Thanks for fixing the issue, Nathan!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
