Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A0F4475
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKHK0c (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 05:26:32 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43106 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHK0c (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 8 Nov 2019 05:26:32 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iT1TK-0003ms-S6; Fri, 08 Nov 2019 18:26:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iT1TK-0002tt-LB; Fri, 08 Nov 2019 18:26:30 +0800
Date:   Fri, 8 Nov 2019 18:26:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: api - Add softdep on cryptomgr
Message-ID: <20191108102630.rljqn5judazucah2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The crypto API requires cryptomgr to be present for probing to work
so we need a softdep to ensure that cryptomgr is added to the
initramfs.

This was usually not a problem because until very recently it was
not practical to build crypto API as module but with the recent
work to eliminate direct AES users this is now possible.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/api.c b/crypto/api.c
index d8ba54142620..7113a03b3d52 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -608,3 +608,4 @@ EXPORT_SYMBOL_GPL(crypto_req_done);
 
 MODULE_DESCRIPTION("Cryptographic core API");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: cryptomgr");
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
