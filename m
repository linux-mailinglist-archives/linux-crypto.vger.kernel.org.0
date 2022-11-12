Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1C6269C3
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Nov 2022 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiKLOLo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Nov 2022 09:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLOLl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Nov 2022 09:11:41 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250711172;
        Sat, 12 Nov 2022 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=/EKve0DJdgDbbBVAUw8fSy/lR7NDWzZ+hyVbdKDOzAI=; b=CmaXke3mU8LGLlCnXP8rymG3zY
        qa8Y5wwgpZ8/H6ltTuWsT8534VR44QVfmtlMPyv7GMn4Jbl7SYpi1b++Ew4QzD9O8ra9++CJlpNtr
        SwGT9bIdr+I2gbGFixYoPKTMWrouA3P67gcQRWjPsntzjrnTzoFEyz3U+zHUHKMaYiIjcDS9OeBek
        gfoFC6oa1MaIbIK+yFmTVmOepOvEaYhyAmyOAJQKpRBFGGeyu8AGnH9zjqZ1C6kv9qmW4PkUcZ7pF
        1TtwVguu/qU3Pi8uK2vThWADuPTTrwJ4nic+OaspC4g1hcmHw7qDv+vyodhgc7P2zFMWjKFH0zziz
        Jc9B4X3g==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE5-00AbR0-Iy; Sat, 12 Nov 2022 15:11:17 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE4-00FxDk-2V;
        Sat, 12 Nov 2022 15:11:16 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list),
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v1 2/3] hwrng: add Rockchip SoC hwrng driver
Date:   Sat, 12 Nov 2022 15:10:58 +0100
Message-Id: <20221112141059.3802506-3-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221112141059.3802506-1-aurelien@aurel32.net>
References: <20221112141059.3802506-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Rockchip SoCs used to have a random number generator as part of their
crypto device, and support for it has to be added to the corresponding
driver. However newer Rockchip SoCs like the RK356x have an independent
True Random Number Generator device. This patch adds a driver for it,
greatly inspired from the downstream driver.

The TRNG device does not seem to have a signal conditionner and the FIPS
140-2 test returns a lot of failures. They can be reduced by increasing
RK_RNG_SAMPLE_CNT, in a tradeoff between quality and speed. This value
has been adjusted to get ~90% of successes and the quality value has
been set accordingly.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/char/hw_random/Kconfig        |  14 ++
 drivers/char/hw_random/Makefile       |   1 +
 drivers/char/hw_random/rockchip-rng.c | 251 ++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/char/hw_random/rockchip-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 3da8e85f8aae..8e5c88504f72 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -549,6 +549,20 @@ config HW_RANDOM_CN10K
 	 To compile this driver as a module, choose M here.
 	 The module will be called cn10k_rng. If unsure, say Y.
 
+config HW_RANDOM_ROCKCHIP
+        tristate "Rockchip True Random Number Generator"
+        depends on HW_RANDOM && (ARCH_ROCKCHIP || COMPILE_TEST)
+        depends on HAS_IOMEM
+        default HW_RANDOM
+        help
+          This driver provides kernel-side support for the True Random Number
+          Generator hardware found on some Rockchip SoC like RK3566 or RK3568.
+
+          To compile this driver as a module, choose M here: the
+          module will be called rockchip-rng.
+
+          If unsure, say Y.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 3e948cf04476..b7e989535fd6 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) += xiphera-trng.o
 obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
 obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
 obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
+obj-$(CONFIG_HW_RANDOM_ROCKCHIP) += rockchip-rng.o
diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_random/rockchip-rng.c
new file mode 100644
index 000000000000..ac7a840c1ac5
--- /dev/null
+++ b/drivers/char/hw_random/rockchip-rng.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rockchip-rng.c True Random Number Generator driver for Rockchip SoCs
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2022, Aurelien Jarno
+ * Authors:
+ *  Lin Jinhan <troy.lin@rock-chips.com>
+ *  Aurelien Jarno <aurelien@aurel32.net>
+ */
+#include <linux/clk.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define RK_RNG_AUTOSUSPEND_DELAY	100
+#define RK_RNG_MAX_BYTE			32
+#define RK_RNG_POLL_PERIOD_US		100
+#define RK_RNG_POLL_TIMEOUT_US		10000
+
+/*
+ * TRNG collects osc ring output bit every RK_RNG_SAMPLE_CNT time. The value is
+ * a tradeoff between speed and quality and has been adjusted to get a quality
+ * of ~900 (~90% of FIPS 140-2 successes).
+ */
+#define RK_RNG_SAMPLE_CNT		1000
+
+/* TRNG registers from RK3568 TRM-Part2, section 5.4.1 */
+#define TRNG_RST_CTL			0x0004
+#define TRNG_RNG_CTL			0x0400
+#define TRNG_RNG_CTL_LEN_64_BIT		(0x00 << 4)
+#define TRNG_RNG_CTL_LEN_128_BIT	(0x01 << 4)
+#define TRNG_RNG_CTL_LEN_192_BIT	(0x02 << 4)
+#define TRNG_RNG_CTL_LEN_256_BIT	(0x03 << 4)
+#define TRNG_RNG_CTL_OSC_RING_SPEED_0	(0x00 << 2)
+#define TRNG_RNG_CTL_OSC_RING_SPEED_1	(0x01 << 2)
+#define TRNG_RNG_CTL_OSC_RING_SPEED_2	(0x02 << 2)
+#define TRNG_RNG_CTL_OSC_RING_SPEED_3	(0x03 << 2)
+#define TRNG_RNG_CTL_ENABLE		BIT(1)
+#define TRNG_RNG_CTL_START		BIT(0)
+#define TRNG_RNG_SAMPLE_CNT		0x0404
+#define TRNG_RNG_DOUT_0			0x0410
+#define TRNG_RNG_DOUT_1			0x0414
+#define TRNG_RNG_DOUT_2			0x0418
+#define TRNG_RNG_DOUT_3			0x041c
+#define TRNG_RNG_DOUT_4			0x0420
+#define TRNG_RNG_DOUT_5			0x0424
+#define TRNG_RNG_DOUT_6			0x0428
+#define TRNG_RNG_DOUT_7			0x042c
+
+struct rk_rng {
+	struct hwrng rng;
+	void __iomem *base;
+	struct reset_control *rst;
+	int clk_num;
+	struct clk_bulk_data *clk_bulks;
+};
+
+/* The mask determine the bits that are updated */
+static void rk_rng_write_ctl(struct rk_rng *rng, u32 val, u32 mask)
+{
+	writel_relaxed((mask << 16) | val, rng->base + TRNG_RNG_CTL);
+}
+
+static int rk_rng_init(struct hwrng *rng)
+{
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+	u32 reg;
+	int ret;
+
+	/* start clocks */
+	ret = clk_bulk_prepare_enable(rk_rng->clk_num, rk_rng->clk_bulks);
+	if (ret < 0) {
+		dev_err((struct device *) rk_rng->rng.priv,
+			"Failed to enable clks %d\n", ret);
+		return ret;
+	}
+
+	/* set the sample period */
+	writel(RK_RNG_SAMPLE_CNT, rk_rng->base + TRNG_RNG_SAMPLE_CNT);
+
+	/* set osc ring speed and enable it */
+	reg = TRNG_RNG_CTL_LEN_256_BIT |
+		   TRNG_RNG_CTL_OSC_RING_SPEED_0 |
+		   TRNG_RNG_CTL_ENABLE;
+	rk_rng_write_ctl(rk_rng, reg, 0xffff);
+
+	return 0;
+}
+
+static void rk_rng_cleanup(struct hwrng *rng)
+{
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+	u32 reg;
+
+	/* stop TRNG */
+	reg = 0;
+	rk_rng_write_ctl(rk_rng, reg, 0xffff);
+
+	/* stop clocks */
+	clk_bulk_disable_unprepare(rk_rng->clk_num, rk_rng->clk_bulks);
+}
+
+static int rk_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct rk_rng *rk_rng = container_of(rng, struct rk_rng, rng);
+	u32 reg;
+	int ret = 0;
+	int i;
+
+	pm_runtime_get_sync((struct device *) rk_rng->rng.priv);
+
+	/* Start collecting random data */
+	reg = TRNG_RNG_CTL_START;
+	rk_rng_write_ctl(rk_rng, reg, reg);
+
+	ret = readl_poll_timeout(rk_rng->base + TRNG_RNG_CTL, reg,
+				 !(reg & TRNG_RNG_CTL_START),
+				 RK_RNG_POLL_PERIOD_US,
+				 RK_RNG_POLL_TIMEOUT_US);
+	if (ret < 0)
+		goto out;
+
+	/* Read random data stored in big endian in the registers */
+	ret = min_t(size_t, max, RK_RNG_MAX_BYTE);
+	for (i = 0; i < ret; i += 4) {
+		reg = readl_relaxed(rk_rng->base + TRNG_RNG_DOUT_0 + i);
+		*(u32 *)(buf + i) = be32_to_cpu(reg);
+	}
+
+out:
+	pm_runtime_mark_last_busy((struct device *) rk_rng->rng.priv);
+	pm_runtime_put_sync_autosuspend((struct device *) rk_rng->rng.priv);
+
+	return ret;
+}
+
+static int rk_rng_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rk_rng *rk_rng;
+	int ret;
+
+	rk_rng = devm_kzalloc(dev, sizeof(struct rk_rng), GFP_KERNEL);
+	if (!rk_rng)
+		return -ENOMEM;
+
+	rk_rng->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rk_rng->base))
+		return PTR_ERR(rk_rng->base);
+
+	rk_rng->clk_num = devm_clk_bulk_get_all(dev, &rk_rng->clk_bulks);
+	if (rk_rng->clk_num < 0)
+		return dev_err_probe(dev, rk_rng->clk_num,
+				     "Failed to get clks property\n");
+
+	rk_rng->rst = devm_reset_control_array_get(&pdev->dev, false, false);
+	if (IS_ERR(rk_rng->rst))
+		return dev_err_probe(dev, PTR_ERR(rk_rng->rst),
+				     "Failed to get reset property\n");
+
+	reset_control_assert(rk_rng->rst);
+	udelay(2);
+	reset_control_deassert(rk_rng->rst);
+
+	platform_set_drvdata(pdev, rk_rng);
+
+	rk_rng->rng.name = dev_driver_string(dev);
+#ifndef CONFIG_PM
+	rk_rng->rng.init = rk_rng_init;
+	rk_rng->rng.cleanup = rk_rng_cleanup;
+#endif
+	rk_rng->rng.read = rk_rng_read;
+	rk_rng->rng.priv = (unsigned long) dev;
+	rk_rng->rng.quality = 900;
+
+	pm_runtime_set_autosuspend_delay(dev, RK_RNG_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_hwrng_register(dev, &rk_rng->rng);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register Rockchip hwrng\n");
+
+	dev_info(&pdev->dev, "Registered Rockchip hwrng\n");
+
+	return 0;
+}
+
+static int rk_rng_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rk_rng_runtime_suspend(struct device *dev)
+{
+	struct rk_rng *rk_rng = dev_get_drvdata(dev);
+
+	rk_rng_cleanup(&rk_rng->rng);
+
+	return 0;
+}
+
+static int rk_rng_runtime_resume(struct device *dev)
+{
+	struct rk_rng *rk_rng = dev_get_drvdata(dev);
+
+	return rk_rng_init(&rk_rng->rng);
+}
+#endif
+
+static const struct dev_pm_ops rk_rng_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk_rng_runtime_suspend,
+				rk_rng_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static const struct of_device_id rk_rng_dt_match[] = {
+	{
+		.compatible = "rockchip,rk3568-rng",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, rk_rng_dt_match);
+
+static struct platform_driver rk_rng_driver = {
+	.driver	= {
+		.name	= "rockchip-rng",
+		.pm	= &rk_rng_pm_ops,
+		.of_match_table = rk_rng_dt_match,
+	},
+	.probe	= rk_rng_probe,
+	.remove = rk_rng_remove,
+};
+
+module_platform_driver(rk_rng_driver);
+
+MODULE_DESCRIPTION("Rockchip True Random Number Generator driver");
+MODULE_AUTHOR("Lin Jinhan <troy.lin@rock-chips.com>, Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

