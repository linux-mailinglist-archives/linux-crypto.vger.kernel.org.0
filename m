Return-Path: <linux-crypto+bounces-20158-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAHSHDyvb2lBGgAAu9opvQ
	(envelope-from <linux-crypto+bounces-20158-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 17:37:16 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9147B8B
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCE5C76740A
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBE439016;
	Tue, 20 Jan 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Brw6E2iT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717C34028B
	for <linux-crypto@vger.kernel.org>; Tue, 20 Jan 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919207; cv=pass; b=logpSg6kmdAnOkEzhIUlwX324jnlraI5NyDrcQfhEK4GCF2PNJL+uFlx2u/naddx1BhnX8f6Xy+ociSYW4HfJCHN8jmuft7IgMmG9F4SuxK4OBpjwL5Eoq6s7iwFv+IHRmWGkyF/Umybn39mx4gu45JmuPtI5YQqldZlUKCtu9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919207; c=relaxed/simple;
	bh=iRq3V9TGTshUsvROKLlwVrfXJ6Y0o2eUwLmYrdqr/HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW57vJ2w0OoDIqwpZyYxdEAOn0AnHGRvLz/fV+4dwKmGcVgB2BW3RjUsQzlBUUPWhcpvA4ufLacAHeH1KL12YJdHxm/3O5cAq+SAmnl38tyPFHV9iHamiv9O+CmJt50JLGDrFZPl5PVvVUxi7qVckJTdLxV5zHlLz7aOfC/zwzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Brw6E2iT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50150bc7731so82132331cf.1
        for <linux-crypto@vger.kernel.org>; Tue, 20 Jan 2026 06:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768919205; cv=none;
        d=google.com; s=arc-20240605;
        b=hw48WOgIVNwuYTYPTzBcPRqJz6ijTg6+jp8JQisUzclSqcCc3z8LMOOC48kw4CHCUQ
         ShaTgJVpLmoecetXlA6SKysG8egWFn4USLcn8Zr/Crq0ufbOS8GCtGKS23yTz0ctjYWE
         ubJdabArrF/yfYz0D29b9xSB/UGV3x4DoHsMG2FHhkP3TlQ3eD8vO+e5BIN4OszM8h7y
         zSwh4QeBo9bgSTj9k3MCslUdGXf532xG/eFddnKAuy9840QRqFHxwrUx2MVDC98cuztC
         LM1IB9qKYt3kuEW3ifeOzLTZZE9JaBBwSq8aUTQa7fep+HB9zDVTXcMzU33b6iaSypAz
         KNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRq3V9TGTshUsvROKLlwVrfXJ6Y0o2eUwLmYrdqr/HA=;
        fh=+o/jVbwjKVH4GusK8heQ+o1cOrwmegH2cwZUAWH3vTo=;
        b=gy39Ws4poEiurh2qJLmePz1wghiNMzPjasp0RrkGAsksFwJ0UCi8bAc/W0D2x10ITG
         RUyL3IUTNOybp6E4TIkNi7PhCnvIdj6O3t/DgD+AMCFTwuaIvN+tMTG2WlCSvRFR/3W/
         mWdNeWRGGqqTEZ+T1Ik2xjq6CBAUBWrq6yRwzf8PaLc9bd25vgsmrWfAm+khkiyt/55G
         aI+Wr6efrvpr9+A5QySbJf98tyRUiQeA9xtljfH4Wx5cLIiMNGRiQgW6Ie1Qy8mOb+Dg
         pCuJDKj0qhthcEkWUkpZkSEoeTN7oqSUSvic21GLZc6Z6sYPWRmb4siSKgJwx3QQy5gC
         XIZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768919205; x=1769524005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRq3V9TGTshUsvROKLlwVrfXJ6Y0o2eUwLmYrdqr/HA=;
        b=Brw6E2iT9/kCrJWwixUvT9umTzNjcJNJEnF3JyDh0Lt7IyX7M4vhwZEw2UNBL9wwyV
         ynGgcvC++G07EarpGzF9RmGvy6EgQ/j6ZfE8DYmRCFQQDW+qFohlKnmpBPLbRUpkVtvk
         J5VIr/xQZXD1h8CyU5ic2Jcm4dVLmVYujv76jjwv+46kmJCLRG3GKN+3iuVmikspi2EQ
         jAU4xpMo8mxlKkGZ0FchXAwEYDodD2nyE13Iuo0W3EJ7noiAFIonPG+o2zpLPzK9ckvq
         GBxwF0tWC32ZKzAKbNulrqVC1/D8elKGw6987GGFuof0J0sp8c2B6e8SeTxgAvD+sVrJ
         rKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768919205; x=1769524005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iRq3V9TGTshUsvROKLlwVrfXJ6Y0o2eUwLmYrdqr/HA=;
        b=GC5GPC2Jw1Ph3uR1QSUikEBRZVsHgWcH+vdgm8phsiKoukVYNZgxYY93Rm928knn7T
         9NsSBUtG4HjFKwQsjCdbHSwwMCDR0PsNoaHhO5AtzQDPXlKaFu8GWgP5+qtsHTddrRp5
         0bdvd7jSt3iuMCkpdUZeCNdtaqfwvSnPZsqsbiP0wQKB5Erhum9qJweu4bVGTpH0KLiy
         ljRBrwmwT5ysk17Ib0P3yljQIsD6Qd8T8fPgoLydd+cuhsypJSi7uxAXc16L6zFsRDb3
         /T5+FAgr2Vd5ogolTJljetVOCT8445NhA6onUWOa9n/QM+eq5EQkYkxaGwMpRtYoBJ1V
         u7kg==
X-Forwarded-Encrypted: i=1; AJvYcCW0nqmFJrYW5SIvRjDEPOhmiZv7CLPdxD6nGq004QNAlR5uzAjkxYnUB7DbpBSpeARpTu7ocGd71/F8UA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0W6WkOHjLPJswpHLiW1Iat1DNo9WgJQhQUm7ASAju5cTxeXq
	N6OaFQmoOjlbT7O0KrE0pQU/4Ab0hfNMygT7zWIBfdew31hvOH1esgf0fAw22On0ShfpGrm4ma1
	xXIOFriIEx4fXPUSngXzgOzBschDQgSIllE5lh6Ju
X-Gm-Gg: AY/fxX63ZhpFhSFXln9xAq/tSQrJysSsXWWy1RTUNYVxeYXi99WJo2Krm2o+dVHOsyz
	PVRutlBJcJ9Gd/XW0kbP5C0bEWtrnAFDudg6Zv34Fx0iiDvFX1JRxV1F/HTj6REd8Y0dKcYCcEr
	p0sbwSgiWyBRE0JFOfnSFhgVlb18X41JafHe+0Wt8nQUkD9xYs2C6cz+ax3mGgv2yputp+GajxI
	VCNd8QVBKtYaZ7kaR4zPvSzGvvrMHCauEZVkJPFEVtDAZqxeN3o9zN4eg9aDypLxb/6PRIZxtgL
	X9x3KDqAGbc+EcFFjVWTwRKT
X-Received: by 2002:ac8:7d56:0:b0:501:426b:d497 with SMTP id
 d75a77b69052e-502a1f2213fmr247099121cf.52.1768919204813; Tue, 20 Jan 2026
 06:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112192827.25989-1-ethan.w.s.graham@gmail.com>
In-Reply-To: <20260112192827.25989-1-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 20 Jan 2026 15:26:07 +0100
X-Gm-Features: AZwV_QhNTGTWINIBPMZao5ljKIiGVxjHAO6q_kPP3h9eB_FkxoIYM4qby5HyYlU
Message-ID: <CAG_fn=W6wdFHYsEqkS37iWOkJUZqS0LUEg-N2HWo+3Rw-76v4A@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] KFuzzTest: a new kernel fuzzing framework
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, andy@kernel.org, 
	andy.shevchenko@gmail.com, brauner@kernel.org, brendan.higgins@linux.dev, 
	davem@davemloft.net, davidgow@google.com, dhowells@redhat.com, 
	dvyukov@google.com, ebiggers@kernel.org, elver@google.com, 
	gregkh@linuxfoundation.org, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, mcgrof@kernel.org, rmoar@google.com, 
	shuah@kernel.org, sj@kernel.org, skhan@linuxfoundation.org, 
	tarasmadan@google.com, wentaoz5@illinois.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20158-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,linuxfoundation.org,gondor.apana.org.au,cloudflare.com,suse.cz,sipsolutions.net,googlegroups.com,vger.kernel.org,kvack.org,wunner.de,illinois.edu];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,linux-crypto@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 26A9147B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 12, 2026 at 8:28=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> This patch series introduces KFuzzTest, a lightweight framework for
> creating in-kernel fuzz targets for internal kernel functions.
>
> The primary motivation for KFuzzTest is to simplify the fuzzing of
> low-level, relatively stateless functions (e.g., data parsers, format
> converters) that are difficult to exercise effectively from the syscall
> boundary. It is intended for in-situ fuzzing of kernel code without
> requiring that it be built as a separate userspace library or that its
> dependencies be stubbed out.
>
> Following feedback from the Linux Plumbers Conference and mailing list
> discussions, this version of the framework has been significantly
> simplified. It now focuses exclusively on handling raw binary inputs,
> removing the complexity of the custom serialization format and DWARF
> parsing found in previous iterations.

Thanks, Ethan!
I left some comments, but overall I think we are almost there :)

A remaining open question is how to handle concurrent attempts to
write data to debugfs.
Some kernel functions may not support reentrancy, so we'll need to
either document this limitation or implement proper per-test case
locking.

