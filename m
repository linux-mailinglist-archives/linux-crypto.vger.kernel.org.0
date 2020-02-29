Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6A174659
	for <lists+linux-crypto@lfdr.de>; Sat, 29 Feb 2020 12:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgB2LFj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 29 Feb 2020 06:05:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgB2LFj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 29 Feb 2020 06:05:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01TAxUmX073420;
        Sat, 29 Feb 2020 06:05:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfk5hv97b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 06:05:24 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01TAxTMK073403;
        Sat, 29 Feb 2020 06:05:24 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfk5hv96t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 06:05:23 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01TB58g6009198;
        Sat, 29 Feb 2020 11:05:22 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 2yffk6297q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 11:05:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01TB5Mhv46399976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 11:05:22 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67290112062;
        Sat, 29 Feb 2020 11:05:22 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC71112061;
        Sat, 29 Feb 2020 11:05:21 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 29 Feb 2020 11:05:21 +0000 (GMT)
Subject: [PATCH V2 0/9] crypto/nx: Enable GZIP engine and provide userpace
 API
From:   Haren Myneni <haren@linux.ibm.com>
To:     herbert@gondor.apana.org.au, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        npiggin@gmail.com, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 29 Feb 2020 03:04:26 -0800
Message-ID: <1582974266.18705.28.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-29_03:2020-02-28,2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290086
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
vas_tx_win_open_attr), kernel determins the VAS instance on the
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
  
Haren Myneni (9):
  powerpc/vas: Initialize window attributes for GZIP coprocessor type
  powerpc/vas: Define VAS_TX_WIN_OPEN ioctl API
  powerpc/vas: Add VAS user space API
  crypto/nx: Initialize coproc entry with kzalloc
  crypto/nx: Rename nx-842-powernv file name to nx-common-powernv
  crypto/NX: Make enable code generic to add new GZIP compression type
  crypto/nx: Enable and setup GZIP compresstion type
  crypto/nx: Remove 'pid' in vas_tx_win_attr struct
  Documentation/powerpc: VAS API

 Documentation/powerpc/index.rst                    |    1 +
 Documentation/powerpc/vas-api.rst                  |  246 +++++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 arch/powerpc/include/asm/vas.h                     |   12 +-
 arch/powerpc/include/uapi/asm/vas-api.h            |   22 +
 arch/powerpc/platforms/powernv/Makefile            |    2 +-
 arch/powerpc/platforms/powernv/vas-api.c           |  290 +++++
 arch/powerpc/platforms/powernv/vas-window.c        |   23 +-
 arch/powerpc/platforms/powernv/vas.h               |    2 +
 drivers/crypto/nx/Makefile                         |    2 +-
 drivers/crypto/nx/nx-842-powernv.c                 | 1062 ------------------
 drivers/crypto/nx/nx-common-powernv.c              | 1133 ++++++++++++++++++++
 12 files changed, 1723 insertions(+), 1073 deletions(-)
 create mode 100644 Documentation/powerpc/vas-api.rst
 create mode 100644 arch/powerpc/include/uapi/asm/vas-api.h
 create mode 100644 arch/powerpc/platforms/powernv/vas-api.c
 delete mode 100644 drivers/crypto/nx/nx-842-powernv.c
 create mode 100644 drivers/crypto/nx/nx-common-powernv.c

-- 
1.8.3.1



