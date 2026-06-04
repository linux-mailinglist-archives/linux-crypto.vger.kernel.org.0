Return-Path: <linux-crypto+bounces-24875-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTvkIurhIGpX8wAAu9opvQ
	(envelope-from <linux-crypto+bounces-24875-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 04:24:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5C63C7BA
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 04:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="iNUbd uU";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24875-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24875-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A66300917E
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002120CCDC;
	Thu,  4 Jun 2026 02:21:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574033D51A
	for <linux-crypto@vger.kernel.org>; Thu,  4 Jun 2026 02:21:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539684; cv=none; b=G7wsBRlAjg2UYLbcTzzCiQJ4xqPKHQEykuQ41tLbL5AoweqX9oZR1tE4EL3ijlkTFdY/Yf4NEdnY8JVMdAdqBWLhAVCf2F0BoWz72FqEHmrNvTmgHFVMjZqJWkgHb8dZkCLGasbTONeP00iHPtT4TnUklmT1zKKYk4LDh1vZn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539684; c=relaxed/simple;
	bh=qqRQ3JCkqQCrZEWo5x2T4s6k3QryBJ476a1uq8noQCU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dvfMyMjuU7SUZnhofvDtmI6PongRm2y/EgpPR03G43MqhnfyD+oCzUmjLc2jfRkojlsTxebrgsgFgwmbzQphM4HJ3Qo8zjeAJC1PpH8VyE5qI+6SJkGlc67SJDgNdtxh9Rgf50RByxqVzEDxXH7HfSY7GuVHOLPldAhPnlW6hMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=iNUbduUp; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=qH5ZpszG9kMOQRTLCZegQ4j5slLepLeqIYMXSP5mjW0=; b=iNUbd
	uUpAneVn7dQfx7nDd8QwIE7wTBZtapv9pYsrXBvT7XLuRlmFPmkMqQI48KB6ylS3cs/Q5Cf927bch
	KyH1Pbe611jvykA8xn2z8hI9/TSILKysLQHy42UMVLO17LdbBjeZujEzX2kcticqXekNum0RqNhU8
	ahkU1hmJzjSQOSxEW/4LeO/9k4Rgyfej6Kide9ecRQQTleIEnmibZVN7luo13wG8hgodRhnpSxsEB
	n/9O2aE+PHdiDj0sKyPCLIuV+RSmTsXzAc5AoIy3+W/yUnVysUZJLX0RhPrU7VvBpxRyRY9B2Dl/x
	kfpwR7DseesQHEqoJaodlH+sTBzjw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUxht-002Df2-2X;
	Thu, 04 Jun 2026 10:21:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 10:21:17 +0800
Date: Thu, 4 Jun 2026 10:21:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] rhashtable: Add workqueue/irq_work header inclusions
Message-ID: <aiDhHQ-bzXzu7GT9@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24875-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DC5C63C7BA

Add inclusions for irq_work.h and workqueue.h to rhashtable.c rather
than relying on indirect inclusions from elsewhere.

Remove workqueue.h from rhashtable.h now that it uses IRQ work only.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..b01d53c37a68 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -23,7 +23,6 @@
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
 #include <linux/list_nulls.h>
-#include <linux/workqueue.h>
 #include <linux/rculist.h>
 #include <linux/bit_spinlock.h>
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 04b3a808fca9..57751ee19faa 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -14,6 +14,7 @@
 #include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irq_work.h>
 #include <linux/log2.h>
 #include <linux/sched.h>
 #include <linux/rculist.h>
@@ -25,6 +26,7 @@
 #include <linux/rhashtable.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/workqueue.h>
 
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

