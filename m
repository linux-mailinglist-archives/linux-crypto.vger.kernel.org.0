Return-Path: <linux-crypto+bounces-8070-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C29C651C
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 00:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274F328418D
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Nov 2024 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBB21E136;
	Tue, 12 Nov 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZaSuw2y"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9021E12A
	for <linux-crypto@vger.kernel.org>; Tue, 12 Nov 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453800; cv=none; b=Desn5mExXKqtEHJi5Amp9e0/l0B0a7w0S9Tv1vdIvvsT0h+4llgszB/pL3/FuvzCPvSYXtF//37stqwLwFFTC4o8eMTczO78ltU0pWe7q+7PzqFk8BGwGN2/8UJHKr7PuXdcWRvhHWaMgkMnCNd7ziRnRSUsg01E/qbRwll4gPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453800; c=relaxed/simple;
	bh=ub/jeAuKxHgVeYJR7qfIWhbva40qGRoVqnXE5Bdp86E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dphu1k2Tp+vRp2YL72fL/8QqQD0JcE346dpyZeoD3OujDcLEkD2AcindMhsaq5seANlzyn9/slPs1g93Mb+9+xQTq5ytVbHoXH6vPP//0CVySUZm7/QAD1ZmSejd57n1YmPrvwzSHglJHS0oBL8+KJr4UexFKz6l7i0a7b4UEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZaSuw2y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e5bdb9244eso93195117b3.2
        for <linux-crypto@vger.kernel.org>; Tue, 12 Nov 2024 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453797; x=1732058597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ke0lLdlr1kk9jFT9Y4ArnxwOQ/foP1O5UmzGSVbFNLU=;
        b=2ZaSuw2yeFSc64GPCHXQ6b9YJwPToj5chgpdlNqrMj6gx+czLTBL4Tvmd5oYqXOZH0
         pb8dKbpTiSWfhF6Dx2oUxOINrQ9WOn7sOXPXZDVAgb+zOlqkpocAKLk60z62LdOtHVzm
         6GZfNzgIQxmpco4inXn1sCRc1NAGBjSwGG79mG02Wcl1QoIjH8leKWk4ocqCvqdGv9Ui
         ebIvyK2+vkk2vtpex+Ztd5Zyt1rJEqKIBRUCMSNn13ZoohAbZ87UCat3oP1RVhE+9EY9
         GFsNgW8ehLPz6dVUcxZHRV1ug9HmK8i4FXbaRU0OdKeOSbTZN06zKg+SpiiYA2v4LrWs
         q4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453797; x=1732058597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ke0lLdlr1kk9jFT9Y4ArnxwOQ/foP1O5UmzGSVbFNLU=;
        b=RaUgDKxUyBoUTZoF+sIVCZLdlrLEmIVcrtRzKInzhKgnvZfBwx+ejm13urGjT2hQxk
         wdNYFRHggk30PmYikFlmraLzTTfbAV3f82NjdWjLW1fBXl2nzI8B5yYkOd0gDj0md1t1
         Hg9QTOR6r/4wuyxDvwcT4rfa+X1JLMf/gy35f3MYSFOPLGZ8d+8LrnhldkKn3wwY/v06
         ZRSLIJnLkv4H8BU+bG6oX0+4Yy2OdYI79HrBsz6dyAi4olR9XnkCek1pGExrG/Bx5wwc
         nRvP0DYGN1kWHxfwhRQ71MJg0pu0uUBANt1t994TKNgs9oHCx0IG42vSraHRWTQb39mb
         l++w==
X-Forwarded-Encrypted: i=1; AJvYcCXYQBnoh7AHSEpJmA4Q+6WrhY5R2JNLlowit9DJQnyKsyztg+TBswr+U59XJOs45kNi28Pu5IZjSFHm5pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQGcQ/9SAGg+AcuYGNGB1UOfBA/5zQNlstetOKeH4qNGehm9j
	5OTAYNRRsRPMKNzvB+MBu1NsAkgnATdEd28vVNBQ2g+PL99uFWaS2xKATKEF0OgONuUVtnvoQn3
	AAiKB08yOPbr/2hvOuYxICA==
X-Google-Smtp-Source: AGHT+IE9XrR6GjaQBHvQS5sK7gytB+L9sUsf5ZrG6EKKcAz5P+cTOu/VMoAAZDFGSEeppHcPeADdJdGGCa104awGmA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:690c:1c:b0:6e3:b08:92c7 with SMTP
 id 00721157ae682-6eaddc1ed85mr3462377b3.0.1731453797357; Tue, 12 Nov 2024
 15:23:17 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:45 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-7-dionnaglaze@google.com>
Subject: [PATCH v6 6/8] crypto: ccp: Add DOWNLOAD_FIRMWARE_EX support
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Ashish Kalra <ashish.kalra@amd.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In order to support firmware hotloading, the DOWNLOAD_FIRMWARE_EX
command must be available.

The DOWNLOAD_FIRMWARE_EX command requires cache flushing and introduces
new error codes that could be returned to user space.

Access to the command is through the firmware_upload API rather than
through the ioctl interface to prefer a common interface.

On init, the ccp device will make /sys/class/firmware/amd/loading etc
firmware upload API attributes available to late-load a SEV-SNP firmware
binary.

The firmware_upload API errors reported are actionable in the following
ways:
* FW_UPLOAD_ERR_HW_ERROR: the machine is in an unstable state and must
  be reset.
* FW_UPLOAD_ERR_RW_ERROR: the firmware update went bad but can be
  recovered by hotloading the previous firmware version.
  Also used in the case that the kernel used the API wrong (bug).
* FW_UPLOAD_ERR_FW_INVALID: user error with the data provided, but no
  instability is expected and no recovery actions are needed.
* FW_UPLOAD_ERR_BUSY: upload attempted at a bad time either due to
  overload or the machine is in the wrong platform state.

synthetic_restore_required:
Instead of tracking the status of whether an individual GCTX is safe for
use in a firmware command, force all following commands to fail with an
error that is indicative of needing a firmware rollback.

To test:
1. Build the kernel enabling SEV-SNP as normal and add CONFIG_FW_UPLOAD=y.
2. Add the following to your kernel_cmdline: ccp.psp_init_on_probe=0.
3.Get an AMD SEV-SNP firmware sbin appropriate to your Epyc chip model at
https://www.amd.com/en/developer/sev.html and extract to get a .sbin
file.
4. Run the following with your sbinfile in FW:

echo 1 > /sys/class/firmware/snp_dlfw_ex/loading
cat "${FW?}" > /sys/class/firmware/snp_dlfw_ex/data
echo 0 > /sys/class/firmware/snp_dlfw_ex/loading

5. Verify the firmware update message in dmesg.

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>

Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/crypto/ccp/Kconfig   |  10 ++
 drivers/crypto/ccp/Makefile  |   1 +
 drivers/crypto/ccp/sev-dev.c |  27 ++--
 drivers/crypto/ccp/sev-dev.h |  31 ++++
 drivers/crypto/ccp/sev-fw.c  | 281 +++++++++++++++++++++++++++++++++++
 include/linux/psp-sev.h      |  17 +++
 6 files changed, 357 insertions(+), 10 deletions(-)
 create mode 100644 drivers/crypto/ccp/sev-fw.c

diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index f394e45e11ab4..40be991f15d28 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -46,6 +46,16 @@ config CRYPTO_DEV_SP_PSP
 	 along with software-based Trusted Execution Environment (TEE) to
 	 enable third-party trusted applications.
 
+config CRYPTO_DEV_SP_PSP_FW_UPLOAD
+	bool "Platform Security Processor (PSP) device with firmware hotloading"
+	default y
+	depends on CRYPTO_DEV_SP_PSP && FW_LOADER && FW_UPLOAD
+	help
+	 Provide support for AMD Platform Security Processor firmware.
+	 The PSP firmware can be updated while no SEV or SEV-ES VMs are active.
+	 Users of this feature should be aware of the error modes that indicate
+	 required manual rollback or reset due to instablity.
+
 config CRYPTO_DEV_CCP_DEBUGFS
 	bool "Enable CCP Internals in DebugFS"
 	default n
diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index 394484929dae3..5ce69134ec48b 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -14,6 +14,7 @@ ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) += psp-dev.o \
                                    platform-access.o \
                                    dbc.o \
                                    hsti.o
+ccp-$(CONFIG_CRYPTO_DEV_SP_PSP_FW_UPLOAD) += sev-fw.o
 
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) += ccp-crypto.o
 ccp-crypto-objs := ccp-crypto-main.o \
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d8c35b8478ff5..a8f5e35ab8a0a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -228,6 +228,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
 	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
+	case SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX:	return sizeof(struct sev_data_download_firmware_ex);
 	default:				return 0;
 	}
 
@@ -489,7 +490,7 @@ void snp_free_firmware_page(void *addr)
 }
 EXPORT_SYMBOL_GPL(snp_free_firmware_page);
 
-static void *sev_fw_alloc(unsigned long len)
+void *sev_fw_alloc(unsigned long len)
 {
 	struct page *page;
 
@@ -857,6 +858,15 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	if (WARN_ON_ONCE(!data != !buf_len))
 		return -EINVAL;
 
+	/* Firmware hotloading can fail to update some guest context pages, in which case
+	 * user space should roll back the firmware instead of committing it. This is already
+	 * a firmware error code called RESTORE_REQUIRED, so report that error if VMs would
+	 * be corrupted if user space were to commit the firmware.
+	 */
+	ret = sev_snp_synthetic_error(sev, psp_ret);
+	if (ret)
+		return ret;
+
 	/*
 	 * Copy the incoming data to driver's scratch buffer as __pa() will not
 	 * work for some memory, e.g. vmalloc'd addresses, and @data may not be
@@ -1661,7 +1671,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len)
 }
 EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 
-static int sev_get_api_version(void)
+int sev_get_api_version(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_user_data_status status;
@@ -1736,14 +1746,7 @@ static int sev_update_firmware(struct device *dev)
 		return -1;
 	}
 
-	/*
-	 * SEV FW expects the physical address given to it to be 32
-	 * byte aligned. Memory allocated has structure placed at the
-	 * beginning followed by the firmware being passed to the SEV
-	 * FW. Allocate enough memory for data structure + alignment
-	 * padding + SEV FW.
-	 */
-	data_size = ALIGN(sizeof(struct sev_data_download_firmware), 32);
+	data_size = ALIGN(sizeof(struct sev_data_download_firmware), SEV_FW_ALIGNMENT);
 
 	order = get_order(firmware->size + data_size);
 	p = alloc_pages(GFP_KERNEL, order);
@@ -2407,6 +2410,8 @@ int sev_dev_init(struct psp_device *psp)
 	if (ret)
 		goto e_irq;
 
+	snp_init_firmware_upload(sev);
+
 	dev_notice(dev, "sev enabled\n");
 
 	return 0;
@@ -2488,6 +2493,8 @@ void sev_dev_destroy(struct psp_device *psp)
 		kref_put(&misc_dev->refcount, sev_exit);
 
 	psp_clear_sev_irq_handler(psp);
+
+	snp_destroy_firmware_upload(sev);
 }
 
 static int snp_shutdown_on_panic(struct notifier_block *nb,
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index ccf3ba78d8332..2417bcce97848 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -29,6 +29,15 @@
 #define SEV_CMD_COMPLETE		BIT(1)
 #define SEV_CMDRESP_IOC			BIT(0)
 
+/*
+ * SEV FW expects the physical address given to it to be 32
+ * byte aligned. Memory allocated has structure placed at the
+ * beginning followed by the firmware being passed to the SEV
+ * FW. Allocate enough memory for data structure + alignment
+ * padding + SEV FW.
+ */
+#define SEV_FW_ALIGNMENT       32
+
 struct sev_misc_dev {
 	struct kref refcount;
 	struct miscdevice misc;
@@ -57,6 +66,11 @@ struct sev_device {
 	bool cmd_buf_backup_active;
 
 	bool snp_initialized;
+
+#ifdef CONFIG_FW_UPLOAD
+	struct fw_upload *fwl;
+	bool fw_cancel;
+#endif /* CONFIG_FW_UPLOAD */
 };
 
 int sev_dev_init(struct psp_device *psp);
@@ -69,4 +83,21 @@ struct sev_asid_data {
 	void *snp_context;
 };
 
+/* Extern to be shared with firmware_upload API implementation if configured. */
+extern struct sev_asid_data *sev_asid_data;
+extern u32 nr_asids, sev_min_asid, sev_max_asid, sev_es_max_asid;
+
+void *sev_fw_alloc(unsigned long len);
+int sev_get_api_version(void);
+
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP_FW_UPLOAD
+void snp_init_firmware_upload(struct sev_device *sev);
+void snp_destroy_firmware_upload(struct sev_device *sev);
+int sev_snp_synthetic_error(struct sev_device *sev, int *psp_ret);
+#else
+static inline void snp_init_firmware_upload(struct sev_device *sev) { }
+static inline void snp_destroy_firmware_upload(struct sev_device *sev) { }
+static inline int sev_snp_synthetic_error(struct sev_device *sev, int *psp_ret) { return 0; }
+#endif /* CONFIG_CRYPTO_DEV_SP_PSP_FW_UPLOAD */
+
 #endif /* __SEV_DEV_H */
diff --git a/drivers/crypto/ccp/sev-fw.c b/drivers/crypto/ccp/sev-fw.c
new file mode 100644
index 0000000000000..327feb846e5be
--- /dev/null
+++ b/drivers/crypto/ccp/sev-fw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Encrypted Virtualization (SEV) firmware upload API
+ */
+
+#include <linux/firmware.h>
+#include <linux/psp.h>
+#include <linux/psp-sev.h>
+
+#include <asm/sev.h>
+
+#include "sev-dev.h"
+
+static bool synthetic_restore_required;
+
+int sev_snp_synthetic_error(struct sev_device *sev, int *psp_ret)
+{
+	if (synthetic_restore_required) {
+		*psp_ret = SEV_RET_RESTORE_REQUIRED;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sev_snp_download_firmware_ex(struct sev_device *sev, const u8 *data, u32 size,
+					int *error)
+{
+	struct sev_data_download_firmware_ex *data_ex;
+	int ret, order;
+	struct page *p;
+	u64 data_size;
+	void *fw_dest;
+
+	data_size = ALIGN(sizeof(struct sev_data_download_firmware_ex), SEV_FW_ALIGNMENT);
+
+	order = get_order(size + data_size);
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p)
+		return -ENOMEM;
+
+	/*
+	 * Copy firmware data to a kernel allocated contiguous
+	 * memory region.
+	 */
+	data_ex = page_address(p);
+	fw_dest = page_address(p) + data_size;
+	memset(data_ex, 0, data_size);
+	memcpy(fw_dest, data, size);
+
+	/* commit is purposefully unset for GCTX update failure to advise rollback */
+	data_ex->fw_paddr = __psp_pa(fw_dest);
+	data_ex->fw_len = size;
+	data_ex->length = sizeof(struct sev_data_download_firmware_ex);
+
+	ret = sev_do_cmd(SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX, data_ex, error);
+
+	if (ret)
+		goto free_err;
+
+	/* Need to do a DF_FLUSH after live firmware update */
+	wbinvd_on_all_cpus();
+	ret = sev_do_cmd(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+	if (ret)
+		dev_dbg(sev->dev, "DF_FLUSH error %d\n", *error);
+
+free_err:
+	__free_pages(p, order);
+	return ret;
+}
+
+static enum fw_upload_err snp_dlfw_ex_prepare(struct fw_upload *fw_upload,
+					      const u8 *data, u32 size)
+{
+	struct sev_device *sev = fw_upload->dd_handle;
+
+	sev->fw_cancel = false;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err snp_dlfw_ex_poll_complete(struct fw_upload *fw_upload)
+{
+	return FW_UPLOAD_ERR_NONE;
+}
+
+/* Cancel can be called asynchronously, but DOWNLOAD_FIRMWARE_EX is atomic and cannot
+ * be canceled. There is no need to synchronize updates to fw_cancel.
+ */
+static void snp_dlfw_ex_cancel(struct fw_upload *fw_upload)
+{
+	/* fw_upload not-NULL guaranteed by firmware_upload API */
+	struct sev_device *sev = fw_upload->dd_handle;
+
+	sev->fw_cancel = true;
+}
+
+static enum fw_upload_err snp_dlfw_ex_err_translate(struct sev_device *sev, int psp_ret)
+{
+	dev_dbg(sev->dev, "Failed to update SEV firmware: %#x\n", psp_ret);
+
+	/*
+	 * Operation error:
+	 *   HW_ERROR: Critical error. Machine needs repairs now.
+	 *   RW_ERROR: Severe error. Roll back to the prior version to recover.
+	 * User error:
+	 *   FW_INVALID: Bad input for this interface.
+	 *   BUSY: Wrong machine state to run download_firmware_ex.
+	 */
+	switch (psp_ret) {
+	case SEV_RET_RESTORE_REQUIRED:
+		dev_warn(sev->dev, "Firmware updated but unusable. Rollback!!!\n");
+		return FW_UPLOAD_ERR_RW_ERROR;
+	case SEV_RET_SHUTDOWN_REQUIRED:
+		/* No state changes made. Not a hardware error. */
+		dev_warn(sev->dev, "Firmware image cannot be live updated\n");
+		return FW_UPLOAD_ERR_FW_INVALID;
+	case SEV_RET_BAD_VERSION:
+		/* No state changes made. Not a hardware error. */
+		dev_warn(sev->dev, "Firmware image is not well formed\n");
+		return FW_UPLOAD_ERR_FW_INVALID;
+		/* SEV-specific errors that can still happen. */
+	case SEV_RET_BAD_SIGNATURE:
+		/* No state changes made. Not a hardware error. */
+		dev_warn(sev->dev, "Firmware image signature is bad\n");
+		return FW_UPLOAD_ERR_FW_INVALID;
+	case SEV_RET_INVALID_PLATFORM_STATE:
+		/* Calling at the wrong time. Not a hardware error. */
+		dev_warn(sev->dev, "Firmware not updated as SEV in INIT state\n");
+		return FW_UPLOAD_ERR_BUSY;
+	case SEV_RET_HWSEV_RET_UNSAFE:
+		dev_err(sev->dev, "Firmware is unstable. Reset your machine!!!\n");
+		return FW_UPLOAD_ERR_HW_ERROR;
+		/* Kernel bug cases. */
+	case SEV_RET_INVALID_PARAM:
+		dev_err(sev->dev, "Download-firmware-EX invalid parameter\n");
+		return FW_UPLOAD_ERR_RW_ERROR;
+	case SEV_RET_INVALID_ADDRESS:
+		dev_err(sev->dev, "Download-firmware-EX invalid address\n");
+		return FW_UPLOAD_ERR_RW_ERROR;
+	default:
+		dev_err(sev->dev, "Unhandled download_firmware_ex err %d\n", psp_ret);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+}
+
+static enum fw_upload_err snp_update_guest_contexts(struct sev_device *sev)
+{
+	struct sev_data_snp_guest_status status_data;
+	void *snp_guest_status;
+	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
+	int rc, error;
+
+	/*
+	 * Force an update of guest context pages after SEV firmware
+	 * live update by issuing SNP_GUEST_STATUS on all guest
+	 * context pages.
+	 */
+	snp_guest_status = sev_fw_alloc(PAGE_SIZE);
+	if (!snp_guest_status)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	for (int i = 1; i <= sev_es_max_asid; i++) {
+		if (!sev_asid_data[i].snp_context)
+			continue;
+
+		status_data.gctx_paddr = __psp_pa(sev_asid_data[i].snp_context);
+		status_data.address = __psp_pa(snp_guest_status);
+		rc = sev_do_cmd(SEV_CMD_SNP_GUEST_STATUS, &status_data, &error);
+		if (!rc)
+			continue;
+
+		/*
+		 * Handle race with SNP VM being destroyed/decommissoned,
+		 * if guest context page invalid error is returned,
+		 * assume guest has been destroyed.
+		 */
+		if (error == SEV_RET_INVALID_GUEST)
+			continue;
+
+		/* Guest context page update failure should force userspace to rollback,
+		 * so make all non-DOWNLOAD_FIRMWARE_EX commands fail with RESTORE_REQUIRED.
+		 * This emulates the behavior of the firmware on an older PSP bootloader version
+		 * that couldn't auto-restore on DOWNLOAD_FIRMWARE_EX failure. However, the error
+		 * is still relevant to this follow-up guest update failure.
+		 */
+		synthetic_restore_required = true;
+		dev_err(sev->dev,
+			"SNP guest context update error, rc=%d, fw_error=0x%x. Rollback!!!\n",
+			rc, error);
+		ret = FW_UPLOAD_ERR_RW_ERROR;
+		break;
+	}
+
+	snp_free_firmware_page(snp_guest_status);
+	return ret;
+}
+
+static enum fw_upload_err snp_dlfw_ex_write(struct fw_upload *fwl, const u8 *data,
+					    u32 offset, u32 size, u32 *written)
+{
+	/* fwl not-NULL guaranteed by firmware_upload API, and sev is non-NULL by precondition to
+	 * snp_init_firmware_upload.
+	 */
+	struct sev_device *sev = fwl->dd_handle;
+	u8 api_major, api_minor, build;
+	int ret, error;
+
+	if (!sev)
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	if (sev->fw_cancel)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	/*
+	 * SEV firmware update is a one-shot update operation, the write()
+	 * callback to be invoked multiple times for the same update is
+	 * unexpected.
+	 */
+	if (offset)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	if (sev_get_api_version())
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	api_major = sev->api_major;
+	api_minor = sev->api_minor;
+	build     = sev->build;
+
+	ret = sev_snp_download_firmware_ex(sev, data, size, &error);
+	if (ret)
+		return snp_dlfw_ex_err_translate(sev, error);
+
+	ret = snp_update_guest_contexts(sev);
+	if (ret)
+		return ret;
+
+	sev_get_api_version();
+	if (api_major != sev->api_major || api_minor != sev->api_minor ||
+	    build != sev->build) {
+		dev_info(sev->dev, "SEV firmware updated from %d.%d.%d to %d.%d.%d\n",
+			 api_major, api_minor, build,
+			 sev->api_major, sev->api_minor, sev->build);
+	} else {
+		dev_info(sev->dev, "SEV firmware not updated, same as current version %d.%d.%d\n",
+			 api_major, api_minor, build);
+	}
+
+	*written = size;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static const struct fw_upload_ops snp_dlfw_ex_ops = {
+	.prepare = snp_dlfw_ex_prepare,
+	.write = snp_dlfw_ex_write,
+	.poll_complete = snp_dlfw_ex_poll_complete,
+	.cancel = snp_dlfw_ex_cancel,
+};
+
+/* PREREQUISITE: sev is non-NULL */
+void snp_init_firmware_upload(struct sev_device *sev)
+{
+	struct fw_upload *fwl;
+
+	fwl = firmware_upload_register(THIS_MODULE, sev->dev, "snp_dlfw_ex", &snp_dlfw_ex_ops, sev);
+	if (IS_ERR(fwl)) {
+		dev_err(sev->dev, "SEV firmware upload initialization error %ld\n", PTR_ERR(fwl));
+		return;
+	}
+
+	sev->fwl = fwl;
+}
+
+/* PREREQUISITE: sev is non-NULL */
+void snp_destroy_firmware_upload(struct sev_device *sev)
+{
+	if (!sev->fwl)
+		return;
+
+	firmware_upload_unregister(sev->fwl);
+}
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 0b3b7707ccb21..9ad941e36bb63 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -185,6 +185,23 @@ struct sev_data_download_firmware {
 	u32 len;				/* In */
 } __packed;
 
+/**
+ * struct sev_data_download_firmware_ex - DOWNLOAD_FIRMWARE_EX command parameters
+ *
+ * @length: length of this command buffer
+ * @fw_paddr: physical address of firmware image
+ * @fw_len: len of the firmware image
+ * @commit: automatically commit the newly installed image
+ */
+struct sev_data_download_firmware_ex {
+	u32 length;				/* In */
+	u32 reserved;				/* In */
+	u64 fw_paddr;				/* In */
+	u32 fw_len;				/* In */
+	u32 commit:1;				/* In */
+	u32 reserved2:31;			/* In */
+} __packed;
+
 /**
  * struct sev_data_get_id - GET_ID command parameters
  *
-- 
2.47.0.277.g8800431eea-goog


