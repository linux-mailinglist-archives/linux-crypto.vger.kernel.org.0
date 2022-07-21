Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F257C305
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Jul 2022 05:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiGUDv0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 Jul 2022 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGUDvH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 Jul 2022 23:51:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC7425290
        for <linux-crypto@vger.kernel.org>; Wed, 20 Jul 2022 20:51:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LpJVb6N5GzFqQK;
        Thu, 21 Jul 2022 11:49:59 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 11:50:38 +0800
Message-ID: <b9cb514c-30ed-0b8b-5d54-75001e07bd36@huawei.com>
Date:   Thu, 21 Jul 2022 11:50:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Inquiry about the removal of flag O_NONBLOCK on /dev/random
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <linux-crypto@vger.kernel.org>, <luto@kernel.org>, <tytso@mit.edu>,
        <ebiggers@kernel.org>
References: <13e1fa9d-4df8-1a99-ca22-d9d655f2d023@huawei.com>
 <YtaPJPkewin5uWdn@zx2c4.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <YtaPJPkewin5uWdn@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2022/7/19 19:01, Jason A. Donenfeld wrote:
> Hi,
> 
> On Thu, Jul 14, 2022 at 03:33:47PM +0800, Guozihua (Scott) wrote:
>> Recently we noticed the removal of flag O_NONBLOCK on /dev/random by
>> commit 30c08efec888 ("random: make /dev/random be almost like
>> /dev/urandom"), it seems that some of the open_source packages e.g.
>> random_get_fd() of util-linux and __getrandom() of glibc. The man page
>> for random() is not updated either.
>>
>> Would anyone please kindly provide some background knowledge of this
>> flag and it's removal? Thanks!
> 
> I didn't write that code, but I assume it was done this way because it
> doesn't really matter that much now, as /dev/random never blocks after
> the RNG is seeded. And now a days, the RNG gets seeded with jitter
> fairly quickly as a last resort, so almost nobody waits a long time.
> 
> Looking at the two examples you mentioned, the one in util-linux does
> that if /dev/urandom fails, which means it's mostly unused code, and the
> one in glibc is for GNU Hurd, not Linux. I did a global code search and
> found a bunch of other instances pretty similar to the util-linux case,
> where /dev/random in O_NONBLOCK mode is used as a fallback to
> /dev/urandom, which means it's basically never used. (Amusingly one such
> user of this pattern is Ted's pwgen code from way back at the turn of
> the millennium.)
> 
> All together, I couldn't really find anywhere that the removal of
> O_NONBLOCK semantics would actually pose a problem for, especially since
> /dev/random doesn't block at all after being initialized. So I'm
> slightly leaning toward the "doesn't matter, do nothing" course of
> action.
> 
> But on the other hand, you did somehow notice this, so that's important
> perhaps. How did you run into it? *Does* it actually pose a problem? Or
> was this a mostly theoretical finding from perusing source code?
> Something like the below diff would probably work and isn't too
> invasive, but I think I'd prefer to leave it be unless this really did
> break some userspace of yours. So please let me know.
> 
> Regards,
> Jason
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 70d8d1d7e2d7..6f232ac258bf 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1347,6 +1347,10 @@ static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *iter)
>   {
>   	int ret;
>   
> +	if (!crng_ready() &&
> +	    ((kiocb->ki_flags & IOCB_NOWAIT) || (kiocb->ki_filp->f_flags & O_NONBLOCK)))
> +		return -EAGAIN;
> +
>   	ret = wait_for_random_bytes();
>   	if (ret != 0)
>   		return ret;
> 
> .

Hi Jason, Thanks for the respond.

The reason this comes to me is that we have an environment that is super 
clean with very limited random events and with very limited random 
hardware access. It would take up to 80 minutes before /dev/random is 
fully initialized. I think it would be great if we can restore the 
O_NONBLOCK flag.

Would you mind merge this change into mainstream or may I have the honor?

-- 
Best
GUO Zihua
