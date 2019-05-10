Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A971A44E
	for <lists+linux-crypto@lfdr.de>; Fri, 10 May 2019 23:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfEJVHS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 May 2019 17:07:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44695 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfEJVHS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 May 2019 17:07:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so6860327edm.11
        for <linux-crypto@vger.kernel.org>; Fri, 10 May 2019 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=elVk6sgIxZrDGVeevhQCe+vhDAsDu3sGw0QGBZMgA9M=;
        b=hEQ/RQ4EGqpM7gmjQ5hQZMKLE4zaduR0T1/Ovknp4ZJfs91m9cgcVtNoDr7qao5jE9
         PbltFAlFNWFeMl08Zlku5MBHVQfOremDpzWbaQ9gdjc3ufM/xIi1oyzWrtH2n9rMsPfJ
         Y1w+X8UB4KqRHTEyY92iFG5SSr/DMeWXs0FQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elVk6sgIxZrDGVeevhQCe+vhDAsDu3sGw0QGBZMgA9M=;
        b=kCYBjQ7bBJ3A0opTVT46x9LmjvmMUKLpEkryAIBQJdxW/M7Ao35gSWquGuau63QXiW
         sOJ0As7VaJi2IAFSOsyXuf7kYz2t+8NqeWu//GJjlOK9A78gDxXozgnTacfyznlgCTqg
         CZuJviMc47YXCqzRgA5Ewq6wLs7QjIAqT5Q7qZnOnZuq3/nZVhRTSyIDVRTq3uz5NCac
         wu4BveGEKHpKyF7oM8ek4//FMnEVc/6zAgkPAGcQmnmC0mThC/PLqNfptQYlvs4H60Lq
         Hc1ySGb/4HOHf8RhdHVHYxcjLnxtZ+oRR4LWCCubchwCP9fRRqGGYZwHhzVo1QEuvB1a
         ZWng==
X-Gm-Message-State: APjAAAXZbJlaaFII0+vTCIGEibTJEQbCMRSEw4jQMCfhIBoAjaLkT6pW
        tmcabx/g8o4yPA4tVGKtfpeMIJJNO+d84w==
X-Google-Smtp-Source: APXvYqy4AA+phRa0ZVJjTEkWVxJxy/0bAIGLY7h5DOIxSZDJDTQD4BIDQ2P98HZFQBLbeDvjy4VMhw==
X-Received: by 2002:a50:bb24:: with SMTP id y33mr13550439ede.116.1557522436869;
        Fri, 10 May 2019 14:07:16 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b4sm1725867eda.9.2019.05.10.14.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 14:07:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] hwrng: Support for 7211 in iproc-rng200
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com,
        wahrenst@gmx.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, mpm@selenic.com
References: <20190510173112.2196-1-f.fainelli@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <b1eb11c0-3aa9-52c1-da4c-e685e4bef48e@broadcom.com>
Date:   Fri, 10 May 2019 14:07:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510173112.2196-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Florian,

On 5/10/2019 10:31 AM, Florian Fainelli wrote:
> Hi Herbert,
> 
> This patch series adds support for BCM7211 to the iproc-rng200 driver,
> nothing special besides matching the compatibile string and updating the
> binding document.
> 
> Florian Fainelli (2):
>   dt-bindings: rng: Document BCM7211 RNG compatible string
>   hwrng: iproc-rng200: Add support for 7211
> 
>  Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 1 +
>  drivers/char/hw_random/iproc-rng200.c                       | 1 +
>  2 files changed, 2 insertions(+)
> 

Patch series looks good to me. Thanks!

Ray
