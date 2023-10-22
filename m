Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADB7D253E
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Oct 2023 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjJVSXG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 22 Oct 2023 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjJVSWz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 22 Oct 2023 14:22:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7ADD41
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 11:22:49 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 385F53FA6A
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697998968;
        bh=IXDb03/nMdyFNBY2tplz4IHYZT3E0MOfqPsaAJS0POs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rsjxDL3CqaODCfC5sfwR0CiMVRDqBgn2Tulmyo/UKYiBHsqa3X9Jpjk2wjRZlyQF8
         s8YlrBFR5cBKri34tEcD4q98WF/o8sNjFSPLWzg38Vh/DkZevlSJT+rWnC5VR0A32M
         Id/ZqjQhe6mD+ywMstc81E57Jf9Ix2jqCn0vaXC863i4MwrX1vZDg4tWGpefG/7Cry
         kBliVECG0HpLqjeFM29Ng7nDi+fiq+ejJ40gcd/Z0LXVeQwqG0MLj7gWKnv4kAQJiU
         Gl8IRdggC6FN6Xi/31lSON1u+5gcOiSY3hxcNBFzTqt5aDq9NXw/yOrPKiCnDpTcHz
         YZqIJaQcaNqEA==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-407d3e55927so16349815e9.1
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 11:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697998968; x=1698603768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXDb03/nMdyFNBY2tplz4IHYZT3E0MOfqPsaAJS0POs=;
        b=iOwpahXUZugUG51wmIRbnco1fLedaC0ViqGIRkz9p4eWtGZ767hO18Q+6gDj95xjlD
         L3W6V4jvbcpcm6itK4oXoP0fkDPL0ExkmeExmFyi/aEerJ8IMXVU/wjUg8YjtB1rwHTJ
         CW4yMMpGWhtuWeXP77x07YRtiyK4FsLLBYDuFzjD0iQ+gNifdY9laOOi7X4goydRWrxD
         Sqfe35EdqySiTRSUt3uWcUGRLmTFvhSS2omDyPeIETvAxk2Fi0FnQJfGonDnzEQrR9nD
         Nyh0RqLnbzUJEW9tSX1xfhsaF6hxdk4fHYEMPm8HixW0zIXf36rx7YXDTSKCNK3vAA4x
         t9cQ==
X-Gm-Message-State: AOJu0YyLwy8IIt6Gl+5ZArPetr7vNBaj39WEhAXbpjKk5jtoqoZRe/m/
        EgRNZht7DhBuldDndCek4fToL+GmivYqe0O8Xz7KECYiFHwemg8htgNw94x0XKGONhmL/3r9pp0
        PBMdZTBvypUDyH2HC/djmni+0H0iy2gFagwQZfx7nzg==
X-Received: by 2002:a5d:560d:0:b0:32d:14a4:ab3 with SMTP id l13-20020a5d560d000000b0032d14a40ab3mr5517344wrv.24.1697998967930;
        Sun, 22 Oct 2023 11:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0bMnZy9mCLBpToURwimakYan3VdjSehyT8XH+oOQxh7REkiQ/VkF0T8NR4g8/MPoJc/nFg==
X-Received: by 2002:a5d:560d:0:b0:32d:14a4:ab3 with SMTP id l13-20020a5d560d000000b0032d14a40ab3mr5517338wrv.24.1697998967586;
        Sun, 22 Oct 2023 11:22:47 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d550e000000b0032d9caeab0fsm6080826wrv.77.2023.10.22.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:22:47 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     herbert@gondor.apana.org.au, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH 5/6] crypto: enable automatic module signing with FIPS 202 SHA-3
Date:   Sun, 22 Oct 2023 19:22:07 +0100
Message-Id: <20231022182208.188714-6-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
References: <20231022182208.188714-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add Kconfig options to use SHA-3 for kernel module signing. 256 size
for RSA only, and higher sizes for RSA and NIST P-384.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 certs/Kconfig         |  2 +-
 kernel/module/Kconfig | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 84582de66b..69d192a32d 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -30,7 +30,7 @@ config MODULE_SIG_KEY_TYPE_RSA
 config MODULE_SIG_KEY_TYPE_ECDSA
 	bool "ECDSA"
 	select CRYPTO_ECDSA
-	depends on MODULE_SIG_SHA384 || MODULE_SIG_SHA512
+	depends on !(MODULE_SIG_SHA256 || MODULE_SIG_SHA3_256)
 	help
 	 Use an elliptic curve key (NIST P384) for module signing. Use
 	 a strong hash of same or higher bit length, i.e. sha384 or
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 9d7d45525f..0ea1b2970a 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -248,6 +248,18 @@ config MODULE_SIG_SHA512
 	bool "Sign modules with SHA-512"
 	select CRYPTO_SHA512
 
+config MODULE_SIG_SHA3_256
+	bool "Sign modules with SHA3-256"
+	select CRYPTO_SHA3
+
+config MODULE_SIG_SHA3_384
+	bool "Sign modules with SHA3-384"
+	select CRYPTO_SHA3
+
+config MODULE_SIG_SHA3_512
+	bool "Sign modules with SHA3-512"
+	select CRYPTO_SHA3
+
 endchoice
 
 config MODULE_SIG_HASH
@@ -256,6 +268,9 @@ config MODULE_SIG_HASH
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
+	default "sha3-256" if MODULE_SIG_SHA3_256
+	default "sha3-384" if MODULE_SIG_SHA3_384
+	default "sha3-512" if MODULE_SIG_SHA3_512
 
 choice
 	prompt "Module compression mode"
-- 
2.34.1

