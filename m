Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE181EDD16
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2020 08:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFDGSk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Jun 2020 02:18:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36224 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgFDGSj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Jun 2020 02:18:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jgjCd-0002F3-44; Thu, 04 Jun 2020 16:18:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2020 16:18:11 +1000
Date:   Thu, 4 Jun 2020 16:18:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
Message-ID: <20200604061811.GA28759@gondor.apana.org.au>
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
 <20200604033918.GA2286@gondor.apana.org.au>
 <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 04, 2020 at 02:10:37PM +0800, Zhangfei Gao wrote:
>
> > Should this even allow truncation? Perhaps it'd be better to fail
> > in case of an overrun?
> I think we do not need consider overrun, since it at most copy size-1 bytes
> to dest.
> From the manual: strlcpy()
>        This  function  is  similar  to  strncpy(), but it copies at most
> size-1 bytes to dest, always adds a terminating null
>        byte,
> And simple tested with smaller SIZE of interface.name,  only SIZE-1 is
> copied, so it is safe.
> -#define UACCE_MAX_NAME_SIZE    64
> +#define UACCE_MAX_NAME_SIZE    4

That's not what I meant.  As it is if you do exceed the limit the
name is silently truncated.  Wouldn't it be better to fail the
allocation instead?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
