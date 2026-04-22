Return-Path: <linux-crypto+bounces-23315-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MSRBFSE6GkNLQIAu9opvQ
	(envelope-from <linux-crypto+bounces-23315-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 10:18:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2BE4435B8
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 10:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 425D53010242
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231623BED77;
	Wed, 22 Apr 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="g1IgcTZu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99093BED58;
	Wed, 22 Apr 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845904; cv=none; b=rbSyTmuj27t41zehYA09YYknMjLgN4aW6WOWN1g/VGWRojZ7RpvFq3x0GytqtmNNCzcEqdcD2hmkRELXQzWvllG5ei//JMN8bERC7bGHr+EgBJ3E9/EZtcmGjl8faKDwjvFPQmtHZyYHTrjQjH+Hw5ox+RRLO2uNjMavStgh28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845904; c=relaxed/simple;
	bh=OSNRI9Vzg5gmFTaihwp/2X5S/QjFfH8CtSrTuMyLEHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SReaJOmldDyHg6xFQ8JXGbkfvwvpWOdhmFFT4AEM8TH04HSzhRoQh6zBkrEA4N7JK+l6jJaDieLGWn8pgFQzFoNmvJolDgOT8DrcJh8zDak8mR1ss22pBGgcCglHWV2eXq/F5fjjHhKnx6IySA7JJSqV2TraZ5kGowIG7cjN0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=g1IgcTZu; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=ekQm8ewHAsjUqvi2x2wso40GhX/Yq+kt0EAdT/Gi4pk=; 
	b=g1IgcTZun4lBHwh65T9FFPl7S9QitLz1C32AgB119ECvS6Y6NtzdSWxpyYaIWI6x911JDdGLgUv
	UhszjxBpUos+lAUpuFlc9kKViTyXqoEsr5hH4YPUxQ2/r8K2RRUj9riMunkEVy8B6mZek5gsue9y0
	FbGp3e+CC3P9BBG65ODV8rp3+XDQVnFTwEC0mEY83FIBHEFXSLi3AmIs2BXsshd7Gx1xnEdoGCrx7
	1CCsFRxInX/mI2ZqvaAUvbvCTjt02Fc/3366u+dbJJ5P0gN/w2nrNcZEhf+nzAMhFH+2Ciqe5SGq8
	yfepkkiI3zgTOPoEqQQDlWVYYri2wKHsf4Dw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wFSmm-007uhl-0g;
	Wed, 22 Apr 2026 16:18:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 Apr 2026 16:18:16 +0800
Date: Wed, 22 Apr 2026 16:18:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Graf <tgraf@suug.ch>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] rhashtable: Check for vmalloc in emergency rehash error path
Message-ID: <aeiESGghexEuKbEV@gondor.apana.org.au>
References: <202604211323.fac1b29e-lkp@intel.com>
 <aedvSnhOGM_mauYP@milan>
 <aehdcxC14ycvY481@gondor.apana.org.au>
 <aeh2Ii9CxtgfsX_p@milan>
 <aeh_2WwIb8nAIcy2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeh_2WwIb8nAIcy2@gondor.apana.org.au>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23315-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suug.ch,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,suse.com,redhat.com,google.com,gmail.com,kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Queue-Id: 3D2BE4435B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 03:59:21PM +0800, Herbert Xu wrote:
>
> Why is kvmalloc returning vmalloc memory under GFP_ATOMIC?
> Is there a new GFP flag to tell it to not return vmalloc memory?
> 
> This has been working for over a decade, what changed?

Nevermind, I found your commit to add vmalloc support for GFP_ATOMIC.

---8<---
As kvmalloc with GFP_ATOMIC can now return vmalloc memory, check
for it when freeing while in the same context so that vfree isn't
called in an atomic context.

Use RCU to defer the freeing if the memory came from vmalloc.

Reported-by: Uladzislau Rezki <urezki@gmail.com>
Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6074ed5f66f3..c386f456e417 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -119,6 +119,16 @@ static void bucket_table_free_rcu(struct rcu_head *head)
 	bucket_table_free(container_of(head, struct bucket_table, rcu));
 }
 
+static void bucket_table_free_atomic(struct bucket_table *tbl)
+{
+	if (is_vmalloc_addr(tbl)) {
+		call_rcu(&tbl->rcu, bucket_table_free_rcu);
+		return;
+	}
+
+	bucket_table_free(tbl);
+}
+
 static union nested_table *nested_table_alloc(struct rhashtable *ht,
 					      union nested_table __rcu **prev,
 					      bool leaf)
@@ -473,7 +483,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 
 	err = rhashtable_rehash_attach(ht, tbl, new_tbl);
 	if (err) {
-		bucket_table_free(new_tbl);
+		bucket_table_free_atomic(new_tbl);
 		if (err == -EEXIST)
 			err = 0;
 	} else
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

