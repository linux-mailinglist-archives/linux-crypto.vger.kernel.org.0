Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7F24D022
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHUH6R (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 03:58:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50012 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgHUH6J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 03:58:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91w7-00042u-0q; Fri, 21 Aug 2020 17:58:08 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:58:07 +1000
Date:   Fri, 21 Aug 2020 17:58:07 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH] crypto: caam - Move debugfs fops into standalone file
Message-ID: <20200821075806.GK25143@gondor.apana.org.au>
References: <20200730135426.GA13682@gondor.apana.org.au>
 <c7fa483a-8f57-ee12-3c72-68c770ba4e00@nxp.com>
 <20200801124249.GA18580@gondor.apana.org.au>
 <bf2588f8-95f0-dd10-cd03-25268ea68837@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf2588f8-95f0-dd10-cd03-25268ea68837@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 06, 2020 at 09:09:49PM +0300, Horia Geantă wrote:
>
> Currently the debugfs fops are defined in caam/intern.h.  This causes
> problems because it creates identical static functions and variables
> in multiple files.  It also creates warnings when those files don't
> use the fops.
> 
> This patch moves them into a standalone file, debugfs.c.
> 
> It also removes unnecessary uses of ifdefs on CONFIG_DEBUG_FS.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> [Moved most of debugfs-related operations into debugfs.c.]
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/Makefile  |  2 +
>  drivers/crypto/caam/ctrl.c    | 77 +++------------------------
>  drivers/crypto/caam/debugfs.c | 96 +++++++++++++++++++++++++++++++++++
>  drivers/crypto/caam/debugfs.h | 26 ++++++++++
>  drivers/crypto/caam/intern.h  | 17 ------
>  drivers/crypto/caam/qi.c      | 20 ++------
>  6 files changed, 137 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/crypto/caam/debugfs.c
>  create mode 100644 drivers/crypto/caam/debugfs.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
