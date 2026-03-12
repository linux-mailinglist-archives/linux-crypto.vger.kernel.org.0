Return-Path: <linux-crypto+bounces-21885-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AISmNINLsml7LQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21885-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 06:13:39 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874B26D530
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 06:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EDD30A62DB
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E303A3815;
	Thu, 12 Mar 2026 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4tahl+Xt"
X-Original-To: linux-crypto@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4938C2C2;
	Thu, 12 Mar 2026 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292414; cv=none; b=ERLXjrmg35KcdQQ6xbNekwf4IUG4MAyqwyfws/CEA4GU9thDLyvs56ody75m6sCmjgu28u8mNdP9waA5iXBc6RV46N23RA1WKPrvbb9ir1svUl0r3TPoUCF4bbaji8jACSo9S2ehT1XjeSdFbXorTCU6TlzCawqUvpwRNQikGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292414; c=relaxed/simple;
	bh=P/wlynXmP6/WASyxAGfBco/hwpq7GSO77US22+hoY2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltZetqK+FUhI53ojIK9GRud6SYb9r99u8KQQlQLTJ8bRVKVPSrCJ8JwZEqj/4lw1yiAUE2P3LHHQlvZNCVGVgpo1wMEYnZ5dr0nPrEb8iPy217wbK/SaFQwPbO8bKF9+2AjNVxL/bjr3W5x49AQP0tkgvi6hifiHzLgFjAd53A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4tahl+Xt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fNphbdRFLswMgxhERbn+phmz9gcrv++Iy1EvPhPBHhQ=; b=4tahl+XtsSOx1825IzX3ojUmzp
	NbblSXCGtaT3aqfKmw2OrWb29ohydq/kTrS7f57ucUXaNIX1CFds5NczZmIx2GP1g5Rm0cQOCh3ct
	COKSDHJ1u6udLgTzCKx2xOq5NSVRxqS3g2sCNFJtpyfTnKBSU1G/31tfwZvHKoM0scj/CQaMgONIF
	IHuDNyWm7DWs57jDjYD1jcV2SJlZkUjY2MVAUvlgFI1kXTB/KOmQWNlD0LNVnLs4RupqGCbDbu6uu
	ZRtCEY0nmgNOSVL5d48LvbaXp1JIHAdQOOXqpoTKNxqsHhBJ7zYPxg+poXOy6oigLXmQdkNvFNLz4
	56yzqEmA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YMO-0000000DL2Z-0zWZ;
	Thu, 12 Mar 2026 05:13:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: hw_random.h: avoid kernel-doc warnings
Date: Wed, 11 Mar 2026 22:13:23 -0700
Message-ID: <20260312051323.679913-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21885-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:email,infradead.org:mid,apana.org.au:email,selenic.com:email]
X-Rspamd-Queue-Id: 4874B26D530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mark internal fields as "private:" so that kernel-doc comments
are not needed for them, eliminating kernel-doc warnings:

Warning: include/linux/hw_random.h:54 struct member 'list' not described
 in 'hwrng'
Warning: include/linux/hw_random.h:54 struct member 'ref' not described
 in 'hwrng'
Warning: include/linux/hw_random.h:54 struct member 'cleanup_work' not
 described in 'hwrng'
Warning: include/linux/hw_random.h:54 struct member 'cleanup_done' not
 described in 'hwrng'
Warning: include/linux/hw_random.h:54 struct member 'dying' not described
 in 'hwrng'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Olivia Mackall <olivia@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org

 include/linux/hw_random.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260311.orig/include/linux/hw_random.h
+++ linux-next-20260311/include/linux/hw_random.h
@@ -46,7 +46,7 @@ struct hwrng {
 	unsigned long priv;
 	unsigned short quality;
 
-	/* internal. */
+	/* private: internal. */
 	struct list_head list;
 	struct kref ref;
 	struct work_struct cleanup_work;

