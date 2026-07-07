Return-Path: <linux-crypto+bounces-25692-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ygnEMs7aTGrVqwEAu9opvQ
	(envelope-from <linux-crypto+bounces-25692-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 12:54:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2032671AAB2
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 12:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R6ZAL9IR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25692-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25692-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0384301BA44
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1A3E92A9;
	Tue,  7 Jul 2026 10:51:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C73F20ED
	for <linux-crypto@vger.kernel.org>; Tue,  7 Jul 2026 10:51:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421482; cv=none; b=p506NGU+836kkwpcxE0D3qZ5RiUfu2Lmtx1sjZPgcZV+yTvMpFu48zbJJ7VZMgTPGtCvpOpoPyWNK0llcbEItaRyPTc1QzH4uuqmMKNZKk+Y7seDALnIuQnCK6HBWWgpWbTLBEvSo/6XiBUpbpW3bCT3+Jc5QYZGSHnpA3B4u0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421482; c=relaxed/simple;
	bh=wcYlzZWo3MuIy9BvyoUO5qdR5kwAEBJovvFsQQQxvlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6+NJu+S6NKZdAxpUGih7LNPaUPGQeKUnmPRVVWMxJUNM30pFlmy6hXj4/Pv0Plowb2rPJaXBuWWH0061RdBJnVOSlOIpp1A8jJktgRJbEiD3UQ2N/2qY5u3Ilf3L/6Kt42fi5FoycExacGXIZE4SlD57NNRlhtaddCrNdry4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6ZAL9IR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8E91F000E9
	for <linux-crypto@vger.kernel.org>; Tue,  7 Jul 2026 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421480;
	bh=/aEEueN9hhBxaCTLIpl+rJt0PG4Iov+AoWrWIGwC4k8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R6ZAL9IRhe+XBCf/m8Yp46Rgsr6BqDr7zofUwdAxSYx9FdMUlxWdDVYHmMXjSXQ0e
	 GrLCQK4lga4abbnZ2IH4eDbBRhqJWaMo727zxZwdUZ09KdZmIgw+kpOQYd/rSzoNxg
	 21jM+u9pPWN6kRTuG4Ypu4WxuE7T0El+xjzQbOVGBWCsx5D6ApzQZe4Ko7CjsCXhPh
	 kbCv7uMq6AqmUXu7Pgel4TN50Q4jD3I5d8u3ppDocPBf38f1p4UsD769V4V1MZfPJI
	 PUGut6aama3nOTaWF2tz952yHxBDMboKVrbRLOjn8EwFNLocxMO5sF3Q1GUqYJ2FrY
	 Gwee4fxod8Jjw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so7129508a12.2
        for <linux-crypto@vger.kernel.org>; Tue, 07 Jul 2026 03:51:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFPcNmXDVBdhs/rn24YHXqTCTcPDrHpXHMpdGTw4jPOT6j0DQT
	/zlXVLLblwWm25BIw2gw0JukYrhO8+LuFyzYshR/Z78IC241ent3sNv30WA2PW04Lqt5Ft+HfGT
	THsdL1tCsAd8BPGdMSOM+4t5BLw6OqMo=
X-Received: by 2002:a17:906:144a:b0:c12:7f25:cc59 with SMTP id
 a640c23a62f3a-c15a67f80b5mr170816166b.16.1783421479445; Tue, 07 Jul 2026
 03:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707053503.209874-1-ebiggers@kernel.org> <20260707053503.209874-33-ebiggers@kernel.org>
In-Reply-To: <20260707053503.209874-33-ebiggers@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 7 Jul 2026 19:51:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_L6pbCMs148Z=RJzcC-xt4dkwvW6+41MTsY5xm0WdBsg@mail.gmail.com>
X-Gm-Features: AVVi8Cea9nX6PZbXk-5JDoY_Qwh5MBDsrJmZnAf9eRSD8d8g3-vRr5pAjZVc7gs
Message-ID: <CAKYAXd_L6pbCMs148Z=RJzcC-xt4dkwvW6+41MTsY5xm0WdBsg@mail.gmail.com>
Subject: Re: [PATCH 32/33] ksmbd: Use AES-GCM and AES-CCM libraries
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25692-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2032671AAB2

On Tue, Jul 7, 2026 at 2:44=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> Now that there are library APIs for AES-GCM and AES-CCM, use them
> instead of "gcm(aes)" and "ccm(aes)" crypto_aeads.  This significantly
> simplifies the code, especially since the pool of crypto_aead objects
> and all the scatterlist building code go away.
>
> Move the encryption and decryption code directly into smb3_decrypt_req()
> and smb3_encrypt_resp() to take advantage of their respective data
> layouts.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

