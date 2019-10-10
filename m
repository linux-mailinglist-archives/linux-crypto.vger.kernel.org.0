Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73533D3042
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Oct 2019 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfJJSYY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Oct 2019 14:24:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfJJSYH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Oct 2019 14:24:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so9075140wrj.6;
        Thu, 10 Oct 2019 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zV4+mJumjqZCVRf0c568eaULYg2KEJ/Mri+qUnmNENE=;
        b=SNnzUgCShqB91rBQPYgw+55+tDlJug8viZ2Uop8snJh+mtOTwMXXgYhs+gZGRxMoQA
         n8/fstbe5hw+a/htzu6rTNddjF2aBagVRxwDDUhHxVxvU40ku96OBLTeapvzMJxLtkOG
         UO6augPEEOj85WasZdSPBpv9NsbNplolHwpA2M3h7FtXUEzsmqKOsIVPMdVlhPm+IrJJ
         yCjQouzRduft0Pmp7zzmRpYbr32cvy60Ha30jpjijErMjamReU/Vype6zxk70HHPVTVl
         2Zp1FAGEoI6hZWVLfSzdHzRkPp/bTbajMdHw28EaRpSNDqoRoxAAVTHEthQgQsPYoXRn
         VtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zV4+mJumjqZCVRf0c568eaULYg2KEJ/Mri+qUnmNENE=;
        b=sm3cWlOI1iwkJWqt7rKspkxfyBEvtCuXO4b+UNMGGIpPV3gI6yR+9E3itB5UCT/E21
         emYw6Im4bzG+GDwCVL9/2ZjsoZPB1aFPk3i/gKaLjH5RMRukYDKZcACpmJ7UW3xfgX3l
         4Ib8acXDNVnv2NobXYtuX1U3e8xoKN8pgR4GzDy+bXarxl9bE1BL8ZU/PCisD645hV+l
         VOQ3VhPUsQ5QsCPk86xHYj/N0wsIZCCzY8qlkLAd7iiLVYjRqxFkZhtPzZ+oHOGynh+o
         wzNgdIgEaUF9F37TevGm+gMcyL6msdPwXdZtQaQuXqo+kKRSHObykRe0FaK8dPw50OOv
         RMvg==
X-Gm-Message-State: APjAAAUgX6x7t/BmGFeblXhKawX/OwCW8d69qMOlMTEGF3ebaXx/xq5y
        JDv12oMisWTUKRPQ9tX1UCk=
X-Google-Smtp-Source: APXvYqzR3Cg6cSaHOhXgTL2hKg0UmDmZ5ktaekLPxs/QO7iDoyUifkfMyP7Bo4y2lIxgPjOmMzNudg==
X-Received: by 2002:a05:6000:12cd:: with SMTP id l13mr9559404wrx.344.1570731845261;
        Thu, 10 Oct 2019 11:24:05 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id y186sm11367664wmb.41.2019.10.10.11.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:24:04 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v3 09/11] sunxi_defconfig: add new Allwinner crypto options
Date:   Thu, 10 Oct 2019 20:23:26 +0200
Message-Id: <20191010182328.15826-10-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010182328.15826-1-clabbe.montjoie@gmail.com>
References: <20191010182328.15826-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds the new Allwinner crypto configs to sunxi_defconfig

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..d0ab8ba7710a 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -150,4 +150,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
+CONFIG_CRYPTO_DEV_ALLWINNER=y
+CONFIG_CRYPTO_DEV_SUN8I_CE=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=y
-- 
2.21.0

