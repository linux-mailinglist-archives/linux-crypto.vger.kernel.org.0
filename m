Return-Path: <linux-crypto+bounces-20592-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJMnEAhvgmlkUAMAu9opvQ
	(envelope-from <linux-crypto+bounces-20592-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 22:56:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB5DF063
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85E333013B77
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Feb 2026 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995235F8AE;
	Tue,  3 Feb 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5Y6vezk"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71161509AB
	for <linux-crypto@vger.kernel.org>; Tue,  3 Feb 2026 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155781; cv=none; b=oBQf01BsBAMALuYH8hcJXgLLwxdcmp+p36xJdi7A2CnZn69RczNhYrW91uGb1t8h+iux+zHGrN5LXBK978fmjHkzBhZqbi22D+evlHUvBtvz85sq4bNRsY5dCqDhUDtFmNWQHpKOvF0ozMi039GALhHBXQEq9v/wD8NmWFO+7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155781; c=relaxed/simple;
	bh=hq0w2VSlTBBQpUIkuGwG99Wh9L8D7GZk4fsxtm5NiNU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=WKAS9IFxlDjWQDgCFxQq5CluX832nqiXfaWmAj38eRGxBir5RnZuMzd8exu2L2QnGOhuEiedtZgd6XRqtF5cy9ElUlzzP3oW4hr4r4egt+KETyTXhucF3Bu5gCM/QoWhjxfRSWKwX94clxJlpDfJ6OCdpzqZ+OTEeeogktgh0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5Y6vezk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770155778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz6ULZhTAdgJd8oMqD3yN5FCP56OfatQprs+uDB0s84=;
	b=g5Y6vezks9rncGWoRrUnNiZ2RlPE0VdOXA+KjxF+4175Qwc/lrb6aivrewc4uwt8AE5dTb
	fkO8/vFkCHy8bbR/DS9R7R9KugaW/1e79A7hS2baQuJd3XfrOPVGimDgAD9Bkgo6RxJ7Rw
	/2Xl3s1+MOj0CmpRAU9fLISKQocZ8iE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-MgKa4Wk-O0uCuWTaGP5YJA-1; Tue,
 03 Feb 2026 16:56:13 -0500
X-MC-Unique: MgKa4Wk-O0uCuWTaGP5YJA-1
X-Mimecast-MFC-AGG-ID: MgKa4Wk-O0uCuWTaGP5YJA_1770155772
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E76E418002CD;
	Tue,  3 Feb 2026 21:56:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 039BA19560B4;
	Tue,  3 Feb 2026 21:56:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260202221552.174341-1-ebiggers@kernel.org>
References: <20260202221552.174341-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
    "Jason A .
 Donenfeld" <Jason@zx2c4.com>,
    Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: mldsa: Clarify the documentation for mldsa_verify() slightly
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2582075.1770155767.1@warthog.procyon.org.uk>
Date: Tue, 03 Feb 2026 21:56:07 +0000
Message-ID: <2582076.1770155767@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20592-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2DB5DF063
X-Rspamd-Action: no action

Eric Biggers <ebiggers@kernel.org> wrote:

> mldsa_verify() implements ML-DSA.Verify with ctx='', so document this
> more explicitly.  Remove the one-liner comment above mldsa_verify()
> which was somewhat misleading.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>


