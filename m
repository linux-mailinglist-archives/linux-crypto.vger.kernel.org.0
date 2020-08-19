Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE800249E0B
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Aug 2020 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHSMeT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Aug 2020 08:34:19 -0400
Received: from auth-smtp.nebula.fi ([217.149.52.145]:39688 "EHLO
        auth-smtp.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgHSMeB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Aug 2020 08:34:01 -0400
Received: from developer-Precision-3630-Tower (82-203-173-204.bb.dnainternet.fi [82.203.173.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: xipheracom)
        by auth-smtp.nebula.fi (Postfix) with ESMTPSA id 386C5444D;
        Wed, 19 Aug 2020 15:22:03 +0300 (EEST)
From:   Atte Tommiska <atte.tommiska@xiphera.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Atte Tommiska <atte.tommiska@xiphera.com>
Subject: [PATCH 0/3] hwrng: add support for Xiphera XIP8001B
Date:   Wed, 19 Aug 2020 15:21:32 +0300
Message-Id: <20200819122135.25316-1-atte.tommiska@xiphera.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=8.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        authsmtp1-hki2.nebula.fi
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset introduces a linux driver for Xiphera's XIP8001B IP.
The IP is an FPGA-based TRNG which can be used in various FPGA families.
The IP is in use in multiple customer projects and in Xiphera's own products.

Atte Tommiska (3):
  dt-bindings: vendor-prefixes: Add Xiphera vendor prefix
  dt-bindings: rng: add bindings for Xiphera XIP8001B hwnrg
  hwrng: xiphera-trng: add support for XIP8001B hwrng

 .../bindings/rng/xiphera,xip8001b-trng.yaml   |  30 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/char/hw_random/Kconfig                |  10 ++
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/xiphera-trng.c         | 151 ++++++++++++++++++
 5 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
 create mode 100644 drivers/char/hw_random/xiphera-trng.c


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.28.0

