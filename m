Return-Path: <linux-crypto+bounces-6064-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538659555EE
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Aug 2024 08:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CE7B2122C
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Aug 2024 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13313AD2F;
	Sat, 17 Aug 2024 06:57:47 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BD2F23;
	Sat, 17 Aug 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877867; cv=none; b=O6xRlqKxgOJNDvRW8Z0miYjf7e+q7n27m9xCX39+pI143yrYZYrc6Hyu+TBK6nW/gM6E1J/ysV6YyHipKNKhdO4AbqQMjadLKLA7/aGn0t2AlKLAvK9q1agS71omaLgT9pPcj7zvLkihusPAz7eVyzwJLzMKzfOfI1z4IOLYRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877867; c=relaxed/simple;
	bh=9JOixDOMEABm8/KrT/4BKVWnyfC+aB+F26ZuYzAhoTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drPAytJxsapf4R0cqjCVHQurLNf5rr6PSBkIZG+zgtDFDtAR1LJc1WfbxpJSrvd7/I7k1v7N1xph3Tr2dG7URVQZjmlLaQQ9LNMX6yX4CqmKblNEwqcGbDbWJGjquBXUBiZpTLu3wnKV6UsMY6M5oCPJAht+7augi+FG7beBjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sfDF9-005IFL-1l;
	Sat, 17 Aug 2024 14:57:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 17 Aug 2024 14:57:40 +0800
Date: Sat, 17 Aug 2024 14:57:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-crypto@vger.kernel.org,
	ltp@lists.linux.it, Linus Torvalds <torvalds@linux-foundation.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [v3 PATCH 2/3] crypto: api - Do not wait for tests during
 registration
Message-ID: <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>

As registration is usually carried out during module init, this
is a context where as little work as possible should be carried
out.  Testing may trigger module loads of underlying components,
which could even lead back to the module that is registering at
the moment.  This may lead to dead-locks outside of the Crypto API.

Avoid this by not waiting for the tests to complete.  They will
be scheduled but completion will be asynchronous.  Any users will
still wait for completion.

Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/algapi.c   | 23 ++++++++++++-----------
 crypto/api.c      | 41 +++++++++++++++++++++--------------------
 crypto/internal.h |  3 +--
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index d2ccc1289f92..74e2261c184c 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -366,7 +366,8 @@ void crypto_alg_tested(const char *name, int err)
 	}
 
 	pr_err("alg: Unexpected test result for %s: %d\n", name, err);
-	goto unlock;
+	up_write(&crypto_alg_sem);
+	return;
 
 found:
 	q->cra_flags |= CRYPTO_ALG_DEAD;
@@ -387,11 +388,12 @@ void crypto_alg_tested(const char *name, int err)
 	crypto_alg_finish_registration(alg, &list);
 
 complete:
+	list_del_init(&test->alg.cra_list);
 	complete_all(&test->completion);
 
-unlock:
 	up_write(&crypto_alg_sem);
 
+	crypto_alg_put(&test->alg);
 	crypto_remove_final(&list);
 }
 EXPORT_SYMBOL_GPL(crypto_alg_tested);
@@ -412,7 +414,6 @@ int crypto_register_alg(struct crypto_alg *alg)
 {
 	struct crypto_larval *larval;
 	LIST_HEAD(algs_to_put);
-	bool test_started = false;
 	int err;
 
 	alg->cra_flags &= ~CRYPTO_ALG_DEAD;
@@ -423,15 +424,16 @@ int crypto_register_alg(struct crypto_alg *alg)
 	down_write(&crypto_alg_sem);
 	larval = __crypto_register_alg(alg, &algs_to_put);
 	if (!IS_ERR_OR_NULL(larval)) {
-		test_started = crypto_boot_test_finished();
+		bool test_started = crypto_boot_test_finished();
+
 		larval->test_started = test_started;
+		if (test_started)
+			crypto_schedule_test(larval);
 	}
 	up_write(&crypto_alg_sem);
 
 	if (IS_ERR(larval))
 		return PTR_ERR(larval);
-	if (test_started)
-		crypto_wait_for_test(larval);
 	crypto_remove_final(&algs_to_put);
 	return 0;
 }
@@ -646,8 +648,10 @@ int crypto_register_instance(struct crypto_template *tmpl,
 	larval = __crypto_register_alg(&inst->alg, &algs_to_put);
 	if (IS_ERR(larval))
 		goto unlock;
-	else if (larval)
+	else if (larval) {
 		larval->test_started = true;
+		crypto_schedule_test(larval);
+	}
 
 	hlist_add_head(&inst->list, &tmpl->instances);
 	inst->tmpl = tmpl;
@@ -657,8 +661,6 @@ int crypto_register_instance(struct crypto_template *tmpl,
 
 	if (IS_ERR(larval))
 		return PTR_ERR(larval);
-	if (larval)
-		crypto_wait_for_test(larval);
 	crypto_remove_final(&algs_to_put);
 	return 0;
 }
@@ -1042,6 +1044,7 @@ static void __init crypto_start_tests(void)
 
 			l->test_started = true;
 			larval = l;
+			crypto_schedule_test(larval);
 			break;
 		}
 
@@ -1049,8 +1052,6 @@ static void __init crypto_start_tests(void)
 
 		if (!larval)
 			break;
-
-		crypto_wait_for_test(larval);
 	}
 
 	set_crypto_boot_test_finished();
diff --git a/crypto/api.c b/crypto/api.c
index ffb81aa32725..bbe29d438815 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -154,32 +154,31 @@ static struct crypto_alg *crypto_larval_add(const char *name, u32 type,
 	return alg;
 }
 
-void crypto_larval_kill(struct crypto_alg *alg)
+static void crypto_larval_kill(struct crypto_larval *larval)
 {
-	struct crypto_larval *larval = (void *)alg;
+	bool unlinked;
 
 	down_write(&crypto_alg_sem);
-	list_del(&alg->cra_list);
+	unlinked = list_empty(&larval->alg.cra_list);
+	if (!unlinked)
+		list_del_init(&larval->alg.cra_list);
 	up_write(&crypto_alg_sem);
-	complete_all(&larval->completion);
-	crypto_alg_put(alg);
-}
-EXPORT_SYMBOL_GPL(crypto_larval_kill);
 
-void crypto_wait_for_test(struct crypto_larval *larval)
+	if (unlinked)
+		return;
+
+	complete_all(&larval->completion);
+	crypto_alg_put(&larval->alg);
+}
+
+void crypto_schedule_test(struct crypto_larval *larval)
 {
 	int err;
 
 	err = crypto_probing_notify(CRYPTO_MSG_ALG_REGISTER, larval->adult);
-	if (WARN_ON_ONCE(err != NOTIFY_STOP))
-		goto out;
-
-	err = wait_for_completion_killable(&larval->completion);
-	WARN_ON(err);
-out:
-	crypto_larval_kill(&larval->alg);
+	WARN_ON_ONCE(err != NOTIFY_STOP);
 }
-EXPORT_SYMBOL_GPL(crypto_wait_for_test);
+EXPORT_SYMBOL_GPL(crypto_schedule_test);
 
 static void crypto_start_test(struct crypto_larval *larval)
 {
@@ -198,7 +197,7 @@ static void crypto_start_test(struct crypto_larval *larval)
 	larval->test_started = true;
 	up_write(&crypto_alg_sem);
 
-	crypto_wait_for_test(larval);
+	crypto_schedule_test(larval);
 }
 
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
@@ -218,9 +217,11 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 	alg = larval->adult;
 	if (time_left < 0)
 		alg = ERR_PTR(-EINTR);
-	else if (!time_left)
+	else if (!time_left) {
+		if (crypto_is_test_larval(larval))
+			crypto_larval_kill(larval);
 		alg = ERR_PTR(-ETIMEDOUT);
-	else if (!alg) {
+	} else if (!alg) {
 		u32 type;
 		u32 mask;
 
@@ -355,7 +356,7 @@ struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask)
 		crypto_mod_put(larval);
 		alg = ERR_PTR(-ENOENT);
 	}
-	crypto_larval_kill(larval);
+	crypto_larval_kill(container_of(larval, struct crypto_larval, alg));
 	return alg;
 }
 EXPORT_SYMBOL_GPL(crypto_alg_mod_lookup);
diff --git a/crypto/internal.h b/crypto/internal.h
index aee31319be2e..711a6a5bfa2b 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -113,8 +113,7 @@ struct crypto_alg *crypto_mod_get(struct crypto_alg *alg);
 struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask);
 
 struct crypto_larval *crypto_larval_alloc(const char *name, u32 type, u32 mask);
-void crypto_larval_kill(struct crypto_alg *alg);
-void crypto_wait_for_test(struct crypto_larval *larval);
+void crypto_schedule_test(struct crypto_larval *larval);
 void crypto_alg_tested(const char *name, int err);
 
 void crypto_remove_spawns(struct crypto_alg *alg, struct list_head *list,
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

