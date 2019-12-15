Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4ED11F7E7
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Dec 2019 14:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfLONIr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 15 Dec 2019 08:08:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbfLONIr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 15 Dec 2019 08:08:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBFD7FtN117859;
        Sun, 15 Dec 2019 08:08:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wvw59t888-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Dec 2019 08:08:28 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBFD8No8120394;
        Sun, 15 Dec 2019 08:08:28 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wvw59t87p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Dec 2019 08:08:27 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBFD7LXj032169;
        Sun, 15 Dec 2019 13:08:26 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 2wvqc5kea1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Dec 2019 13:08:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBFD8QnX52691260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Dec 2019 13:08:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52524B205F;
        Sun, 15 Dec 2019 13:08:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86ED7B2064;
        Sun, 15 Dec 2019 13:08:25 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 15 Dec 2019 13:08:25 +0000 (GMT)
Subject: [PATCH 10/10] Documentation/powerpc: VAS API
From:   Haren Myneni <haren@linux.ibm.com>
To:     herbert@gondor.apana.org.au
Cc:     mpe@ellerman.id.au, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, hch@infradead.org,
        npiggin@gmail.com, mikey@neuling.org, sukadev@linux.vnet.ibm.com
In-Reply-To: <1576414240.16318.4066.camel@hbabu-laptop>
References: <1576414240.16318.4066.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 15 Dec 2019 05:06:36 -0800
Message-ID: <1576415196.16318.4098.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-15_03:2019-12-13,2019-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912150125
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Power9 introduced Virtual Accelerator Switchboard (VAS) which allows
userspace to communicate with Nest Accelerator (NX) directly. But
kernel has to establish channel to NX for userspace. This document
describes user space API that application can use to establish
communication channel.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 Documentation/powerpc/index.rst   |   1 +
 Documentation/powerpc/vas-api.rst | 246
++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 Documentation/powerpc/vas-api.rst

diff --git a/Documentation/powerpc/index.rst
b/Documentation/powerpc/index.rst
index db7b6a8..8b5b167 100644
--- a/Documentation/powerpc/index.rst
+++ b/Documentation/powerpc/index.rst
@@ -27,6 +27,7 @@ powerpc
     syscall64-abi
     transactional_memory
     ultravisor
+    vas-api
 
 .. only::  subproject and html
 
diff --git a/Documentation/powerpc/vas-api.rst
b/Documentation/powerpc/vas-api.rst
new file mode 100644
index 0000000..13ce4e7
--- /dev/null
+++ b/Documentation/powerpc/vas-api.rst
@@ -0,0 +1,246 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _VAS-API:
+
+===================================================
+Virtual Accelerator Switchboard (VAS) userspace API
+===================================================
+
+Introduction
+============
+
+Power9 processor introduced Virtual Accelerator Switchboard (VAS) which
+allows both userspace and kernel communicate to co-processor
+(hardware accelerator) referred to as the Nest Accelerator (NX). The NX
+unit comprises of one or more hardware engines or co-processor types
+such as 842 compression, GZIP compression and encryption. On power9,
+userspace applications will have access to only GZIP Compression engine
+which supports ZLIB and GZIP compression algorithms in the hardware.
+
+To communicate with NX, kernel has to establish a channel or window and
+then requests can be submitted directly without kernel involvement.
+Requests to the GZIP engine must be formatted as a co-processor Request
+Block (CRB) and these CRBs must be submitted to the NX using COPY/PASTE
+instructions to paste the CRB to hardware address that is associated
with
+the engine's request queue.
+
+The GZIP engine provides two priority levels of requests: Normal and
+High. Only Normal requests are supported from userspace right now.
+
+This document explains userspace API that is used to interact with
+kernel to setup channel / window which can be used to send compression
+requests directly to NX accelerator.
+
+
+Overview
+========
+
+Application access to the GZIP engine is provided through
+/dev/crypto/nx-gzip device node implemented by the VAS/NX device
driver.
+An application must open the /dev/crypto/nx-gzip device to obtain a
file
+descriptor (fd). Then should issue VAS_TX_WIN_OPEN ioctl with this fd
to
+establish connection to the engine. It means send window is opened on
GZIP
+engine for this process. Once a connection is established, the
application
+should use the mmap() system call to map the hardware address of
engine's
+request queue into the application's virtual address space.
+
+The application can then submit one or more requests to the the engine
by
+using copy/paste instructions and pasting the CRBs to the virtual
address
+(aka paste_address) returned by mmap(). User space can close the
+established connection or send window by closing the file descriptior
+(close(fd)) or upon the process exit.
+
+Note that applications can send several requests with the same window
or
+can establish multiple windows, but one window for each file
descriptor.
+
+Following sections provide additional details and references about the
+individual steps.
+
+NX-GZIP Device Node
+===================
+
+There is one /dev/crypto/nx-gzip node in the system and it provides
+access to all GZIP engines in the system. The only valid operations on
+/dev/crypto/nx-gzip are:
+
+	* open() the device for read and write.
+	* issue VAS_TX_WIN_OPEN ioctl
+	* mmap() the engine's request queue into application's virtual
+	  address space (i.e. get a paste_address for the co-processor
+	  engine).
+	* close the device node.
+
+Other file operations on this device node are undefined.
+
+Note that the copy and paste operations go directly to the hardware and
+do not go through this device. Refer COPY/PASTE document for more
+details.
+
+Although a system may have several instances of the NX co-processor
+engines (typically, one per P9 chip) there is just one
+/dev/crypto/nx-gzip device node in the system. When the nx-gzip device
+node is opened, Kernel opens send window on a suitable instance of NX
+accelerator. It finds CPU on which the user process is executing and
+determine the NX instance for the corresponding chip on which this CPU
+belongs.
+
+Applications may chose a specific instance of the NX co-processor using
+the vas_id field in the VAS_TX_WIN_OPEN ioctl as detailed below.
+
+A userspace library libnxz is available here but still in development:
+	 https://github.com/abalib/power-gzip
+
+Applications that use inflate / deflate calls can link with libnxz
+instead of libz and use NX GZIP compression without any modification.
+
+Open /dev/crypto/nx-gzip
+========================
+
+The nx-gzip device should be opened for read and write. No special
+privileges are needed to open the device. Each window coreesponds to
one
+file descriptor. So if the userspace process needs multiple windows,
+several open calls have to be issued.
+
+See open(2) system call man pages for other details such as return
values,
+error codes and restrictions.
+codes and restrictions.
+
+VAS_TX_WIN_OPEN ioctl
+=====================
+
+Applications should use the VAS_TX_WIN_OPEN ioctl as follows to
establish
+a connection with NX co-processor engine:
+
+	::
+		struct vas_tx_win_open_attr {
+			__u32   version;
+			__s16   vas_id; /* specific instance of vas or -1
+						for default */
+			__u16   reserved1;
+			__u64   flags;	/* For future use */
+			__u64   reserved2[6];
+		};
+
+	version: The version field must be currently set to 1.
+	vas_id: If '-1' is passed, kernel will make a best-effort attempt
+		to assign an optimal instance of NX for the process. To
+		select the specific VAS instance, refer
+		"Discovery of available VAS engines" section below.
+
+	flags, reserved1 and reserved2[6] fields are for future extension
+	and must be set to 0.
+
+	The attributes attr for the VAS_TX_WIN_OPEN ioctl are defined as
+	follows:
+		#define VAS_MAGIC 'v'
+		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 1,
+						struct vas_tx_win_open_attr)
+
+		struct vas_tx_win_open_attr attr;
+		rc = ioctl(fd, VAS_TX_WIN_OPEN, &attr);
+
+	The VAS_TX_WIN_OPEN ioctl returns 0 on success. On errors, it
+	returns -1 and sets the errno variable to indicate the error.
+
+	Error conditions:
+		EINVAL	fd does not refer to a valid VAS device.
+		EINVAL	Invalid vas ID
+		EINVAL	version is not set with proper value
+		EEXIST	Window is already opened for the given fd
+		ENOMEM	Memory is not available to allocate window
+		ENOSPC	System has too many active windows (connections)
+			opened
+		EINVAL	reserved fields are not set to 0.
+
+	See the ioctl(2) man page for more details, error codes and
+	restrictions.
+
+mmap() NX-GZIP device
+=====================
+
+The mmap() system call for a NX-GZIP device fd returns a paste_address
+that the application can use to copy/paste its CRB to the hardware
engines.
+	::
+
+		paste_addr = mmap(addr, size, prot, flags, fd, offset);
+
+	Only restrictions on mmap for a NX-GZIP device fd are:
+		* size should be 4K page size
+		* offset parameter should be 0ULL
+
+	Refer to mmap(2) man page for additional details/restrictions.
+	In addition to the error conditions listed on the mmap(2) man
+	page, can also fail with one of the following error codes:
+
+		EINVAL	fd is not associated with an open window
+			(i.e mmap() does not follow a successful call
+			to the VAS_TX_WIN_OPEN ioctl).
+		EINVAL	offset field is not 0ULL.
+
+Discovery of available VAS engines
+==================================
+
+Each available VAS instance in the system will have a device tree node
+like /proc/device-tree/vas@* or /proc/device-tree/xscom@*/vas@*.
+Determine the chip or VAS instance and use the corresponding ibm,vas-id
+property value in this node to select specific VAS instance.
+
+Copy/Paste operations
+=====================
+
+Applications should use the copy and paste instructions defined in the
RFC
+to copy/paste the CRB.
+
+CRB Specification and use NX
+============================
+
+Applications should format requests to the co-processor using the
+co-processor Request Block (CRBs). Refer NX workbook for the format of
+CRB and use NX from userspace such as sending requests and checking
+request status.
+
+Simple example
+==============
+
+	::
+		int use_nx_gzip()
+		{
+			int rc, fd;
+			void *addr;
+			struct vas_setup_attr txattr;
+
+			fd = open("/dev/crypto/nx-gzip", O_RDWR);
+			if (fd < 0) {
+				fprintf(stderr, "open nx-gzip failed\n");
+				return -1;
+			}
+			memset(&txattr, 0, sizeof(txattr));
+			txattr.version = 1;
+			txattr.vas_id = -1
+			rc = ioctl(fd, VAS_TX_WIN_OPEN,
+					(unsigned long)&txattr);
+			if (rc < 0) {
+				fprintf(stderr, "ioctl() n %d, error %d\n",
+						rc, errno);
+				return rc;
+			}
+			addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
+					MAP_SHARED, fd, 0ULL);
+			if (addr == MAP_FAILED) {
+				fprintf(stderr, "mmap() failed, errno %d\n",
+						errno);
+				return -errno;
+			}
+			do {
+				//Format CRB request with compression or
+				//uncompression
+				// Refer tests for vas_copy/vas_paste
+				vas_copy((&crb, 0, 1);
+				vas_paste(addr, 0, 1);
+				// Poll on csb.flags with timeout
+				// csb address is listed in CRB
+			} while (true)
+			close(fd) or window can be closed upon process exit
+		}
+
+	Refer https://github.com/abalib/power-gzip for tests or more
+	use cases.
-- 
1.8.3.1



