Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560F21FEBD2
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2020 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFRHAb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jun 2020 03:00:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60104 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgFRHA2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jun 2020 03:00:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jloX8-0001Hn-6V; Thu, 18 Jun 2020 17:00:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 17:00:22 +1000
Date:   Thu, 18 Jun 2020 17:00:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: api - Prune inclusions in crypto.h
Message-ID: <20200618070022.GA6213@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

We haven't used string.h since the memcpy calls were removed so
this patch removes its inclusion.  The file uaccess.h isn't needed
at all.  However, removing it reveals that we do need to add an
inclusion for refcount.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 763863dbc079..bc5d2d4bfc3d 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -16,9 +16,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/bug.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/uaccess.h>
 #include <linux/completion.h>
 
 /*
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
