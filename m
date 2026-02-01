Return-Path: <linux-crypto+bounces-20525-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E4XEDExf2k8lQIAu9opvQ
	(envelope-from <linux-crypto+bounces-20525-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 01 Feb 2026 11:55:45 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A336C5B41
	for <lists+linux-crypto@lfdr.de>; Sun, 01 Feb 2026 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5C20300E711
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Feb 2026 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF905324B10;
	Sun,  1 Feb 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KZXxTBI6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41015155389
	for <linux-crypto@vger.kernel.org>; Sun,  1 Feb 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769943340; cv=pass; b=X8FZwGNMgXhyuDIXzcJZJ+J90dK672LX1RamEpvYqStKAJFwkmAdzgogC9YD/KnfoVlh7JjmpT4njL1qCJ4raLpVOJqDF5IOvhYutwSPOBxueqR/cDEmz7Qud80FHfON3XZUBMnSneok+iOId1eg9x9s0tk8HLwhiy0fu5D9BLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769943340; c=relaxed/simple;
	bh=1Swfe2etv/wNCLCtXc4nmkEHhtKTjFFzP3hrwHN72mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXsU76yFQPzx+vuPH4lMOwu595/U69P/OA42leKrzc7/oB3nd5rTJmnkRQxWwjBkFhfLFylup2EC9YKujHRpAuL5J4AXPKQCryf4ATzM6pSxVuiEwnd96S4IPgBVuF6pifsj9O4DonVVfUjIhJL6nl6ehmSxlOB4OrCa6Bl2Sos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KZXxTBI6; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-385b9be0759so28562551fa.3
        for <linux-crypto@vger.kernel.org>; Sun, 01 Feb 2026 02:55:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769943337; cv=none;
        d=google.com; s=arc-20240605;
        b=XMSNESiACI6HE/Nt4WHi8Hc5rBzXUVMjKrDq4PuTur9D6yu3cpkMViMUrFEqfdDoen
         fTfiRADZKpTSAR2P0qNJ3SWNgaVWLmoAxmEYn2auiNilMzjj4Ivr5akwnASd9qLEj1bV
         fSEYw64V/3ZfAD1F8bRLhFuvYUPdVVNSocxnoGq0Y50thuQCuPZOtSy1QTuDuKwCtOrP
         HNdSdfCkRT6cdhUqdtvG1ovTko+C3CFlpuX45yx84HHkyn03ZeJjn2ZP4xbMe2RGEoAH
         IezvJWccVC7xLQGVGvr+FTOmhlWrIJhLqJaQlD+6vChl9sX9jpuA2LNQgyTPHPUXWBww
         gYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8GpgGKP5IZleqQddKeEio7KMhNEW9pWbymGbf+VxVuQ=;
        fh=mw8mHn3cNPvuJvlIWL8CBH788bjxTTLb1vmX+DiLKUI=;
        b=RWTTj0FVIc6H1rS0eEX83TBW35nMCFO7bLR9Rq6r3aaa4mTZrD4CkGxrE+Fb3UbCsA
         LjytWrSE4tDKsoRRhb2CLJpHqbFYiZTDiZqZhQHd30l+Kr9LsSOCwYderclJIfK/KKkr
         fvifTr0LfvvOWZ5T22fyQZT7bpF+rqK3aQRDQCwtIG4cbhF7ISGUHzHCemOweyugqMmv
         4h6Ue/nM4VPrhoESCwh0k0BeciYs475wFjVolimZKODZbbjop5v7eLTtTDOBMr5IzcQi
         Q623mCc3Smqts6LXcLm6ePGwqWQNnf8emZYhd3oCbpFVmtU6PO3kuObWPcTTR/QPfUEG
         mSEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769943337; x=1770548137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GpgGKP5IZleqQddKeEio7KMhNEW9pWbymGbf+VxVuQ=;
        b=KZXxTBI6Sg1e64M7h4Dz9YEEiKy/jVdTz/QQYpM3Y+iAFCt68s39O0l9gPSc1L8qYi
         61Aut5c8xYW/EUmb2FVEJgsJuXTdr7JA3ZLEbWvviwXHrwxfCAsmW/Myuj6vdxZhl48Q
         DCyg+38noI1eDFp1j4BfAGzb/bnegPX+zMLiW6vqOaQxrld4OgQqJxOlh6bX3mJaKP/j
         F7xdjYkY+3MHzTRkpvUVm3kS8Gut4NhVs0ybyT1Uy0pC/95qwDojh0ICUygWOxBAiNeG
         88Fiky9+060y6ifljT6IbrDKPLJphGBrdBTbT+y+oqzG/3HOyVrkN+5156sH1V0S/wRg
         CygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769943337; x=1770548137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GpgGKP5IZleqQddKeEio7KMhNEW9pWbymGbf+VxVuQ=;
        b=wHd6nMnWdVNOUXqAVAqKWHmY0vvb0YzA2jXAn2ZhLUoiNyARWOGQXoUbe9aCZflxZe
         NqKN7DqjxAjGR8J+at7qtlYeCGnE57DvjNgxVtVRqJupqrrZI90ydFm0DGz6d4BB0/F2
         zcyM1XnAwpWkqQENDIeSoRYXm1FK3c/WYD7Jx9mZMImGzSZlI3U9Wmkm2AWNtnTJgR6A
         8VqXgvt8EPL1gnly+XU1kMRpTh2qcB0cVO00zJIuxquEwM8JGU61uoGpt75yZJSAxoG3
         Mged8LG6kN7ywlXUJW/HFzgD3gmEaOxckbnyslufp4bswydQsYnt49tV+69duloK0dam
         xsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvySytT+y4fR0HVOrrj908FdkP6ZpsQvhBZRfoqc4F2jspn/U2IPytlu7W1fDESHYCDZxPZMuJNGfH0Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvM81xhJk83e+lmxzYhIsScU7B3QyQ6zDozpT8WKXXgsDKwp9q
	muLC1ebFW6D8I6s+9f2hrZGLYSmbedNnbSjNtQ+PNU0Z37ZKbXpowb3n2O6TncPtufQppTf7KGu
	z0RVER+Cu/bSrkoOxI73to+RwPt5v+F4SU8Ah6B6Vsg==
X-Gm-Gg: AZuq6aLbOy97w82hPf6nkrDKdexd+hcCZX7km0Szt8GkziudLvttcrQx61aCypNEa98
	QGbE8kpc2LMDb6w7bWK2AW9f3eQmf/kPs7DhRFUcP+rWfhwROmRqa/oPJ+bK4ti5pZS87WOWH3a
	/TVWkIRFhKwRLBCiDQAZZjXR1cekCJ7rK+vYrATWKMDgvS3Ie76aE1jqSjqXcX1At3b6N/2+1/f
	vLeQEEmOySmwpPVDVB4Xt3JiaT3Z278tD+POP8vY6yLMDpWF1N72tdz7kpznnr/HoM6VvUMk3dO
	nvt1WYb9PmY=
X-Received: by 2002:a05:6512:39d4:b0:59d:d661:7918 with SMTP id
 2adb3069b0e04-59e16433cf6mr2997894e87.33.1769943337439; Sun, 01 Feb 2026
 02:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201035503.3945067-1-hodgesd@meta.com> <20260201044135.GA71244@quark>
In-Reply-To: <20260201044135.GA71244@quark>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Sun, 1 Feb 2026 11:55:26 +0100
X-Gm-Features: AZwV_QiiMQ-nKAcQSxRODo5dnWjw_Py087hLnp2WQPPd0C_t5npaQXViBAQcx60
Message-ID: <CALrw=nG0Pj1W-bZ6qQax0WnxSayCtYx97ivRuQMsVZHbsQZong@mail.gmail.com>
Subject: Re: [PATCH] crypto: pkcs7 - use constant-time digest comparison
To: Eric Biggers <ebiggers@kernel.org>
Cc: Daniel Hodges <hodgesd@meta.com>, David Howells <dhowells@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20525-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@cloudflare.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A336C5B41
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 5:41=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Sat, Jan 31, 2026 at 07:55:03PM -0800, Daniel Hodges wrote:
> > This creates a timing side-channel that could allow an
> > attacker to forge valid signatures by measuring verification time
> > and recovering the expected digest value byte-by-byte.
>
> Good luck with that.  The memcmp just checks that the CMS object
> includes the hash of the data as a signed attribute.  It's a consistency
> check of two attacker-controlled values, which happens before the real
> signature check.  You may be confusing it with a MAC comparison.

On top of that the CMS object and the hash inside is "public", so even
if you have state-of-the-art quantum computer thing you can just take
the object and forge the signature "offline"

> - Eric

