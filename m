Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68AA1DD8C9
	for <lists+linux-crypto@lfdr.de>; Thu, 21 May 2020 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgEUUtT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 21 May 2020 16:49:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbgEUUtS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 21 May 2020 16:49:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKltuA116407;
        Thu, 21 May 2020 20:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=xDe/pW6X4soZd0XpBlU40tPwy743kldPD8/AVUiNJRc=;
 b=NkGEoDaecc9Qei+OqUnu1HrtjwBNVZAV6Yi9bVltWiMM5/h+0kDaJ2a4WJa4qwiUg2i7
 JKkbpVcImT3C34Nj0m46/vwCbcRItJ3MTg3gwZGjefS+OzT/xpT5u1Y5iPkPWmgD3IQY
 lipJSSGmlKHyJHzIYfWBy+e7FcwA6udFLrMaqnf2s4NiqV1OpOIOQtlV5NaSkQwYzwSD
 +DJLgN0oRlsrL0mLoKSn+pwpbva4F0DG/uVWykTgMNsezSNWuR3SVtjVOHfTXesVjeWb
 NeCc7NjPjeemhTe3nJRKEqFcPd8D5yOFvhrBTor91lSk0R8w8355lh+JV0IWAICZI2g7 DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31501rh6m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 20:49:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKhEUU072775;
        Thu, 21 May 2020 20:47:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 312t3can5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 20:47:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LKl2P0028354;
        Thu, 21 May 2020 20:47:03 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 13:47:02 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mathias Krause <minipli@googlemail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [stable-4.14 1/4] padata: set cpu_index of unused CPUs to -1
Date:   Thu, 21 May 2020 16:46:55 -0400
Message-Id: <20200521204658.1952777-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210154
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>

[ Upstream commit 1bd845bcb41d5b7f83745e0cb99273eb376f2ec5 ]

The parallel queue per-cpu data structure gets initialized only for CPUs
in the 'pcpu' CPU mask set. This is not sufficient as the reorder timer
may run on a different CPU and might wrongly decide it's the target CPU
for the next reorder item as per-cpu memory gets memset(0) and we might
be waiting for the first CPU in cpumask.pcpu, i.e. cpu_index 0.

Make the '__this_cpu_read(pd->pqueue->cpu_index) == next_queue->cpu_index'
compare in padata_get_next() fail in this case by initializing the
cpu_index member of all per-cpu parallel queues. Use -1 for unused ones.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/padata.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 40a0ebb8ea51..858e82179744 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -462,8 +462,14 @@ static void padata_init_pqueues(struct parallel_data *pd)
 	struct padata_parallel_queue *pqueue;
 
 	cpu_index = 0;
-	for_each_cpu(cpu, pd->cpumask.pcpu) {
+	for_each_possible_cpu(cpu) {
 		pqueue = per_cpu_ptr(pd->pqueue, cpu);
+
+		if (!cpumask_test_cpu(cpu, pd->cpumask.pcpu)) {
+			pqueue->cpu_index = -1;
+			continue;
+		}
+
 		pqueue->pd = pd;
 		pqueue->cpu_index = cpu_index;
 		cpu_index++;
-- 
2.26.2

