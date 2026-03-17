Return-Path: <linux-crypto+bounces-21994-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBVIcAAuWkxnAEAu9opvQ
	(envelope-from <linux-crypto+bounces-21994-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 08:20:32 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3B2A4B40
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF3DE303BA6F
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70C946C;
	Tue, 17 Mar 2026 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="RvrrbF6k"
X-Original-To: linux-crypto@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCF28314C;
	Tue, 17 Mar 2026 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732029; cv=none; b=lVmXMzQ6xASUeKVp1BUobP0xF8klrpkYkCe93WejeioCZAWOSKArXHzV1ozo8qvf5kiZKw3N3zTljIlJ1YpP+++SkohSrI9FxRDyseinqgneJT3mEUOgF7zUekreFDeCuvCuVpi2stoiZcT8gMYD8S4GBuNgEUcbPsbsgEwZ4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732029; c=relaxed/simple;
	bh=E5sZVEq2WWpN/+wuHFT2HtcxRzclcrs/30GgikonGv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gP6xV+60XTNb+j8jSscD+L0L91ukRJEw+BS0gvObw/KqsotUWMPid0FosnTdG4twRhFUR9QHUdbX8aZLbaFd9ruZSs1HJXbK/UddDudbP/L7mYTIREX6YV8G11IkGaL4/N+r/iuTF5Ruxtvzp6yYJDVLZwJZ5ml/otrm/9HfLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=RvrrbF6k; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MLK/MzCSFDXEBzGQYYqULug04vL9DbdvEieFHbU2S1Q=; t=1773732026;
	x=1774336826; b=RvrrbF6k1rFzRzev2ivdktlmIORxGE16aZtxqUJrrkTm9AqprYSVGhw7+Et1R
	GPnw9pyZk6me35nnmENNcdH+HGu89J6mTcGpp2Yxk+9WLYdSnvp53dxA0S5xBiORQvstkap45w+KF
	c+9KFuLgq1pMJGTuzz9OyVbqSjbnGpDW+LYqeZAJP8SBhbGcY7EbCypDbTRta4Ge/LntxISC3Ezj6
	NvSLfFw5pev6xIlUMSxVfxcCCaaGv4RGtaEKlG/UG8x10BrJ01T9UAcKkBE9wW9QZIGTh9JlEkpVb
	LpPm3i6TpQ6DhgTNQyp21+K9cvzDytVmLmu3n8UxzibGYtIs+A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w2Ofh-00000001XeU-0O8o; Tue, 17 Mar 2026 08:16:57 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w2Ofg-00000003shH-3fVs; Tue, 17 Mar 2026 08:16:57 +0100
Message-ID: <76ed4ac4c86341c5c9168aeee8cd53566e018001.camel@physik.fu-berlin.de>
Subject: Re: Does the SPARC optimized crypto and CRC code actually work?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Biggers <ebiggers@kernel.org>, Nathaniel Roach
	 <nroach44@nroach44.id.au>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller"	
 <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-crypto@vger.kernel.org
Date: Tue, 17 Mar 2026 08:16:56 +0100
In-Reply-To: <20260317034539.GA2705965@google.com>
References: <20260316204211.GA2661@quark>
	 <ca9ba2ec-849c-4f86-8ac9-274ac4b5f885@nroach44.id.au>
	 <20260317034539.GA2705965@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fu-berlin.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fu-berlin.de:s=fub01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21994-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fu-berlin.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glaubitz@physik.fu-berlin.de,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3B3B2A4B40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

On Tue, 2026-03-17 at 03:45 +0000, Eric Biggers wrote:
> On Tue, Mar 17, 2026 at 10:48:52AM +0800, Nathaniel Roach wrote:
> > I've been testing some of the PCI changes that have come through on my =
T5-2.
> > I'll happily add some tests for the crypto functions, I've just got no =
idea
> > how to do so.
>=20
> Well, try enabling all KUnit tests in lib/crc/ and lib/crypto/, as well
> as CONFIG_CRYPTO_SELFTESTS=3Dy and CONFIG_CRYPTO_SELFTESTS_FULL=3Dy.
>=20
> However, will this be a regular testing run, or only a one-off run?  If
> it will only be one-off, we'll quickly be back to where we started.
>=20
> We need regular testing on either hardware or QEMU.

If Nathaniel can test the code from time to time for the time being, we sho=
uld
already get some coverage. In the near future, we could certainly set up a =
CI
job if you let me know what infrastructure to use for it.

Please keep in mind that a lot of us are doing this as volunteers and we do=
n't
always have the possibilities to respond to such requests within a short ti=
me.

Feel free to use the sparclinux issue tracker if you want to file any reque=
sts:

https://github.com/sparclinux/issues/issues

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

