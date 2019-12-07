Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4586F115AF1
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Dec 2019 05:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLGEU0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Dec 2019 23:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfLGEU0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Dec 2019 23:20:26 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827CA21835
        for <linux-crypto@vger.kernel.org>; Sat,  7 Dec 2019 04:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575692425;
        bh=jOD1SgWgrPuh75IdvZWWJnof8kREDWVW1hG/2kt0McI=;
        h=From:To:Subject:Date:From;
        b=eKXHWYyGfqd11xKKFcvhcaDS5jRz5Vz+DbED3vkjgNY2iwRHFBDtH043SyWtUyF0Z
         ZdOkBysMqqfXk8fNxxaazBPDaKIWkMLDQMTFUsPjyQmlFKtN0A99+rNORyfrEbOiLc
         eppx89uORayLcfCZvvvU8jmgWiQQE03T7jEm079k=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: doc - remove references to ARC4
Date:   Fri,  6 Dec 2019 20:19:37 -0800
Message-Id: <20191207041937.97925-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

arc4 is no longer considered secure, so it shouldn't be used, even as
just an example.  Mention serpent and chacha20 instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/crypto/devel-algos.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/crypto/devel-algos.rst b/Documentation/crypto/devel-algos.rst
index f9d288015acc..fb6b7979a1de 100644
--- a/Documentation/crypto/devel-algos.rst
+++ b/Documentation/crypto/devel-algos.rst
@@ -57,7 +57,7 @@ follows:
 Single-Block Symmetric Ciphers [CIPHER]
 ---------------------------------------
 
-Example of transformations: aes, arc4, ...
+Example of transformations: aes, serpent, ...
 
 This section describes the simplest of all transformation
 implementations, that being the CIPHER type used for symmetric ciphers.
@@ -108,7 +108,7 @@ is also valid:
 Multi-Block Ciphers
 -------------------
 
-Example of transformations: cbc(aes), ecb(arc4), ...
+Example of transformations: cbc(aes), chacha20, ...
 
 This section describes the multi-block cipher transformation
 implementations. The multi-block ciphers are used for transformations
-- 
2.24.0

