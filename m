Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939351B3915
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2020 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgDVHiy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Apr 2020 03:38:54 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:58799 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVHiy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Apr 2020 03:38:54 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id aa0d615f;
        Wed, 22 Apr 2020 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=/sg8GZPKwFtmJRFpacBo1cf/OgI=; b=2cM/3a
        yz8IvpwnuEqoqbbkvRLBLcWqtHUcAdVxzlKYl0UKYPgfJGksZQclryc+Gq6hnEsN
        /SUy54gs4FfYaHCIFYqk/eyrPTw4mVNlI45sfjxn04BMGq3sHWL3jQjU7TjERqJ2
        /OpA6dkjWLCV75Ez/50e/A1h0raPy656P+JZw2gnl/lbbA4d0SyMcysFFJ/tKwXx
        hCqu93Bibdwyq6YSdi9T9hSqteq6qdFOLJX4aF7/+DcQomBVrGalXvOCYYCvuxh4
        65L+FTc6Fe5wokQN4/l0VH37J4Pa/fZhDlodXype6u+WujJ+EbU+S51/rZpecNWA
        3s/wTvIttHLz/xdA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 684cb763 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 22 Apr 2020 07:28:02 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id f82so922965ilh.8;
        Wed, 22 Apr 2020 00:38:52 -0700 (PDT)
X-Gm-Message-State: AGi0Pubkt8TsqluhG9prKhqcn/iwJ29IYSseAeqMbVcSMkVaTwKYCHhN
        e1d1rmneQ3noGZUl7ZOgAO+rRwS+uzc5X12k8cs=
X-Google-Smtp-Source: APiQypLTtpTIRljCgyNakNz/zRP4C8vI82xsF2BjTAYEiN/4S1KV/Cc2xjZaNymJWJMjKaZ/6lHCQwvSaS71tFjtaME=
X-Received: by 2002:a92:bf0b:: with SMTP id z11mr22557664ilh.207.1587541131618;
 Wed, 22 Apr 2020 00:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200420075711.2385190-1-Jason@zx2c4.com> <20200422040415.GA2881@sol.localdomain>
 <CAMj1kXGRNCEkTFPGM03h1N+HtOiLVMcm89UJYMZcuWjyFAp5Ag@mail.gmail.com>
In-Reply-To: <CAMj1kXGRNCEkTFPGM03h1N+HtOiLVMcm89UJYMZcuWjyFAp5Ag@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 22 Apr 2020 01:38:40 -0600
X-Gmail-Original-Message-ID: <CAHmME9oZUO4=uV8EsKwQf_TJ20EL62fn=-UiyZW-we5TukqxGQ@mail.gmail.com>
Message-ID: <CAHmME9oZUO4=uV8EsKwQf_TJ20EL62fn=-UiyZW-we5TukqxGQ@mail.gmail.com>
Subject: Re: [PATCH crypto-stable] crypto: arch/lib - limit simd usage to
 PAGE_SIZE chunks
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Apr 22, 2020 at 1:23 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> So I think 4 KB is indeed a reasonable quantum of work here. Only
> PAGE_SIZE is not necessarily equal to 4 KB on arm64, so we should use
> SZ_4K instead.

Will wait to hear the rt guys' opinion, but sure, we can do SZ_4K
explicitly. If we go with that in the end, v2 will adjust the other
places that are already using PAGE_SIZE.

> So do we have any callers that are likely to pass more than 4 KB of
> input at a time?

Network packets can be big -- ethernet jumbo packets are 9k, for
example -- so that means this could potentially ipsec, wireguard, and
maybe wifi too. (Crypto api users might go through another layer of
indirection that splits things up smaller, maybe.)
