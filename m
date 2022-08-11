Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DB58FFC5
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Aug 2022 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiHKPdY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Aug 2022 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiHKPci (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Aug 2022 11:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C797D56;
        Thu, 11 Aug 2022 08:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED753B82157;
        Thu, 11 Aug 2022 15:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718F3C433D6;
        Thu, 11 Aug 2022 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660231889;
        bh=GLdBc2h5Tcvr10jZvvlTIeKGec1FDDwOLUf9VmUKEkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6Q7RwVRFrek82dVJEazunrTRR4RS2x3b/u+SWKZ9jmrRKhwLWLZuYH8cjezdkix+
         e0ThnPEOHwAnQcwNzbLiSjoSriSmj0JuQTcXszoIsPTtsg+l70I2QASS4iAxhwdVkS
         v1Fc/hK7HO3+BWiOJlh7UyIzc3uLn3DrUIXOL0EPc8KKhgakcwyFnEt/lofLYGDCDN
         A4pESMBPHf5D2VleXgAvJBxwnG4V1WR7f75z/5MrxVk9Lq8AKLbNg6n9AbEJhb57+I
         i7s4UJpKaJygT7xaDFomq6NJSX51mm4WiRY3rgOep1GOo0lxxkHfxQKEW2Jz7N3QqQ
         NqyzroFhNMRLQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shijith Thotton <sthotton@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, bbrezillon@kernel.org,
        arno@natisbad.org, schalla@marvell.com, davem@davemloft.net,
        dan.carpenter@oracle.com, keescook@chromium.org,
        jiapeng.chong@linux.alibaba.com, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 022/105] crypto: octeontx2 - fix potential null pointer access
Date:   Thu, 11 Aug 2022 11:27:06 -0400
Message-Id: <20220811152851.1520029-22-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811152851.1520029-1-sashal@kernel.org>
References: <20220811152851.1520029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Shijith Thotton <sthotton@marvell.com>

[ Upstream commit b03c0dc0788abccc7a25ef7dff5818f4123bb992 ]

Added missing checks to avoid null pointer dereference.

The patch fixes below issue reported by klocwork tool:
. Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
  at line 1608 may be NULL and will be dereferenced at line 1608. Also
  there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 9cba2f714c7e..080cbfa093ec 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1605,7 +1605,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
 			if (has_se || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1617,7 +1620,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ae", 2) && strchr(val, ':')) {
 			if (has_ae || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
@@ -1629,7 +1635,10 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		} else if (!strncasecmp(val, "ie", 2) && strchr(val, ':')) {
 			if (has_ie || ucode_idx)
 				goto err_print;
-			tmp = strim(strsep(&val, ":"));
+			tmp = strsep(&val, ":");
+			if (!tmp)
+				goto err_print;
+			tmp = strim(tmp);
 			if (!val)
 				goto err_print;
 			if (strlen(tmp) != 2)
-- 
2.35.1

