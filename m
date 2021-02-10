Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798BF315C5B
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 02:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhBJBfi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Feb 2021 20:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhBJBdc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Feb 2021 20:33:32 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161BC0613D6
        for <linux-crypto@vger.kernel.org>; Tue,  9 Feb 2021 17:32:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so300471plh.12
        for <linux-crypto@vger.kernel.org>; Tue, 09 Feb 2021 17:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6voKTk6/OdOzOuPgN0xYWNzCZPSi7LG5qfSMC9hkY0=;
        b=Ump3YhBMnDO6jOwbzAYdSdwi+bxYNZoVhs1d7kKrZcMxTs6PGLNTpwTuNk5bOETuA8
         USrvPZo9BBRCr3cLqHbLUCN9nB4DT253/NxqYBg7aKS5ugqRK8Dwtkh4wImZq36FXFtf
         BqKr8byaMDB6nQ4RDMNrWYGqCA4zqvo6BrZ4PKLtwOg7WSuN070wpz8zBisKU619vV8O
         dCos8kBnDXRkLJPpXZl7r+QzYwZyBuYfT3gXOCn1LY34XuQoe9jx+j2FygwYhAH99cWT
         47/fysUZ1Zw+CUE4jc5VQjOAQd8bEP/s4pyip5P54E0yNb3aXmS+jODmJrys7qKaxl3S
         j5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6voKTk6/OdOzOuPgN0xYWNzCZPSi7LG5qfSMC9hkY0=;
        b=darskbZTmkQ3j0+fMwnT0B7OCSyTU+OCedp+z8sJ2avKiqb2DGSJ0SbZfeWjPrxvRQ
         8OVFl55HyqcEpsE75q71GCEf55GPcpuYDALVvshPBWbT8rDPFp9KYgC2jwOHE84jXv6g
         SLPuruO0Rer3UXs7cnPt0rhxwf14vmhgiWkD/Y84Tj2dI0nHJTPW2GMinXk61i8BB3/e
         /oeG7jOzb9wdRG7JVyeq1tk+n1lSU5ywIMwxuxiSDFeCwYHvHORektGJbQP9tbSRr7Iu
         mlbDiKMvcEoG3t4VWbEPPTzPbRq0n6OX6l+1977Md8irLTG0JAFsy/WZZYqk/uJ8GmWZ
         sGAg==
X-Gm-Message-State: AOAM533O0Wppo7jjOsX/URfeHfp0pmvqcMhzR9j4uJjPKIne20gAFSMl
        0hY2hLvZQx05xosMFyizkO1UhaIAQcM=
X-Google-Smtp-Source: ABdhPJy0b5I+6N64Xz+iZbhDKWK6dK9Y1pDcCQk5IKibjCBxqEqKr19ueYXRPBYMH2BvpSeGuwYceQ==
X-Received: by 2002:a17:90a:cd06:: with SMTP id d6mr731958pju.86.1612920772287;
        Tue, 09 Feb 2021 17:32:52 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z22sm171027pfa.41.2021.02.09.17.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 17:32:51 -0800 (PST)
Subject: Re: [PATCH v2] hwrng: bcm2835 - remove redundant null check
To:     Tian Tao <tiantao6@hisilicon.com>, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenzjulienne@suse.de
Cc:     linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1612919698-60261-1-git-send-email-tiantao6@hisilicon.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <08a9cc3c-2bee-4fce-ff79-05499b11f903@gmail.com>
Date:   Tue, 9 Feb 2021 17:32:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612919698-60261-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On 2/9/2021 5:14 PM, Tian Tao wrote:
> clk_prepare_enable() and clk_disable_unprepare() will check
> NULL clock parameter, so It is not necessary to add additional checks.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for the quick spin!
-- 
Florian
