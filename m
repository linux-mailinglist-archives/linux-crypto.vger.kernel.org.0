Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0E2C7CBC
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Nov 2020 03:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgK3CWv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 29 Nov 2020 21:22:51 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50428 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgK3CWv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 29 Nov 2020 21:22:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGusXv9_1606702916;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UGusXv9_1606702916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Nov 2020 10:21:57 +0800
Subject: Re: [PATCH] crypto: ecrdsa - use subsys_initcall instead of
 module_init
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Vitaly Chikunov <vt@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201015110241.89676-1-tianjia.zhang@linux.alibaba.com>
 <20201015120504.GA12976@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f6d98764-dde8-6f40-c0e7-9eb5b087d713@linux.alibaba.com>
Date:   Mon, 30 Nov 2020 10:21:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201015120504.GA12976@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Herbert,

On 10/15/20 8:05 PM, Herbert Xu wrote:
> On Thu, Oct 15, 2020 at 07:02:41PM +0800, Tianjia Zhang wrote:
>> All templates and generic algorithms have been registered in
>> subsys_initcall instead of module_init. The ecrdsa algorithm
>> happened to be missed. Here is a fix for it.
> 
> That is true only if there are non-generic implementations of
> the algorithms, which is not the case here.  Please explain the
> real reason why this is needed.
> 
> Cheers,
> 

This is a generic algorithm, the author Vitaly Chikunov has also 
confirmed it, please consider this patch again.

Thanks.
