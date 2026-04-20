Return-Path: <linux-crypto+bounces-23270-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDZvHrxu5mmBwAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23270-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 20:21:48 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B016432BC7
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 20:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A86C3014878
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0D3803FD;
	Mon, 20 Apr 2026 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qACMxoN4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01323A0E97;
	Mon, 20 Apr 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709305; cv=none; b=SSRVoAUQtg6sThAxrPz5fwog9BtJc0U5nj8PDy+e5rggbhaZj+xqwNulA0kde1STRGQgBLUIJo0VyQrWA4ard71dJgdUTvUaC6q+x1Q7Mlox5yn/hQoIheo2CFJNY5maooTYrRTRy3lvHzfztlMHRacee7DD7GVZ/XCN8H0ZudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709305; c=relaxed/simple;
	bh=zCeKjbXoTI6kRJfbuAWC3zZGhUWlZwENSYzIegLsots=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoilezZ0loonLkxge8MMYNe9HQgqnXEazxSJWoI8D/D0Fp8BixMDqcKsKjht6aNKf2VyNwqAmCC186Mwd5cIAg8N906OHiSOoOyzGu/lLlX5Efw8UTzsA2rmU6ULaUifqWHYrRs2Ystb8gpDZiRr2KZ7zcjOUElO3GIsYHRimZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qACMxoN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F9C19425;
	Mon, 20 Apr 2026 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776709305;
	bh=zCeKjbXoTI6kRJfbuAWC3zZGhUWlZwENSYzIegLsots=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qACMxoN4aYV/2q841hxDi4EXfaqonP1MOgNQ2LZgKO6XKVqkNn6Rp1NdIYhFGxGiP
	 d0fPF/Gw/JlQRWzJJ9ry/jJN2VgDJw2isoRu8JnUfurjhcy3yN6MNIwt+breG7ZmtV
	 Cmd7L5//5NeQI0Y0/fVLXCpxUco8EI+Hhp8rWNcXoq7ujOmZiiM4eyG79moM9mbnoC
	 VcVDohnvq/yhRPgm9Ddxm5fFd+XocCcRhAPlAfyu7k5dS0KasU8bb3C6i2zDpN3yL4
	 DLlfNDgLFzUCMBKhrCdUo4LPqn/xqsG9hlskDRxxPpsGUZP/xgSO3QkPaBvok8VdT2
	 KxTQDdBmq0rpg==
From: Tejun Heo <tj@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] rhashtable: Bounce deferred worker kick through irq_work
Date: Mon, 20 Apr 2026 08:12:58 -1000
Message-ID: <4ff731fc-3791-4b96-a997-89c3bcd2d69b@kernel.org>
In-Reply-To: <67fedbf2-914b-44f7-9422-1fe97d833705@kernel.org>
References: <67fedbf2-914b-44f7-9422-1fe97d833705@kernel.org>
 <aeXnak9Yl84a-kho@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23270-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B016432BC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Inserts past 75% load call schedule_work(&ht->run_work) to kick an
async resize. If a caller holds a raw spinlock (e.g. an
insecure_elasticity user), schedule_work() under that lock records

  caller_lock -> pool->lock -> pi_lock -> rq->__lock

A cycle forms if any of these locks is acquired in the reverse
direction elsewhere. sched_ext, the only current insecure_elasticity
user, hits this: it holds scx_sched_lock across rhashtable inserts of
sub-schedulers, while scx_bypass() takes rq->__lock -> scx_sched_lock.
Exercising the resize path produces:

  Chain exists of:
    &pool->lock --> &rq->__lock --> scx_sched_lock

Route the kick unconditionally through irq_work so schedule_work() runs
from hard IRQ context with the caller's lock no longer held.

v2: bounce unconditionally instead of gating on insecure_elasticity, as
    suggested by Herbert.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Herbert, any preference on how this should be routed?

Thanks.

 include/linux/rhashtable-types.h |  3 +++
 include/linux/rhashtable.h       |  3 ++-
 lib/rhashtable.c                 | 24 ++++++++++++++++++++----
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 72082428d6c6..fc2f596a6df1 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -12,6 +12,7 @@
 #include <linux/alloc_tag.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
+#include <linux/irq_work_types.h>
 #include <linux/mutex.h>
 #include <linux/workqueue_types.h>

@@ -77,6 +78,7 @@ struct rhashtable_params {
  * @p: Configuration parameters
  * @rhlist: True if this is an rhltable
  * @run_work: Deferred worker to expand/shrink asynchronously
+ * @run_irq_work: Bounces the @run_work kick through hard IRQ context.
  * @mutex: Mutex to protect current/future table swapping
  * @lock: Spin lock to protect walker list
  * @nelems: Number of elements in table
@@ -88,6 +90,7 @@ struct rhashtable_params {
 	struct rhashtable_params	p;
 	bool				rhlist;
 	struct work_struct		run_work;
+	struct irq_work			run_irq_work;
 	struct mutex                    mutex;
 	spinlock_t			lock;
 	atomic_t			nelems;
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 7def3f0f556b..ef5230cece36 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -20,6 +20,7 @@

 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/irq_work.h>
 #include <linux/jhash.h>
 #include <linux/list_nulls.h>
 #include <linux/workqueue.h>
@@ -847,7 +848,7 @@ static __always_inline void *__rhashtable_insert_fast(
 	rht_assign_unlock(tbl, bkt, obj, flags);

 	if (rht_grow_above_75(ht, tbl))
-		schedule_work(&ht->run_work);
+		irq_work_queue(&ht->run_irq_work);

 	data = NULL;
 out:
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index fb2b7bc137ba..218d3c1f34fb 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -442,7 +442,21 @@ static void rht_deferred_worker(struct work_struct *work)
 	mutex_unlock(&ht->mutex);

 	if (err)
-		schedule_work(&ht->run_work);
+		irq_work_queue(&ht->run_irq_work);
+}
+
+/*
+ * rhashtable can be used under raw spinlocks. Calling schedule_work()
+ * from such context can close a locking cycle through workqueue and
+ * scheduler locks. Bounce through irq_work so the schedule_work() runs
+ * from hard IRQ context with the caller's lock no longer held.
+ */
+static void rht_deferred_irq_work(struct irq_work *irq_work)
+{
+	struct rhashtable *ht = container_of(irq_work, struct rhashtable,
+					     run_irq_work);
+
+	schedule_work(&ht->run_work);
 }

 static int rhashtable_insert_rehash(struct rhashtable *ht,
@@ -477,7 +491,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 		if (err == -EEXIST)
 			err = 0;
 	} else
-		schedule_work(&ht->run_work);
+		irq_work_queue(&ht->run_irq_work);

 	return err;

@@ -488,7 +502,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,

 	/* Schedule async rehash to retry allocation in process context. */
 	if (err == -ENOMEM)
-		schedule_work(&ht->run_work);
+		irq_work_queue(&ht->run_irq_work);

 	return err;
 }
@@ -630,7 +644,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			rht_unlock(tbl, bkt, flags);

 			if (inserted && rht_grow_above_75(ht, tbl))
-				schedule_work(&ht->run_work);
+				irq_work_queue(&ht->run_irq_work);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));

@@ -1085,6 +1099,7 @@ int rhashtable_init_noprof(struct rhashtable *ht,
 	RCU_INIT_POINTER(ht->tbl, tbl);

 	INIT_WORK(&ht->run_work, rht_deferred_worker);
+	init_irq_work(&ht->run_irq_work, rht_deferred_irq_work);

 	return 0;
 }
@@ -1150,6 +1165,7 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 	struct bucket_table *tbl, *next_tbl;
 	unsigned int i;

+	irq_work_sync(&ht->run_irq_work);
 	cancel_work_sync(&ht->run_work);

 	mutex_lock(&ht->mutex);

