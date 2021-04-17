Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315D4363258
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Apr 2021 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhDQVHA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 17 Apr 2021 17:07:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231555AbhDQVG7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 17 Apr 2021 17:06:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13HL4iDx011929;
        Sat, 17 Apr 2021 17:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V2Hkp6xflK/b9FbVa15SPgKsx/ofb5qmILbd2TOvQmY=;
 b=JyilqF/v05/ncX41+zXj2unqCtKcvLn3pAlUGAxKAp1fIutcF2L1Zr1KugpVdOSYJKVl
 188veP+DtnWGTewGV4wi+TO/gOapZvW8dVBdEsTgmbDCiU6ZpfsV4bstBBklHISZRKZV
 24kmDs6JOQw/PIo89INGT7dpfhS9QSK5/L9N7Tc8TJAEzGA1XWFNcVvDme2QcVTuyzE2
 CkNIx8Mzk2DwwMP8ENmsXxGzTRBWOZP8q1GGdVrNhTSa5A91OQXrdapgRA2Ufd8O58HX
 C/U2ELRrM/Tz9OlW2hHvDpncFR+bXJeWE/Lwp8taITVnc/31UyFcUWKGGqgMDGPPdM6/ 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3804vnsypy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 17:06:25 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13HL4vs6012208;
        Sat, 17 Apr 2021 17:06:25 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3804vnsypk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 17:06:24 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13HKltZW019223;
        Sat, 17 Apr 2021 21:06:23 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 37yqa85hvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 21:06:23 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13HL6JVK32244124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 21:06:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26148112062;
        Sat, 17 Apr 2021 21:06:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28A44112065;
        Sat, 17 Apr 2021 21:06:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.232.48])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Apr 2021 21:06:18 +0000 (GMT)
Message-ID: <90328d5aa92016434f3061ec7cadc812ea2c5dbc.camel@linux.ibm.com>
Subject: [V3 PATCH 07/16] powerpc/vas: Define QoS credit flag to allocate
 window
From:   Haren Myneni <haren@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        mpe@ellerman.id.au, herbert@gondor.apana.org.au, npiggin@gmail.com
Cc:     hbabu@us.ibm.com, haren@us.ibm.com
Date:   Sat, 17 Apr 2021 14:06:16 -0700
In-Reply-To: <a910e5bd3f3398b4bd430b25a856500735b993c3.camel@linux.ibm.com>
References: <a910e5bd3f3398b4bd430b25a856500735b993c3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gotznsyDV97p2Dpw4KWpSqWxrCUaeI3r
X-Proofpoint-GUID: oYxD0OAwEfpfZ8-OEojTJ8XkBKuW5KHn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_12:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104170152
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


pHyp introduces two different type of credits: Default and Quality
of service (QoS).

The total number of default credits available on each LPAR depends
on CPU resources configured. But these credits can be shared or
over-committed across LPARs in shared mode which can result in
paste command failure (RMA_busy). To avoid NX HW contention, phyp
introduces QoS credit type which makes sure guaranteed access to NX
resources. The system admins can assign QoS credits for each LPAR
via HMC.

Default credit type is used to allocate a VAS window by default as
on powerVM implementation. But the process can pass VAS_WIN_QOS_CREDITS
flag with VAS_TX_WIN_OPEN ioctl to open QoS type window.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/vas-api.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/vas-api.h b/arch/powerpc/include/uapi/asm/vas-api.h
index ebd4b2424785..eb7c8694174f 100644
--- a/arch/powerpc/include/uapi/asm/vas-api.h
+++ b/arch/powerpc/include/uapi/asm/vas-api.h
@@ -13,11 +13,15 @@
 #define VAS_MAGIC	'v'
 #define VAS_TX_WIN_OPEN	_IOW(VAS_MAGIC, 0x20, struct vas_tx_win_open_attr)
 
+/* Flags to VAS TX open window ioctl */
+/* To allocate a window with QoS credit, otherwise default credit is used */
+#define	VAS_WIN_QOS_CREDITS	0x0000000000000001
+
 struct vas_tx_win_open_attr {
 	__u32	version;
 	__s16	vas_id;	/* specific instance of vas or -1 for default */
 	__u16	reserved1;
-	__u64	flags;	/* Future use */
+	__u64	flags;
 	__u64	reserved2[6];
 };
 
-- 
2.18.2


