Return-Path: <linux-crypto+bounces-23273-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGzfA0GU5mnGyQEAu9opvQ
	(envelope-from <linux-crypto+bounces-23273-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 23:01:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B3433DEF
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7571F301A511
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E03388392;
	Mon, 20 Apr 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="kvTkuC60";
	dkim=permerror (0-bit key) header.d=chronox.de header.i=@chronox.de header.b="ifD6kezo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43F38655E;
	Mon, 20 Apr 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718900; cv=pass; b=MB0ASVRgaAZotVWdPe7loePnToi5JPxzDKZhXD1VdyhlRnNKt5PgZQoDpfNlj2xf87+gc899huG0ie5J9W70ay8MtMX1haVK3irkJ7SgdPese5QWKhqfcCAcnPBCHvC3upYwsqzcYG3hZOeqXXskbVCpVUVkluDkZ/SoAQJXhn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718900; c=relaxed/simple;
	bh=ye4h1b45Dhz1/x54QS8ou2K3uUMBfzGC9UtyHDQWRzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZbfORkXHdZknwQdk+RdTc8ZIKbAGpNMXrT/zZH5sVfB2T/QnxSSa9B3D5meBMH6UsiVqXc2YbNpw7uPNrZdcIhSs/udQG7mb0U1dAm65H9ee1QWHs7GPshhCz/IKpCjo5XL9sW8hQ+szXk/ZG8hO3e+mrWqjfSz7sJNNdEnRmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chronox.de; spf=none smtp.mailfrom=chronox.de; dkim=pass (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b=kvTkuC60; dkim=permerror (0-bit key) header.d=chronox.de header.i=@chronox.de header.b=ifD6kezo; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chronox.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chronox.de
ARC-Seal: i=1; a=rsa-sha256; t=1776718719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b/ZcjGku6PD92gbfosD2DQU2fVctQBhwzcQVy4B5V3XpYip1dwDFDBMI9e7x8jye04
    b21tCWI8XWKWz961EcAhzyjhiIuEU4IGGJ1MlSP6kTJDhhF8Yn0BBKQjAWmsJiT0zaYT
    QLp2a58ZGWfBq8cx6Ty7uyvjmdcr4PAQnkgdBVnqBsBCdtO0xvJ/GA3URIkrhboIKcwX
    7hmzIobR6blsuhljkJxF/7TpUYtonfechjumEPgLoZNuPPC3avJ1aEiC0HG87/DcW6nH
    6gXjUf02Oddk31+ZThc2ejF7JeAebim+BRhS6o65ZGAtnaEFMj707RQziVJcIBsfbztJ
    hO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776718719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iY8nb1K/EOQXWn+2rIphqaNIopvdK5Qv6Mg1KVW+G5A=;
    b=fdbWFrQlcvTXGYTBBdaeAb9A5vKQSUXKin7iUl0JKqMCClQBV545cBtsrALWkKN6+r
    ojnUpKeBAvuGVWjHR3tcDkgbY403j0tJid0XR8xYgj7riQ95UNQDsW0EJQwP7gPUKUBv
    ISYXDwI/fdcgBtfQJYM7/55jmQMDrsgLQ1fcY5uaKcCpCztZS4tWZRIiKBBPYB59dHOk
    nkcZrC6PmQnwNUTrguUnTjdlbjs/wO6psr1znD7KMcWcP1C6pDIWfP/x/NcpSyMTI3w6
    GDoQyjy5pUgvVN65XNXuLGEYv/BkugeWUVS3gvKLmnf/YcGtsW5BEKiyO9XIeiHHNx8R
    9alw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776718719;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iY8nb1K/EOQXWn+2rIphqaNIopvdK5Qv6Mg1KVW+G5A=;
    b=kvTkuC60z07xZc9DB7uIT/CRrOrejRtc4zuWRFP7RmknlohxN3hop297y1zYNeXoIj
    7JKbBnZwGMZMk7jrDPgUR+Q7B6TmxmfGCTKPyRt4c2IvlK6I/VC7sSfvyMR0q0LW5jgL
    mWQ+2Vk9gb8/XvKSqN5YSbze3P2r+WDAJJMqVeE9WU3KnnsdKsOPktQc6EJ3idvpzfbV
    K3mkyVFf2SiuCai97GdsC2B5wm0CLhPj/hKPT8IFcoRUoEbUimeas55r25+G+AVgGlGh
    9vjxgiwd9KuStVPvTBkGelZRpzijXqHnYoPb5buFBo+A2eYOh+KL6pJHu3EC5Wnqkfmw
    RQJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776718719;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=iY8nb1K/EOQXWn+2rIphqaNIopvdK5Qv6Mg1KVW+G5A=;
    b=ifD6kezoROyTexqkOLBGIUyzRMmEBEDz5gKxz/vK098BpTEky897MWeotbhHmGOS+l
    mk9bnBR7vPG7Nh7nizDg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeIHyFbS0Vgyta8="
Received: from tauon.localnet
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id f7792023KKwax5W
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 20 Apr 2026 22:58:36 +0200 (CEST)
From: Stephan Mueller <smueller@chronox.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 12/38] crypto: drbg - Remove support for CTR_DRBG
Date: Mon, 20 Apr 2026 22:58:32 +0200
Message-ID: <5687317.Sb9uPGUboI@tauon>
In-Reply-To: <20260420205607.GA153390@google.com>
References:
 <20260420063422.324906-1-ebiggers@kernel.org> <10862605.nUPlyArG6x@tauon>
 <20260420205607.GA153390@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chronox.de,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[chronox.de:s=strato-dkim-0002,chronox.de:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23273-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smueller@chronox.de,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[chronox.de:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chronox.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D3B3433DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Montag, 20. April 2026, 22:56:07 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Eric=20
Biggers:

Hi Eric,

> On Mon, Apr 20, 2026 at 09:54:48PM +0200, Stephan Mueller wrote:
> > > Note that the only way to select it
> >=20
> > The selection would always be done during compile time for those vendor=
s.
>=20
> Again, even if someone were to want to do that for some reason, the
> status quo is that it's not supported.  That is, currently you can set
> CONFIG_CRYPTO_DRBG_CTR=3Dy, but "stdrng" is still HMAC_DRBG regardless.

Changes to the priorities were applied to their kernels.
>=20
> - Eric


Ciao
Stephan



