Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6F160358
	for <lists+linux-crypto@lfdr.de>; Sun, 16 Feb 2020 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBPKFC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 16 Feb 2020 05:05:02 -0500
Received: from foss.arm.com ([217.140.110.172]:53048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPKFC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 16 Feb 2020 05:05:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D96830E;
        Sun, 16 Feb 2020 02:05:02 -0800 (PST)
Received: from ssg-dev-vb.kfn.arm.com (unknown [10.50.4.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D0E63F68F;
        Sun, 16 Feb 2020 02:04:58 -0800 (PST)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Weili Qian <qianweili@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: [PATCH v4 3/3] MAINTAINERS: add HG as cctrng maintainer
Date:   Sun, 16 Feb 2020 12:04:10 +0200
Message-Id: <1581847450-22924-4-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581847450-22924-1-git-send-email-hadar.gat@arm.com>
References: <1581847450-22924-1-git-send-email-hadar.gat@arm.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I work for Arm on maintaining the TrustZone CryptoCell TRNG driver.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0c1618..654585a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3790,6 +3790,15 @@ S:	Supported
 F:	drivers/crypto/ccree/
 W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
 
+CCTRNG ARM TRUSTZONE CRYPTOCELL TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
+M:	Hadar Gat <hadar.gat@arm.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	drivers/char/hw_random/cctrng.c
+F:	drivers/char/hw_random/cctrng.h
+F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
+W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
+
 CEC FRAMEWORK
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.7.4

