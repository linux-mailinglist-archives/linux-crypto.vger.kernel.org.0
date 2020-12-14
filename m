Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333122D91C9
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Dec 2020 03:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437986AbgLNC3U (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Dec 2020 21:29:20 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:37360 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgLNC3T (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Dec 2020 21:29:19 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 10:28:35 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 10:28:33 +0800
Subject: Re: [PATCH] crypto: x86/crc32c-intel - Don't match some Zhaoxin CPUs
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <TimGuo-oc@zhaoxin.com>,
        <CooperYan@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <SilviaZhao@zhaoxin.com>
References: <1607686144-2604-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <X9Ov3RWDpUik7gXo@sol.localdomain>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <1f8d17bf-c1d9-6496-d2f8-5773633011fb@zhaoxin.com>
Date:   Mon, 14 Dec 2020 10:28:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <X9Ov3RWDpUik7gXo@sol.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 12/12/2020 01:43, Eric Biggers wrote:
> On Fri, Dec 11, 2020 at 07:29:04PM +0800, Tony W Wang-oc wrote:
>> The driver crc32c-intel match CPUs supporting X86_FEATURE_XMM4_2.
>> On platforms with Zhaoxin CPUs supporting this X86 feature, When
>> crc32c-intel and crc32c-generic are both registered, system will
>> use crc32c-intel because its .cra_priority is greater than
>> crc32c-generic. This case expect to use crc32c-generic driver for
>> some Zhaoxin CPUs to get performance gain, So remove these Zhaoxin
>> CPUs support from crc32c-intel.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> 
> Does this mean that the performance of the crc32c instruction on those CPUs is
> actually slower than a regular C implementation?  That's very weird.
> 

From the lmbench3 Create and Delete file test on those chips, I think yes.

sincerely
Tony
