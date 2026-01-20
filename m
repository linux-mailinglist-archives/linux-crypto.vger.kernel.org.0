Return-Path: <linux-crypto+bounces-20186-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MXrGZzRb2mgMQAAu9opvQ
	(envelope-from <linux-crypto+bounces-20186-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 20:03:56 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E923049F93
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 20:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2EC96CE27
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E804508EB;
	Tue, 20 Jan 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx8MOyW4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5D3EF0C1
	for <linux-crypto@vger.kernel.org>; Tue, 20 Jan 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925471; cv=none; b=mgbsIXLjxT85YhsK+/hBw0tHCOVCNUo/xS4kdlwZBJeHk2zxO1UzFrZ+B7R9BArHr4oVBPMtXpJfWl1CpyKdx9ie8qFa6sT1qlaAip+dD+q0KeErPUBBJgSP4tLWI2RQ1mLBCjQ4mXDKlo+QXz5K3GWzen8cZvXr9gwhQJGQdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925471; c=relaxed/simple;
	bh=tWPMM5C6dDxijHPBafjYC1SjTJ0g6oQdXgKfFFqdrfE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QEIYWGZfuSO4+EylZKZcoWgZr1mfc96D7JJxh17a5Y1qPZUS+gxXk4ivvLGGsMfJ8EHOo+IMyNTB3g7KgrVfCI1mIF/6bpKgE0MfOXNChvB/EfTxhKk3YA4s4TU0H4L8OKntHxkUEN3PBXpy2Rxc2aZ3mIO8VENpejgcAnbAz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wx8MOyW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768925467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRtTF5ndQZQPQCXaLyEtKnLXPyyjrq8Fu6UawbLrHgM=;
	b=Wx8MOyW4kVPdjENZd4N5a11A4nXrR74yPrRHi7gIYwSK+EkU8DFNG1Ao9nJGVm0Im5m/M3
	X3uPXy2U79XJwZXaVb/dUi91DxLTEwc1CQJGucxlNwP21cydhwuNkXzPUEpth+j5hv9xbY
	eFTQ44uCujSZHU83tVlBKQz0z5fttNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-1tkB6R5EMxK6yB4fnXnMgg-1; Tue,
 20 Jan 2026 11:11:05 -0500
X-MC-Unique: 1tkB6R5EMxK6yB4fnXnMgg-1
X-Mimecast-MFC-AGG-ID: 1tkB6R5EMxK6yB4fnXnMgg_1768925463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C9A1195609F;
	Tue, 20 Jan 2026 16:11:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E16C3000218;
	Tue, 20 Jan 2026 16:10:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALrw=nH8zOXiyiCGkx1A533ijM=pyVebbhYCFpUyvP0bnjrXzA@mail.gmail.com>
References: <CALrw=nH8zOXiyiCGkx1A533ijM=pyVebbhYCFpUyvP0bnjrXzA@mail.gmail.com> <20260115215100.312611-1-dhowells@redhat.com> <20260115215100.312611-3-dhowells@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: dhowells@redhat.com, Lukas Wunner <lukas@wunner.de>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Eric Biggers <ebiggers@kernel.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 02/10] pkcs7: Allow the signing algo to calculate the digest itself
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1189034.1768925458.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2026 16:10:58 +0000
Message-ID: <1189035.1768925458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-20186-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Queue-Id: E923049F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ignat Korchagin <ignat@cloudflare.com> wrote:

> > +                       sig->digest =3D kmalloc(umax(sinfo->authattrs_=
len, sig->digest_size),
> > +                                             GFP_KERNEL);
> =

> I'm still bothered by this "reallocation". You mentioned we need to do
> some parsing for attributes, but it seems by the time this function is
> called we have all the data to do something like
> kmalloc(sig->algo_does_hash ? umax(sinfo->authattrs_len,
> sig->digest_size) : sig->digest_size, GFP_KERNEL) during the initial
> allocation. Or am I missing something?

Actually, you're right, we do have that info at this point

David


