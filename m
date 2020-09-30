Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85C27E91C
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Sep 2020 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgI3NBe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Sep 2020 09:01:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39346 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3NBc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Sep 2020 09:01:32 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kNbjY-0008WT-BG; Wed, 30 Sep 2020 13:01:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next][resend] lib/mpi: fix off-by-one check on index "no"
Date:   Wed, 30 Sep 2020 14:01:23 +0100
Message-Id: <20200930130123.8064-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an off-by-one range check on the upper limit of
index "no".  Fix this by changing the > comparison to >=

Addresses-Coverity: ("Out-of-bounds read")
Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

resend to Cc linux-crypto

---
 lib/mpi/mpiutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
index 3c63710c20c6..632d0a4bf93f 100644
--- a/lib/mpi/mpiutil.c
+++ b/lib/mpi/mpiutil.c
@@ -69,7 +69,7 @@ postcore_initcall(mpi_init);
  */
 MPI mpi_const(enum gcry_mpi_constants no)
 {
-	if ((int)no < 0 || no > MPI_NUMBER_OF_CONSTANTS)
+	if ((int)no < 0 || no >= MPI_NUMBER_OF_CONSTANTS)
 		pr_err("MPI: invalid mpi_const selector %d\n", no);
 	if (!constants[no])
 		pr_err("MPI: MPI subsystem not initialized\n");
-- 
2.27.0

