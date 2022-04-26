Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDF50FC5D
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Apr 2022 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349724AbiDZMAY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 Apr 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiDZMAV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 26 Apr 2022 08:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B9B45469B
        for <linux-crypto@vger.kernel.org>; Tue, 26 Apr 2022 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650974233;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtGBciEbW3HrGbgfdt44SW/MAlLfJ/KV2/2Bj92AK+4=;
        b=SHiL0itjCnFnyEKaCVcL8TsDEvUw8LkRyHa2yn/Kd2wM9eNSbYiZDtn3RC+Fx5oZiNrom1
        sz+66ckJQ1uT7DHckUltbE9BSQw2OdlOMSBn4Y0dYWvhEwBLpj1k4+LpOsx1hQd6b9jr5J
        pe/nmnRLS/ZoMO1fZxla/aIWiliZj5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-GDLsOS10NyK7qFRCVICpZg-1; Tue, 26 Apr 2022 07:57:11 -0400
X-MC-Unique: GDLsOS10NyK7qFRCVICpZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF5C83395E;
        Tue, 26 Apr 2022 11:57:11 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E9440F9D40;
        Tue, 26 Apr 2022 11:57:08 +0000 (UTC)
Date:   Tue, 26 Apr 2022 12:57:05 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     mst@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        cohuck@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 7/8] tests/crypto: Add test suite for crypto akcipher
Message-ID: <YmfeEaQHupPLBteU@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
 <20220411104327.197048-8-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411104327.197048-8-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Apr 11, 2022 at 06:43:26PM +0800, zhenwei pi wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> Add unit test and benchmark test for crypto akcipher.
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  tests/bench/benchmark-crypto-akcipher.c | 161 ++++++
>  tests/bench/meson.build                 |   4 +
>  tests/bench/test_akcipher_keys.inc      | 537 ++++++++++++++++++
>  tests/unit/meson.build                  |   1 +
>  tests/unit/test-crypto-akcipher.c       | 708 ++++++++++++++++++++++++
>  5 files changed, 1411 insertions(+)
>  create mode 100644 tests/bench/benchmark-crypto-akcipher.c
>  create mode 100644 tests/bench/test_akcipher_keys.inc
>  create mode 100644 tests/unit/test-crypto-akcipher.c
> 

> diff --git a/tests/bench/test_akcipher_keys.inc b/tests/bench/test_akcipher_keys.inc
> new file mode 100644
> index 0000000000..7adf218135
> --- /dev/null
> +++ b/tests/bench/test_akcipher_keys.inc
> @@ -0,0 +1,537 @@
> +/*
> + * Copyright (c) 2022 Bytedance, and/or its affiliates
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * Author: lei he <helei.sig11@bytedance.com>
> + */
> +
> +/* RSA test keys, generated by OpenSSL */
> +static const uint8_t rsa1024_priv_key[] = {
> +    0x30, 0x82, 0x02, 0x5c, 0x02, 0x01, 0x00, 0x02,
> +	0x81, 0x81, 0x00, 0xe6, 0x4d, 0x76, 0x4f, 0xb2,

snip

For the patch as is:

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


It could be nice to add another test with some intentionally corrupt
RSA keys with bad DER encoding, as a way to prove that we're handling
errors in DER decoding correctly when faced with malicous data from a
bad guest.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

