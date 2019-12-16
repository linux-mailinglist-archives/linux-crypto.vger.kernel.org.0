Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7F11FEF0
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Dec 2019 08:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLPHTG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Dec 2019 02:19:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfLPHTF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Dec 2019 02:19:05 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66BDCAD51559310B8857;
        Mon, 16 Dec 2019 15:19:03 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 15:18:54 +0800
To:     <linux-crypto@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <forest.zhouchang@huawei.com>, <zhangwei375@huawei.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Subject: [Question] Confusion of the meaning for encrypto API's return value
Message-ID: <7a4edfcb-c140-bf1b-c674-dbb1b30f9b07@huawei.com>
Date:   Mon, 16 Dec 2019 15:18:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

I get a confusion.

According to my understanding, That 'crypto_skcipher_encrypt(request)' 
returns '-EBUSY '

means the caller should call this API again with the request. However, 
as my knowledge in

'dm-crypt', this means the caller need not call this request again, 
because 'dm-crypt' thinks

that the driver of 'crypto_skcipher_encrypt' will send the request again 
as it is not busy.

    So, my question is: what's the meaning of 
'crypto_skcipher_encrypt(request)' returning '-EBUSY '?


Cheers,

Zaibo


.


