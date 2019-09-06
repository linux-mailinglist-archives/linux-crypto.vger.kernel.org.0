Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B250AB050
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Sep 2019 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391931AbfIFBnr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 21:43:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391930AbfIFBnr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 21:43:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861gtxj026350;
        Fri, 6 Sep 2019 01:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=HDJotMfJ0oHz8HxUSu0ZzPbbbnN4HvFLkMPPfdPoerA=;
 b=hEfTsCpsNXnz+zAQqJYpVYeWGNuyVzQPCmabJKEY5tCpsGCRDApx2ePtiEAEnD4rEVIy
 86uV+ahBByb2jbkfSuSSYElCAj49qmOCP0XNHnrSKsRcOHuXuuoxWru81F3rhnD0KgUf
 4qeQ2un87B7oZgjzkSKeJeGMaFkYpfaioQZDVoATVVXnyLorUY6lPLDES5/pRVQzso4e
 BNqcsfx+vw4LIKXDLVINYSg0u+ra6eR/2zw1Aw8d++8xE6ayLAEPKaTILbX/7UcH9y5S
 r42+pIvj7sLhw3W6Lm9WUTGoCr4X/wXDka42aBezveYzXYit+9ofjgwTqJbmeDY6CmTU lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uue1f803f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:43:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861cYW1188431;
        Fri, 6 Sep 2019 01:40:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2utpmc44vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:40:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x861efca021705;
        Fri, 6 Sep 2019 01:40:41 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 18:40:40 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 4/9] padata: make padata_do_parallel find alternate callback CPU
Date:   Thu,  5 Sep 2019 21:40:24 -0400
Message-Id: <20190906014029.3345-5-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906014029.3345-1-daniel.m.jordan@oracle.com>
References: <20190906014029.3345-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060016
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

padata_do_parallel currently returns -EINVAL if the callback CPU isn't
in the callback cpumask.

pcrypt tries to prevent this situation by keeping its own callback
cpumask in sync with padata's and checks that the callback CPU it passes
to padata is valid.  Make padata handle this instead.

padata_do_parallel now takes a pointer to the callback CPU and updates
it for the caller if an alternate CPU is used.  Overall behavior in
terms of which callback CPUs are chosen stays the same.

Prepares for removal of the padata cpumask notifier in pcrypt, which
will fix a lockdep complaint about nested acquisition of the CPU hotplug
lock later in the series.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 crypto/pcrypt.c        | 33 ++-------------------------------
 include/linux/padata.h |  2 +-
 kernel/padata.c        | 27 ++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index d67293063c7f..efca962ab12a 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -57,35 +57,6 @@ struct pcrypt_aead_ctx {
 	unsigned int cb_cpu;
 };
 
-static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
-			      struct padata_pcrypt *pcrypt)
-{
-	unsigned int cpu_index, cpu, i;
-	struct pcrypt_cpumask *cpumask;
-
-	cpu = *cb_cpu;
-
-	rcu_read_lock_bh();
-	cpumask = rcu_dereference_bh(pcrypt->cb_cpumask);
-	if (cpumask_test_cpu(cpu, cpumask->mask))
-			goto out;
-
-	if (!cpumask_weight(cpumask->mask))
-			goto out;
-
-	cpu_index = cpu % cpumask_weight(cpumask->mask);
-
-	cpu = cpumask_first(cpumask->mask);
-	for (i = 0; i < cpu_index; i++)
-		cpu = cpumask_next(cpu, cpumask->mask);
-
-	*cb_cpu = cpu;
-
-out:
-	rcu_read_unlock_bh();
-	return padata_do_parallel(pcrypt->pinst, padata, cpu);
-}
-
 static int pcrypt_aead_setkey(struct crypto_aead *parent,
 			      const u8 *key, unsigned int keylen)
 {
@@ -157,7 +128,7 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 			       req->cryptlen, req->iv);
 	aead_request_set_ad(creq, req->assoclen);
 
-	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pencrypt);
+	err = padata_do_parallel(pencrypt.pinst, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
 
@@ -199,7 +170,7 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 			       req->cryptlen, req->iv);
 	aead_request_set_ad(creq, req->assoclen);
 
-	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pdecrypt);
+	err = padata_do_parallel(pdecrypt.pinst, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
 
diff --git a/include/linux/padata.h b/include/linux/padata.h
index 839d9319920a..f7851f8e2190 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -154,7 +154,7 @@ struct padata_instance {
 extern struct padata_instance *padata_alloc_possible(const char *name);
 extern void padata_free(struct padata_instance *pinst);
 extern int padata_do_parallel(struct padata_instance *pinst,
-			      struct padata_priv *padata, int cb_cpu);
+			      struct padata_priv *padata, int *cb_cpu);
 extern void padata_do_serial(struct padata_priv *padata);
 extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 			      cpumask_var_t cpumask);
diff --git a/kernel/padata.c b/kernel/padata.c
index 58728cd7f40c..9a17922ec436 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -94,17 +94,19 @@ static void padata_parallel_worker(struct work_struct *parallel_work)
  *
  * @pinst: padata instance
  * @padata: object to be parallelized
- * @cb_cpu: cpu the serialization callback function will run on,
- *          must be in the serial cpumask of padata(i.e. cpumask.cbcpu).
+ * @cb_cpu: pointer to the CPU that the serialization callback function should
+ *          run on.  If it's not in the serial cpumask of @pinst
+ *          (i.e. cpumask.cbcpu), this function selects a fallback CPU and if
+ *          none found, returns -EINVAL.
  *
  * The parallelization callback function will run with BHs off.
  * Note: Every object which is parallelized by padata_do_parallel
  * must be seen by padata_do_serial.
  */
 int padata_do_parallel(struct padata_instance *pinst,
-		       struct padata_priv *padata, int cb_cpu)
+		       struct padata_priv *padata, int *cb_cpu)
 {
-	int target_cpu, err;
+	int i, cpu, cpu_index, target_cpu, err;
 	struct padata_parallel_queue *queue;
 	struct parallel_data *pd;
 
@@ -116,8 +118,19 @@ int padata_do_parallel(struct padata_instance *pinst,
 	if (!(pinst->flags & PADATA_INIT) || pinst->flags & PADATA_INVALID)
 		goto out;
 
-	if (!cpumask_test_cpu(cb_cpu, pd->cpumask.cbcpu))
-		goto out;
+	if (!cpumask_test_cpu(*cb_cpu, pd->cpumask.cbcpu)) {
+		if (!cpumask_weight(pd->cpumask.cbcpu))
+			goto out;
+
+		/* Select an alternate fallback CPU and notify the caller. */
+		cpu_index = *cb_cpu % cpumask_weight(pd->cpumask.cbcpu);
+
+		cpu = cpumask_first(pd->cpumask.cbcpu);
+		for (i = 0; i < cpu_index; i++)
+			cpu = cpumask_next(cpu, pd->cpumask.cbcpu);
+
+		*cb_cpu = cpu;
+	}
 
 	err =  -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
@@ -129,7 +142,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 	err = 0;
 	atomic_inc(&pd->refcnt);
 	padata->pd = pd;
-	padata->cb_cpu = cb_cpu;
+	padata->cb_cpu = *cb_cpu;
 
 	target_cpu = padata_cpu_hash(pd);
 	padata->cpu = target_cpu;
-- 
2.23.0

