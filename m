Return-Path: <linux-crypto+bounces-538-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B5803A87
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A801F20F0B
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C4250FD
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Dec 2023 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb0OmF+/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE5B3;
	Mon,  4 Dec 2023 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701702054; x=1733238054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I27skRL2mlo5Di+ZOkkxTCHHmHLE279HG6eNMJsqcPo=;
  b=mb0OmF+/8cbcRE46plwrsQmaCSEJW5ehM1nUFNaC038Kji9SpjhLjeYX
   fnx/RKCKpSjagZe50b90AU5AZUW0ogWnSYf47/1s8gTITLvfq1DDZUpEn
   HQqjPNJ/k3gYEPagMrZTFUcla6eOGB6P3IjJIjJGn2e7MiULsn+JHPqWP
   lS0LVhptUlsaoUVl2pJQbUef6mcxEBra9c9ouphIYsXgq8+DncW+uQil8
   mj+LjtQethJr4G6qkS4bSEcgc62uSTLsG3xOxoYtwGWFXj69PmvwVNcMJ
   WhDKxg5KBvTOtQTnBeWiyAZvUqsGU7YXbYXCz8eT/u5dX3yvvsaVatxg0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="812253"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="812253"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 07:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720344488"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720344488"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2023 07:00:38 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: tom.zanussi@linux.intel.com
Cc: dave.jiang@intel.com,
	davem@davemloft.net,
	dmaengine@vger.kernel.org,
	fenghua.yu@intel.com,
	giovanni.cabiddu@intel.com,
	herbert@gondor.apana.org.au,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	tony.luck@intel.com,
	vinodh.gopal@intel.com,
	vkoul@kernel.org,
	wajdi.k.feghali@intel.com
Subject: Re: [PATCH v11 11/14] crypto: iaa - Add support for deflate-iaa compression algorithm
Date: Mon,  4 Dec 2023 23:00:28 +0800
Message-Id: <20231204150028.3544490-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201201035.172465-12-tom.zanussi@linux.intel.com>
References: <20231201201035.172465-12-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Tom,

On 2023-12-01 at 14:10:32 -0600, Tom Zanussi wrote:

[snip]

> +static int iaa_wq_put(struct idxd_wq *wq)
> +{
> +	struct idxd_device *idxd = wq->idxd;
> +	struct iaa_wq *iaa_wq;
> +	bool free = false;
> +	int ret = 0;
> +
> +	spin_lock(&idxd->dev_lock);
> +	iaa_wq = idxd_wq_get_private(wq);
> +	if (iaa_wq) {
> +		iaa_wq->ref--;
> +		if (iaa_wq->ref == 0 && iaa_wq->remove) {
> +			__free_iaa_wq(iaa_wq);
> +			idxd_wq_set_private(wq, NULL);
> +			free = true;
> +		}
> +		idxd_wq_put(wq);
> +	} else {
> +		ret = -ENODEV;
> +	}
> +	spin_unlock(&idxd->dev_lock);
__free_iaa_wq() may cause schedule, whether it should be move out of the
context between spin_lock() and spin_unlock()?
> +	if (free)
> +		kfree(iaa_wq);
> +
> +	return ret;
> +}

[snip]

> @@ -800,12 +1762,38 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
>  
>  	remove_iaa_wq(wq);
>  
> +	spin_lock(&idxd->dev_lock);
> +	iaa_wq = idxd_wq_get_private(wq);
> +	if (!iaa_wq) {
> +		spin_unlock(&idxd->dev_lock);
> +		pr_err("%s: no iaa_wq available to remove\n", __func__);
> +		goto out;
> +	}
> +
> +	if (iaa_wq->ref) {
> +		iaa_wq->remove = true;
> +	} else {
> +		wq = iaa_wq->wq;
> +		__free_iaa_wq(iaa_wq);
> +		idxd_wq_set_private(wq, NULL);
> +		free = true;
> +	}
> +	spin_unlock(&idxd->dev_lock);
__free_iaa_wq() may cause schedule, whether it should be move out of the
context between spin_lock() and spin_unlock()?
> +
> +	if (free)
> +		kfree(iaa_wq);
> +
>  	idxd_drv_disable_wq(wq);
>  	rebalance_wq_table();
>  
> -	if (nr_iaa == 0)
> +	if (nr_iaa == 0) {
> +		iaa_crypto_enabled = false;
Is it necessary to add iaa_unregister_compression_device() here?
All iaa devices are disabled cause the variable first_wq will be true,
if enable wq, iaa_register_compression_device() will fail due to the
algorithm is existed.
>  		free_wq_table();
> +		module_put(THIS_MODULE);
>  
> +		pr_info("iaa_crypto now DISABLED\n");
> +	}
> +out:
>  	mutex_unlock(&iaa_devices_lock);
>  	mutex_unlock(&wq->wq_lock);
>  }

[snip]

Thanks,
Rex Zhang
> -- 
> 2.34.1
> 

