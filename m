Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9556883F
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Jul 2022 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiGFMX5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Jul 2022 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiGFMX4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Jul 2022 08:23:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEA20F77
        for <linux-crypto@vger.kernel.org>; Wed,  6 Jul 2022 05:23:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso8717263wms.1
        for <linux-crypto@vger.kernel.org>; Wed, 06 Jul 2022 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5KHAdDcwX24NbzKDAvafzAtUGJGDqZUpioC/hxvH8ww=;
        b=YOn5npfdMjt1/r8szulBt6rTdFj6qGfwHDuhJY2PuDnjluIUztjJMzr6hgUuSRSBhl
         lkoC44nQXvdC7Q5O1RFglOvfMx1z/nxXl5FDN+Itlf+AgilBSq4fzrmn64lSUDrfj3fC
         O+m11xW8/+KlcN65vAA1xncU4WiEiPmMdOW0RYodCekqGOnjr3sYyyeFeQyQnM67ZWBJ
         Et/mzTE+6h4RHNGKL3pmR0KJ2zg//aTSo54D4iKo5sqRPDHkEGmrvddgQRLXQw4VgE0v
         1npiY7eT2I13//lFrIMivwIc+VTfdJebv6wFllxVKU0YNpeZ0yhfz5beSDGxXTIcpp7W
         4v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5KHAdDcwX24NbzKDAvafzAtUGJGDqZUpioC/hxvH8ww=;
        b=XdZJ+NX/7fH7j9QGmP/fUbnjf35o1Y1rroiqkP7qVLr0Gsa0NpCxDudeAnSTV+4nDx
         NFlYBHhGhleZVNnUAx2PXYrYfqeJRLqnxQlr2SuuXiNl2U1syqKPzYDo4tsfthJIAy0a
         cb6IxP6O/ggN9W6jiank/aiV26it3CQzBQ3loAiRBtxG9LWhObHWQctCsv/Kl1/aAZsN
         QovWnFJM+vznUEzC2vesljk+NUO0MgP6V1IOoyZ43sGlqEIlgZqDqm+hRCUSvOkApE9C
         hhAMNQNe0yLmvakSdJWfh9EVm61b9ZpZyG79xtYgoav+nHu60UCoTNvnhgCstHaIMY20
         Ncbw==
X-Gm-Message-State: AJIora9dPESiQ+CXrWbtocle6MQ7ynSpSsRBLSWVAJLnpvFKppASkGSS
        4jffdWrxBMAZfpHCoY/wVx49Mg==
X-Google-Smtp-Source: AGRyM1s8pbcxPA7bUbV0T+xiYTeDMY3a909i6c7eZwEIlshJcOKVCYxEY2JgBSfJM15EErYJF1lrnQ==
X-Received: by 2002:a05:600c:3b1d:b0:3a2:60a1:fe6a with SMTP id m29-20020a05600c3b1d00b003a260a1fe6amr15263688wms.3.1657110233895;
        Wed, 06 Jul 2022 05:23:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id i30-20020a1c541e000000b003a032c88877sm21834833wmb.15.2022.07.06.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:23:53 -0700 (PDT)
Date:   Wed, 6 Jul 2022 14:23:48 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, herbert@gondor.apana.org.au,
        heiko@sntech.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <YsV+1DQzJ/KFnqBk@Red>
References: <20220701132735.1594822-1-clabbe@baylibre.com>
 <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk>
 <YsP0eekTthD4jWGV@Red>
 <20220705164213.GA14484@lst.de>
 <ec401a51-5895-fce7-1075-a2c964466d2b@codethink.co.uk>
 <20220706115807.GA16222@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706115807.GA16222@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Le Wed, Jul 06, 2022 at 01:58:07PM +0200, Christoph Hellwig a �crit :
> On Wed, Jul 06, 2022 at 10:47:24AM +0100, Ben Dooks wrote:
> > I'm not sure that the dma-mapping code for non-coherent riscv systems
> > did get sorted. I couldn't find any when looking in 5.17.
> 
> Yes, none of that is upstream.  But as supporting it is essential for
> the allwinner SOCs I'm pretty sure Corentin is not actually using an
> upstream kernel anyway.

I use an upstream kernel + some "not yet merged but sent for review" patch serie like
"riscv: implement Zicbom-based CMO instructions + the t-head variant"

And good news, I just updated to use the v6 of this serie (just posted today) and my problem disappear.

Regards
