Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E512259337
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jun 2019 07:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF1FJr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 01:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfF1FJq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 01:09:46 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85F3206E0;
        Fri, 28 Jun 2019 05:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561698586;
        bh=/peHflkrKmzjbuBmMuvUh/DLiTO8hGnUbfVTz+1n2Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuUO3xjaZIWvv3Mbofdz1xB8AocKHnbI5XgL+ZE/Yrl4SQPS/oif9fvuu28wewGbF
         y3INDtDd1R3SOBrBKOxq5TNIordgAutrhTvLNsVlaCsvqOX+YyuOx9JEfflt3KkCLq
         PPafmL2uJvZ7PtFOxYWVbFGr29cYtAtZ3jO1gnHc=
Date:   Thu, 27 Jun 2019 22:09:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        t-kristo@ti.com, linux-crypto@vger.kernel.org, nm@ti.com
Subject: Re: [RESEND PATCH 05/10] crypto: sha256_generic: Export the
 Transform function
Message-ID: <20190628050944.GE673@sol.localdomain>
References: <20190628042745.28455-1-j-keerthy@ti.com>
 <20190628042745.28455-6-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628042745.28455-6-j-keerthy@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 28, 2019 at 09:57:40AM +0530, Keerthy wrote:
> The transform function can be used as is by other crypto
> drivers that need to transform the 256 bit key using cpu.
> Hence export it.

What is this supposed to mean?  SHA-256 is an unkeyed hash function.

Also, you need to actually explain why this is needed.  If your hardware
supports SHA-256, why do you need to use the C sha256_transform()?

- Eric
