Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5342B1DBCD9
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2020 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgETS2O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 May 2020 14:28:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58644 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETS2N (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 May 2020 14:28:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KIHRpm000781;
        Wed, 20 May 2020 18:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jCJIf2wmiDSS+BjtUDA+ZMjI+y7yIcmsNXeQVwW/Xag=;
 b=x5LSs/4ijZLCMnuICsPpuDDbTx4yAJ7NkaxrnkWI9TPHmcBX62mo6sL8dHRaXxzLhRi/
 MUajNfN96/ikt9Whx1H3v5dWpP9hvXoUpY+eP7n2PEvQMOD4xceHvw/uAsLa6UP6/XHr
 ympP6PF3g7EVPonCaqo8RI5UrhNrzxVL9ckPBo1raknaIOAhZG7uYdEnvCsIKtYi6ccM
 7vdryTK6ZS4qSN/X0iJlmiJhUHLyfqD6mKnX0ttiRGCpZgF0gRi2QvyuTtxlHsR73KeV
 7oOHt5FfU7G+Kki8B5SZaMtx0dXjormuQj2mv2ffGHRcwNLGD6+p0iFFoafpoq8DPKK4 kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rb8a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 18:27:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KICdqQ014999;
        Wed, 20 May 2020 18:27:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 313gj3yth8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 18:27:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KIR64p016486;
        Wed, 20 May 2020 18:27:06 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 11:27:06 -0700
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
        Robert Elliott <elliott@hpe.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-crypto@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 6/7] mm: make deferred init's max threads arch-specific
Date:   Wed, 20 May 2020 14:26:44 -0400
Message-Id: <20200520182645.1658949-7-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=2 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200148
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Using padata during deferred init has only been tested on x86, so for
now limit it to this architecture.

If another arch wants this, it can find the max thread limit that's best
for it and override deferred_page_init_max_threads().

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/x86/mm/init_64.c    | 12 ++++++++++++
 include/linux/memblock.h |  3 +++
 mm/page_alloc.c          | 13 ++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b5f73f5e207c..2d749ec12ea8a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1260,6 +1260,18 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
+{
+	/*
+	 * More CPUs always led to greater speedups on tested systems, up to
+	 * all the nodes' CPUs.  Use all since the system is otherwise idle
+	 * now.
+	 */
+	return max_t(int, cpumask_weight(node_cpumask), 1);
+}
+#endif
+
 int kernel_set_to_readonly;
 
 void mark_rodata_ro(void)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6bc37a731d27b..2b289df44194f 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -275,6 +275,9 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 #define for_each_free_mem_pfn_range_in_zone_from(i, zone, p_start, p_end) \
 	for (; i != U64_MAX;					  \
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
+
+int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
+
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9cb780e8dec78..0d7d805f98b2d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1843,6 +1843,13 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	atomic_long_add(nr_pages, &args->nr_pages);
 }
 
+/* An arch may override for more concurrency. */
+__weak int __init
+deferred_page_init_max_threads(const struct cpumask *node_cpumask)
+{
+	return 1;
+}
+
 /* Initialise remaining memory on a node */
 static int __init deferred_init_memmap(void *data)
 {
@@ -1891,11 +1898,7 @@ static int __init deferred_init_memmap(void *data)
 						 first_init_pfn))
 		goto zone_empty;
 
-	/*
-	 * More CPUs always led to greater speedups on tested systems, up to
-	 * all the nodes' CPUs.  Use all since the system is otherwise idle now.
-	 */
-	max_threads = max(cpumask_weight(cpumask), 1u);
+	max_threads = deferred_page_init_max_threads(cpumask);
 
 	while (spfn < epfn) {
 		epfn_align = ALIGN_DOWN(epfn, PAGES_PER_SECTION);
-- 
2.26.2

