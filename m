Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D931FFB
	for <lists+linux-crypto@lfdr.de>; Sat,  1 Jun 2019 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFAQ3K (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 1 Jun 2019 12:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfFAQ3K (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 1 Jun 2019 12:29:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717AE27753;
        Sat,  1 Jun 2019 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559406550;
        bh=9cyji5W/w3gbLF6yi/8SShOVJ7aru52p6Duz2OPhsWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yilr7e1TS/QXm+oWaOWbk/DSU4NcsL/dtLlbqwQEszU6azN9QYEeb5TwuJFUXMBV6
         ZVawcKz+8SuISvEwXuinwm6ATX9KQS+MDq6bNGuAoNZl+1XN1H7Ab+MX9JeCidP2k2
         UUENOivbzAFvzWGdvPyMpPiOMQMr5ezgOLRzryXo=
Date:   Sat, 1 Jun 2019 18:29:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, allison@lohutok.net, alexios.zavras@intel.com,
        swinslow@gmail.com, rfontana@redhat.com,
        linux-spdx@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] crypto: ux500 - fix license comment syntax error
Message-ID: <20190601162907.GB6261@kroah.com>
References: <20190601144943.126995-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601144943.126995-1-alex_y_xu@yahoo.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jun 01, 2019 at 10:49:43AM -0400, Alex Xu (Hello71) wrote:
> Causes error: drivers/crypto/ux500/cryp/Makefile:5: *** missing
> separator.  Stop.
> 
> Fixes: af873fcecef5 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 194")
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  drivers/crypto/ux500/cryp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also, how did 0-day not catch this?  Is this an odd configuration that
it can not build?

thanks,

greg k-h
