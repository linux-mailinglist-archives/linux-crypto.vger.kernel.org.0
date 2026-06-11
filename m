Return-Path: <linux-crypto+bounces-25077-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rWP+Ljh5KmoTqQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25077-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 11:00:40 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B8670204
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 11:00:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=qz8hrwBE;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25077-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25077-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C573360EAC
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E933BB131;
	Thu, 11 Jun 2026 08:54:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DB3BB108;
	Thu, 11 Jun 2026 08:54:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168099; cv=none; b=kIRTZlLKP8hR77Tdzqe45t0X6/0BxVOB8fkgMKb3L8uvBHq2G2THr+3Ln/45vdDCWd/faYcghcQlNdKTGK+EMsXhU9JVuHQ/xvauQv0OEyTnYHQAHUtKmwIC7bcHMFwADrkX2HlD6LbDiRf81s3Ml+lK88EtrmNFnu4kJrCsliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168099; c=relaxed/simple;
	bh=Esp5sxInBJYX/iDPq6hzrrIEF1yn/PDjdHxXfbg0HQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIu4ZXzK5ZIeRvOWfvJE7dXn7JBpgvmuVBoOJoWY5TadXx/z4viItAP4vuUBbKJ/NFbYw9jQTVKXzzl/pdRbp1szbbpHbNCW4mCFg2mgfQ9smEIfQhhFb9BdDVfogs4u91ZKVvxbeicsOXHMuQ4nbibxsLQnfQyvXtFauHWQF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=qz8hrwBE; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=I5x/U2VzLe3MBCuRsZ7KN6kqzlLtIzBLJvLIHMx3AQA=; 
	b=qz8hrwBEqXEJk6lPrC9JP1lRmdmQyNVNOEnNzOOCfg9Qyo+AnwV/3D25p/wFbNRBOHMyP9MvbEs
	QWH3p5VlhMc9Ledb9gBSYqoUctrxLAwPDCViCJ7aEzrVkUnK+W09FGcfmFLebUeWrxAVYWpeAGmsY
	VtwVZTfzoxeixc41LRfACzkupUf4/Z0G8l25HDXlkLvwQjDQgmkdDoQJ/Ui1N+x6+ToNkXZFk/4/I
	Z3jDr3KILoDxPgXaPQv6QgXlHQNN1wgI8Kb/58mmQsyMX/CLPYu0vI0nDfQdYnbLmqCFdugLNQUpW
	9kg/9M02DowgoN4xujwHRfH9vhNjmSXuhJ8g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXbBe-00000004XdM-0mdi;
	Thu, 11 Jun 2026 16:54:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:54:54 +0800
Date: Thu, 11 Jun 2026 16:54:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - allow
 authenc(hmac(sha{256,384}),cts(cbc(aes))) in FIPS mode
Message-ID: <aip33ggJp2eLAP8T@gondor.apana.org.au>
References: <20260603155008.736872-1-idryomov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603155008.736872-1-idryomov@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25077-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:idryomov@gmail.com,m:dhowells@redhat.com,m:linux-crypto@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,nist.gov:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 526B8670204

On Wed, Jun 03, 2026 at 05:50:04PM +0200, Ilya Dryomov wrote:
> hmac(sha256), hmac(sha384) and cts(cbc(aes)) algorithms have been
> marked as FIPS allowed for years.  Mark the respective authenc()
> constructions per RFC 8009 ("AES Encryption with HMAC-SHA2 for
> Kerberos 5") as such as well.
> 
> SP 800-57 Part 3 Rev. 1 from Jan 2015 [1] links the draft of what
> became RFC 8009 in Oct 2016 as approved in section 6.3 Procurement
> Guidance (item/recommendation 3).
> 
> [1] https://csrc.nist.gov/pubs/sp/800/57/pt3/r1/final
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  crypto/testmgr.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

