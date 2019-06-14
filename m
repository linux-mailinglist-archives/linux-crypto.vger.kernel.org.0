Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A746459E6
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Jun 2019 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFNKFj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Jun 2019 06:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfFNKFj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Jun 2019 06:05:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1090021773;
        Fri, 14 Jun 2019 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560506738;
        bh=Y8PVX03thKRAz9zYHx5TO70jzybxR9Kq9EKsJoQRaXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApYnzrUIjCRr9XqBHGCw7be000TI9C++YHMEShVyEMqdT9uTn1PCqUm104/s0P03l
         Qx3nx8BXsHCXSvLCpX7AdDBuRP2PJYrBKbGaf23TXNoJQ99A9x1E9r+l5ZgMCmTBXo
         YsUx9q9OdtkMnFzQxHzauV+ae/LmSP/9Ucl49Bgo=
Date:   Fri, 14 Jun 2019 12:05:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v2] wusb: switch to cbcmac transform
Message-ID: <20190614100536.GA8466@kroah.com>
References: <20190614094353.23089-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614094353.23089-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 14, 2019 at 11:43:53AM +0200, Ard Biesheuvel wrote:
> The wusb code takes a very peculiar approach at implementing CBC-MAC,
> by using plain CBC into a scratch buffer, and taking the output IV
> as the MAC.
> 
> We can clean up this code substantially by switching to the cbcmac
> shash, as exposed by the CCM template. To ensure that the module is
> loaded on demand, add the cbcmac template name as a module alias.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: - use finup()/digest() where possible, and process b0+b1 using a single
>       call to update()
>     - make 'stv_hsmic_hs' static const and remove comment regarding GCC 4.1
> 
> NOTE: I don't have any hardware to test this, but the built-in selftest
>       still passes.

No one has this hardware :)

I'll take this, but I think I'll be moving all of the wireless usb code
to staging to drop it in a few kernel versions as there are no users of
it anymore that I can tell.

thanks,

greg k-h
