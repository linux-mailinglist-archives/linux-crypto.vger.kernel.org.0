Return-Path: <linux-crypto+bounces-24874-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dFGGFXLgIGod8wAAu9opvQ
	(envelope-from <linux-crypto+bounces-24874-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 04:18:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478AC63C73B
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 04:18:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=lc5M4rmt;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24874-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24874-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C4CC300988E
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 02:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA330C610;
	Thu,  4 Jun 2026 02:18:20 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123530FC23;
	Thu,  4 Jun 2026 02:18:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539500; cv=none; b=SRoR7ceE9mmBacB/lR2yxBfCeGCjuqlQGUbXg/sm2h12j4+kHOSqhCvdgzdcGktvXpv5ty+50VeJZE/JnYZ4aE3ROLtzp29RSnbJFGZgDJ5zmzUDafbrqlGPeeM8mMtDrpj/uhYk3e4roLzvMeKm3aqCyT3wnbfBFsGfvWhzB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539500; c=relaxed/simple;
	bh=d/Z/3QyOfB3rrfshguzBQCzjtI1e8oZsg5+2nlyBXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnqXcd2ZpRhrrzNAr/lZgS+qijE6BwsuHRFlSN1zKgrR9KG5On21Sr9aih1S+ZN4UMlVbGmsagGxi9VgxQNuRl4uM5zMJwYDbnaWmUjpzKGL2FWmONMlnZD1pvkdLhNGCGQJX0sFp0NBHaj9nEBPM84T7VCZI1t3YJLx0eZQSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lc5M4rmt; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=kq8HBaSr83eJu8MS5ar+t8j6rYNQ0hqiMPA0MyxowA4=; 
	b=lc5M4rmtLmD6nHYesWKO0dIKub7eC9E9tYfsKepNpNpMGUxsIPZI7bi8CIwlkExPqKwNiDvqSbp
	5vI8KJ/6QOSnmQEtkTSSr8gSGEiqHa3bE2IKlq9BEQk3/Dj1vQzhye5YMmY4WdnHfp7WK2R3NhVhS
	311KK+IFHjTngc9HqsBWXi4iNx90vEaYAaLBUX4K2lvW+IZol16GW3T3LBRbJMpAvkqNCTPEV8pYk
	V0NnU7fZUe6bK/UnXfm7HV1jyKuOEyOkVWI6RvelFhZRpQH0bIhxhUVqRjoVbPXo/gPHw/wSYTWnG
	yfRtLx8PhphwwgozFQym4zsZ0Eha5qsWgM6Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUxea-002DdF-3A;
	Thu, 04 Jun 2026 10:17:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 10:17:52 +0800
Date: Thu, 4 Jun 2026 10:17:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
	kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
	yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev, Tejun Heo <tj@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] rhashtable: Use irq work for shrinking
Message-ID: <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
 <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
 <3960ffc3-78f3-46da-baaf-ce72b6495698@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3960ffc3-78f3-46da-baaf-ce72b6495698@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24874-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mykyta.yatsenko5@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:kafai@meta.com,m:kernel-team@meta.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:yatsenko@meta.com,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:tj@kernel.org,m:linux-crypto@vger.kernel.org,m:mykytayatsenko5@gmail.com,m:bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,meta.com,gmail.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 478AC63C73B

On Wed, Jun 03, 2026 at 02:08:25PM +0100, Mykyta Yatsenko wrote:
>
> For v7 I'm dropping automatic_shrinking, because it adds a risk of
> calling schedule_work() on element deletion path (__rhashtable_remove_fast_one())
> when hashtable size drops below 30% of the capacity.

Now that expansion uses irq work I think shrinking should switch
to that as well.

---8<---
Use irq work for automatic shrinking so that this may be called
in NMI context.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ef5230cece36..0693bce6f890 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1117,7 +1117,7 @@ static __always_inline int __rhashtable_remove_fast_one(
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
 			     rht_shrink_below_30(ht, tbl)))
-			schedule_work(&ht->run_work);
+			irq_work_queue(&ht->run_irq_work);
 		err = 0;
 	}
 
Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

