Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE801C2353
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEBFdt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 01:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgEBFdq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 01:33:46 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FC9208DB;
        Sat,  2 May 2020 05:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397626;
        bh=VK3L5BIk03pa6rK76LADKFXOAOOyd/XyN2Ibf6A9B4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc8/LN3Y73ieRgTWJW+guipZirfitS4BA9+w321xwR0kTFI8CLMBHAFcwoOtqjdla
         glljJzPAU0CVSpNKrSqYxsSNHoJ9dnss9tGUvRRCaYLfxzP+e9x1VP74lzM9asO6bC
         68Sd9BVrVibI6whZRhbPX5sJ6OkVBMOLXMZIXvHg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 20/20] ASoC: cros_ec_codec: use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:22 -0700
Message-Id: <20200502053122.995648-21-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 sound/soc/codecs/cros_ec_codec.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index d3dc42aa682565..bfdd852bdc0de4 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -115,14 +115,7 @@ static int calculate_sha256(struct cros_ec_codec_priv *priv,
 		return PTR_ERR(tfm);
 	}
 
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-
-		desc->tfm = tfm;
-
-		crypto_shash_digest(desc, buf, size, digest);
-		shash_desc_zero(desc);
-	}
+	crypto_shash_tfm_digest(tfm, buf, size, digest);
 
 	crypto_free_shash(tfm);
 
-- 
2.26.2

