Return-Path: <linux-crypto+bounces-23096-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJu6NcTf4WkBzgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23096-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 09:22:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C714417D9D
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40FC3015827
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82333688D;
	Fri, 17 Apr 2026 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UG9Frnu1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0D296BD2;
	Fri, 17 Apr 2026 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410552; cv=none; b=cTltrF3EKrWSGjlHd55QRFoKGZNiQOpVrAXfzR7BfGXHNzVS0HhbOnYFU7UrBv4ky4PZxqSXJibxr3EXPWhRaZYF3aUddK9BYlKcSRrDrWFz2SIPmQXPkufcs05QyFGbWcx713+UU9ml0AEpEZ0vdv72b4EXsxIEvMb6xgPOwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410552; c=relaxed/simple;
	bh=aYhnMB8exwcdwO8nghToLfcTjGhQoG+YuF3UZPR9I/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPmeEoYl0Davo18g7FxkbiiNBb+S9sPcHVsu/ZLXvcWnCe+3BK6OK9/jK33qLKWMxec8XCj76DX3IdgkYgLQaxSB2R7I3UpG2vrYp79W9gBp81ZTT1G8Ui7iq4wN5ecTvVP/Z9LuSMRAaVCdFyzxKIqLeE/zZdXYoGy/FOr3FR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UG9Frnu1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1CCFC41084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1776410550; bh=KPnHi+1bKzHEd/oisuQ1QlmvkMCVC7FxZM8j7Mxe7mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UG9Frnu1b57q69zn83mAsuhnNTNGDKO0UN10o0LvZN2dlZuElucLKmbkKBVMs3H1v
	 s87GwYC2hihTr2j0Tj2PpLHnVhYvGsimngj6mOnQE8f0D/4NyqcbAAVfPBcYK0i6Nw
	 vv/t7IqumaSkAfEcsNsOVDv+FRN5pjci248jQfvsLI5zZOFKpqP1QwqxQw4FKI3oCC
	 tzEtnoFT67sl7mLxUZfp/K65n8WsSgBkHdZXt3QxRC70HivCxC5k5seUT98QwXAQ4a
	 nwGm8DD3T8avZSpKBHQ0vbj1u/xCf14OptBHzQOexXzSE2cEPj7MqxGwr9BnmgOWfh
	 FhSshEXaRtZaA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1CCFC41084;
	Fri, 17 Apr 2026 07:22:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A
 . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Eric
 Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/2] Improve the crypto library documentation
In-Reply-To: <20260417065529.64925-1-ebiggers@kernel.org>
References: <20260417065529.64925-1-ebiggers@kernel.org>
Date: Fri, 17 Apr 2026 01:22:26 -0600
Message-ID: <874ilayrt9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lwn.net:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23096-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C714417D9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Biggers <ebiggers@kernel.org> writes:

> While the crypto library already has a lot of kerneldoc, it's not being
> included in the HTML or PDF documentation.  Update Documentation/crypto/
> to include it, and also add a high-level overview of the library.
>
> I'd like to take this series via the libcrypto tree for 7.1.
>
> Eric Biggers (2):
>   docs: kdoc: Expand 'at_least' when creating parameter list
>   lib/crypto: docs: Add rst documentation to Documentation/crypto/
>
>  Documentation/crypto/index.rst                |   2 +-
>  .../crypto/libcrypto-blockcipher.rst          |  19 ++
>  Documentation/crypto/libcrypto-hash.rst       |  86 +++++++++
>  Documentation/crypto/libcrypto-signature.rst  |  11 ++
>  Documentation/crypto/libcrypto-utils.rst      |   6 +
>  Documentation/crypto/libcrypto.rst            | 167 ++++++++++++++++++
>  Documentation/crypto/sha3.rst                 |   2 +
>  tools/lib/python/kdoc/kdoc_parser.py          |   5 +
>  8 files changed, 297 insertions(+), 1 deletion(-)

I think this is great - sorry about the snide comment on LWN, but this
will make this documentation much more accessible.

Thanks,

jon

