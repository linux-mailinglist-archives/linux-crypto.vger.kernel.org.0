Return-Path: <linux-crypto+bounces-23031-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHJuLUwx4GlWdQAAu9opvQ
	(envelope-from <linux-crypto+bounces-23031-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 02:46:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26740953D
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 02:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D422305965C
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90314A62B;
	Thu, 16 Apr 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o3ji330D"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25040AD24
	for <linux-crypto@vger.kernel.org>; Thu, 16 Apr 2026 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300359; cv=none; b=nmFRliil3e7aBp3d8MZNhii4aQjjon78kFk6tQWqMJ1W/1RaFpufNUjwEjVUH26uRH/1VXj1LdLSJbf+ETFQqCaCaCbCUa3Zhv4+a/ypfyQgr4NdyKpp06qqQnT9yPirtpsoqaTiY2OOPVykrGPR/wY1fkpZFWyw/FiCG34BQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300359; c=relaxed/simple;
	bh=gc+pdoS3br/cCEUwwrd0N37zvlUp6ObC/rNJq+jtszo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6T/UO2T28oz/psPhiPZAqm2o/GnksC31oyQU5KDld6BqIRtO2rWYKzSI/C/Okq3P9RaiR5Z/w72d26KW9xX3nZtNsSFGsj1Hu4eoCVs8DftTMkyXPvpu9xK2WIb+l9YTx+o+fdaN5r4uVA2XMHvt1kKBKm+4yGB2U0TKxGtlUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=o3ji330D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8107FC19424
	for <linux-crypto@vger.kernel.org>; Thu, 16 Apr 2026 00:45:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o3ji330D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776300357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gc+pdoS3br/cCEUwwrd0N37zvlUp6ObC/rNJq+jtszo=;
	b=o3ji330D02VoReM7QKOkLW6U6rONSoucRqbjQVtcVvZaDM25ep/2x3mEHidwQi4L1quMfF
	hvEAYCFeDh8R6ml5LHK+FBzuDLU4K1w1abhCAWYm8lS6T4f4uZNJRL1iqlWWU5fU8s/k7+
	+2IgfPQDxwnztuVPr586GKvpOhNovr0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d2425692 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-crypto@vger.kernel.org>;
	Thu, 16 Apr 2026 00:45:55 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4645dde00a7so87739b6e.1
        for <linux-crypto@vger.kernel.org>; Wed, 15 Apr 2026 17:45:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ87Yiov9mxvRbBZ61dccaTdc6tA4gXyffekllS36RLaF2YTTXh5bVhgLs9qO5EmjV+YdzqLk5amY0UDTo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU414C02rz9RZ4hHBYdN6sHx3XCeVBLfqx72IIYq7y3N0FOfYo
	y7gJA482E6Y6CfFM/JBMQkAWDWeWtXGXvmm7/wPSJwhR4tBZRIIto45xluGXQQDfC4gu+1ukSZy
	hI2vXICKoEfZjDEUIZlxcl6FgzrHS794=
X-Received: by 2002:a05:6808:130d:b0:471:d846:86fa with SMTP id
 5614622812f47-4798505ee44mr814225b6e.28.1776300354349; Wed, 15 Apr 2026
 17:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202604151657.8e26ef70-lkp@intel.com> <20260415174755.GB3142@quark>
In-Reply-To: <20260415174755.GB3142@quark>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 16 Apr 2026 02:45:43 +0200
X-Gmail-Original-Message-ID: <CAHmME9q1UVnfEwyXL_Gi8xtRJ3pNhJ55h40nV1gtfQJ4zwt9Og@mail.gmail.com>
X-Gm-Features: AQROBzCOhE_5_BtMA7Eex_hMRhvJQSA03BmtBhLQsOHp5B2iQH7wsS4fL2LxiKs
Message-ID: <CAHmME9q1UVnfEwyXL_Gi8xtRJ3pNhJ55h40nV1gtfQJ4zwt9Og@mail.gmail.com>
Subject: Re: [linus:master] [lib/crypto] e5046823f8: stress-ng.urandom.ops_per_sec
 4.3% regression
To: Eric Biggers <ebiggers@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	TAGGED_FROM(0.00)[bounces-23031-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8D26740953D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 7:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> [+Cc Jason and Ted]
>
> On Wed, Apr 15, 2026 at 04:45:48PM +0800, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed a 4.3% regression of stress-ng.urandom.ops_pe=
r_sec on:
> >
> >
> > commit: e5046823f8fa3677341b541a25af2fcb99a5b1e0 ("lib/crypto: chacha: =
Zeroize permuted_state before it leaves scope")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> This commit fixed the forward secrecy of the RNG, so it needed to go in.
>
> For large RNG requests, we could get most of this performance back by
> refactoring the chacha20_block() API to move the allocation of the
> temporary state array into the caller.
>
> We could also get much better performance than before by using the
> architecture-optimized ChaCha20 code instead of the generic ChaCha20
> code.
>
> However, neither would be a simple change.

I saw this commit when you were making it and also benched it and it
didn't seem like a big deal. (Otherwise I would have piped up or tried
to come up with a different solution.) For a while, I was thinking
that arch-optimized code in random.c would be neat, but with
getrandom() being in the vDSO, we already get architecture-optimized
code there, by necessity. So I think practically speaking, this is not
a big deal. I had also looked into what happens to that stack in the
context of the RNG, and it gets pretty quickly corrupted (and
remember, you don't need to erase all of it for it to become
practically non-invertible). But why should we play games with that
sort of thing? Zeroing is the right move.

Jason

