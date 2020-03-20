Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0718C709
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2020 06:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCTFbv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Mar 2020 01:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgCTFbv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Mar 2020 01:31:51 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EEAF2072D;
        Fri, 20 Mar 2020 05:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584682310;
        bh=zNNn2sMFi+NV3lbWyUonnbEAUt5r4OtIBHc7roBXYqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5tJJdQQ70wqZil/MYY/mJjiBc0WcmrwPlOCyC2c9kaf8IAa7gEEt/lNJIovG+I1p
         JnZj+VOtvpC5YuKZJb94UGcXBjGf+jZ5iSFxueObw5FjN2SfheqvMkMJ6mlV5zM8kW
         ykOyhCK15FH4ZRoFUc3kNXbj8mp+GFRjO6el3MbI=
Date:   Thu, 19 Mar 2020 22:31:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Srujana Challa <schalla@marvell.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, pathreya@marvell.com,
        schandran@marvell.com, arno@natisbad.org, bbrezillon@kernel.org
Subject: Re: [PATCH v2 0/4] Add Support for Marvell OcteonTX Cryptographic
Message-ID: <20200320053149.GC1315@sol.localdomain>
References: <1584100028-21279-1-git-send-email-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584100028-21279-1-git-send-email-schalla@marvell.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 13, 2020 at 05:17:04PM +0530, Srujana Challa wrote:
> The following series adds support for Marvell Cryptographic Accelerarion
> Unit (CPT) on OcteonTX CN83XX SoC.
> 
> Changes since v1:
> * Replaced CRYPTO_BLKCIPHER with CRYPTO_SKCIPHER in Kconfig.
> 
> Srujana Challa (4):
>   drivers: crypto: create common Kconfig and Makefile for Marvell
>   drivers: crypto: add support for OCTEON TX CPT engine
>   drivers: crypto: add the Virtual Function driver for CPT
>   crypto: marvell: enable OcteonTX cpt options for build

There's no mention of testing.  Did you try CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?

- Eric
