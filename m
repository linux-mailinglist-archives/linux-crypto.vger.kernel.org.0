Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E92A5F2A
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Nov 2020 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgKDIO5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Nov 2020 03:14:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7140 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgKDIO4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Nov 2020 03:14:56 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQzwD0G26z15RGQ;
        Wed,  4 Nov 2020 16:14:52 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 4 Nov 2020
 16:14:51 +0800
Subject: Re: [PATCH 1/1] arm64: Accelerate Adler32 using arm64 SVE
 instructions.
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Dave Martin <Dave.Martin@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20201103121506.1533-1-liqiang64@huawei.com>
 <20201103121506.1533-2-liqiang64@huawei.com>
 <CAMj1kXFJRQ59waFwbe2X0v5pGvMv6Yo6DJPLMEzjxDAThC-+gw@mail.gmail.com>
 <eaba1019-0cdb-fa36-5620-354c6478b713@huawei.com>
 <CAMj1kXETrqGrcCCAg+afCUJVfngoJkmSfedB3B9DhuGTJHgN5g@mail.gmail.com>
From:   Li Qiang <liqiang64@huawei.com>
Message-ID: <d7d173c6-d2af-639b-69ac-2a87e395df19@huawei.com>
Date:   Wed, 4 Nov 2020 16:14:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXETrqGrcCCAg+afCUJVfngoJkmSfedB3B9DhuGTJHgN5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.110.54.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



在 2020/11/4 16:04, Ard Biesheuvel 写道:
> I understand that zlib_deflate uses adler32 internally. But where does
> it invoke the crypto API to use the shash abstraction to perform this
> transformation?

Um... yes, I haven't finished this part yet.

-- 
Best regards,
Li Qiang
