Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7962164D0
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2020 05:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGGDrT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Jul 2020 23:47:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55904 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgGGDrT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Jul 2020 23:47:19 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jseZd-0002J2-Ae; Tue, 07 Jul 2020 13:47:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Jul 2020 13:47:13 +1000
Date:   Tue, 7 Jul 2020 13:47:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Olivier Sobrie <olivier.sobrie@silexinsight.com>,
        Waleed Ziad <waleed94ziad@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] hwrng: ba431 - Include kernel.h
Message-ID: <20200707034713.GA13363@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

There are multiple things in this file that requires kernel.h but
it's only included through other header files indirectly.  This
patch adds a direct inclusion as those indirect inclusions may go
away at any point.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/ba431-rng.c b/drivers/char/hw_random/ba431-rng.c
index a39e3abf50b9..410b50b05e21 100644
--- a/drivers/char/hw_random/ba431-rng.c
+++ b/drivers/char/hw_random/ba431-rng.c
@@ -5,6 +5,7 @@
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
