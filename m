Return-Path: <linux-crypto+bounces-8987-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466CA088D1
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jan 2025 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A123A8F87
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jan 2025 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2220767C;
	Fri, 10 Jan 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V61kgX2s"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE8207656
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jan 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493244; cv=none; b=bTSqFFpwwJwL8SlnW9sEhbg0MopgxvX9smDtCJljyu7ctWg64LmfIoPu5Y2Cb41ahMIyRKvq41ue/XbLk4ZM0okoDBjIc0xE4memdDQwRunnxXJXuXRlTdy8UxxX1bdmFbMd1VeuGhXERtQ5zbzS0hRZySiUluR3prE+IuuUViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493244; c=relaxed/simple;
	bh=lprOQfulzu8v6KvGdaC/bIeIPCWpKvc6opCkgeRU8p8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uZxEleaEcGP5jNZnMF64wYGpuUR9oON6TScOh8jfKG0qfRxU0gnL8MPd67hmlhsn89UtugHKM6lR5s+b1wtiJwZnYewENXcJwtw4XX/v6sBLlfPdCtxALSyyzZkIOZhlVxrLQHLjnZpNO+Bp2goZLxiMaYZUkikyB+xQGc9eu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V61kgX2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736493242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQbXIksEk073+Fi/YrEVMIhtLpzXwHk7tiFH7RnZK5M=;
	b=V61kgX2sg/pXaY2oCVnh2wd3bOTNJjRgac7L9uEh784T4E/UAwy/GPeLS+WOnXYHjSv8RY
	smkWnaTEpd6PeXLlhQyZbwzYnh3tMTTkvTYT5vYdeeQ450st3uj43tkqP7OJmQa78vPNeZ
	KzH4VUELI2kulMgtSPqcEyoYpnF/eNo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-O0KBR35FP7uFyN5xYPBuug-1; Fri,
 10 Jan 2025 02:13:56 -0500
X-MC-Unique: O0KBR35FP7uFyN5xYPBuug-1
X-Mimecast-MFC-AGG-ID: O0KBR35FP7uFyN5xYPBuug
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 511911955D64;
	Fri, 10 Jan 2025 07:13:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C52530001BE;
	Fri, 10 Jan 2025 07:13:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250110055058.GA63811@sol.localdomain>
References: <20250110055058.GA63811@sol.localdomain> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1478992.1736493228.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 07:13:48 +0000
Message-ID: <1478993.1736493228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> It sounds like a lot of workarounds had to be implemented to fit these
> protocols into the crypto_aead API.
> =

> It also seems unlikely that there will be other implementations of these
> protocols added to the kernel, besides the one you're adding in crypto/k=
rb5/.
> =

> Given that, providing this functionality as library functions instead wo=
uld be
> much simpler.  Take a look at how crypto/kdf_sp800108.c works, for examp=
le.

Yes.  That's how I did my first implementation.  I basically took the code
from net/sunrpc/auth_gss/ and made it more generic.  Herbert wants it done
this way, however.  :-/

David


