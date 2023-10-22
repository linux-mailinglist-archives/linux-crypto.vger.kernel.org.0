Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4B7D2541
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Oct 2023 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJVSX2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 22 Oct 2023 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJVSXT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 22 Oct 2023 14:23:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEFA10C1
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 11:23:07 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 284A03F68B
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998985;
        bh=PFQQQyGHvq4Vgum/xnVjVuElfTVJmiceygKugibWkQQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EMZ6fFo+xEsAuv4TZP2OdkWVYg//M+Gob3sh6MXxlNMLYZGfdEX4p96UuBfV28b4a
         IXMf9rCoF+irn+aDCiGRBa7tqqz+PGa9YGmxOtflm+1xQQGxTY+9rDMhXs4QAqYl0W
         fM/ZJeJi0SSCC+Yy0Q/3sG+hiz/kbMvtY4jlSvYKzJKTGMeqsJzkOpl6hJqQhRO9Uq
         MrbjhbbLtrsL6hEss87JPOwjMxmaV+VYiGwbaA7lB9F5rRmXiE8K9kOni1LVBIjQN5
         m8vxljf4e/YkCYOAk90JpATtHnWoTZGxrCz/Wh/IoY9tmue8j/DLDGPwyaI9RwjGJv
         jV+ahBR+l06Ww==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083865e0b7so14593365e9.3
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 11:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998971; x=1698603771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFQQQyGHvq4Vgum/xnVjVuElfTVJmiceygKugibWkQQ=;
        b=hWk+JfDD5+WNvoiAd7kS8KIyz5PoxTCyEPOIw74QUodHJa7zzTp7pOxOpe8PAjBaG5
         ouJZhEQxOeZnL+Ip/MXcTXDDZnL8mF4geuqsY0TVUkPaj8/g0JoLbsELV3ME5cANZO9j
         mdvSf2tYl8xgVI50SZTkeMIV2qiCpN4vFmGB+tKCJC0Jm31UNrMWmYFVIvy58jUUXvhN
         Nhp7vr2Nny+SUiu994IWPAslTnLDhnN4+qT6VFl+8U34wthg0K4hpm66jD3rgMm1FaFp
         ++mUvoJLyWcHlLWOix4WpzAfwTW0vFk1mL2zKBMhkebC2p6zhyhMncOohCgthMRQMY/3
         vSTw==
X-Gm-Message-State: AOJu0YwAyrZaoclQCurFoMv8qgIntiNjfUGF2OhZ8eHPals7NaiuWMFD
        BiuFIzPYnHxvnCmgROi5yn334L3mOLHL00dMb26b/ftKGi3sPBeHzV5MYh3Ee/idrwug2rjkreM
        Ek8GjUhWrBRfDe5pIdQP7aEv1YFv8oTg50OnGUx1KKw==
X-Received: by 2002:a05:600c:3d87:b0:405:7b92:4558 with SMTP id bi7-20020a05600c3d8700b004057b924558mr5636479wmb.38.1697998971512;
        Sun, 22 Oct 2023 11:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQIKtMn/SYn1WUGMKRheSfZ+Femytgt+MFX4tUeo2/oPl9EgWulzTC+YwAtcdViA0qd/tCA==
X-Received: by 2002:a05:600c:3d87:b0:405:7b92:4558 with SMTP id bi7-20020a05600c3d8700b004057b924558mr5636467wmb.38.1697998971268;
        Sun, 22 Oct 2023 11:22:51 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm12360739wmq.47.2023.10.22.11.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:51 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 6/6] Documentation/module-signing.txt: bring up to date
Date:   Sun, 22 Oct 2023 19:22:08 +0100
Message-Id: <20231022182208.188714-7-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
References: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Update the documentation to mention that ECC NIST P-384 automatic
keypair generation is available to use ECDSA signature type, in
addition to the RSA.

Drop mentions of the now removed SHA-1 and SHA-224 options.

Add the just added FIPS 202 SHA-3 module signature hashes.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 Documentation/admin-guide/module-signing.rst | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 2898b27032..a8667a7774 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -28,10 +28,10 @@ trusted userspace bits.
 
 This facility uses X.509 ITU-T standard certificates to encode the public keys
 involved.  The signatures are not themselves encoded in any industrial standard
-type.  The facility currently only supports the RSA public key encryption
-standard (though it is pluggable and permits others to be used).  The possible
-hash algorithms that can be used are SHA-1, SHA-224, SHA-256, SHA-384, and
-SHA-512 (the algorithm is selected by data in the signature).
+type.  The built-in facility currently only supports the RSA & NIST P-384 ECDSA
+public key signing standard (though it is pluggable and permits others to be
+used).  The possible hash algorithms that can be used are SHA-2 and SHA-3 of
+sizes 256, 384, and 512 (the algorithm is selected by data in the signature).
 
 
 ==========================
@@ -81,11 +81,12 @@ This has a number of options available:
      sign the modules with:
 
         =============================== ==========================================
-	``CONFIG_MODULE_SIG_SHA1``	:menuselection:`Sign modules with SHA-1`
-	``CONFIG_MODULE_SIG_SHA224``	:menuselection:`Sign modules with SHA-224`
 	``CONFIG_MODULE_SIG_SHA256``	:menuselection:`Sign modules with SHA-256`
 	``CONFIG_MODULE_SIG_SHA384``	:menuselection:`Sign modules with SHA-384`
 	``CONFIG_MODULE_SIG_SHA512``	:menuselection:`Sign modules with SHA-512`
+	``CONFIG_MODULE_SIG_SHA3_256``	:menuselection:`Sign modules with SHA3-256`
+	``CONFIG_MODULE_SIG_SHA3_384``	:menuselection:`Sign modules with SHA3-384`
+	``CONFIG_MODULE_SIG_SHA3_512``	:menuselection:`Sign modules with SHA3-512`
         =============================== ==========================================
 
      The algorithm selected here will also be built into the kernel (rather
@@ -145,6 +146,10 @@ into vmlinux) using parameters in the::
 
 file (which is also generated if it does not already exist).
 
+One can select between RSA (``MODULE_SIG_KEY_TYPE_RSA``) and ECDSA
+(``MODULE_SIG_KEY_TYPE_ECDSA``) to generate either RSA 4k or NIST
+P-384 keypair.
+
 It is strongly recommended that you provide your own x509.genkey file.
 
 Most notably, in the x509.genkey file, the req_distinguished_name section
-- 
2.34.1

