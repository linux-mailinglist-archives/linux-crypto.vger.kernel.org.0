Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD71211C6
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Dec 2019 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfLPRcT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Dec 2019 12:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfLPRcT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Dec 2019 12:32:19 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D2D206E0;
        Mon, 16 Dec 2019 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576517539;
        bh=3FHq3kkLRYBJTfZNYWTQU4o8xmH7L/DFB3nGZUj0wE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEYXaehDLIpwWwKH+UEyI8ry8lHI/s0ScYkPjg3pNtvsgw1r0Z3vhM1j5GK0ODhc7
         6s+se7cLAO7dWTwXuPGjbGAK+nkreOiG3ah5AZD+dOQufzPL5nAhIaG4RgP0sGQDJW
         hWvT50n+wIV+s2bJ1mbxKeC1TosZpRbTso48sabQ=
Date:   Mon, 16 Dec 2019 09:32:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xu Zaibo <xuzaibo@huawei.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        forest.zhouchang@huawei.com, zhangwei375@huawei.com
Subject: Re: [Question] Confusion of the meaning for encrypto API's return
 value
Message-ID: <20191216173217.GD139479@gmail.com>
References: <7a4edfcb-c140-bf1b-c674-dbb1b30f9b07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4edfcb-c140-bf1b-c674-dbb1b30f9b07@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 16, 2019 at 03:18:54PM +0800, Xu Zaibo wrote:
> Hi,
> 
> I get a confusion.
> 
> According to my understanding, That 'crypto_skcipher_encrypt(request)'
> returns '-EBUSY '
> 
> means the caller should call this API again with the request. However, as my
> knowledge in
> 
> 'dm-crypt', this means the caller need not call this request again, because
> 'dm-crypt' thinks
> 
> that the driver of 'crypto_skcipher_encrypt' will send the request again as
> it is not busy.
> 
>    So, my question is: what's the meaning of
> 'crypto_skcipher_encrypt(request)' returning '-EBUSY '?
> 
> 
> Cheers,
> 

-EBUSY means that the request was put on the backlog.  It will still be
completed eventually.

- Eric
