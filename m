Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55D2C5BF9
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Nov 2020 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbgKZSZ2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 Nov 2020 13:25:28 -0500
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:59502
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403953AbgKZSZ2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 Nov 2020 13:25:28 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glkc-linux-crypto@m.gmane-mx.org>)
        id 1kiLxO-0003AQ-2v
        for linux-crypto@vger.kernel.org; Thu, 26 Nov 2020 19:25:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-crypto@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] crypto: qat - Use dma_set_mask_and_coherent to simplify
 code
Date:   Thu, 26 Nov 2020 19:25:20 +0100
Message-ID: <f8d556f4-75da-7daf-a4af-8335788ff4a1@wanadoo.fr>
References: <20201121071359.1320167-1-christophe.jaillet@wanadoo.fr>
 <20201126120408.GA21666@silpixa00400314>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201126120408.GA21666@silpixa00400314>
Content-Language: fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Le 26/11/2020 à 13:04, Giovanni Cabiddu a écrit :
> Hi Christophe,
> 
> On Sat, Nov 21, 2020 at 07:13:59AM +0000, Christophe JAILLET wrote:
>> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
>> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
>>
>> While at it, also remove some unless extra () in the 32 bits case.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Instead of returning -EFAULT, we could also propagate the error returned
>> by dma_set_mask_and_coherent()
> I'm going to re-submit implementing the comment above and also including
> qat_4xxx.
> 
> Regards,
> 

Sure,
sorry for missing this one.

CJ

