Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446E6751E
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jul 2019 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGLSfb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jul 2019 14:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfGLSfa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jul 2019 14:35:30 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3753205ED;
        Fri, 12 Jul 2019 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562956529;
        bh=VK5CVif+hioqD4HhWjppaKQ7r2s9Mt8/bAz5z4WBpyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feQIeIcILaYz/LIQfa8cwVW1r4Tub5CjLz4OWHrp1bZkraeuEBq+O4+pPww9YSfFN
         891EbSjkbZmXiAqQhQVuFbNhv8mVUNIB3Zr/TMA0aaT26CLOMpgUKXNjJv9GeLtwUC
         OgH5SHmuKKvnk1pw0SuZBPa6d/DDGk/jGMgDsd+s=
Date:   Fri, 12 Jul 2019 11:35:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: CAVS test harness
Message-ID: <20190712183528.GA701@sol.localdomain>
Mail-Followup-To: "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>,
        Stephan Mueller <smueller@chronox.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <TU4PR8401MB0544875B118D39899547FDEFF6F10@TU4PR8401MB0544.NAMPRD84.PROD.OUTLOOK.COM>
 <1782078.ZURsmYODYl@tauon.chronox.de>
 <TU4PR8401MB05445179722F462CD8C05AB0F6F30@TU4PR8401MB0544.NAMPRD84.PROD.OUTLOOK.COM>
 <2317418.W1bvXbUTk3@tauon.chronox.de>
 <TU4PR8401MB0544B9D0BCD4C091857A1EAFF6F20@TU4PR8401MB0544.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB0544B9D0BCD4C091857A1EAFF6F20@TU4PR8401MB0544.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 12, 2019 at 05:55:07PM +0000, Bhat, Jayalakshmi Manjunath wrote:
> Hi Stephan,
> 
> Thank you very much for the suggestions, I have another question, is it possible to implement MMT and MCT using kernel crypto API's.  Also FCC and FCC functions.
> 
> Regards,
> Jaya
> 

Please stop top posting.

I don't think you can implement Modern Monetary Theory, Medium-Chain
Triglycerides, or Federal Communications Commission functions using the Linux
kernel crypto API.

Of course, if those acronyms stand for something else, it would be helpful if
you'd explain what they are :-)

- Eric
