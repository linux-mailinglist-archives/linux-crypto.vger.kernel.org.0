Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280A4739E0
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Dec 2021 01:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbhLNA7g (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Dec 2021 19:59:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:21411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhLNA7f (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443575; x=1670979575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VnKbDj9INci9I8jOiGqny0phPxxQrd50d9zB9AWtByI=;
  b=XAwKPGvGc8iObClbI3F19GkmYtQZ3WdhfRR7BGwBDXYlWgbwnBDWg+zl
   IkTu6Dus+91tKlRMIhgdk31AW6KYUz4KVIJGGzSrsXITJCANCaKip9UQN
   1kLvJG/Mh+dL6w5I7yHOEkLuBobJMhzRPWKPzEpMAGNcVWvYJU+nvuUbW
   3+R1XtIEthwAvIpzIViC6OwzCBiiPbKduFU5ZSUTstn+xkt8ookRvF2N1
   niNkT9Q84Ht3TxCgrdj9HlBbUbWMQMlGLB3N9nxT///6yOarBHO6/ViYC
   1tTGu6xHwmAo9tPY0gtRvrsS7DcKiUKpz3KReVmJsBZpzRpXPkRrDO/Bd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139608"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148559"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:35 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, linux-doc@vger.kernel.org
Subject: [PATCH v4 01/13] Documentation/x86: Document Key Locker
Date:   Mon, 13 Dec 2021 16:52:00 -0800
Message-Id: <20211214005212.20588-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Document the overview of the feature along with relevant consideration when
provisioning dm-crypt volumes with AES-KL instead of AES-NI.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Add as a new patch.
---
 Documentation/x86/index.rst     |  1 +
 Documentation/x86/keylocker.rst | 98 +++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/x86/keylocker.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..bbea47ea10f6 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -38,3 +38,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   keylocker
diff --git a/Documentation/x86/keylocker.rst b/Documentation/x86/keylocker.rst
new file mode 100644
index 000000000000..e65d936ef199
--- /dev/null
+++ b/Documentation/x86/keylocker.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+x86 Key Locker
+==============
+
+Introduction
+============
+
+Key Locker is a CPU feature feature to reduce key exfiltration
+opportunities while maintaining a programming interface similar to AES-NI.
+It converts the AES key into an encoded form, called the 'key handle'. The
+key handle is a wrapped version of the clear-text key where the wrapping
+key has limited exposure. Once converted, all subsequent data encryption
+using new AES instructions (AES-KL) uses this key handle, reducing the
+exposure of private key material in memory.
+
+Internal Wrapping Key (IWKey)
+=============================
+
+The CPU-internal wrapping key is an entity in a software-invisible CPU
+state. On every system boot, a new key is loaded. So the key handle that
+was encoded by the old wrapping key is no longer usable on system shutdown
+or reboot.
+
+And the key may be lost on the following exceptional situation upon wakeup:
+
+IWKey Restore Failure
+---------------------
+
+The CPU state is volatile with the ACPI S3/4 sleep states. When the system
+supports those states, the key has to be backed up so that it is restored
+on wake up. The kernel saves the key in non-volatile media.
+
+The event of an IWKey restore failure upon resume from suspend, all
+established key handles become invalid. In flight dm-crypt operations
+receive error results from pending operations. In the likely scenario that
+dm-crypt is hosting the root filesystem the recovery is identical to if a
+storage controller failed to resume from suspend, reboot. If the volume
+impacted by an IWKey restore failure is a data-volume then it is possible
+that I/O errors on that volume do not bring down the rest of the system.
+However, a reboot is still required because the kernel will have
+soft-disabled Key Locker. Upon the failure, the crypto library code will
+return -ENODEV on every AES-KL function call. The Key Locker implementation
+only loads a new IWKey at initial boot, not any time after like resume from
+suspend.
+
+Use Case and Non-use Cases
+==========================
+
+Bare metal disk encryption is the only intended use case.
+
+Userspace usage is not supported because there is no ABI provided to
+communicate and coordinate wrapping-key restore failure to userspace. For
+now, key restore failures are only coordinated with kernel users. But the
+kernel can not prevent userspace from using the feature's AES instructions
+('AES-KL') when the feature has been enabled. So, the lack of userspace
+support is only documented, not actively enforced.
+
+Key Locker is not expected to be advertised to guest VMs and the kernel
+implementation ignores it even if the VMM enumerates the capability. The
+expectation is that a guest VM wants private IWKey state, but the
+architecture does not provide that. An emulation of that capability, by
+caching per VM IWKeys in memory, defeats the purpose of Key Locker. The
+backup / restore facility is also not performant enough to be suitable for
+guest VM context switches.
+
+AES Instruction Set
+===================
+
+The feature accompanies a new AES instruction set. This instruction set is
+analogous to AES-NI. A set of AES-NI instructions can be mapped to an
+AES-KL instruction. For example, AESENC128KL is responsible for ten rounds
+of transformation, which is equivalent to nine times AESENC and one
+AESENCLAST in AES-NI.
+
+But they have some notable differences:
+
+* AES-KL provides a secure data transformation using an encrypted key.
+
+* If an invalid key handle is provided, e.g. a corrupted one or a handle
+  restriction failure, the instruction fails with setting RFLAGS.ZF. The
+  crypto library implementation includes the flag check to return an error
+  code. Note that the flag is also set when the internal wrapping key is
+  changed because of missing backup.
+
+* AES-KL implements support for 128-bit and 256-bit keys, but there is no
+  AES-KL instruction to process an 192-bit key. But there is no AES-KL
+  instruction to process a 192-bit key. The AES-KL cipher implementation
+  logs a warning message with a 192-bit key and then falls back to AES-NI.
+  So, this 192-bit key-size limitation is only documented, not enforced. It
+  means the key will remain in clear-text in memory. This is to meet Linux
+  crypto-cipher expectation that each implementation must support all the
+  AES-compliant key sizes.
+
+* Some AES-KL hardware implementation may have noticeable performance
+  overhead when compared with AES-NI instructions.
+
-- 
2.17.1

