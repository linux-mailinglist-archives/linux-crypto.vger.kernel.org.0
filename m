Return-Path: <linux-crypto+bounces-22988-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJYfLio63Wk3awkAu9opvQ
	(envelope-from <linux-crypto+bounces-22988-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 20:47:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A53F2388
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789E1300EAB4
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Apr 2026 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A22D0C84;
	Mon, 13 Apr 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mega.nu header.i=@mega.nu header.b="CD3NH8Ds"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mega.nu (mega.nu [108.65.49.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4AE7DA66
	for <linux-crypto@vger.kernel.org>; Mon, 13 Apr 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.65.49.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106023; cv=none; b=hZ0eoODK1cQXTOsFIG9mHQnv73ckARoH1qAucgf56KqiRqU9/UFo69FtQinHKZdalvNvj26nIK7l1GoWlH8WX3Npslc8YujKP5mEUVf1yaxy/XRrynIrA7ljuxd6sSrizis+y32gnsxgSzc44R99K9JLo3sI4g2ktphH0yEo7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106023; c=relaxed/simple;
	bh=Ph85Y48VeztU7aHl7zkGRnckoPd/jAjcQ7RV2VFdugg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tI4Ungea7NoNPlwmU2PyPUJOPHHRJTVBBtghAgGFz4bIyvjSmrqFQTqEqXHPAMMQRsWKuGPdJ5xiHStZJXLN+JM/DXsFusuzzu7iDmScGSvj+5EIksxvSiyPOmn0lb1/kMQ55tjDTxIfUT1yYwct2YdT1T9BPS36lzdYLiOYguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mega.nu; spf=pass smtp.mailfrom=mega.nu; dkim=pass (1024-bit key) header.d=mega.nu header.i=@mega.nu header.b=CD3NH8Ds; arc=none smtp.client-ip=108.65.49.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mega.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mega.nu
Received-SPF: pass (mega.nu: authenticated connection)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mega.nu; s=20180922;
	t=1776105989; bh=xSovlgnRaHD6xLEK7cAlaHoU4jOL3RcTF8f9KkVkaIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Cc:
	 Subject:Reply-To:In-reply-to:References:Content-type;
	b=CD3NH8DscQesG0ZMaGHgnRmnC36kfnFC78/HJ7DBH+R9aSa/ugwYqNSIq8cnKTRv1
	 PoSyY9AMNgnZdU6JbyiHvE82xcPao5DSGyOplMRoGMef5PC3oJbzLbfoRtROkv3MmL
	 4Ot+hXaPuOoJ2TspyVyQwpgCvp0alG+703DhD42o=
X-Authenticated-User: douzzer.mobile to mega.nu using PLAIN
Received: from douzzer.mobile (localhost [127.0.0.1])
	by mega.nu:587 (8.18.2/8.16.0.41) with ESMTPSA id 63DIkTvm006209
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 13 Apr 2026 18:46:29 GMT
	(envelope-from douzzer@mega.nu)
Message-ID: <f950e9499dabd2a7204c11c71d75d9bf67b8c49f.camel@mega.nu>
Subject: Re: [v2 PATCH] crypto: algif_aead - Fix minimum RX size check for
 decryption
From: Daniel Pouzzner <douzzer@mega.nu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Taeyang Lee
 <0wn@theori.io>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds	
 <torvalds@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, davem@davemloft.net,
        Brian Pak <bpak@theori.io>, Juno Im <juno@theori.io>,
        Jungwon Lim <setuid0@theori.io>,
        Linux kernel regressions list
 <regressions@lists.linux.dev>
Date: Mon, 13 Apr 2026 13:46:29 -0500
In-Reply-To: <adsuZfIjp6OcaAsi@gondor.apana.org.au>
References: <acOpDrnN3cVfiASk@gondor.apana.org.au>
	 <CAH-2XvLZD_-CVQT0omao2+GrdQt1Loq+oo4X6q=0NUAeUk==1w@mail.gmail.com>
	 <acTSfLPWDGTaGIf7@gondor.apana.org.au>
	 <73ab5267-57b8-4394-9c10-4ee3bf92e444@leemhuis.info>
	 <adkOsK-uPRsv49Yz@gondor.apana.org.au>
	 <ac3f34e743737c128c289576c1f134d1991d4552.camel@mega.nu>
	 <adsuZfIjp6OcaAsi@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mega.nu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mega.nu:s=20180922];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22988-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[mega.nu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[douzzer@mega.nu,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: C88A53F2388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hooray, all clean with this, on all impacted test scenarios.  Thanks Herber=
t!=20
And made it into v7.0 with over 5 hours to spare :-)

On Sun, 2026-04-12 at 13:32 +0800, Herbert Xu wrote:
> On Fri, Apr 10, 2026 at 10:33:39AM -0500, Daniel Pouzzner wrote:
> >=20
> > Meanwhile, next-20260409 with your point patches to
> > crypto/algif_aead.c:_aead_recvmsg() and crypto/af_alg.c:af_alg_pull_tsg=
l()
> > deterministically produces wrong results on these:
> >=20
> > [FAILED: 64-bit - 7.1.0-rc7-next-next-20260409-dirty] AEAD ccm(aes) asy=
nchronous one shot multiple test
> > (/usr/local/libexec/libkcapi/kcapi  -d 4 -x 10   -c ccm(aes) -q 4edb58e=
8d5eb6bc711c43a6f3693daebde2e5524f1b55297abb29f003236e43d -t a7877c99 -n 67=
4742abd0f5ba -k 2861fd0253705d7875c95ba8a53171b4 -a fb7bc304a3909e66e2e0c5e=
f952712dd884ce3e7324171369f2c5db1adc48c7d)
> > Exp 8dd351509dcf1df9[...]
> > Got EBADMSG
>=20
> Sorry I got the maths wrong.  This one works for me:
>=20
> ---8<---
> The check for the minimum receive buffer size did not take the
> tag size into account during decryption.  Fix this by adding the
> required extra length.
>=20
> Reported-by: syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com
> Reported-by: Daniel Pouzzner <douzzer@mega.nu>
> Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
> index dda15bb05e89..f8bd45f7dc83 100644
> --- a/crypto/algif_aead.c
> +++ b/crypto/algif_aead.c
> @@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, struct =
msghdr *msg,
>  	if (usedpages < outlen) {
>  		size_t less =3D outlen - usedpages;
> =20
> -		if (used < less) {
> +		if (used < less + (ctx->enc ? 0 : as)) {
>  			err =3D -EINVAL;
>  			goto free;
>  		}

