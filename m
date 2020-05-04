Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522FF1C4646
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2020 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEDSsJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 May 2020 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDSsJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 May 2020 14:48:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9378C061A0E;
        Mon,  4 May 2020 11:48:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F1B0D11F5F61A;
        Mon,  4 May 2020 11:48:06 -0700 (PDT)
Date:   Mon, 04 May 2020 11:48:06 -0700 (PDT)
Message-Id: <20200504.114806.529418018451997120.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     ayush.sawal@chelsio.com, vinay.yadav@chelsio.com,
        rohitm@chelsio.com, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, yuehaibing@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxgb4/chcr: avoid -Wreturn-local-addr warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200430103912.1170231-1-arnd@arndb.de>
References: <20200430103912.1170231-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 May 2020 11:48:07 -0700 (PDT)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 Apr 2020 12:39:02 +0200

> gcc-10 warns about functions that return a pointer to a stack
> variable. In chcr_write_cpl_set_tcb_ulp(), this does not actually
> happen, but it's too hard to see for the compiler:
> 
> drivers/crypto/chelsio/chcr_ktls.c: In function 'chcr_write_cpl_set_tcb_ulp.constprop':
> drivers/crypto/chelsio/chcr_ktls.c:760:9: error: function may return address of local variable [-Werror=return-local-addr]
>   760 |  return pos;
>       |         ^~~
> drivers/crypto/chelsio/chcr_ktls.c:712:5: note: declared here
>   712 |  u8 buf[48] = {0};
>       |     ^~~
> 
> Split the middle part of the function out into a helper to make
> it easier to understand by both humans and compilers, which avoids
> the warning.
> 
> Fixes: 5a4b9fe7fece ("cxgb4/chcr: complete record tx handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
