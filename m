Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C87C42A5
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Oct 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJJVeh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Oct 2023 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjJJVeg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Oct 2023 17:34:36 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7091;
        Tue, 10 Oct 2023 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696973675; x=1728509675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h1kiry+iqF/J7hIjxqeb5UuH4djv7YHSmIDmxGof4d8=;
  b=lCQGYTWesq6erpUfXyQ1gJaA7CFR+ICQ4YYx3fDFXaCJzP/lBUhE3rO3
   EBykefQJ0UrM9vFmPIP0HibP/hghUKtuCiQIyDyVcxwAoWb5YGfFILMOR
   Z8clGM7kaDtLLot8YXh28KVKKC0yeSmDj+lEehY4fasHU+g3L4oJJYoJb
   4=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="308119488"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 21:34:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 1411140D3F;
        Tue, 10 Oct 2023 21:34:25 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:34:24 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:34:22 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v6] misc: Add Nitro Secure Module driver
Date:   Tue, 10 Oct 2023 21:34:20 +0000
Message-ID: <20231010213420.93725-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When running Linux inside a Nitro Enclave, the hypervisor provides a
special virtio device called "Nitro Security Module" (NSM). This device
has 3 main functions:

  1) Provide attestation reports
  2) Modify PCR state
  3) Provide entropy

This patch adds a driver for NSM that exposes a /dev/nsm device node which
user space can issue an ioctl on this device with raw NSM CBOR formatted
commands to request attestation documents, influence PCR states, read
entropy and enumerate status of the device. In addition, the driver
implements a hwrng backend.

Originally-by: Petre Eftime <petre.eftime@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Remove boilerplate
  - Add uapi header

v2 -> v3:

  - Move globals to device struct
  - Add compat handling
  - Simplify some naming
  - Remove debug prints
  - Use module_virtio_driver
  - Drop use of uio.h

v3 -> v4:

  - Merge hwrng into the misc driver
  - Add dependency on CBOR library
  - Add internal and ioctl logic for all current NSM actions
  - Use in-struct arrays instead of kvecs
  - Add sysfs entries for NSM metadata
  - Use dev_ print and devm_ allocation helpers

v4 -> v5:

  - Remove CBOR parsing and generation again
  - Remove support for any non-raw ioctls

v5 -> v6:

  - Change devm callers to normal ones when devm logic is not needed
  - Remove double free
  - Remove superfluous list_head
---
 MAINTAINERS              |   9 +
 drivers/misc/Kconfig     |  13 +
 drivers/misc/Makefile    |   1 +
 drivers/misc/nsm.c       | 572 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nsm.h |  31 +++
 5 files changed, 626 insertions(+)
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 include/uapi/linux/nsm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09d..d7afb3dedbd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15096,6 +15096,15 @@ F:	include/linux/nitro_enclaves.h
 F:	include/uapi/linux/nitro_enclaves.h
 F:	samples/nitro_enclaves/
 
+NITRO SECURE MODULE (NSM)
+M:	Alexander Graf <graf@amazon.com>
+L:	linux-kernel@vger.kernel.org
+L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
+S:	Supported
+W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
+F:	drivers/misc/nsm.c
+F:	include/uapi/linux/nsm.h
+
 NOHZ, DYNTICKS SUPPORT
 M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index cadd4a820c03..236f36a8e8d4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -562,6 +562,19 @@ config TPS6594_PFSM
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps6594-pfsm.
 
+config NSM
+	tristate "Nitro (Enclaves) Security Module support"
+	depends on VIRTIO
+	select HW_RANDOM
+	select CBOR
+	help
+	  This driver provides support for the Nitro Security Module
+	  in AWS EC2 Nitro based Enclaves. The driver exposes a /dev/nsm
+	  device user space can use to communicate with the hypervisor.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called nsm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f2a4d1ff65d4..ea6ea5bbbc9c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
 obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
+obj-$(CONFIG_NSM)		+= nsm.o
diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
new file mode 100644
index 000000000000..a2e384ec08d5
--- /dev/null
+++ b/drivers/misc/nsm.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Amazon Nitro Secure Module driver.
+ *
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * The Nitro Secure Module implements commands via CBOR over virtio.
+ * This driver exposes a raw message ioctls on /dev/nsm that user
+ * space can use to issue these commands.
+ */
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/hw_random.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio.h>
+#include <linux/wait.h>
+#include <uapi/linux/nsm.h>
+
+/* Timeout for NSM virtqueue respose in milliseconds. */
+#define NSM_DEFAULT_TIMEOUT_MSECS (120000) /* 2 minutes */
+
+struct nsm {
+	struct virtio_device *vdev;
+	struct virtqueue     *vq;
+	struct mutex          lock;
+	wait_queue_head_t     wq;
+	bool                  device_notified;
+	struct miscdevice     misc;
+	struct hwrng          hwrng;
+	struct work_struct    misc_init;
+};
+
+/* NSM device ID */
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_NITRO_SEC_MOD, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+/* Maximum length input data */
+struct nsm_data_req {
+	__u32 len;
+	__u8  data[NSM_REQUEST_MAX_SIZE];
+};
+
+/* Maximum length output data */
+struct nsm_data_resp {
+	__u32 len;
+	__u8  data[NSM_RESPONSE_MAX_SIZE];
+};
+
+/* Full NSM request/response message */
+struct nsm_msg {
+	struct nsm_data_req req;
+	struct nsm_data_resp resp;
+};
+
+static inline struct nsm *file_to_nsm(struct file *file)
+{
+	return container_of(file->private_data, struct nsm, misc);
+}
+
+static inline struct nsm *hwrng_to_nsm(struct hwrng *rng)
+{
+	return container_of(rng, struct nsm, hwrng);
+}
+
+static inline struct nsm *misc_dev_to_nsm(struct miscdevice *misc)
+{
+	return container_of(misc, struct nsm, misc);
+}
+
+#define CBOR_TYPE_MASK  0xE0
+#define CBOR_TYPE_MAP 0xA0
+#define CBOR_TYPE_TEXT 0x60
+#define CBOR_TYPE_ARRAY 0x40
+#define CBOR_HEADER_SIZE_SHORT 1
+
+#define CBOR_SHORT_SIZE_MAX_VALUE 23
+#define CBOR_LONG_SIZE_U8  24
+#define CBOR_LONG_SIZE_U16 25
+#define CBOR_LONG_SIZE_U32 26
+#define CBOR_LONG_SIZE_U64 27
+
+#define CBOR_HEADER_SIZE_U8  (CBOR_HEADER_SIZE_SHORT + sizeof(u8))
+#define CBOR_HEADER_SIZE_U16 (CBOR_HEADER_SIZE_SHORT + sizeof(u16))
+#define CBOR_HEADER_SIZE_U32 (CBOR_HEADER_SIZE_SHORT + sizeof(u32))
+#define CBOR_HEADER_SIZE_U64 (CBOR_HEADER_SIZE_SHORT + sizeof(u64))
+
+static bool cbor_object_is_array(const u8 *cbor_object, size_t cbor_object_size)
+{
+	if (cbor_object_size == 0 || cbor_object == NULL)
+		return false;
+
+	return (cbor_object[0] & CBOR_TYPE_MASK) == CBOR_TYPE_ARRAY;
+}
+
+static int cbor_object_get_array(u8 *cbor_object, size_t cbor_object_size, u8 **cbor_array)
+{
+	u8 cbor_short_size;
+	u64 array_len;
+	u64 array_offset;
+
+	if (!cbor_object_is_array(cbor_object, cbor_object_size))
+		return -EFAULT;
+
+	if (cbor_array == NULL)
+		return -EFAULT;
+
+	cbor_short_size = (cbor_object[0] & 0x1F);
+
+	/* Decoding byte array length */
+	/* In short field encoding, the object header is 1 byte long and
+	 * contains the type on the 3 MSB and the length on the LSB.
+	 * If the length in the LSB is larger than 23, then the object
+	 * uses long field encoding, and will contain the length over the
+	 * next bytes in the object, depending on the value:
+	 * 24 is u8, 25 is u16, 26 is u32 and 27 is u64.
+	 */
+	if (cbor_short_size <= CBOR_SHORT_SIZE_MAX_VALUE) {
+		/* short encoding */
+		array_len = cbor_short_size;
+		array_offset = CBOR_HEADER_SIZE_SHORT;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U8) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U8)
+			return -EFAULT;
+		/* 1 byte */
+		array_len = cbor_object[1];
+		array_offset = CBOR_HEADER_SIZE_U8;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U16) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U16)
+			return -EFAULT;
+		/* 2 bytes */
+		array_len = cbor_object[1] << 8 | cbor_object[2];
+		array_offset = CBOR_HEADER_SIZE_U16;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U32) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U32)
+			return -EFAULT;
+		/* 4 bytes */
+		array_len = cbor_object[1] << 24 |
+			cbor_object[2] << 16 |
+			cbor_object[3] << 8  |
+			cbor_object[4];
+		array_offset = CBOR_HEADER_SIZE_U32;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U64) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U64)
+			return -EFAULT;
+		/* 8 bytes */
+		array_len = (u64) cbor_object[1] << 56 |
+			  (u64) cbor_object[2] << 48 |
+			  (u64) cbor_object[3] << 40 |
+			  (u64) cbor_object[4] << 32 |
+			  (u64) cbor_object[5] << 24 |
+			  (u64) cbor_object[6] << 16 |
+			  (u64) cbor_object[7] << 8  |
+			  (u64) cbor_object[8];
+		array_offset = CBOR_HEADER_SIZE_U64;
+	}
+
+	if (cbor_object_size < array_offset)
+		return -EFAULT;
+
+	if (cbor_object_size - array_offset < array_len)
+		return -EFAULT;
+
+	if (array_len > INT_MAX)
+		return -EFAULT;
+
+	*cbor_array = cbor_object + array_offset;
+	return array_len;
+}
+
+/* Copy the request of a raw message to kernel space */
+static int fill_req_raw(struct nsm *nsm, struct nsm_data_req *req,
+			struct nsm_raw *raw)
+{
+	/* Verify the user input size. */
+	if (raw->request.len > sizeof(req->data))
+		return -EMSGSIZE;
+
+	/* Copy the request payload */
+	if (copy_from_user(req->data, u64_to_user_ptr(raw->request.addr),
+			   raw->request.len))
+		return -EFAULT;
+
+	req->len = raw->request.len;
+
+	return 0;
+}
+
+/* Copy the response of a raw message back to user-space */
+static int parse_resp_raw(struct nsm *nsm, struct nsm_data_resp *resp,
+			  struct nsm_raw *raw)
+{
+	/* Truncate any message that does not fit. */
+	raw->response.len = min_t(u64, raw->response.len, resp->len);
+
+	/* Copy the response content to user space */
+	if (copy_to_user(u64_to_user_ptr(raw->response.addr),
+			 resp->data, raw->response.len))
+		return -EFAULT;
+
+	return 0;
+}
+
+/* Virtqueue interrupt handler */
+static void nsm_vq_callback(struct virtqueue *vq)
+{
+	struct nsm *nsm = vq->vdev->priv;
+
+	nsm->device_notified = true;
+	wake_up(&nsm->wq);
+}
+
+/* Forward a message to the NSM device and wait for the response from it */
+static int nsm_sendrecv_msg(struct nsm *nsm, struct nsm_msg *msg)
+{
+	struct device *dev = &nsm->vdev->dev;
+	struct scatterlist sg_in, sg_out;
+	struct virtqueue *vq = nsm->vq;
+	unsigned int len;
+	void *queue_buf;
+	bool kicked;
+	int rc;
+
+	/* Initialize scatter-gather lists with request and response buffers. */
+	sg_init_one(&sg_out, msg->req.data, msg->req.len);
+	sg_init_one(&sg_in, msg->resp.data, sizeof(msg->resp.data));
+
+	mutex_lock(&nsm->lock);
+
+	/* Add the request buffer (read by the device). */
+	rc = virtqueue_add_outbuf(vq, &sg_out, 1, msg->req.data, GFP_KERNEL);
+	if (rc) {
+		mutex_unlock(&nsm->lock);
+		return rc;
+	}
+
+	/* Add the response buffer (written by the device). */
+	rc = virtqueue_add_inbuf(vq, &sg_in, 1, msg->resp.data, GFP_KERNEL);
+	if (rc)
+		goto cleanup;
+
+	nsm->device_notified = false;
+	kicked = virtqueue_kick(vq);
+	if (!kicked) {
+		/* Cannot kick the virtqueue. */
+		rc = -EIO;
+		goto cleanup;
+	}
+
+	/* If the kick succeeded, wait for the device's response. */
+	rc = wait_event_timeout(nsm->wq,
+		nsm->device_notified == true,
+		msecs_to_jiffies(NSM_DEFAULT_TIMEOUT_MSECS));
+	if (!rc) {
+		rc = -ETIMEDOUT;
+		goto cleanup;
+	}
+
+	queue_buf = virtqueue_get_buf(vq, &len);
+	if (!queue_buf || (queue_buf != msg->req.data)) {
+		dev_err(dev, "wrong request buffer.");
+		rc = -ENODATA;
+		goto cleanup;
+	}
+
+	queue_buf = virtqueue_get_buf(vq, &len);
+	if (!queue_buf || (queue_buf != msg->resp.data)) {
+		dev_err(dev, "wrong response buffer.");
+		rc = -ENODATA;
+		goto cleanup;
+	}
+
+	msg->resp.len = len;
+
+	rc = 0;
+
+cleanup:
+	if (rc) {
+		/* Clean the virtqueue. */
+		while (virtqueue_get_buf(vq, &len) != NULL)
+			;
+	}
+
+	mutex_unlock(&nsm->lock);
+	return rc;
+}
+
+static int fill_req_get_random(struct nsm *nsm, struct nsm_data_req *req)
+{
+	/*
+	 * 69                          # text(9)
+	 *     47657452616E646F6D      # "GetRandom"
+	 */
+	const u8 request[] = { CBOR_TYPE_TEXT + strlen("GetRandom"),
+			       'G', 'e', 't', 'R', 'a', 'n', 'd', 'o', 'm' };
+
+	memcpy(req->data, request, sizeof(request));
+	req->len = sizeof(request);
+
+	return 0;
+}
+
+static int parse_resp_get_random(struct nsm *nsm, struct nsm_data_resp *resp,
+				 void *out, size_t max)
+{
+	/*
+	 * A1                          # map(1)
+	 *     69                      # text(9) - Name of field
+	 *         47657452616E646F6D  # "GetRandom"
+	 * A1                          # map(1) - The field itself
+	 *     66                      # text(6)
+	 *         72616E646F6D        # "random"
+	 *	# The rest of the response is random data
+	 */
+	const u8 response[] = { CBOR_TYPE_MAP + 1,
+				CBOR_TYPE_TEXT + strlen("GetRandom"),
+				'G', 'e', 't', 'R', 'a', 'n', 'd', 'o', 'm',
+				CBOR_TYPE_MAP + 1,
+				CBOR_TYPE_TEXT + strlen("random"),
+				'r', 'a', 'n', 'd', 'o', 'm' };
+	struct device *dev = &nsm->vdev->dev;
+	u8 *rand_data = NULL;
+	u8 *resp_ptr = resp->data;
+	u64 resp_len = resp->len;
+	int rc;
+
+	if ((resp->len < sizeof(response) + 1) ||
+	    (memcmp(resp_ptr, response, sizeof(response)) != 0)) {
+		dev_err(dev, "Invalid response for GetRandom");
+		return -EFAULT;
+	}
+
+	resp_ptr += sizeof(response);
+	resp_len -= sizeof(response);
+
+	if (!cbor_object_is_array(resp_ptr, resp_len)) {
+		/* not a byte array */
+		dev_err(dev, "GetRandom: Not a byte array");
+		return -EFAULT;
+	}
+
+	rc = cbor_object_get_array(resp_ptr, resp_len, &rand_data);
+	if (rc < 0) {
+		dev_err(dev, "GetRandom: Invalid CBOR encoding\n");
+		return rc;
+	}
+
+	rc = min_t(size_t, rc, max);
+	memcpy(out, rand_data, rc);
+
+	return rc;
+}
+
+/*
+ * HwRNG implementation
+ */
+static int nsm_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct nsm *nsm = hwrng_to_nsm(rng);
+	struct device *dev = &nsm->vdev->dev;
+	struct nsm_msg *msg;
+	int rc = 0;
+
+	/* NSM always needs to wait for a response */
+	if (!wait)
+		return 0;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	rc = fill_req_get_random(nsm, &msg->req);
+	if (rc != 0)
+		goto out;
+
+	rc = nsm_sendrecv_msg(nsm, msg);
+	if (rc != 0)
+		goto out;
+
+	rc = parse_resp_get_random(nsm, &msg->resp, data, max);
+	if (rc < 0)
+		goto out;
+
+	dev_dbg(dev, "RNG: returning rand bytes = %d", rc);
+out:
+	kfree(msg);
+	return rc;
+}
+
+static long nsm_dev_ioctl(struct file *file, unsigned int cmd,
+	unsigned long arg)
+{
+	void __user *argp = u64_to_user_ptr((u64)arg);
+	struct nsm *nsm = file_to_nsm(file);
+	struct nsm_msg *msg;
+	struct nsm_raw raw;
+	int r = 0;
+
+	if (cmd != NSM_IOCTL_RAW)
+		return -EINVAL;
+
+	if (_IOC_SIZE(cmd) != sizeof(raw))
+		return -EINVAL;
+
+	/* Allocate message buffers to device */
+	r = -ENOMEM;
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		goto out;
+
+	/* Copy user argument struct to kernel argument struct */
+	r = -EFAULT;
+	if (copy_from_user(&raw, argp, _IOC_SIZE(cmd)))
+		goto out;
+
+	/* Convert kernel argument struct to device request */
+	r = fill_req_raw(nsm, &msg->req, &raw);
+	if (r)
+		goto out;
+
+	/* Send message to NSM and read reply */
+	r = nsm_sendrecv_msg(nsm, msg);
+	if (r)
+		goto out;
+
+	/* Parse device response into kernel argument struct */
+	r = parse_resp_raw(nsm, &msg->resp, &raw);
+	if (r)
+		goto out;
+
+	/* Copy kernel argument struct back to user argument struct */
+	r = -EFAULT;
+	if (copy_to_user(argp, &raw, sizeof(raw)))
+		goto out;
+
+	r = 0;
+
+out:
+	kfree(msg);
+	return r;
+}
+
+static int nsm_dev_file_open(struct inode *node, struct file *file)
+{
+	return 0;
+}
+
+static int nsm_dev_file_close(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int nsm_device_init_vq(struct virtio_device *vdev)
+{
+	struct virtqueue *vq = virtio_find_single_vq(vdev,
+		nsm_vq_callback, "nsm.vq.0");
+	struct nsm *nsm = vdev->priv;
+
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+
+	nsm->vq = vq;
+
+	return 0;
+}
+
+static const struct file_operations nsm_dev_fops = {
+	.open = nsm_dev_file_open,
+	.release = nsm_dev_file_close,
+	.unlocked_ioctl = nsm_dev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+/* Handler for probing the NSM device */
+static int nsm_device_probe(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct nsm *nsm;
+	int rc;
+
+	nsm = devm_kzalloc(&vdev->dev, sizeof(*nsm), GFP_KERNEL);
+	if (!nsm)
+		return -ENOMEM;
+
+	vdev->priv = nsm;
+	nsm->vdev = vdev;
+
+	rc = nsm_device_init_vq(vdev);
+	if (rc) {
+		dev_err(dev, "queue failed to initialize: %d.\n", rc);
+		goto err_init_vq;
+	}
+
+	mutex_init(&nsm->lock);
+	init_waitqueue_head(&nsm->wq);
+
+	/* Register as hwrng provider */
+	nsm->hwrng = (struct hwrng) {
+		.read = nsm_rng_read,
+		.name = "nsm-hwrng",
+		.quality = 1000,
+	};
+
+	rc = hwrng_register(&nsm->hwrng);
+	if (rc) {
+		dev_err(dev, "RNG initialization error: %d.\n", rc);
+		goto err_hwrng;
+	}
+
+	/* Register /dev/nsm device node */
+	nsm->misc = (struct miscdevice) {
+		.minor	= MISC_DYNAMIC_MINOR,
+		.name	= "nsm",
+		.fops	= &nsm_dev_fops,
+		.mode	= 0666,
+	};
+
+	rc = misc_register(&nsm->misc);
+	if (rc) {
+		dev_err(dev, "misc device registration error: %d.\n", rc);
+		goto err_misc;
+	}
+
+	return 0;
+
+err_misc:
+	hwrng_unregister(&nsm->hwrng);
+err_hwrng:
+	vdev->config->del_vqs(vdev);
+err_init_vq:
+	return rc;
+}
+
+/* Handler for removing the NSM device */
+static void nsm_device_remove(struct virtio_device *vdev)
+{
+	struct nsm *nsm = vdev->priv;
+
+	hwrng_unregister(&nsm->hwrng);
+
+	vdev->config->del_vqs(vdev);
+	misc_deregister(&nsm->misc);
+}
+
+/* NSM device configuration structure */
+static struct virtio_driver virtio_nsm_driver = {
+	.feature_table             = 0,
+	.feature_table_size        = 0,
+	.feature_table_legacy      = 0,
+	.feature_table_size_legacy = 0,
+	.driver.name               = KBUILD_MODNAME,
+	.driver.owner              = THIS_MODULE,
+	.id_table                  = id_table,
+	.probe                     = nsm_device_probe,
+	.remove                    = nsm_device_remove,
+};
+
+module_virtio_driver(virtio_nsm_driver);
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio NSM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/nsm.h b/include/uapi/linux/nsm.h
new file mode 100644
index 000000000000..e529f232f6c0
--- /dev/null
+++ b/include/uapi/linux/nsm.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#ifndef __UAPI_LINUX_NSM_H
+#define __UAPI_LINUX_NSM_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define NSM_MAGIC		0x0A
+
+#define NSM_REQUEST_MAX_SIZE	0x1000
+#define NSM_RESPONSE_MAX_SIZE	0x3000
+
+struct nsm_iovec {
+	__u64 addr; /* Virtual address of target buffer */
+	__u64 len;  /* Length of target buffer */
+};
+
+/* Raw NSM message. Only available with CAP_SYS_ADMIN. */
+struct nsm_raw {
+	/* Request from user */
+	struct nsm_iovec request;
+	/* Response to user */
+	struct nsm_iovec response;
+};
+#define NSM_IOCTL_RAW		_IOWR(NSM_MAGIC, 0x0, struct nsm_raw)
+
+#endif /* __UAPI_LINUX_NSM_H */
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



