Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0A1F6605
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2020 12:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFKKya (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jun 2020 06:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFKKya (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jun 2020 06:54:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507682072F;
        Thu, 11 Jun 2020 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591872869;
        bh=80uubE3dNVN39nZNbsDqyk0sI6supmeMUDV8kVu2jYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S56k98nXcJaD2+CE+2qM17zrmLz3+qoUNu3luUjLD4GcrVAfUVlM8W6tkFSpmtRtH
         FBM6sTIX3X/GUQLEh0/VCPOOKztl8AsE41tTBWmR2DoQPxSFFRWVzeieK96JK8k3y+
         iFV/iMMx7hv6e660ViYLi5cP2ORzFUW7o6ByycqQ=
Date:   Thu, 11 Jun 2020 12:54:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Kang Yin <cantona@cantona.net>
Cc:     linux-crypto@vger.kernel.org, christophe.leroy@c-s.fr,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: talitos - fix ECB and CBC algs ivsize
Message-ID: <20200611105423.GB3802953@kroah.com>
References: <cantona@cantona.net>
 <20200611100745.6513-1-cantona@cantona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611100745.6513-1-cantona@cantona.net>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 11, 2020 at 06:07:45PM +0800, Su Kang Yin wrote:
> Patch for 4.9 upstream:
> 
> commit e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
> wrongly modified CBC algs ivsize instead of ECB aggs ivsize.
> 
> This restore the CBC algs original ivsize of removes ECB's ones.
> 
> Signed-off-by: Su Kang Yin <cantona@cantona.net>
> ---
>  drivers/crypto/talitos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Nice catch, sorry about that, patch now queued up.

greg k-h
