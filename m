Return-Path: <linux-crypto+bounces-25817-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id njiBEFDIUGol5AIAu9opvQ
	(envelope-from <linux-crypto+bounces-25817-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 12:24:16 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2B739A5F
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 12:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FhM5sijX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25817-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25817-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06AD300E245
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B44071CB;
	Fri, 10 Jul 2026 10:17:52 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B340681A
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 10:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678671; cv=none; b=BuqCGgrPv1B256WN43ZP5xpYIMv2ClOKJGXuJjThB/wSLSOCu6WBODp7H1HTH0wUrthy1JlBiETs6I8a6dSxTKriBPRKWsBz8G2KgtJ1hu8oVGE5JdQXljCUdtcXYf7Rd/kKQhdQ1PydGBpoSCpX1PWjU4Amyp9CTAkio6Xel+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678671; c=relaxed/simple;
	bh=y9qWk9cJLZQicI63fmh7280tbO5NRBzwGQME6T3CAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeU3E72hkFFUw2LoS+SpB1uDEiyJSkGVecVouC76ttjx7zCzWt8eB9W3G8AWU29KdELnTcXcDoOwmW+OXormDHxuRG1/jOsDENIiS3LEEBQ0nBvqEnFa4UTnpA+fIkPkAjp6US7pqqiyENZOt/ohxy0InMfIUXyMPZAyGJEXfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhM5sijX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1146C1F000E9
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783678668;
	bh=y9qWk9cJLZQicI63fmh7280tbO5NRBzwGQME6T3CAn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FhM5sijXvczeoHmlKhz/HsYE6VmxCT9Vtcgly8UR+p/QL7SufvSABA7TtWsTAuvpB
	 meJeg8zwicPNnpM+QEmvnX8Gk7pzUaAqeiH7uDTut9qyy8HsFu7wHRjks2dxCvj6hI
	 o4Go12W+aUBCVSjIsURPD5Mz19mxmAdceT52cgd3w/mds8SYdy7zYwH3d2JcpudS4i
	 nxkLzDY57I7ti04FcqfEdYv+Smo/Mn3Pm7MLUt4RKTQbJ/ihHuNVyy+QKbwB7jAR+N
	 i++tUcQ0UZcYbNaWNoJyNTEz25UxkDB8EIExBKrynaXNuDVlvKUW2m0qnAc1oKLsHy
	 5xIm45QJo/kdA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so634776e87.1
        for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 03:17:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocqN7vKoRk82gZIScxASVENGKO1F2iyDGypXrx+cxXovvcQdgWOzB0KTG7iLNKbBeml0pHGM0gchTsnFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUKKjxD9eCqIRWBPoBXCvIdljOI4om/R1LjZV1iYMk0/HlRXk
	jfgbYtdfF5mEEuyPd6V6QBPVeYJQj9FdWxbhDyUGBbVmYfjO+OdQ6JmWY3UlGmNoKhT3PuS5Pe2
	87INzfny72cAmx1fS281hpjTayBCv8lk=
X-Received: by 2002:a05:6512:2305:b0:5ae:bd53:70f6 with SMTP id
 2adb3069b0e04-5b011463cf2mr2828605e87.4.1783678666894; Fri, 10 Jul 2026
 03:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710074216.734849-2-thorsten.blum@linux.dev>
In-Reply-To: <20260710074216.734849-2-thorsten.blum@linux.dev>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 12:17:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLmWvxiKX6=3-U0nxLYnm2uWkUrd1ac7P1LK9xn6-93aFw@mail.gmail.com>
X-Gm-Features: AUfX_mxDcKSIV5VeiNMT3WnVlpI0alYwosA8IttxVMHe_RGcKbAuZnkNYzHD6zQ
Message-ID: <CAD++jLmWvxiKX6=3-U0nxLYnm2uWkUrd1ac7P1LK9xn6-93aFw@mail.gmail.com>
Subject: Re: [PATCH] crypto: sl3516 - drop invalid sg_dma_len checks before
 DMA mapping
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Corentin Labbe <clabbe@baylibre.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,googlemail.com,gondor.apana.org.au,davemloft.net,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25817-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:clabbe@baylibre.com,m:ulli.kroll@googlemail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-arm-kernel@lists.infradead.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ullikroll@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FA2B739A5F

On Fri, Jul 10, 2026 at 9:42=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:

> sg_dma_len() is only valid after mapping the scatterlist with
> dma_map_sg(). However, sl3516_ce_need_fallback() checks it before the
> source and destination scatterlists are mapped. Thus, a stale DMA length
> that is not a multiple of 16 could incorrectly force a software fallback
> when CONFIG_NEED_SG_DMA_LENGTH=3Dy.
>
> Remove the invalid checks; the existing scatterlist length checks are
> sufficient.
>
> Fixes: 46c5338db7bd ("crypto: sl3516 - Add sl3516 crypto engine")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks right to me.
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

