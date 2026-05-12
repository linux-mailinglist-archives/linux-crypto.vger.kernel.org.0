Return-Path: <linux-crypto+bounces-23945-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLLXIWnEAmp7wQEAu9opvQ
	(envelope-from <linux-crypto+bounces-23945-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 08:10:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 826FD51AB9A
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 08:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70523307CF43
	for <lists+linux-crypto@lfdr.de>; Tue, 12 May 2026 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C358436352;
	Tue, 12 May 2026 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="o1i98UEK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFC42E001
	for <linux-crypto@vger.kernel.org>; Tue, 12 May 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566089; cv=none; b=NoQvOh2gitSygKrHSD4LJve5liKcYrqmgw74pe+rwE6X3S5YjB0HFIlR9VU/DIosE++8qTqkhz5962cJEdrsQqeGS/A+GhW+H4wgJ1GbyKHni9YJdZj3Rh9hw59YxPWQwaeXTJM8YRYLP3ZNN7qpRWlaSEHCeBC4Nl+FlZDj4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566089; c=relaxed/simple;
	bh=kVL7EGfH1sMu+QWj+bUlHVVLJDvJcWJRAqo2vMXMB04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoPkQI1jyYpYZ5OpdhGYvOvYEuqmv7TnC5t4WNP1c+19pI+q2apSUmHQaK98eKTEUupSYLrERnOnr46kFPIwSkaB4HlHhhz6ptIIGqDCa2g9BdT9D1Vq1BUvkl2lSBBUjEp6qHthVIZ/n+Tzph9gDp3ziVjLZXAtZ1d4EvBqx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=o1i98UEK; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1778566075;
	bh=U1k73+ZhMqaCjS8wmSv5b+P6ZarOPAu2zgauQeBza60=;
	h=From:Subject:Date:Message-ID;
	b=o1i98UEKDVN8QQZTrwpAvyIVe7ikdeu5RT+Rpv7VCu4pmZROcYHKe2EEje/Gk/gei
	 eCOdhYTGY6KXuAktTWJPUotIz2HRX4pG1cTNKfMUJaDz05pA8Gp3yC3QaXb0c0dP7e
	 t7jbP4grFpfnMKXDBTfxorrQj6D9LhHSV1ZKttA8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A02C3A300007271; Tue, 12 May 2026 14:07:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6643796816219
X-SMAIL-UIID: D2D2087B3AA146928B8B0A13CF2B4652-20260512-140732-1
From: Hillf Danton <hdanton@sina.com>
To: Tejun Heo <tj@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Graf <tgraf@suug.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rhashtable: Bounce deferred worker kick through irq_work
Date: Tue, 12 May 2026 14:07:31 +0800
Message-ID: <20260512060732.512-1-hdanton@sina.com>
In-Reply-To: <20260421060326.2836354-1-tj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 826FD51AB9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23945-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sina.com:mid,sina.com:dkim]
X-Rspamd-Action: no action

On Mon, 20 Apr 2026 20:03:26 -1000 Tejun Heo wrote:
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -441,10 +441,33 @@ static void rht_deferred_worker(struct work_struct *work)
>  
>  	mutex_unlock(&ht->mutex);
>  
> +	/*
> +	 * Re-arm via @run_work, not @run_irq_work.
> +	 * rhashtable_free_and_destroy() drains async work as irq_work_sync()
> +	 * followed by cancel_work_sync(). If this site queued irq_work while
> +	 * cancel_work_sync() was waiting for us, irq_work_sync() would already
> +	 * have returned and the stale irq_work could fire post-teardown.
> +	 * cancel_work_sync() natively handles self-requeue on @run_work.
> +	 */
>  	if (err)
>  		schedule_work(&ht->run_work);
>  }
> 
Two cents: add BUG to capture the failure of handling self-requeue.

--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -2369,6 +2369,10 @@ retry:
 		work_flags |= WORK_STRUCT_INACTIVE;
 		insert_work(pwq, work, &pwq->inactive_works, work_flags);
 	}
+	do {
+		unsigned long data = *work_data_bits(work);
+		BUG_ON(data & WORK_OFFQ_DISABLE_MASK);
+	} while (0);
 
 out:
 	raw_spin_unlock(&pool->lock);
--

