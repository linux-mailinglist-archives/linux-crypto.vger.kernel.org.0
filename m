Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86156B386
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Jul 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiGHH3B (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Jul 2022 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiGHH27 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Jul 2022 03:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED67B361;
        Fri,  8 Jul 2022 00:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAF462577;
        Fri,  8 Jul 2022 07:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F57C341C0;
        Fri,  8 Jul 2022 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657265337;
        bh=P3KJbNk/a1tni8VNKqa9yL67GlHHapXzf5CgJxWvq2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwNF3wcS5wZs0apvEn9xv6n5LXVfwDmNG/aWqaunbQhVrmAk7gzn7R6HU07LSpAe+
         BA/dmzqZ2IHyv/ket3FWllSMB+rV3FfUmKjLHUfEMUoVGkcuIyEF2uoXRjU8fA+KDz
         RE/RTd1R2bTHjm4/tcC05MPFQJy01G2lDVTtCZtU=
Date:   Fri, 8 Jul 2022 09:28:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH v5 1/3] uacce: supports device isolation feature
Message-ID: <YsfctnUkPCo+qGJW@kroah.com>
References: <20220708070820.43958-1-yekai13@huawei.com>
 <20220708070820.43958-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708070820.43958-2-yekai13@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 08, 2022 at 03:08:18PM +0800, Kai Ye wrote:
> UACCE adds the hardware error isolation API. Users can configure
> the isolation frequency by this sysfs node. UACCE reports the device
> isolate state to the user space. If the AER error frequency exceeds
> the value of setting for a certain period of time, the device will be
> isolated.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 55 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uacce.h      | 11 ++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..d07b5f1f0596 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -7,6 +7,8 @@
>  #include <linux/slab.h>
>  #include <linux/uacce.h>
>  
> +#define MAX_ERR_ISOLATE_COUNT		65535
> +
>  static struct class *uacce_class;
>  static dev_t uacce_devt;
>  static DEFINE_MUTEX(uacce_mutex);
> @@ -339,12 +341,63 @@ static ssize_t region_dus_size_show(struct device *dev,
>  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>  }
>  
> +static ssize_t isolate_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +
> +	if (!uacce->ops->get_isolate_state)
> +		return -ENODEV;

If there is no callback, why is this sysfs even created at all?  Please
do not create it if it can not be accessed.

Use the is_visable() callback for the group to do this.

> +
> +	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
> +}
> +
> +static ssize_t isolate_strategy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	u32 val;
> +
> +	if (!uacce->ops->isolate_strategy_read)
> +		return -ENODEV;

Same here, don't have a sysfs file that does nothing.

> +
> +	val = uacce->ops->isolate_strategy_read(uacce);
> +	if (val > MAX_ERR_ISOLATE_COUNT)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t isolate_strategy_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct uacce_device *uacce = to_uacce_device(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	if (!uacce->ops->isolate_strategy_write)
> +		return -ENODEV;

Same here.

thanks,

greg k-h
