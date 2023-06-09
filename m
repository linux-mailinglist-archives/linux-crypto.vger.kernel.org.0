Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7D729221
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Jun 2023 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjFIIDd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Jun 2023 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjFIIDG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Jun 2023 04:03:06 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A24EF9
        for <linux-crypto@vger.kernel.org>; Fri,  9 Jun 2023 01:01:30 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 29336218;
        Fri,  9 Jun 2023 08:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 29336218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686297611; bh=U4BRNmt6l052hCM0CBa4piomvb9Y+0lGhrlp2V3ok00=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VOut7YpNUdMs2OEeayHc+qtj/McBHpGkosGZVry9ZCIdJCSmRbJEC1MKioVpu5QqE
         F2eDiWhWTnx0T1xIODukZrrVGYuYBqkWUzIFTUeqtWxf3RolB9144MA5UB/+fdKvHw
         wA5niA02LG88RUGRxqa3ApNp1Ewkhg6Qc7NHuRP17qN27+8V75bGilMqYYHuFp4OWZ
         CgXnXVmXIBJBPDLDxZ3EaIlsE2LApDytaIvGFncNlE0RJ3m/0viYhZBcYXyVMs45Zt
         +lWE1Hyg1jORXOxFWsoNO3mnnxtJ/8emT3Xf1qUZ0tAuHuAoGExBNOPhz/0aHLJkwA
         KMuGYFCr/RHrQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Baruch Siach <baruch@tkos.co.il>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-crypto@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] docs: crypto: async-tx-api: fix typo in struct name
In-Reply-To: <2ef9dfaa33c1eff019e6fe43fe738700c2230b3d.1685342291.git.baruch@tkos.co.il>
References: <2ef9dfaa33c1eff019e6fe43fe738700c2230b3d.1685342291.git.baruch@tkos.co.il>
Date:   Fri, 09 Jun 2023 02:00:06 -0600
Message-ID: <87jzwdoyk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Baruch Siach <baruch@tkos.co.il> writes:

> Add missing underscore.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/crypto/async-tx-api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/crypto/async-tx-api.rst b/Documentation/crypto/async-tx-api.rst
> index bfc773991bdc..27c146b54d71 100644
> --- a/Documentation/crypto/async-tx-api.rst
> +++ b/Documentation/crypto/async-tx-api.rst
> @@ -66,7 +66,7 @@ features surfaced as a result:
>  ::
>  
>    struct dma_async_tx_descriptor *
> -  async_<operation>(<op specific parameters>, struct async_submit ctl *submit)
> +  async_<operation>(<op specific parameters>, struct async_submit_ctl *submit)

Applied, thanks.

jon
