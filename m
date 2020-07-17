Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2E72246FC
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Jul 2020 01:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGQXf4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jul 2020 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXf4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jul 2020 19:35:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48EC0619D2;
        Fri, 17 Jul 2020 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3yCn9n57+UR1kjOKoAiXbK1WiituoPuKBtvTIx874rk=; b=SMRuCcvHr2k0ODyRwlWWyEqWDy
        XnNWrRC64BlRvCVTOTou2D7kxW7k6syb3sgwqjsmSgIMvVkNjSIZ9Xl9dgq3GCi1cuBlXXasN01gb
        ykyidl/L03/RPmLPuz5F/ufdujYzXg7o4LeuvUGFgcQHp8BJuoQkGFDe+v7zd/r7GGZU+zJMV/SeJ
        W3YD94NbgjieVbTilNCiQnjPerkbfXC+6yFJx6OiqdE0gXAH89o7ANhucKyRfXZIoJuFypiFisR5o
        cltNObMG32me90PK+SYfZA6E2pYtP58BvaD3V/jgEhU8qCG011sGqGRxAWyXv+ErHSK+uRtH3nxvq
        76ApEfOQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZtR-0006U1-0i; Fri, 17 Jul 2020 23:35:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] crypto: skcipher.h: drop duplicated word in kernel-doc
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Message-ID: <c031a64c-2337-cd9d-e148-ed8365c2365e@infradead.org>
Date:   Fri, 17 Jul 2020 16:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "request" in a kernel-doc comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 include/crypto/skcipher.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/crypto/skcipher.h
+++ linux-next-20200714/include/crypto/skcipher.h
@@ -18,7 +18,7 @@
  *	@iv: Initialisation Vector
  *	@src: Source SG list
  *	@dst: Destination SG list
- *	@base: Underlying async request request
+ *	@base: Underlying async request
  *	@__ctx: Start of private context data
  */
 struct skcipher_request {

