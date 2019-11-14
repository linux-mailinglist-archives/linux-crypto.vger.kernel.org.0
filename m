Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237A9FBE91
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Nov 2019 05:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNEdG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Nov 2019 23:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfKNEdG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Nov 2019 23:33:06 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D5D206D7;
        Thu, 14 Nov 2019 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573705986;
        bh=/xYY+c2j1RKWj54LB/twVjrK69iylSYXPKpSf2SQjec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/BG2AnLQx7uj9T2ncjGW9yo7FSi0mQpwgRmNLN5/SQRPO9AuK9oEDEKQ9SajGXWe
         99NzjVN2PIts9WGV6jlV138CrCUrsB7bsKQ3fOHU0T8s5Q6MEBHrwx91ZV/SBJkjH1
         q0bkh/ca+0THtezH66R1Nx7SZJ4s7Wvc7O7kOTSs=
Date:   Thu, 14 Nov 2019 10:03:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qce/dma - Use dma_request_chan() directly for
 channel request
Message-ID: <20191114043300.GD952516@vkoul-mobl>
References: <20191113090947.28499-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113090947.28499-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 13-11-19, 11:09, Peter Ujfalusi wrote:
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Thanks Peter

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
