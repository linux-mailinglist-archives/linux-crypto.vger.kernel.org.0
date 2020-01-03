Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B554912F3A5
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jan 2020 05:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgACEBZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jan 2020 23:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgACEBZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jan 2020 23:01:25 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F73722314
        for <linux-crypto@vger.kernel.org>; Fri,  3 Jan 2020 04:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578024084;
        bh=Xh56S2p/u7dijE7JzTBgalq9BKRLTICE05G86pxpQcw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wolVh05oGuNzovkPw6U+gpmB9FbJ2eYb6NKDsTmnVCIV3lr4yhr74kzqJwPz1+0fG
         xfFLoV7HiErlA7sb8QkIp+rkekhKVepl2sD49RxVDlvNSnGyhXAGnhjydqIgBIovOV
         +fZhTnk3w/q6b6MPuyauGmdcJAO2HlNQ+5x16Qhs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH v2 02/28] crypto: algapi - make crypto_grab_spawn() handle an ERR_PTR() name
Date:   Thu,  2 Jan 2020 19:58:42 -0800
Message-Id: <20200103035908.12048-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200103035908.12048-1-ebiggers@kernel.org>
References: <20200103035908.12048-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

To allow further simplifying template ->create() functions, make
crypto_grab_spawn() handle an ERR_PTR() name by passing back the error.

For most templates, this will allow the result of crypto_attr_alg_name()
to be passed directly to crypto_grab_*(), rather than first having to
assign it to a variable [where it can then potentially be misused, as it
was in the rfc7539 template prior to commit 5e27f38f1f3f ("crypto:
chacha20poly1305 - set cra_name correctly")] and check it for error.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 4c761f48110d..a5223c5f2275 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -720,6 +720,10 @@ int crypto_grab_spawn(struct crypto_spawn *spawn, const char *name,
 	struct crypto_alg *alg;
 	int err;
 
+	/* Allow the result of crypto_attr_alg_name() to be passed directly */
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
 	alg = crypto_find_alg(name, spawn->frontend, type, mask);
 	if (IS_ERR(alg))
 		return PTR_ERR(alg);
-- 
2.24.1

