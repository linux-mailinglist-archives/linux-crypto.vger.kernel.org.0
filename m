Return-Path: <linux-crypto+bounces-23178-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKgVNm2P5Gk9WwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23178-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 19 Apr 2026 10:16:45 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCB42361F
	for <lists+linux-crypto@lfdr.de>; Sun, 19 Apr 2026 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB453014134
	for <lists+linux-crypto@lfdr.de>; Sun, 19 Apr 2026 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2E337689;
	Sun, 19 Apr 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATjQnqa3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8F28000F
	for <linux-crypto@vger.kernel.org>; Sun, 19 Apr 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776586598; cv=none; b=fSm+gnznofQiOqBAEwlpHT3h1kzKhfIdBxNF2alcewUpJcjsKKQcAoHMVJOmWq0E1YSU13syu4RKDyj8Z8Or1lMuEcVZyBCLFX0xhuUEdo+lG2PlzlYqevKMWwKOLkvQmf6SCnBfMt6vXk6Fuj8GfxJQ7+Knoa6H6hbsuj9cinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776586598; c=relaxed/simple;
	bh=ZAd+IFCa9tZH5vzsuiUNeNba8lEtkX8vemyuywiscs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7QrhcHyLv7RMF9C7W+HnBDeuiNEgZmxczlmYR/tvAsWQrirYASyfvQGp9NYunfaeh0d8h5uX7oNimf1MD28fb9t4y7HhIWA3dRfIa2NAcYlliIWF4uw/eqanm546uUc686oSt5K4pgl/udQ3z93ZCpJlIOC3UVwgDY94jwGtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATjQnqa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385DEC2BCAF
	for <linux-crypto@vger.kernel.org>; Sun, 19 Apr 2026 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776586598;
	bh=ZAd+IFCa9tZH5vzsuiUNeNba8lEtkX8vemyuywiscs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ATjQnqa3/boYdJ63gWBAI6DpeXnJ1Ha6sGbcmc8hs1oklqwpL6t4jWxI0f0f4+Q2P
	 u3GnkaGF59e8QeStNmXilPFvAgZ7y2SB5JzUE5SmMldmHsZj/7troSe0xmiizcw8W0
	 A/Fue5MjjgRkBH+brXtSHl5KjEm4j9DJhTKDcApVCRHj8Uhq5wJnPxY38y/MOpZho2
	 x88WP2ezvSZP9tmzxbx2xFfsDxT25nPyKfiWYAEj5KTH2/p0ULb30iwJ32eZZxOD+q
	 Pfj4tUsmOloGwe4l3hTpI95h4YP7fbvp/Nx+jS8CNiVNfYELaUnea3eMBq3wdXnHiK
	 0ul56XU8A9QJg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-675ab2bde61so108960a12.0
        for <linux-crypto@vger.kernel.org>; Sun, 19 Apr 2026 01:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8p1SJuE27VSF/6nfJDkXtNvG9bksG6XQeuC685uwXfqn+k8E7jAKESYtnaz4iIy4TBWu7h7bWkvIGRY3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSZ6pgCSOGZyIOvzbhFZe0TVSVkgVwthU2vcIAoZp5Q2sRsp7
	UMgUmwi5mGEKDYJuPRhd9eQx4YWyGYRdFGS+g0crP+wqXTqVikPYA1C/WC5ll7iklHoJpwnUGwM
	MEU2Yb2a+SZBoibu+OLh1CyuGh0Lrj48=
X-Received: by 2002:a05:6402:325a:b0:672:158d:9de4 with SMTP id
 4fb4d7f45d1cf-672bfdc8c14mr3002401a12.14.1776586596796; Sun, 19 Apr 2026
 01:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418221707.67972-1-ebiggers@kernel.org>
In-Reply-To: <20260418221707.67972-1-ebiggers@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 19 Apr 2026 17:16:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-g5E0hd63QBOhcZGx=KTe1unGRvO8iG+aQrctSyf7jrg@mail.gmail.com>
X-Gm-Features: AQROBzC7I1NiVlK1mnmba71tTfBdEbCO96YGQ7tM90Z8yYOaVhayMgG7K860Qkw
Message-ID: <CAKYAXd-g5E0hd63QBOhcZGx=KTe1unGRvO8iG+aQrctSyf7jrg@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: Use AES-CMAC library for SMB3 signature calculation
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,chromium.org,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23178-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1CFCB42361F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 7:18=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Now that AES-CMAC has a library API, convert ksmbd_sign_smb3_pdu() to
> use it instead of a "cmac(aes)" crypto_shash.
>
> The result is simpler and faster code.  With the library there's no need
> to dynamically allocate memory, no need to handle errors, and the
> AES-CMAC code is accessed directly without inefficient indirect calls
> and other unnecessary API overhead.
>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks!

