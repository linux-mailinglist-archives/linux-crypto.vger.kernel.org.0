Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A84C1630
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Feb 2022 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiBWPLz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Feb 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiBWPLy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Feb 2022 10:11:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65172B82D8
        for <linux-crypto@vger.kernel.org>; Wed, 23 Feb 2022 07:11:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2333121118;
        Wed, 23 Feb 2022 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645629085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jj0VDg4qe/7XaGf26u5BBLCjUikPfXJEstOrdhAHq5o=;
        b=XTiuNDBLnj1EBWvVPNkDPsI97AYYGuj5VMtzWtk/IMFDpHoghUscQGE2NRJu+5NS0bmZoY
        b1IoVhT5J3vevvf06xqbk/25NvlcokM7Gi8D2iA5DGbNTqx/nEVMHX9sQYwPARuphpAWaV
        q33tJ1092s6RlX+bUf0h4uFg0ai9A+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645629085;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jj0VDg4qe/7XaGf26u5BBLCjUikPfXJEstOrdhAHq5o=;
        b=yJi4molU16v9vZb52yXmAAovhuMr+6nRTNCZ78p4hA0stZ1LqbyZQQ0kbwLYHynW9ww3NE
        GcbMctX47xGJPPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99F8113D80;
        Wed, 23 Feb 2022 15:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dCO+IpxOFmISYQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 23 Feb 2022 15:11:24 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-crypto@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, leitao@debian.org,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/1] crypto: vmx - add missing dependencies
Date:   Wed, 23 Feb 2022 16:11:15 +0100
Message-Id: <20220223151115.28536-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

vmx-crypto module depends on CRYPTO_AES, CRYPTO_CBC, CRYPTO_CTR or
CRYPTO_XTS, thus add them.

These dependencies are likely to be enabled, but if
CRYPTO_DEV_VMX=y && !CRYPTO_MANAGER_DISABLE_TESTS
and either of CRYPTO_AES, CRYPTO_CBC, CRYPTO_CTR or CRYPTO_XTS is built
as module or disabled, alg_test() from crypto/testmgr.c complains during
boot about failing to allocate the generic fallback implementations
(2 == ENOENT):

[    0.540953] Failed to allocate xts(aes) fallback: -2
[    0.541014] alg: skcipher: failed to allocate transform for p8_aes_xts: -2
[    0.541120] alg: self-tests for p8_aes_xts (xts(aes)) failed (rc=-2)
[    0.544440] Failed to allocate ctr(aes) fallback: -2
[    0.544497] alg: skcipher: failed to allocate transform for p8_aes_ctr: -2
[    0.544603] alg: self-tests for p8_aes_ctr (ctr(aes)) failed (rc=-2)
[    0.547992] Failed to allocate cbc(aes) fallback: -2
[    0.548052] alg: skcipher: failed to allocate transform for p8_aes_cbc: -2
[    0.548156] alg: self-tests for p8_aes_cbc (cbc(aes)) failed (rc=-2)
[    0.550745] Failed to allocate transformation for 'aes': -2
[    0.550801] alg: cipher: Failed to load transform for p8_aes: -2
[    0.550892] alg: self-tests for p8_aes (aes) failed (rc=-2)

Fixes: c07f5d3da643 ("crypto: vmx - Adding support for XTS")
Fixes: d2e3ae6f3aba ("crypto: vmx - Enabling VMX module for PPC64")

Suggested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* Drop commit which merged CRYPTO_DEV_VMX and CRYPTO_DEV_VMX_ENCRYPT
  (Herbert)

 drivers/crypto/vmx/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/vmx/Kconfig b/drivers/crypto/vmx/Kconfig
index c85fab7ef0bd..b2c28b87f14b 100644
--- a/drivers/crypto/vmx/Kconfig
+++ b/drivers/crypto/vmx/Kconfig
@@ -2,7 +2,11 @@
 config CRYPTO_DEV_VMX_ENCRYPT
 	tristate "Encryption acceleration support on P8 CPU"
 	depends on CRYPTO_DEV_VMX
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_CTR
 	select CRYPTO_GHASH
+	select CRYPTO_XTS
 	default m
 	help
 	  Support for VMX cryptographic acceleration instructions on Power8 CPU.
-- 
2.35.1

