Return-Path: <linux-crypto+bounces-23506-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMueK0sV8WkcdAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23506-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 22:15:07 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D548B93C
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 22:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 538E330F3140
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AB3C3420;
	Tue, 28 Apr 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifh43llB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51A3B635B
	for <linux-crypto@vger.kernel.org>; Tue, 28 Apr 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406992; cv=pass; b=W7NINxoliSPRAF773uI2aUERj6eRbwNgJq0U1CVlBZBLELlg7t/0XX4Z/AjT9bYyJjE+RQlZaIoKw3CW5sZz7Pc2/GVeTnabbFsaZd9UdSa/y9Ubk7ct0FUeMirb6Ag/eHuCl1ifMYx+rgIWzoDpSpPshVomOaUY++F2r4QL7EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406992; c=relaxed/simple;
	bh=NoPJ94OvLOWoKUd4dNdRgWB88m5a8wLnlbGTI+3zbG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyArv1eJAmKl0L4YUJUBSXyNNxKcNc6WaI/6gDXf7B1maClOJWx0ly0UGCJbdguf2idf0hctC0klyCSaCJ6tycvq6cNMAtikIp74bGAt8DEHsvlfDFbUyXwrUpwkPmPuCga6u1ELyNnlnboXjhZG9PhJq0vw0WIs7E4KiC6L1a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifh43llB; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c88e5f4aeso144635c88.0
        for <linux-crypto@vger.kernel.org>; Tue, 28 Apr 2026 13:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777406990; cv=none;
        d=google.com; s=arc-20240605;
        b=TIz5pcLHS8lb38j4Oaf4ok5F+RRRw9cNjC2SGui2N9YubDhCQ33aecl15OVF7/fEsI
         jUzNGVe1Ey3R7RNv8j22m4aaPWfCBeDti1q+bd8SHNlxNiOAJUzKrErA8//L21nolxVn
         alGd5tvSLG/F9T75d5XOfOrRy2d7/0eyIMo82tjiRl6b/EkCqpX8YfPoi4sNI2v/Vcij
         2MUxMLPD5tn6pPbj4Lv9xmUBjfROgS4ycV0M07QKoV/oSu+FEbCje7+qomVrvl9C3iTY
         jLeD8Xgbg7DOBprYKEcoOiBbCX43MgJxOKJVfEQWik31s+xQK7ZGoNEVrJo3eYNnc+SI
         h0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NoPJ94OvLOWoKUd4dNdRgWB88m5a8wLnlbGTI+3zbG0=;
        fh=V/FoZwNnXcs5bCWzPzAq/LgSw5CsWfgOA34mgI3bBbc=;
        b=jrZ40skWcgjA+i25laIh6mzsAKB1OGKgBzwM3pBtIly3Sl+8pb6HRzDIsfskD4Scij
         MS8IVLyTMNvXikwZ/MSc/wPaUpl7L3k++DeC1Q7npgUs7XgMyFjAfFVH9H9P7iijwh3J
         cT9tD2pTygzcPwtlWnSABMsE0LKkYZ7VIxgrata1s8Qx7poY41IBj0YpLn3Uqj5qAuT2
         s1qENA3Z3FnDHMjcUizF5TBAv3hmpMD5b9NIxPbldCbP4C43JkcILk3UrpyxiBqhHGm+
         46VldtnUaZB3WF0TwahpxYFs0wKGrmTEwD92hA249z6rDJG8BiiXY8UQZeGThyIAx3eA
         Si4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777406990; x=1778011790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoPJ94OvLOWoKUd4dNdRgWB88m5a8wLnlbGTI+3zbG0=;
        b=ifh43llBKrW4OT1MFdPM+UzwHyLjAkgfFVRJEY8dy6mC8s1ItiTpjwkCGR36Har/DC
         G3d1xaGIUlgu4zLFYxLa4XT9RdXQOpnUU8cWaAyvszpyIb6ubBlprEWHADtK43ljWG27
         wU2+9coAGGMacspbKtUKil++49lMUbUKxp9+yUzBkV7D5auWaYG8mDbz1Xz7kFyDHRvh
         Ozzi8AL4dZCus69qwAzjdGxg0Kpn4Q8hoWav8nsAH+0vL56/SVwt30+aFcWOfN88hIKx
         S8Bg2uJeW9mnYiSWUyO+2KbVZ9HSqfutwy8njQC1mVV19coJgNPBwVXVXarc9dajZzzL
         dq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777406990; x=1778011790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NoPJ94OvLOWoKUd4dNdRgWB88m5a8wLnlbGTI+3zbG0=;
        b=nBu8Mnq2hHGMiDYnpkGV/tQzh+qtQxvGut56nvNK1+JqJoUPXotoHUvgZfLE35Ze49
         bfS9Qtl1yVzw4pWW9c1nTPOuaVa+LeQxzQRqfo+tQrZ9fSxJTnZ4h3se3hLtj4cfyPI6
         KWXvVGFJ+E9sCUPuiLFGPOIVVallTn/mr7kCEM7t2sYpbXYOTxZMg+bsuDAOucSYB/s7
         oE8gfCz1sJgxsv0nQScRmhFMKTmGswUOYMqXaiUuoewdFt/o/NMNLAl4UuQFOB7C+nVP
         VLa5GSqqisz09VcGhwwxNlgddSEOBEZvKU95c7dIzh4+RhlLMQ3SJgpIeNaF2OOEtb1k
         i6FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nNz5xtXfE/7ClrJ8ihGQysoORFvZe4O0K/59wKgPxtXLqPFGKd27zdi7r4qvWILTkbm/UY6FXzaWEiWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJt4briAjZIP6tm3/k+6E2gp39B+zZzhw4iY05tTULslSMAhu
	ZyvlEftu0XgD6plBlwzNeFNI6UPfRwy3pZR2ZiT/Jmp1GPQFUmrXYSVItDLUUpL1HeTuAfoWIE8
	Ju4CN0nkwzZxY+7THjEKfdckZ9sePeVHve1a/PRLo
X-Gm-Gg: AeBDieu+OOT4Tsj2t/kGBDt/ywzjv3+vScoO8Eew5EVhVjbCaI74RruZ0DLGpaJADcO
	liz54HruexIco3tQjBVo7pCmy8uUPZaVYnGK3h84WpBfU7NvigeUkunmttzjlLmMa1wPIk96fho
	YfqwCWb3GH9tucuSqUH3vjqCn9XeWLSSm+9iwUUO0SOIzFMK1ZvHtn3K60RPFrFSGc4xi8nywnm
	jbMq2pHHutfKwxUgLET8xUSRd9R7CsFcvW6JNgl6rqGKKgeQdrA7RvC9zMJVvwOaoC9KQcfliT/
	XZN1nvXpUlWm8kj+PvNSvQiEuZRdjbyCxk7oyJPJn+Qz9tcz8J1MH6w5knzAEA6yJYENvKTy16p
	wXpFP5PUFEXGTF3WuCi8hupz5O9uxb+fhxz7sJ8ul744iY47Y36QAC9zMhQK7zMwrUXtchw==
X-Received: by 2002:a05:7022:60d:b0:12c:2c8:d490 with SMTP id
 a92af1059eb24-12de2cc86e4mr200034c88.5.1777406989535; Tue, 28 Apr 2026
 13:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427104129.309982-7-thorsten.blum@linux.dev> <20260427104129.309982-11-thorsten.blum@linux.dev>
In-Reply-To: <20260427104129.309982-11-thorsten.blum@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 13:09:37 -0700
X-Gm-Features: AVHnY4JtMAirwq4mT0LQREHw4clPP0ubTFVH-m9JKUv0QTosDtZbFFWFNFtKuUs
Message-ID: <CAAVpQUBQCkb6UHB2=VbppfFBftVsZJDGeGtmBJOuYoaAqOaW8A@mail.gmail.com>
Subject: Re: [PATCH 5/6] crypto: algif_rng - use sock_kzalloc in rng_accept_parent
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 309D548B93C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23506-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 3:43=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
> simplify rng_accept_parent().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

