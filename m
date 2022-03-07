Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB454CEFC5
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Mar 2022 03:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiCGCqT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 6 Mar 2022 21:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiCGCqS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 6 Mar 2022 21:46:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383D38A1
        for <linux-crypto@vger.kernel.org>; Sun,  6 Mar 2022 18:45:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso11968231pjb.0
        for <linux-crypto@vger.kernel.org>; Sun, 06 Mar 2022 18:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MqTvzhnDnNsM5gc1jxNKVsqHTeWOImRbSBaH/Le+AV0=;
        b=ii0KSuBKQb6dIjrfOwNM5mk/9+Nq7Hgn9DTHrwdUkgL/ZLQLBBKluI3Iwlmv8Zu1O4
         Q8/j77axaUB3XVjJ72tcgzUH8A4jWRlTK5rp7S6IQ0j7DWMJpCmQZidE1zpTVZ6rE19a
         XJXOL96PemSMSQwhyECg4jWBTKm06QfU2quY23E0II6hHrppbQ9TsirSKEmILBMVNz8/
         bCdC9cURTp3hMsgFnMlrhoNl4n+ATpabzkW2Z0rpr9zQIH4Yr2xTEbXqKed2RxmmlJ7a
         b/EF2ho6JLko+gIQb3pK4xJQsa2D7+REwDPDyFkd18tHDpzyUN6cCmuySwm7Nv4EXGU0
         YyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqTvzhnDnNsM5gc1jxNKVsqHTeWOImRbSBaH/Le+AV0=;
        b=y9h0WLKn4g3N3srzSvOtyRE7+L1Oj6dK0Z2vLD6sHdeMoPFvGBEYV/4vgZ3Bj+7Iu7
         7vTnQpZF3yh7qc5nyg5aJrbhu2J8vbFUknfN4WMKGBcm8508bMXpWSt6jsjTglaBMtfk
         QpgJA8wYZUmIbG6qU1YnN2iCdtXs9Y+tIUtdR3SlxPcz4XTVH6oR4jQ+qed95numIiHW
         o+5hOLeEXVJ2W+N1xjvlg+WxJKBTwXttjJD4IVzfik4qfOrcAhwniH+nXFzTvD5r8F6H
         2hR0Yv+gGukqirHJY0g5IJ4gVnytwvlOPWIMbh5Tz2Dh5jNEn5scMeGPNio7NmNYdjBz
         SiiA==
X-Gm-Message-State: AOAM532Hlv+n6pqjzUUV6UENZm6SGeNl3g0ux9c5Q5m/EA0MiImD/EWF
        7siT5uE2ICyTBPND7yXvwzEi6kq01KEkUw==
X-Google-Smtp-Source: ABdhPJx9z16gRqP9k0HLwPVJ/PCks1UzrTHcjIYRn5tv8E0ldU0gePkCgrzBhpbw4mb5hbFv4roBfw==
X-Received: by 2002:a17:902:7143:b0:151:eea7:bc62 with SMTP id u3-20020a170902714300b00151eea7bc62mr1578566plm.122.1646621125042;
        Sun, 06 Mar 2022 18:45:25 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b001bf09d6c7d7sm11087532pjb.26.2022.03.06.18.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 18:45:24 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com,
        cohuck@redhat.com
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
Date:   Mon, 7 Mar 2022 10:42:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi, Michael & Lei

The full patchset has been reviewed by Gonglei, thanks to Gonglei.
Should I modify the virtio crypto specification(use "__le32 
akcipher_algo;" instead of "__le32 reserve;" only, see v1->v2 change), 
and start a new issue for a revoting procedure?

Also cc Cornelia Huck.

On 3/2/22 11:39 AM, zhenwei pi wrote:
> v2 -> v3:
>    Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
>      minor changes of function name.
>    Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
>      buffer if opcode is verify.
> 
> v1 -> v2:
>    Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
>    Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>      struct virtio_crypto_config directly without size change.
>    Add padding in struct virtio_crypto_ecdsa_session_para to keep
>      64-bit alignment.
>    Remove irrelevant change by code format alignment.
> 
>    Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> 
>    Test with QEMU(patched by the v2 version), works fine.
> 
> v1:
>    Introduce akcipher service, implement RSA algorithm, and a minor fix.
> 
> zhenwei pi (4):
>    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>    virtio-crypto: introduce akcipher service
>    virtio-crypto: implement RSA algorithm
>    virtio-crypto: rename skcipher algs
> 
>   drivers/crypto/virtio/Makefile                |   3 +-
>   .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
>   drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
>   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
>   ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
>   include/uapi/linux/virtio_crypto.h            |  82 ++-
>   7 files changed, 693 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>   rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)
> 

-- 
zhenwei pi
