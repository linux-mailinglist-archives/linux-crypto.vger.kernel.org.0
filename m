Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90BBA4457
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Aug 2019 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHaMEZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 31 Aug 2019 08:04:25 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:48774 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHaMEZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 31 Aug 2019 08:04:25 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2019 08:04:24 EDT
Received: from localhost.localdomain (p57BC9339.dip0.t-ipconnect.de [87.188.147.57])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 07A9A29F9FC;
        Sat, 31 Aug 2019 11:51:42 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     mpm@selenic.com, herbert@gondor.apana.org.au,
        gregkh@linuxfoundation.org
Cc:     linux-crypto@vger.kernel.org, Daniel Mack <daniel@zonque.org>
Subject: [PATCH] hw_random: timeriomem_rng: relax check on memory resource size
Date:   Sat, 31 Aug 2019 13:55:55 +0200
Message-Id: <20190831115555.11708-1-daniel@zonque.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The timeriomem_rng driver only accesses the first 4 bytes of the given
memory area and currently, it also forces that memory resource to be
exactly 4 bytes in size.

This, however, is problematic when used with device-trees that are
generated from things like FPGA toolchains, where the minimum size
of an exposed memory block may be something like 4k.

Hence, let's only check for what's needed for the driver to operate
properly; namely that we have enough memory available to read the
random data from.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/rng/timeriomem_rng.txt | 2 +-
 drivers/char/hw_random/timeriomem-rng.c                  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/timeriomem_rng.txt b/Documentation/devicetree/bindings/rng/timeriomem_rng.txt
index 214940093b55..fb4846160047 100644
--- a/Documentation/devicetree/bindings/rng/timeriomem_rng.txt
+++ b/Documentation/devicetree/bindings/rng/timeriomem_rng.txt
@@ -12,7 +12,7 @@ Optional properties:
             which disables using this rng to automatically fill the kernel's
             entropy pool.
 
-N.B. currently 'reg' must be four bytes wide and aligned
+N.B. currently 'reg' must be at least four bytes wide and 32-bit aligned
 
 Example:
 
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index f615684028af..dc0194d85d80 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -120,9 +120,9 @@ static int timeriomem_rng_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 
-	if (res->start % 4 != 0 || resource_size(res) != 4) {
+	if (res->start % 4 != 0 || resource_size(res) < 4) {
 		dev_err(&pdev->dev,
-			"address must be four bytes wide and aligned\n");
+			"address must be at least four bytes wide and 32-bit aligned\n");
 		return -EINVAL;
 	}
 
-- 
2.21.0

