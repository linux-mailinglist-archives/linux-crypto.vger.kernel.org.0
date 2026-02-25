Return-Path: <linux-crypto+bounces-21136-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H84NBFanmkjUwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21136-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 03:10:25 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38422190A3B
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9611831F36F3
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 01:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67523258ED5;
	Wed, 25 Feb 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zzmks9Nx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7728689B
	for <linux-crypto@vger.kernel.org>; Wed, 25 Feb 2026 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983907; cv=none; b=Yf7JnHna9EePh/jAd9pE4Td1u1LGX90wI7xM3T0gsHaAmM1nZCwIg5b8SwtZXPMuCVC6eT80LkTIgOZzsDcVbfLr4r+BcLuBYRUOFeQ0Jw8GDdSKIFNVfjgzi0dUPSnYrLEFcLpH96QT75DFA5eOxKt1qw/M/ObnS0CMmDzNwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983907; c=relaxed/simple;
	bh=75DMrOdr6KFKXLZ7+4r9yUqENDxySfBAjb3B7OjPB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umZD9adaDIeUufljFEH1JKps6y4OEsxb5wqUoS73EGaPUrPG0Q1GAx4rKqtfuKe3Tx2R08x7++dIRIfuxeFjPFgF+KMEawWybeKBe3KG9bliFokToeSuDa9taTzkt9G1crrlpDpg9329KRs+HjiirsfUEH5aQ3B9QIuee8hAyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zzmks9Nx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=F6OGqiRnYiylH45D2JfFVZs7gV7XDRgHjdkZt4Xd4So=; b=zzmks9NxqMyxg6T7o3GdyjFQCq
	OJB6yKYthjGsU0iBzJdU26qG1lMFRDNBb2Vf7xak5H7DuKJSF2N9nm32H+VdmGiUU8AyBBTdnry2/
	n2P6hzAiVc+Ik3qTPooX2aUXMpMqro+9i1AslsmYPN5Ku8eda0UUuU5U6dTm65Md9HvDshOK6OYHB
	/ydIqYOjG4mXl4DHgBb9/BKSOcjwItBpBgcNSXaa81C5QY5IibGr7l71JJD8Z7Dwfk8OskyAdtArR
	niRHXuLJaPAziPdtcTkzAbphaL6c0wfkPbIb8ZF8UWZ/zsEmmT2eUGycWd1pgY6CgTCbAjttuypfw
	C+fJS93A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv3xV-0000000338h-0snz;
	Wed, 25 Feb 2026 01:45:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-crypto@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: acomp: acompress.h: repair kernel-doc warnings
Date: Tue, 24 Feb 2026 17:45:00 -0800
Message-ID: <20260225014500.41938-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21136-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email,apana.org.au:email,davemloft.net:email]
X-Rspamd-Queue-Id: 38422190A3B
X-Rspamd-Action: no action

Correct kernel-doc:
- add the @extra function parameter
- add "_extra" to the mismatched function name
- spell the "cmpl" parameter correctly

to avoid these warnings:

Warning: include/crypto/acompress.h:251 function parameter 'extra' not
 described in 'acomp_request_alloc_extra'
Warning: include/crypto/acompress.h:251 expecting prototype for
 acomp_request_alloc(). Prototype was for acomp_request_alloc_extra()
 instead
Warning: include/crypto/acompress.h:327 function parameter 'cmpl' not
 described in 'acomp_request_set_callback'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>

 include/crypto/acompress.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20260224.orig/include/crypto/acompress.h
+++ linux-next-20260224/include/crypto/acompress.h
@@ -240,9 +240,10 @@ static inline const char *crypto_acomp_d
 }
 
 /**
- * acomp_request_alloc() -- allocates asynchronous (de)compression request
+ * acomp_request_alloc_extra() -- allocates asynchronous (de)compression request
  *
  * @tfm:	ACOMPRESS tfm handle allocated with crypto_alloc_acomp()
+ * @extra:	amount of extra memory
  * @gfp:	gfp to pass to kzalloc (defaults to GFP_KERNEL)
  *
  * Return:	allocated handle in case of success or NULL in case of an error
@@ -318,7 +319,7 @@ static inline void acomp_request_free(st
  *
  * @req:	request that the callback will be set for
  * @flgs:	specify for instance if the operation may backlog
- * @cmlp:	callback which will be called
+ * @cmpl:	callback which will be called
  * @data:	private data used by the caller
  */
 static inline void acomp_request_set_callback(struct acomp_req *req,

