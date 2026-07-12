Return-Path: <linux-crypto+bounces-25861-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TR7dBIP/UmrVVwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25861-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 04:44:19 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F39743974
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 04:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hfRWUlvg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25861-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25861-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECF130179E8
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jul 2026 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE672368277;
	Sun, 12 Jul 2026 02:44:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4381C68F
	for <linux-crypto@vger.kernel.org>; Sun, 12 Jul 2026 02:44:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783824253; cv=pass; b=NN9HPWQ4aUa5XB8kPdaaV5J4Qw+M4Wj1w7TK2Pp2fKD6UpqSSWgH4Grf6d9Qdd0mxqOaJvyMdO5TvXfE3BQ/PO5YAsVlxmb0+pFQJCNR6oXKFIDEoCVT/mL1gA7TdZTlseB+BVDLc4Ht2AcmCsENaGRNEUtjZBnU8If3GzSDb2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783824253; c=relaxed/simple;
	bh=VpNyuXu6TnU4VubVPyoSf475P8tqAr0gyIf4yhpsNF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S79R3HO2JddYpe60sc4uRh7qRPFB+i5L0INOkZ8ghQXd5zzvrfm7Q7omT/bAB/5AIDxSTawRgmmJGVotb97WvPuMfGoKRUuD2QW7j+5oX8XkzVa4g2HAIuAdf1Tl2tZJ9+jn4GfuwG5U+it8bKCyX6UfMlesorWJq6gFGxirz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfRWUlvg; arc=pass smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ee88fce572so21505706d6.1
        for <linux-crypto@vger.kernel.org>; Sat, 11 Jul 2026 19:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783824251; cv=none;
        d=google.com; s=arc-20260327;
        b=SwRvE/6IORQ8CcDQ3vWwAjI2pB2wR1hMnTbDBcAifI6opUBYc7vy6499mlVrYr9JQ9
         FAooNjRBsCQy7OVXV0T3XhZC9FVs1GOoc9H9SGYYzcbRRxstWCWEoRXgeyH7a/xeAOhL
         8wKIqvm8mC4TqucKeZSf97s/LwypHcdrVHv02AvZfFjcTIXP5CfHIxPQeo34PG2Vfh5M
         s765uansTwhFZy8Wf5KqQyo4rCkNKLvNa/Oq0/78f6wvRKGZREUCc11is141c+Ro8VDe
         7+JKDu93V8G5ZQMfYccTlS82P1/gpiGdD7DZEnqynUyVEpY7GEq6UNgh94jr6ExbzMV6
         3cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        fh=z8l3n/3gBnY0OIuvxXc5FkqOk8xbSIDwMAaWJ+XV+Q4=;
        b=Dw51nPYNGQAJy7Lwbej87JYOq3+tQ7R5EJRywKIkfo+GP8pZuy2OIOjSXq8Ljt+l3q
         BiWPOGVoY4efyNTiU5j+UZYjYPpqrqGZbJCwccK+sH4Y7SSDmqA/i2+4EXe1FEm2IzgK
         Hnk5D2lBsDpIJ0X5JWvVkaXWpm3eozZh75AETQf9GVYQnu9HF9FRR9yVNUkzbV+7cba7
         PrO6mFpe66k+k0OgoafGDOmu4FaSvFfltNCWZmSB5JsM7nu4A/eB5NcSv15Nx0szrD5Z
         /aMrYf/NhGIJQVqZsJqa+bYDmM2EOEiGgaJWLRgFe4H1hcFoVNOfR8DTg67vhQxMNa1U
         810Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783824251; x=1784429051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        b=hfRWUlvgWVxBd36vJCJ3nPy23IDhuPwZmv8saHCytcRj8gDHvG1RhAiZlrE4TyBFUv
         w5S4YzLQEJ/nbrrA05BjoK3bTLKfYyf8Wc7fhU0hJjKpjn4aqLaGUwZiyRqew0N6DGIy
         PeMBEdbbzDpG3871PtHZljpdNazbQrY1HMJnXWAKsTmmxm4qtd2YV3dkg+oR3qcAgLBT
         h3VSpRDWjMDfnuDBQ5NsOADkL0hT+LaNR4HE9hKEsLVlT4/WawUTFIlyViiYCDGGFHHr
         509ZQKZeIfOFs8EGujHecoylLykD1raEGtuRYnLrZxC2wSpKlDnPv8UnTSpekJwZOSxg
         MQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783824251; x=1784429051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSPbXXuWQiFm+lkWUPjIwu/3EBZIFqc/5MozDdOJ2rc=;
        b=qPeUPygqCQhqNsHmF2Q97jzRoC6x//0JNIcudOBq5x4YZJA+Db5J4L8ut7hjqabvGj
         s2uxj9Om5IepF5TMRv3W3mGd0qDXSuukkahklZug6g1s3DMFOqVkLPPkIA3YVHTxENMm
         pl6wIsDDa3wtyOWYy1qPSJdEzHzYSFIrqySXzzbVnJuTOa5lBwzAcnEtPd5J3cJaNDam
         aP/mbKiTayvSVJr8IQxXPs0rKMPsQ7MCeGCsB8kO/419v3Jea5bBhaIsoqv9zzZkzQ1l
         I7SGOtLz93REuc+PNOo1Zcx5o+4ju7SJ/HgyowUtGs+KV3wU8wmhvzAvzqSmmD8e0kdR
         XGVg==
X-Forwarded-Encrypted: i=1; AHgh+RpLb4xmXUfmoQEirWKMb2Xab6zum/tI4TRhniwz2NmdFcDU1ilsW3i3u1rJKJ253RyzjBLCRXQDuLMxAfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6NlVYc8qhd5s3hbWHl52EnpGnjdksOU84sOe1Oudyf8reREE
	3Mhbe4xRKyCIYahSacsMjvE2JacAN/N5tCWrStBcskJY3d80P7BaMORwkRC+1f81k9RyRC1LMoz
	vgF3OlQ2kSCe6zNKs0YHrrBQTwJs7oKkfuoVqqDY=
X-Gm-Gg: AfdE7ckuyCtdFZnU5RmuF2ILzPFSXUALbflrF2dr/iH7xqmJcIym4Wn3N2BeRX6hRcH
	sSWDt8ZHz1qjy3+1MtM6r//XIKRG7C3wsfXYPfSfquXdgdBliDs8fP6tToFPF02eG2v/87J3Pid
	3JvedcHr4HYGX+V4HgNKi83Eup1+2segYVRQbr+x6Tr3hPHX4c17bCL/ZQUfBaGdYDnZ9fLdEs/
	gK2N+0EvlXf5iRmjE/LtOa3xcX2MOCNriaFdfh2zq+U7ofnxyONVAWSYh82vc6/GADVnYSQG6l7
	FaFMaw==
X-Received: by 2002:a05:6214:459f:b0:8ee:88fc:e0ba with SMTP id
 6a1803df08f44-90400b8395dmr63724626d6.6.1783824251374; Sat, 11 Jul 2026
 19:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705220112.2522-2-muhammetkaankilinc@gmail.com> <20260706135124.draft-0003@kernel.org>
In-Reply-To: <20260706135124.draft-0003@kernel.org>
From: =?UTF-8?B?TXVoYW1tZXQgS2FhbiBLxLFsxLFuw6c=?= <muhammetkaankilinc@gmail.com>
Date: Sun, 12 Jul 2026 05:43:59 +0300
X-Gm-Features: AUfX_mwsFjJKYmNHgJtNJGbvZnqB1zcgYKZqP7pXckm3QbfUyRNP4WT7_Ct4gZ8
Message-ID: <CAAGBmJG-bt2vrKKArWKbGAe7G9U4etkaKnUgV50UTVB-To0bXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: algif_skcipher - snapshot IV for async
 skcipher requests
To: Sasha Levin <sashal@kernel.org>
Cc: herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.22 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.94)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25861-lists,linux-crypto=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[muhammetkaankilinc@gmail.com,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammetkaankilinc@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50F39743974

Thanks for the review, Sasha.

v2 addresses both points:

- The snapshot is now limited to the AIO branch; the sync path passes
  ctx->iv directly.

- On the writeback: I initially implemented it in the completion
  callback, but that requires lock_sock() there, and the callback can
  run in softirq/atomic context on hardware skcipher backends -- a
  sleeping-in-atomic bug. Rather than convert the ctx->iv serialization
  to a spinlock (too invasive for stable), v2 follows the aead sibling
  5aa58c3a572b and drops the writeback entirely. Implicit back-to-back
  AIO IV chaining is therefore not preserved; callers set the IV
  explicitly per request. MSG_MORE chaining is unaffected (carried by
  ctx->state, untouched).

v2: https://lore.kernel.org/linux-crypto/20260712022618.1665-2-muhammetkaan=
kilinc@gmail.com

Thanks,
Kaan


On Mon, Jul 6, 2026 at 5:08=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > The AIO/async path in skcipher_recvmsg() passes the socket-wide
> > ctx->iv directly into the skcipher request. After io_submit() the
> > socket lock is dropped and the request is processed asynchronously
> > by a worker (e.g. cryptd), which dereferences ctx->iv only later.
>
> The race looks real, but the snapshot here is taken for synchronous
> requests too, and the updated IV is never written back to ctx->iv.
> That breaks implicit IV chaining across MSG_MORE fragments and
> back-to-back operations for cbc/ctr on a path that has no race to
> begin with.
>
> --
> Thanks,
> Sasha

