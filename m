Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956DF1C07A0
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgD3UOM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Apr 2020 16:14:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgD3UOL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Apr 2020 16:14:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UKDVRZ025753;
        Thu, 30 Apr 2020 20:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=bsNo9rsQ3aFck0kh92tJlakAeF2BagCrvsBcqBZwAXg=;
 b=fLKeMtx3d59+jUCFA69Ged5Iax+Lk7YDP+/H16X+U6ar7kDa35CHuJB5q3KYZUsrGwNs
 ZM3SAAuBuLK2jqKQDCEctzNp80jL4ETebv0BNyMSIK3ziws/Zw7V+OWaQX3ORSqLZs3v
 G8DqzqN8LvqWMteRd3Wqe599GzHysnr8FDVD2wqLgM3n0huFVAppZo5KyBnVA/39oXHN
 0CDFE9jQ++TbvRonp4OclcuUb0MIeDF+yBTilRTh5Nd9nYRpwt6JUVlixNwl6vcXhkTC
 OAMPLcmjyo7q+ZZak7Y6w3Cnlr8oZBu4bV2gcvFWhc/0NQ8CV/E8LftDZoc63gzO+/OO AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30p01p45je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 20:13:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03UK6tei001625;
        Thu, 30 Apr 2020 20:11:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30qtf8fyjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 20:11:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03UKBdFS002226;
        Thu, 30 Apr 2020 20:11:39 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 13:11:39 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-crypto@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 4/7] padata: add basic support for multithreaded jobs
Date:   Thu, 30 Apr 2020 16:11:22 -0400
Message-Id: <20200430201125.532129-5-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430201125.532129-1-daniel.m.jordan@oracle.com>
References: <20200430201125.532129-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=2 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300151
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Sometimes the kernel doesn't take full advantage of system memory
bandwidth, leading to a single CPU spending excessive time in
initialization paths where the data scales with memory size.

Multithreading naturally addresses this problem.

Extend padata, a framework that handles many parallel yet singlethreaded
jobs, to also handle multithreaded jobs by adding support for splitting
up the work evenly, specifying a minimum amount of work that's
appropriate for one helper thread to do, load balancing between helpers,
and coordinating them.

This is inspired by work from Pavel Tatashin and Steve Sistare.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/padata.h |  29 ++++++++
 kernel/padata.c        | 152 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 3 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 3bfa503503ac5..b0affa466a841 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 2008, 2009 secunet Security Networks AG
  * Copyright (C) 2008, 2009 Steffen Klassert <steffen.klassert@secunet.com>
+ *
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ * Author: Daniel Jordan <daniel.m.jordan@oracle.com>
  */
 
 #ifndef PADATA_H
@@ -130,6 +133,31 @@ struct padata_shell {
 	struct list_head		list;
 };
 
+/**
+ * struct padata_mt_job - represents one multithreaded job
+ *
+ * @thread_fn: Called for each chunk of work that a padata thread does.
+ * @fn_arg: The thread function argument.
+ * @start: The start of the job (units are job-specific).
+ * @size: size of this node's work (units are job-specific).
+ * @align: Ranges passed to the thread function fall on this boundary, with the
+ *         possible exceptions of the beginning and end of the job.
+ * @min_chunk: The minimum chunk size in job-specific units.  This allows
+ *             the client to communicate the minimum amount of work that's
+ *             appropriate for one worker thread to do at once.
+ * @max_threads: Max threads to use for the job, actual number may be less
+ *               depending on task size and minimum chunk size.
+ */
+struct padata_mt_job {
+	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
+	void			*fn_arg;
+	unsigned long		start;
+	unsigned long		size;
+	unsigned long		align;
+	unsigned long		min_chunk;
+	int			max_threads;
+};
+
 /**
  * struct padata_instance - The overall control structure.
  *
@@ -171,6 +199,7 @@ extern void padata_free_shell(struct padata_shell *ps);
 extern int padata_do_parallel(struct padata_shell *ps,
 			      struct padata_priv *padata, int *cb_cpu);
 extern void padata_do_serial(struct padata_priv *padata);
+extern void __init padata_do_multithreaded(struct padata_mt_job *job);
 extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 			      cpumask_var_t cpumask);
 extern int padata_start(struct padata_instance *pinst);
diff --git a/kernel/padata.c b/kernel/padata.c
index edd3ff551e262..ccb617d37677a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -7,6 +7,9 @@
  * Copyright (C) 2008, 2009 secunet Security Networks AG
  * Copyright (C) 2008, 2009 Steffen Klassert <steffen.klassert@secunet.com>
  *
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ * Author: Daniel Jordan <daniel.m.jordan@oracle.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -21,6 +24,7 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <linux/completion.h>
 #include <linux/export.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
@@ -32,6 +36,8 @@
 #include <linux/sysfs.h>
 #include <linux/rcupdate.h>
 
+#define	PADATA_WORK_ONSTACK	1	/* Work's memory is on stack */
+
 struct padata_work {
 	struct work_struct	pw_work;
 	struct list_head	pw_list;  /* padata_free_works linkage */
@@ -42,7 +48,17 @@ static DEFINE_SPINLOCK(padata_works_lock);
 static struct padata_work *padata_works;
 static LIST_HEAD(padata_free_works);
 
+struct padata_mt_job_state {
+	spinlock_t		lock;
+	struct completion	completion;
+	struct padata_mt_job	*job;
+	int			nworks;
+	int			nworks_fini;
+	unsigned long		chunk_size;
+};
+
 static void padata_free_pd(struct parallel_data *pd);
+static void __init padata_mt_helper(struct work_struct *work);
 
 static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
 {
@@ -81,18 +97,56 @@ static struct padata_work *padata_work_alloc(void)
 }
 
 static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
-			     void *data)
+			     void *data, int flags)
 {
-	INIT_WORK(&pw->pw_work, work_fn);
+	if (flags & PADATA_WORK_ONSTACK)
+		INIT_WORK_ONSTACK(&pw->pw_work, work_fn);
+	else
+		INIT_WORK(&pw->pw_work, work_fn);
 	pw->pw_data = data;
 }
 
+static int __init padata_work_alloc_mt(int nworks, void *data,
+				       struct list_head *head)
+{
+	int i;
+
+	spin_lock(&padata_works_lock);
+	/* Start at 1 because the current task participates in the job. */
+	for (i = 1; i < nworks; ++i) {
+		struct padata_work *pw = padata_work_alloc();
+
+		if (!pw)
+			break;
+		padata_work_init(pw, padata_mt_helper, data, 0);
+		list_add(&pw->pw_list, head);
+	}
+	spin_unlock(&padata_works_lock);
+
+	return i;
+}
+
 static void padata_work_free(struct padata_work *pw)
 {
 	lockdep_assert_held(&padata_works_lock);
 	list_add(&pw->pw_list, &padata_free_works);
 }
 
+static void __init padata_works_free(struct list_head *works)
+{
+	struct padata_work *cur, *next;
+
+	if (list_empty(works))
+		return;
+
+	spin_lock(&padata_works_lock);
+	list_for_each_entry_safe(cur, next, works, pw_list) {
+		list_del(&cur->pw_list);
+		padata_work_free(cur);
+	}
+	spin_unlock(&padata_works_lock);
+}
+
 static void padata_parallel_worker(struct work_struct *parallel_work)
 {
 	struct padata_work *pw = container_of(parallel_work, struct padata_work,
@@ -168,7 +222,7 @@ int padata_do_parallel(struct padata_shell *ps,
 	pw = padata_work_alloc();
 	spin_unlock(&padata_works_lock);
 	if (pw) {
-		padata_work_init(pw, padata_parallel_worker, padata);
+		padata_work_init(pw, padata_parallel_worker, padata, 0);
 		queue_work(pinst->parallel_wq, &pw->pw_work);
 	} else {
 		/* Maximum works limit exceeded, run in the current task. */
@@ -409,6 +463,98 @@ static int pd_setup_cpumasks(struct parallel_data *pd,
 	return err;
 }
 
+static void __init padata_mt_helper(struct work_struct *w)
+{
+	struct padata_work *pw = container_of(w, struct padata_work, pw_work);
+	struct padata_mt_job_state *ps = pw->pw_data;
+	struct padata_mt_job *job = ps->job;
+	bool done;
+
+	spin_lock(&ps->lock);
+
+	while (job->size > 0) {
+		unsigned long start, size, end;
+
+		start = job->start;
+		/* So end is chunk size aligned if enough work remains. */
+		size = roundup(start + 1, ps->chunk_size) - start;
+		size = min(size, job->size);
+		end = start + size;
+
+		job->start = end;
+		job->size -= size;
+
+		spin_unlock(&ps->lock);
+		job->thread_fn(start, end, job->fn_arg);
+		spin_lock(&ps->lock);
+	}
+
+	++ps->nworks_fini;
+	done = (ps->nworks_fini == ps->nworks);
+	spin_unlock(&ps->lock);
+
+	if (done)
+		complete(&ps->completion);
+}
+
+/**
+ * padata_do_multithreaded - run a multithreaded job
+ * @job: Description of the job.
+ *
+ * See the definition of struct padata_mt_job for more details.
+ */
+void __init padata_do_multithreaded(struct padata_mt_job *job)
+{
+	/* In case threads finish at different times. */
+	static const unsigned long load_balance_factor = 4;
+	struct padata_work my_work, *pw;
+	struct padata_mt_job_state ps;
+	LIST_HEAD(works);
+	int nworks;
+
+	if (job->size == 0)
+		return;
+
+	/* Ensure at least one thread when size < min_chunk. */
+	nworks = max(job->size / job->min_chunk, 1ul);
+	nworks = min(nworks, job->max_threads);
+
+	if (nworks == 1) {
+		/* Single thread, no coordination needed, cut to the chase. */
+		job->thread_fn(job->start, job->start + job->size, job->fn_arg);
+		return;
+	}
+
+	spin_lock_init(&ps.lock);
+	init_completion(&ps.completion);
+	ps.job	       = job;
+	ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
+	ps.nworks_fini = 0;
+
+	/*
+	 * Chunk size is the amount of work a helper does per call to the
+	 * thread function.  Load balance large jobs between threads by
+	 * increasing the number of chunks, guarantee at least the minimum
+	 * chunk size from the caller, and honor the caller's alignment.
+	 */
+	ps.chunk_size = job->size / (ps.nworks * load_balance_factor);
+	ps.chunk_size = max(ps.chunk_size, job->min_chunk);
+	ps.chunk_size = roundup(ps.chunk_size, job->align);
+
+	list_for_each_entry(pw, &works, pw_list)
+		queue_work(system_unbound_wq, &pw->pw_work);
+
+	/* Use the current thread, which saves starting a workqueue worker. */
+	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
+	padata_mt_helper(&my_work.pw_work);
+
+	/* Wait for all the helpers to finish. */
+	wait_for_completion(&ps.completion);
+
+	destroy_work_on_stack(&my_work.pw_work);
+	padata_works_free(&works);
+}
+
 static void __padata_list_init(struct padata_list *pd_list)
 {
 	INIT_LIST_HEAD(&pd_list->list);
-- 
2.26.2

