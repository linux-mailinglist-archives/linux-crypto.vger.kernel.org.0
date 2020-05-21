Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3831DD8B5
	for <lists+linux-crypto@lfdr.de>; Thu, 21 May 2020 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgEUUtE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 21 May 2020 16:49:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgEUUtE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 21 May 2020 16:49:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKlUfJ115683;
        Thu, 21 May 2020 20:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=P5MFO0nMjIobXcB4VC1dpLtWIqlaul0EXeuZjFJVDDM=;
 b=Khr0hmC6F8R5xMLuEZ5B0J5ZhD1ZbbuGeFMWD0J+EjRwNYKRxBbayn4RD99xlmaTyPP/
 IQ80Bgqk6VEOF1DMERx3UvZ/41Bh5c2jyNJXw9UK0WiqqfulDr+U/51BhUGlUKecFcxW
 n55MITjzMBZrPyRDpGnck5TzqVrwS/JEFHo0BfH+WkglmB0VAifFr8o5WpLzxoSiLOKr
 5DmlKqermvTFcWhsbzkyd7otpbHkeLZ4RVCjfjHy87kRSy9eGUSm0JG3l4YJubl7a0kr
 +3LLKEJAH+DQSGQP7HJynlTmFSOdQAQWRkd7AMsQ9JBRAaRPLrTFAkhakY7Nd7k6N9o5 GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rh6kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 20:48:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LKmhNL125879;
        Thu, 21 May 2020 20:48:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj6a5hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 20:48:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LKmqtx023030;
        Thu, 21 May 2020 20:48:52 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 13:48:51 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mathias Krause <minipli@googlemail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [stable-4.9 1/4] padata: set cpu_index of unused CPUs to -1
Date:   Thu, 21 May 2020 16:48:44 -0400
Message-Id: <20200521204847.1953064-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210154
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
index 693536efccf9..52a1d3fd13b5 100644
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

