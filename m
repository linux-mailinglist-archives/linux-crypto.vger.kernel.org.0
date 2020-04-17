Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD11AD93C
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2020 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgDQI4W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Apr 2020 04:56:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729784AbgDQI4W (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Apr 2020 04:56:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H8YMEa006260;
        Fri, 17 Apr 2020 04:56:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f8x98pj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 04:56:02 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03H8YZPa008441;
        Fri, 17 Apr 2020 04:56:02 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f8x98phr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 04:56:02 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03H8tfeB027078;
        Fri, 17 Apr 2020 08:56:00 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 30b5h7nctf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 08:56:00 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H8txaj55312764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 08:55:59 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885EFC6057;
        Fri, 17 Apr 2020 08:55:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F7CC6055;
        Fri, 17 Apr 2020 08:55:59 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Apr 2020 08:55:58 +0000 (GMT)
Subject: [PATCH v6 0/9] crypto/nx: Enable GZIP engine and provide userpace
 API
From:   Haren Myneni <haren@linux.ibm.com>
To:     mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc:     mikey@neuling.org, npiggin@gmail.com, linux-crypto@vger.kernel.org,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        dja@axtens.net
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 17 Apr 2020 01:55:32 -0700
Message-ID: <1587113732.2275.1096.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_02:2020-04-14,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170063
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Power9 processor supports Virtual Accelerator Switchboard (VAS) which
allows kernel and userspace to send compression requests to Nest
Accelerator (NX) directly. The NX unit comprises of 2 842 compression
engines and 1 GZIP engine. Linux kernel already has 842 compression
support on kernel. This patch series adds GZIP compression support
from user space. The GZIP Compression engine implements the ZLIB and
GZIP compression algorithms. No plans of adding NX-GZIP compression
support in kernel right now.

Applications can send requests to NX directly with COPY/PASTE
instructions. But kernel has to establish channel / window on NX-GZIP
device for the userspace. So userspace access to the GZIP engine is
provided through /dev/crypto/nx-gzip device with several operations.

An application must open the this device to obtain a file descriptor (fd).
Using the fd, application should issue the VAS_TX_WIN_OPEN ioctl to
establish a connection to the engine. Once window is opened, should use
mmap() system call to map the hardware address of engine's request queue
into the application's virtual address space. Then user space forms the
request as co-processor Request Block (CRB) and paste this CRB on the
mapped HW address using COPY/PASTE instructions. Application can poll
on status flags (part of CRB) with timeout for request completion.

For VAS_TX_WIN_OPEN ioctl, if user space passes vas_id = -1 (struct
vas_tx_win_open_attr), kernel determines the VAS instance on the
corresponding chip based on the CPU on which the process is executing.
Otherwise, the specified VAS instance is used if application passes the
proper VAS instance (vas_id listed in /proc/device-tree/vas@*/ibm,vas_id).

Process can open multiple windows with different FDs or can send several
requests to NX on the same window at the same time.

A userspace library libnxz is available:
        https://github.com/abalib/power-gzip

Applications that use inflate/deflate calls can link with libNXz and use
NX GZIP compression without any modification.

Tested the available 842 compression on power8 and power9 system to make
sure no regression and tested GZIP compression on power9 with tests
available in the above link.

Thanks to Bulent Abali for nxz library and tests development.

Changelog:

V2:
  - Move user space API code to powerpc as suggested. Also this API
    can be extended to any other coprocessor type that VAS can support
    in future. Example: Fast thread wakeup feature from VAS
  - Rebased to 5.6-rc3

V3:
  - Fix sparse warnings (patches 3&6)

V4:
  - Remove unused coproc_instid and add only window address in
    fp->private_data.
  - Add NX User's manual and Copy/paste links in VAS API documentation
    in patch and other changes as Daniel Axtens suggested

V5:
  - Added "NX Fault handling" section in VAS API documentation as Nick
    suggested.
  - Documentation: mmap size should be PAGE_SIZE as Daniel Axtens pointed.

V6:
  - Make ioctl generic to support any coprocessor type (Michael Ellerman)
    (patches 3&7)

Haren Myneni (9):
  powerpc/vas: Initialize window attributes for GZIP coprocessor type
  powerpc/vas: Define VAS_TX_WIN_OPEN ioctl API
  powerpc/vas: Add VAS user space API
  crypto/nx: Initialize coproc entry with kzalloc
  crypto/nx: Rename nx-842-powernv file name to nx-common-powernv
  crypto/nx: Make enable code generic to add new GZIP compression type
  crypto/nx: Enable and setup GZIP compresstion type
  crypto/nx: Remove 'pid' in vas_tx_win_attr struct
  Documentation/powerpc: VAS API

 Documentation/powerpc/index.rst                    |    1 +
 Documentation/powerpc/vas-api.rst                  |  292 +++++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 arch/powerpc/include/asm/vas.h                     |   13 +-
 arch/powerpc/include/uapi/asm/vas-api.h            |   22 +
 arch/powerpc/platforms/powernv/Makefile            |    2 +-
 arch/powerpc/platforms/powernv/vas-api.c           |  278 +++++
 arch/powerpc/platforms/powernv/vas-window.c        |   23 +-
 arch/powerpc/platforms/powernv/vas.h               |    2 +
 drivers/crypto/nx/Makefile                         |    2 +-
 drivers/crypto/nx/nx-842-powernv.c                 | 1062 ------------------
 drivers/crypto/nx/nx-common-powernv.c              | 1136 ++++++++++++++++++++
 12 files changed, 1761 insertions(+), 1073 deletions(-)
 create mode 100644 Documentation/powerpc/vas-api.rst
 create mode 100644 arch/powerpc/include/uapi/asm/vas-api.h
 create mode 100644 arch/powerpc/platforms/powernv/vas-api.c
 delete mode 100644 drivers/crypto/nx/nx-842-powernv.c
 create mode 100644 drivers/crypto/nx/nx-common-powernv.c

-- 
1.8.3.1



