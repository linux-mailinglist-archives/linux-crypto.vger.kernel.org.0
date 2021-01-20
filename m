Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CBE2FCACE
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Jan 2021 06:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbhATFlu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 Jan 2021 00:41:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:45446 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbhATFlk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 Jan 2021 00:41:40 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l26EY-00062I-0A; Wed, 20 Jan 2021 16:40:47 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Jan 2021 16:40:45 +1100
Date:   Wed, 20 Jan 2021 16:40:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: marvel/cesa - Fix tdma descriptor on 64-bit
Message-ID: <20210120054045.GA8539@gondor.apana.org.au>
References: <20210118091808.3dlauqgbv5yk25oa@SvensMacbookPro.hq.voleatech.com>
 <20210120052629.GA7040@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120052629.GA7040@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jan 20, 2021 at 04:26:29PM +1100, Herbert Xu wrote:
>
> Is your machine big-endian or little-endian?

Does this patch fix your problem?

---8<---
The patch that added src_dma/dst_dma to struct mv_cesa_tdma_desc
is broken on 64-bit systems as the size of the descriptor has been
changed.  This patch fixes it by using u32 instead of dma_addr_t.

Fixes: e62291c1d9f4 ("crypto: marvell/cesa - Fix sparse warnings")
Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index fabfaaccca87..fa56b45620c7 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -300,11 +300,11 @@ struct mv_cesa_tdma_desc {
 	__le32 byte_cnt;
 	union {
 		__le32 src;
-		dma_addr_t src_dma;
+		u32 src_dma;
 	};
 	union {
 		__le32 dst;
-		dma_addr_t dst_dma;
+		u32 dst_dma;
 	};
 	__le32 next_dma;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
