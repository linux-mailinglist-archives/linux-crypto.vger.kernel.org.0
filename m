Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAF32CD06
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 07:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhCDGmk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Mar 2021 01:42:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52578 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235528AbhCDGmX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Mar 2021 01:42:23 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHhfz-0007VI-UP; Thu, 04 Mar 2021 17:41:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 17:41:35 +1100
Date:   Thu, 4 Mar 2021 17:41:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] crypto: qat - fix spelling mistake: "messge" -> "message"
Message-ID: <20210304064135.GD15863@gondor.apana.org.au>
References: <20210209102855.118609-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209102855.118609-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 09, 2021 at 10:28:55AM +0000, Giovanni Cabiddu wrote:
> From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Trivial fix to spelling mistake in adf_pf2vf_msg.c and adf_vf2pf_msg.c.
> s/messge/message/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 2 +-
>  drivers/crypto/qat/qat_common/adf_vf2pf_msg.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
