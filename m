Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E115E784
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Feb 2020 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404844AbgBNQSq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Feb 2020 11:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404840AbgBNQSp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8442470C;
        Fri, 14 Feb 2020 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697124;
        bh=mHRN/U1+jT2UN4sOMP6Pwo7RNbjCocslk1nYHOW6ipk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2BI+pPBCRAZe9aGOhbQsskM1XZ2t9QsJuGXksUgXwb4pTE4/wv1myAb8beVqWIZa
         by3ognkRwZT3WHSlebO7QXIvT+3A4jY1pHptg06A5xcJWnhb8lXfPXt+Tx27ZAxdoT
         jjwcpRXSpkmoiu4L1TU19nQY6ZZeq6tvcQwOYo9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 069/186] padata: always acquire cpu_hotplug_lock before pinst->lock
Date:   Fri, 14 Feb 2020 11:15:18 -0500
Message-Id: <20200214161715.18113-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

[ Upstream commit 38228e8848cd7dd86ccb90406af32de0cad24be3 ]

lockdep complains when padata's paths to update cpumasks via CPU hotplug
and sysfs are both taken:

  # echo 0 > /sys/devices/system/cpu/cpu1/online
  # echo ff > /sys/kernel/pcrypt/pencrypt/parallel_cpumask

  ======================================================
  WARNING: possible circular locking dependency detected
  5.4.0-rc8-padata-cpuhp-v3+ #1 Not tainted
  ------------------------------------------------------
  bash/205 is trying to acquire lock:
  ffffffff8286bcd0 (cpu_hotplug_lock.rw_sem){++++}, at: padata_set_cpumask+0x2b/0x120

  but task is already holding lock:
  ffff8880001abfa0 (&pinst->lock){+.+.}, at: padata_set_cpumask+0x26/0x120

  which lock already depends on the new lock.

padata doesn't take cpu_hotplug_lock and pinst->lock in a consistent
order.  Which should be first?  CPU hotplug calls into padata with
cpu_hotplug_lock already held, so it should have priority.

Fixes: 6751fb3c0e0c ("padata: Use get_online_cpus/put_online_cpus")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 87540ce72aea6..40aea129a76d9 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -626,8 +626,8 @@ int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 	struct cpumask *serial_mask, *parallel_mask;
 	int err = -EINVAL;
 
-	mutex_lock(&pinst->lock);
 	get_online_cpus();
+	mutex_lock(&pinst->lock);
 
 	switch (cpumask_type) {
 	case PADATA_CPU_PARALLEL:
@@ -645,8 +645,8 @@ int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 	err =  __padata_set_cpumasks(pinst, parallel_mask, serial_mask);
 
 out:
-	put_online_cpus();
 	mutex_unlock(&pinst->lock);
+	put_online_cpus();
 
 	return err;
 }
-- 
2.20.1

