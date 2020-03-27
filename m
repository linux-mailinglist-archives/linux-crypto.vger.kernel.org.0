Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521BD195D5B
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2020 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0SQk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Mar 2020 14:16:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgC0SQk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Mar 2020 14:16:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RI3iNn058488;
        Fri, 27 Mar 2020 14:16:26 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywd8h6e8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 14:16:25 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02RI1bdj013238;
        Fri, 27 Mar 2020 18:16:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ywawnc7mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 18:16:24 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RIGOO641746788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 18:16:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51251AE064;
        Fri, 27 Mar 2020 18:16:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE88AE05C;
        Fri, 27 Mar 2020 18:16:23 +0000 (GMT)
Received: from localhost (unknown [9.85.130.3])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 18:16:23 +0000 (GMT)
From:   Raphael Moreira Zinsly <rzinsly@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, mpe@ellerman.id.au,
        haren@linux.ibm.com, abali@us.ibm.com, dja@axtens.net
Subject: [PATCH V2 0/5] selftests/powerpc: Add NX-GZIP engine testcase  
Date:   Fri, 27 Mar 2020 15:16:06 -0300
Message-Id: <20200327181610.13762-1-rzinsly@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_06:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=910 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270152
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch series are intended to test the POWER9 Nest
Accelerator (NX) GZIP engine that is being introduced by
https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-March/205659.html
More information about how to access the NX can be found in that patch, also a
complete userspace library and more documentation can be found at:
https://github.com/libnxz/power-gzip

Changes in V2:
	- Fixed errors and warnings caught by scripts/checkpatch.pl, including
	  line breaks inside strings.
	- Fixed infinite loop and out-of-boundaries writing found by Daniel
	  Axtens.

Best regards,
Raphael

