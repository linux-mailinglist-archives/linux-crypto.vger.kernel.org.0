Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E14265650
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 03:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgIKBF1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 21:05:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgIKBF1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 21:05:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A35A1B3BE7B7DF74EDAC
        for <linux-crypto@vger.kernel.org>; Fri, 11 Sep 2020 09:05:23 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Sep 2020 09:05:20 +0800
Subject: Re: [PATCH 0/5] crypto: hisilicon - update ACC module parameter
From:   liulongfang <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
References: <1599742610-33571-1-git-send-email-liulongfang@huawei.com>
Message-ID: <cb797569-b06e-7a9c-eea5-766312708d4f@huawei.com>
Date:   Fri, 11 Sep 2020 09:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1599742610-33571-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


On 2020/9/10 20:56, Longfang Liu Wrote:
> In order to pass kernel crypto test, the ACC module parameter
> pf_q_num needs to be set to an integer greater than 1,
> and then fixed two bugs.
>
> Longfang Liu (5):
>   crypto: hisilicon - update mininum queue
>   crypto: hisilicon - update HPRE module parameter description
>   crypto: hisilicon - update SEC module parameter description
>   crypto: hisilicon - update ZIP module parameter description
>   crypto: hisilicon - fixed memory allocation error
>
>  drivers/crypto/hisilicon/hpre/hpre_main.c  |  2 +-
>  drivers/crypto/hisilicon/qm.h              |  4 ++--
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 16 ++++++++++++----
>  drivers/crypto/hisilicon/sec2/sec_main.c   |  2 +-
>  drivers/crypto/hisilicon/zip/zip_main.c    |  2 +-
>  5 files changed, 17 insertions(+), 9 deletions(-)

Hi， Herbert

Please omit this patch set！

Due to my mailbox error， I sent this patch set again。

Sorry for this.

