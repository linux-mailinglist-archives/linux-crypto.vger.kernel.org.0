Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D440142C
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Sep 2021 03:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhIFBck (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Sep 2021 21:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351844AbhIFBbJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Sep 2021 21:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E32A361211;
        Mon,  6 Sep 2021 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891471;
        bh=Bx6ebCy6IMUhrvLMURL4TkUSCZQW3y4A8HoOQDe80z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfNnHlfgBIZJgvfmN6k2HYQjhYN8PI6jipmI9d1U51r3atJXnXz3wCkF72py/ZWTw
         CGUICLr6BoAN9vaANclWcmwY7AphWrJhabyIUS5HUSXKOEiMF1DnkZHo/i+PT3ZarE
         iysMW0nOlulJ4QIQvxnMNbOwB5Ml+qCk2fX2BRmiGX9AAQF6BIWn3RFwrSIw/CmgpF
         tL/UWDEyDHyhylKCA5o/SC0vWbdv+8bPgOEruJu8TdT7VaEAa7ihfeW1Woxr/2AQSm
         UAA8e7NyCh1mBjF5UYbTUWUlViCRX5JzLwmOAgojS4uIAnYnwQ+ZdKLfQ2PglkeDJK
         qX2uPtGEFcT4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Chiappero <marco.chiappero@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/14] crypto: qat - fix naming for init/shutdown VF to PF notifications
Date:   Sun,  5 Sep 2021 21:24:13 -0400
Message-Id: <20210906012415.931147-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012415.931147-1-sashal@kernel.org>
References: <20210906012415.931147-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

[ Upstream commit b90c1c4d3fa8cd90f4e8245b13564380fd0bfad1 ]

At start and shutdown, VFs notify the PF about their state. These
notifications are carried out through a message exchange using the PFVF
protocol.

Function names lead to believe they do perform init or shutdown logic.
This is to fix the naming to better reflect their purpose.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c |  4 ++--
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c   |  4 ++--
 drivers/crypto/qat/qat_common/adf_common_drv.h       |  8 ++++----
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c        | 12 ++++++------
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c      |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index d2d0ae445fd8..7c7d49a8a403 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -123,10 +123,10 @@ void adf_init_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
 	hw_data->enable_error_correction = adf_vf_void_noop;
 	hw_data->init_admin_comms = adf_vf_int_noop;
 	hw_data->exit_admin_comms = adf_vf_void_noop;
-	hw_data->send_admin_init = adf_vf2pf_init;
+	hw_data->send_admin_init = adf_vf2pf_notify_init;
 	hw_data->init_arb = adf_vf_int_noop;
 	hw_data->exit_arb = adf_vf_void_noop;
-	hw_data->disable_iov = adf_vf2pf_shutdown;
+	hw_data->disable_iov = adf_vf2pf_notify_shutdown;
 	hw_data->get_accel_mask = get_accel_mask;
 	hw_data->get_ae_mask = get_ae_mask;
 	hw_data->get_num_accels = get_num_accels;
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 38e4bc04f407..90e8a7564756 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -123,10 +123,10 @@ void adf_init_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
 	hw_data->enable_error_correction = adf_vf_void_noop;
 	hw_data->init_admin_comms = adf_vf_int_noop;
 	hw_data->exit_admin_comms = adf_vf_void_noop;
-	hw_data->send_admin_init = adf_vf2pf_init;
+	hw_data->send_admin_init = adf_vf2pf_notify_init;
 	hw_data->init_arb = adf_vf_int_noop;
 	hw_data->exit_arb = adf_vf_void_noop;
-	hw_data->disable_iov = adf_vf2pf_shutdown;
+	hw_data->disable_iov = adf_vf2pf_notify_shutdown;
 	hw_data->get_accel_mask = get_accel_mask;
 	hw_data->get_ae_mask = get_ae_mask;
 	hw_data->get_num_accels = get_num_accels;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 0d596a99f564..88c8831503e4 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -239,8 +239,8 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 void adf_enable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 
-int adf_vf2pf_init(struct adf_accel_dev *accel_dev);
-void adf_vf2pf_shutdown(struct adf_accel_dev *accel_dev);
+int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev);
+void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev);
 int adf_init_pf_wq(void);
 void adf_exit_pf_wq(void);
 int adf_init_vf_wq(void);
@@ -263,12 +263,12 @@ static inline void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev)
 {
 }
 
-static inline int adf_vf2pf_init(struct adf_accel_dev *accel_dev)
+static inline int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev)
 {
 	return 0;
 }
 
-static inline void adf_vf2pf_shutdown(struct adf_accel_dev *accel_dev)
+static inline void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 {
 }
 
diff --git a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
index cd5f37dffe8a..1830194567e8 100644
--- a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
@@ -49,14 +49,14 @@
 #include "adf_pf2vf_msg.h"
 
 /**
- * adf_vf2pf_init() - send init msg to PF
+ * adf_vf2pf_notify_init() - send init msg to PF
  * @accel_dev:  Pointer to acceleration VF device.
  *
  * Function sends an init messge from the VF to a PF
  *
  * Return: 0 on success, error code otherwise.
  */
-int adf_vf2pf_init(struct adf_accel_dev *accel_dev)
+int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev)
 {
 	u32 msg = (ADF_VF2PF_MSGORIGIN_SYSTEM |
 		(ADF_VF2PF_MSGTYPE_INIT << ADF_VF2PF_MSGTYPE_SHIFT));
@@ -69,17 +69,17 @@ int adf_vf2pf_init(struct adf_accel_dev *accel_dev)
 	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(adf_vf2pf_init);
+EXPORT_SYMBOL_GPL(adf_vf2pf_notify_init);
 
 /**
- * adf_vf2pf_shutdown() - send shutdown msg to PF
+ * adf_vf2pf_notify_shutdown() - send shutdown msg to PF
  * @accel_dev:  Pointer to acceleration VF device.
  *
  * Function sends a shutdown messge from the VF to a PF
  *
  * Return: void
  */
-void adf_vf2pf_shutdown(struct adf_accel_dev *accel_dev)
+void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 {
 	u32 msg = (ADF_VF2PF_MSGORIGIN_SYSTEM |
 	    (ADF_VF2PF_MSGTYPE_SHUTDOWN << ADF_VF2PF_MSGTYPE_SHIFT));
@@ -89,4 +89,4 @@ void adf_vf2pf_shutdown(struct adf_accel_dev *accel_dev)
 			dev_err(&GET_DEV(accel_dev),
 				"Failed to send Shutdown event to PF\n");
 }
-EXPORT_SYMBOL_GPL(adf_vf2pf_shutdown);
+EXPORT_SYMBOL_GPL(adf_vf2pf_notify_shutdown);
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index a3b4dd8099a7..3a8361c83f0b 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -123,10 +123,10 @@ void adf_init_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
 	hw_data->enable_error_correction = adf_vf_void_noop;
 	hw_data->init_admin_comms = adf_vf_int_noop;
 	hw_data->exit_admin_comms = adf_vf_void_noop;
-	hw_data->send_admin_init = adf_vf2pf_init;
+	hw_data->send_admin_init = adf_vf2pf_notify_init;
 	hw_data->init_arb = adf_vf_int_noop;
 	hw_data->exit_arb = adf_vf_void_noop;
-	hw_data->disable_iov = adf_vf2pf_shutdown;
+	hw_data->disable_iov = adf_vf2pf_notify_shutdown;
 	hw_data->get_accel_mask = get_accel_mask;
 	hw_data->get_ae_mask = get_ae_mask;
 	hw_data->get_num_accels = get_num_accels;
-- 
2.30.2

