Return-Path: <linux-crypto+bounces-10903-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CFA67247
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Mar 2025 12:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CE0188AF40
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Mar 2025 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640D20ADC0;
	Tue, 18 Mar 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OijEjc3/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDD209F49
	for <linux-crypto@vger.kernel.org>; Tue, 18 Mar 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296215; cv=none; b=WKnIfKOaZ6Pw/fQdi06kV4HXCBYKC0A/5Ho6cvk8GvFbf3QmmSXROAvPTVp5E+vecAH7MGs1cSUiOtc01P9Qpa+UjQ5TYdMJUJeE2gGkX8PB0o/3UUYACEG3uNVyCqcMeLUujDK63W45tRxw6lyCs5R74i1lJ2RDHBPmw2IftJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296215; c=relaxed/simple;
	bh=t+8aTqYJiQhc0a1Cq0clXumsHtAtEQPDhAUx+L34SlY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ivAdqRKC+TeWXADyb94yUAdnGGhpEsjHVHv06EkOJk4QCuO2j3NLd6vXu5DjgvhkO7yN4yiT71/Zb88s2CwYUtUNR8d97PLwsyYzkMOaUArBMMfWWG1uCVrMBaA8tO4J1/ujI3ZT4aGzQIuyAyKgAD0mBHqkt4Iu8Idkco+jJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OijEjc3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742296211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKeYGMJn+qJhMLwvqdHnSj6tekdHaiz41QSP0i4UJ1I=;
	b=OijEjc3/MmzaZzdhw1pVIQGGPKpzoNcGVyThuMALUbVn1psmaa6uHaMQ6THBKKRnuzdNAd
	K4B3T4B6YFai1epFv9Af0XJFMn15NVkEFBbll5z1fTbpk31mtodKRCHvQ8xyO8+YCq3Nl1
	/QBGa2PnabZi69wUjzhKBbL/YoFi2jo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-S2ICisW3N-ez1TjWWeeXYA-1; Tue,
 18 Mar 2025 07:10:08 -0400
X-MC-Unique: S2ICisW3N-ez1TjWWeeXYA-1
X-Mimecast-MFC-AGG-ID: S2ICisW3N-ez1TjWWeeXYA_1742296206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA77E1800EC5;
	Tue, 18 Mar 2025 11:10:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7814718001EF;
	Tue, 18 Mar 2025 11:10:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com>
References: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com> <20250203142343.248839-1-dhowells@redhat.com> <20250203142343.248839-4-dhowells@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David
 S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2481241.1742296198.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 11:09:58 +0000
Message-ID: <2481243.1742296198@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +         Combined hash and cipher support for Kerberos 5 RFC3961 simp=
lified
> > +         profile.  This is required for Kerberos 5-style encryption, =
used by
> > +         sunrpc/NFS and rxrpc/AFS.
> =

> Hence shouldn't the latter (e.g. RPCSEC_GSS_KRB5) select CRYPTO_KRB5ENC
> or CRYPTO_KRB5? Or am I missing something?

SunRPC hasn't been converted to use it yet.  The help text is slightly
misleading, I guess: "Kerberos 5-style encryption" is used by sunrpc/NFS
within the kernel, but not this library yet.

Unfortunately, the rxrpc/AFS patches didn't make it in due to them requiri=
ng
to go through the net-next tree, but having dependencies on both the VFS t=
ree
and the crypto tree.

Herbert wanted the crypto patches (krb5 lib) based on his tree, which I di=
d
and he pulled it - but then this disqualified it for also being pulled int=
o
net-next as that would've pulled *all* the crypodev patches there as well.

For reference, the rxrpc patches can be found here:

	https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git=
/log/?h=3Drxrpc-next

I intend to post them for net-next inclusion after the merge window.

David


