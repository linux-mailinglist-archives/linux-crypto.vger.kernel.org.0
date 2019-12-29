Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02D712C00A
	for <lists+linux-crypto@lfdr.de>; Sun, 29 Dec 2019 03:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL2C6D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 28 Dec 2019 21:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfL2C6D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 28 Dec 2019 21:58:03 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F36621744
        for <linux-crypto@vger.kernel.org>; Sun, 29 Dec 2019 02:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577588282;
        bh=0Jmn6rgHyxICeqesUsUiqMF+viPCeJM7M1LgfU0aapQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XdNMfdghrFEezDNdNxwKcPs9/XPme69D9QDF3XoXGXHZWqNY21jkn87fPkyuc1Upk
         uryJtHbvQIftidsPDTjGS6FWBFlbguqm45hVvPxiog7P+rc2apE//fuOMeGmyB9jHr
         uhFmJ9oOT3xZG4PECrnrS1ECW5p73HeIDIodSty8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 01/28] crypto: algapi - make crypto_drop_spawn() a no-op on uninitialized spawns
Date:   Sat, 28 Dec 2019 20:56:47 -0600
Message-Id: <20191229025714.544159-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229025714.544159-1-ebiggers@kernel.org>
References: <20191229025714.544159-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make crypto_drop_spawn() do nothing when the spawn hasn't been
initialized with an algorithm yet.  This will allow simplifying error
handling in all the template ->create() functions, since on error they
will be able to just call their usual "free instance" function, rather
than having to handle dropping just the spawns that have been
initialized so far.

This does assume the spawn starts out zero-filled, but that's always the
case since instances are allocated with kzalloc().  And some other code
already assumes this anyway.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 363849983941..4c761f48110d 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -734,6 +734,9 @@ EXPORT_SYMBOL_GPL(crypto_grab_spawn);
 
 void crypto_drop_spawn(struct crypto_spawn *spawn)
 {
+	if (!spawn->alg) /* not yet initialized? */
+		return;
+
 	down_write(&crypto_alg_sem);
 	if (!spawn->dead)
 		list_del(&spawn->list);
-- 
2.24.1

