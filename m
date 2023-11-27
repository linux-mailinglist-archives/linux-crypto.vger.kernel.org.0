Return-Path: <linux-crypto+bounces-318-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371427F9FBB
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1611F20CD5
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCC2D7AB
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E248111;
	Mon, 27 Nov 2023 04:32:44 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sf4hw4X9JzWhsS;
	Mon, 27 Nov 2023 20:32:00 +0800 (CST)
Received: from [10.67.121.197] (10.67.121.197) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Nov 2023 20:32:41 +0800
Message-ID: <bff73a43-e13d-7ec3-8caa-c636da05a6d4@huawei.com>
Date: Mon, 27 Nov 2023 20:32:35 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] MAINTAINERS: update SEC2/HPRE driver maintainers list
Content-Language: en-US
To: Longfang Liu <liulongfang@huawei.com>, <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231127112449.50756-1-liulongfang@huawei.com>
From: "songzhiqi (A)" <songzhiqi1@huawei.com>
In-Reply-To: <20231127112449.50756-1-liulongfang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected

Reviewed-by: Zhiqi Song <songzhiqi1@huawei.com>

On 2023/11/27 19:24, Longfang Liu wrote:
> Kai Ye is no longer participates in the Linux community.
> Zhiqi Song will be responsible for the code maintenance of the
> HPRE module.
> Therefore, the maintainers list needs to be updated.
>
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..de394b632b99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9542,6 +9542,7 @@ F:	Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
>   F:	drivers/gpio/gpio-hisi.c
>   
>   HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
> +M:	Zhiqi Song <songzhiqi1@huawei.com>
>   M:	Longfang Liu <liulongfang@huawei.com>
>   L:	linux-crypto@vger.kernel.org
>   S:	Maintained
> @@ -9642,7 +9643,6 @@ F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>   F:	drivers/scsi/hisi_sas/
>   
>   HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
> -M:	Kai Ye <yekai13@huawei.com>
>   M:	Longfang Liu <liulongfang@huawei.com>
>   L:	linux-crypto@vger.kernel.org
>   S:	Maintained

