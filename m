Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3524AA5D
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHSX6E (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Aug 2020 19:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgHSX43 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Aug 2020 19:56:29 -0400
Received: from localhost (unknown [70.37.104.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4492E20FC3;
        Wed, 19 Aug 2020 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881389;
        bh=mZ+xjhUT11PTCiS0S8kVh706FaAhXCyVl6jXHHCd8LI=;
        h=Date:From:To:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
        b=dKYJFrsHl6D5x0JvP+cHUFL9MklzSSA4QEQ+kk0g7jC5icP+LCHddK8zfuo+S1ojZ
         0YZv/ahy77TWzxhXMwdLFUasXkj07ciXhlAjePcn/3RAgo6jqX/t8+BjDqlN7Z/u04
         lT+QIMQKsftFt80y4sW025UdmKHQsafs5El81gpY=
Date:   Wed, 19 Aug 2020 23:56:28 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Andrei Botila <andrei.botila@oss.nxp.com>
To:     Andrei Botila <andrei.botila@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6/9] crypto: caam/qi2 - add support for more XTS key lengths
In-Reply-To: <20200806114127.8650-7-andrei.botila@oss.nxp.com>
References: <20200806114127.8650-7-andrei.botila@oss.nxp.com>
Message-Id: <20200819235629.4492E20FC3@mail.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 226853ac3ebe ("crypto: caam/qi2 - add skcipher algorithms").

The bot has tested the following trees: v5.8.1, v5.7.15, v5.4.58.

v5.8.1: Failed to apply! Possible dependencies:
    528f776df67c ("crypto: qat - allow xts requests not multiple of block")
    93f83eb04603 ("crypto: caam/qi2 - add fallback for XTS with more than 8B IV")
    a85211f36f3d ("crypto: qat - fallback for xts with 192 bit keys")
    b185a68710e0 ("crypto: qat - validate xts key")
    b8aa7dc5c753 ("crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY")
    da6a66853a38 ("crypto: caam - silence .setkey in case of bad key length")

v5.7.15: Failed to apply! Possible dependencies:
    528f776df67c ("crypto: qat - allow xts requests not multiple of block")
    93f83eb04603 ("crypto: caam/qi2 - add fallback for XTS with more than 8B IV")
    a85211f36f3d ("crypto: qat - fallback for xts with 192 bit keys")
    b185a68710e0 ("crypto: qat - validate xts key")
    b8aa7dc5c753 ("crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY")
    da6a66853a38 ("crypto: caam - silence .setkey in case of bad key length")

v5.4.58: Failed to apply! Possible dependencies:
    64db5e7439fb ("crypto: sparc/aes - convert to skcipher API")
    66d7fb94e4ff ("crypto: blake2s - generic C library implementation and selftest")
    674f368a952c ("crypto: remove CRYPTO_TFM_RES_BAD_KEY_LEN")
    746b2e024c67 ("crypto: lib - tidy up lib/crypto Kconfig and Makefile")
    7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
    7f725f41f627 ("crypto: powerpc - convert SPE AES algorithms to skcipher API")
    7f9b0880925f ("crypto: blake2s - implement generic shash driver")
    91d689337fe8 ("crypto: blake2b - add blake2b generic implementation")
    93f83eb04603 ("crypto: caam/qi2 - add fallback for XTS with more than 8B IV")
    b4d0c0aad57a ("crypto: arm - use Kconfig based compiler checks for crypto opcodes")
    b95bba5d0114 ("crypto: skcipher - rename the crypto_blkcipher module and kconfig option")
    d00c06398154 ("crypto: s390/paes - convert to skcipher API")
    da6a66853a38 ("crypto: caam - silence .setkey in case of bad key length")
    ed0356eda153 ("crypto: blake2s - x86_64 SIMD implementation")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
