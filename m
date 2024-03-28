Return-Path: <linux-crypto+bounces-3035-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBB890981
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 20:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266BD294E8E
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 19:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C7130A54;
	Thu, 28 Mar 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5df2u2t"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD35FBA7
	for <linux-crypto@vger.kernel.org>; Thu, 28 Mar 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654945; cv=none; b=LeHrZZ5eeEjvy8DaULVmwiXxGFql6Q8M2rwDzXKQAd4bY7Zdn0ipaufPHlDyhNspOg8EgJUjzy//Fu2vHkElmN0dxtaaeAf/FgukzLrzrW9UPaFKC5dIdkTFYDLuMdlIlgJt7DRXpVgxdVE227rigipCwtpDrtthVPxGzBqZmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654945; c=relaxed/simple;
	bh=G54bg5q8nSHx+bWgKyzuXCJMK6dG285yA0AuuEKhQKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmDyHVevc2FHpI9/uveL5p7ePnvVA2DmaFuIl9u8n9Xabj3iJbgnn08qRu4bTPuydzKQnyxKfHo0itg0NJK/0mwTsOxKzh2WwgvxcVteTQAxfnmOezlfKhDS1kBLl62w6H5W+vYJglWd1K4N4v0vwBRimSg6S8F52xMfWD4CwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5df2u2t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711654941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9rFKgdnjl1+qP2ulkGzbGF6DQvxAxPK/GjEf2hMSac=;
	b=F5df2u2ttAPAcMRAylxaI75/GGm/jIZufXMTJ98gfxEUHosSLc1yNcj+tCFyO7nIzFXO1C
	BUIlrN2dlyMkTp5I4DfuN7IKcL+Cewh+ADUcvl0gl8FbzNnFB6j2R/siKdlDTf5bCFt9IB
	/LE7bpb5hJedD0IQ1zy45WznJViS/CI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-0pJKG3AIMS6c6E2O9qbhYg-1; Thu,
 28 Mar 2024 15:42:16 -0400
X-MC-Unique: 0pJKG3AIMS6c6E2O9qbhYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76DF729AC03F;
	Thu, 28 Mar 2024 19:42:16 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 61E11C53361;
	Thu, 28 Mar 2024 19:42:16 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id DED8812E8CC; Thu, 28 Mar 2024 15:42:15 -0400 (EDT)
Date: Thu, 28 Mar 2024 15:42:15 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: jaganmohan kanakala <jaganmohan.kanakala@gmail.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [External] : Re: LINUX NFS support for SHA256 hash types
Message-ID: <ZgXIF1IzGn8dZGAB@aion>
References: <CAK6vGwma1mALwE1zDUqXhGP+YHjtXdPipykui3Tt0a6NL_KOqw@mail.gmail.com>
 <2DC5A71F-F7B7-401B-954E-6A0656BDC6A9@oracle.com>
 <CAK6vGw=50xecARE1MHmB73VrQS_OFzSqA5c1JF9AuOmjusUDNg@mail.gmail.com>
 <DEC63E8F-A254-4A2C-B0CD-74E2256D0990@oracle.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DEC63E8F-A254-4A2C-B0CD-74E2256D0990@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, 25 Mar 2024, Chuck Lever III wrote:

>=20
>=20
> > On Mar 25, 2024, at 2:34=E2=80=AFAM, jaganmohan kanakala <jaganmohan.ka=
nakala@gmail.com> wrote:
> >=20
> > Hi Chuck,
> >=20
> > Following up with my earlier email, I've noted from the following commi=
t that the support for SHA 256/384 has now been added to Linux NFS.
> > https://github.com/torvalds/linux/commit/a40cf7530d3104793f9361e69e84ad=
a7960724f2
> >=20
> > The commit message says that the implementation was in 'beta' at the ti=
me of the commit. Is the implementation still in the 'beta' stage?
>=20
> "Beta" was used simply to mean that the code did not have
> significant test or deployment experience. So far there
> have been only a few bugs, all known to be fixed at the
> moment.
>=20
>=20
> > I have an NFS client where I'm trying to support SHA 256 for Krb5. How =
can I verify my implementation with the Linux NFS server?
>=20
> You will need a Linux distribution whose user space
> Kerberos libraries support AES_SHA2 enctypes, and of
> course a recent kernel. Scott, anything else? Does the
> KDC need to handle these enctypes too?

It depends on whether both the NFS client and the NFS server support the
enctype negotiation extension (RFC 4537).  If they do, then the KDC
doesn't need to be able to handle those enctypes.

-Scott

>=20
> -- Chuck Lever
>=20
>=20


