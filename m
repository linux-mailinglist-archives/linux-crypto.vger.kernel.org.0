Return-Path: <linux-crypto+bounces-25225-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2p1ZJnq/MmpG5AUAu9opvQ
	(envelope-from <linux-crypto+bounces-25225-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:38:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C769B10D
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:38:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fireburn-co-uk.20251104.gappssmtp.com header.s=20251104 header.b=BFOpV3yf;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25225-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25225-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8E3326A626
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29DF48125D;
	Wed, 17 Jun 2026 15:19:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A247F2ED
	for <linux-crypto@vger.kernel.org>; Wed, 17 Jun 2026 15:19:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709575; cv=pass; b=Rob6elfbsCjeYYNP0baK1Xw3XaLPdBSZ0XDqnusRtmGz0k9p+HMpN531W4br2PdHfPoAA6+wPE7z1ysfdIVhY/KepqjPWTIjI/DhEm6o0GLyuEi/Dni2oKqG4ik1m4Cb1by6YoVwCjEEq3UEPtpskFVLZuBr7PbGUcQnrXRWFEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709575; c=relaxed/simple;
	bh=Jm6hSlkUp9+8ytkymNNVkAolB04FA2Ccq4+pdSay7kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJK7X0WrYuhiI0nYOLJxnwucMw9qW+CMXnEyxXLr0gR7lqCk85FLhpT2inUXr51dr/05BFGR99PHsPzYno1pNA/GvCIvSt8NilUM2ULOOqQbaxXvxnL+BWQO9mgT6dG5OpvYu/LjlNPc2TdPh5G74OzPn7MSTi1p0oH8lnAixT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=BFOpV3yf; arc=pass smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso3689806a91.1
        for <linux-crypto@vger.kernel.org>; Wed, 17 Jun 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781709570; cv=none;
        d=google.com; s=arc-20240605;
        b=YcpLBegJQgd1f1TAdTfZVbeCvSZg06ySeTa93kZ+s5nsFlRXM4gk6kG6na2Utpcrm9
         JpBfHHlDSlT1+BjFeoICoj11l2GWNURYPhtiDGVC/04v1kHHdQm1pm8//bUSa/bGgPZ6
         NUzRtjz2XoT2aM2PVRX+M8U5gRu06o23s20ia/RVHl7vGkrMaFXIlhDZm5IFiiDCcxXx
         gy35Hb/b7VMZACpzXInEOE6xEqT/BZnHCQNtV1qoPdMejGLK/fzVpGUfBZoIFZ39Y/cd
         h4fVCK6+a8lTHe1ixPJCIDEUhwkVynWq3y/cS1mCsWLfGjpm5QS7CXSYOYrXYLO3Ezqm
         gneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jm6hSlkUp9+8ytkymNNVkAolB04FA2Ccq4+pdSay7kY=;
        fh=oyGvLGqhWlcqJ+LdSeVlcKOf5891FOvrOK5WK6SHNWg=;
        b=Cxnl9Dk8B4XixfOaW9J08HNcTI59Z/ABzZ14zENUaIl3S+QPA725fvKZp3bX9RhFIN
         Hfwp1ssGhrMOjHx7viNhFBe10Ok/OGglmRMsJqqX/nuErg1uj/tDnM/cgK2vJu/fA3kq
         dryv4ZW0QZPeXlfP+N1qDakcYwsIwI4DHhGBAI2xs4pcpMChtIUvlhzNExRiJVLZlH7K
         xzCJxcx54xjhpBC0lDNYaePL7aoFxhkAXdlowZ3oN9TV1HC2rRNdCucMBtBKQgRmBy4C
         8aMhAw3IryULUZjlVbJfikvckb4+Vf1jKISfsyE5KQrprIityqlrimqmHYNm8NEuewec
         aoFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781709570; x=1782314370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm6hSlkUp9+8ytkymNNVkAolB04FA2Ccq4+pdSay7kY=;
        b=BFOpV3yfn+qdzHxciCXyLgJW7631M8YcPccVK/2dZZQ4fM7jcN9yZsQzx5MgdHTNIn
         2zBvjJFfiHomG13S7KHH+hwkVdkdsc5u1GLOYoPYlVrwbUKZvAROHXv14rGNogHsTYW2
         7G29oWq5VY2gfZftkCT9/3q7/hys93qF+nN9MAdHuGmNJuc5C92yXYzNqp0T4cBFta2a
         HzjvHvWcFM0BIC1R3VAdvjlPEC/iBw3u9rddzjomo29I67RvNFivENKF2ZjMoolMpVDl
         oyjalxknsD9c5t6nlGyWEY38VoPvDLyntebFvqWyFKVC2gnpWvlrqVgMBgX08GtERVAP
         SQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781709570; x=1782314370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm6hSlkUp9+8ytkymNNVkAolB04FA2Ccq4+pdSay7kY=;
        b=GlVWiSd5f1B/SlNS16TJ2Rz4oGxWErVGTcaawRyrETvgVdyFofXn207IYxbSlbzflO
         k9Lc96M9TY+yF903LqaJ6jmNp6PzsTKtg3DqOSHeW44vrRIssmTiHSQcnM9prMI1oKuQ
         6nVbeW7CXkpfAQMHmxGhb9uFc0Yj6/0PifU/IagMkRITxoCsO4+q0EM8SGPCQOlhV0YZ
         9LAUosAnSbkKqfLW4EzKFmhBvFnt3eqUcGWGWcELR8ynPlxoA7InFYNgqT0op+Z6dBWy
         Y78QtrykxOZmyt327Yzh/NnvZyBTdM8YDSgoA8K7DCoVIz4lOo38KXaZt7HHFQYiPVn7
         j72w==
X-Forwarded-Encrypted: i=1; AFNElJ/uQGIvXBcc4QGKopfYxy7SET1hTczabpYDW4ikNaujzrm/HdwSRGG6XOu1Nz9PWrTu184C2v3m2eQSqv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4YmqQz+Zx8caV1RYyXeNUrCyDWgeFSEF+bl8pVdLsw5zLDvM
	VX746LbUzdQGO+G4mvrYUUZJTJ62kBvpkMUMzYVRlG5F3wIJzTTnZHtefWovTUIEYPZ+tG2ov/R
	eSF8PusrQmleabnDy4LqN6GdZRie9CSXTtF/MhD+w
X-Gm-Gg: AfdE7cmgJ6h40PRVmLmLeWGPc4iSw2fY6LSbhF69BDtWPCjqf+el3scnU6hmYogAomt
	MYNFkbxLB+eDShP007F1VuKtKLX5A6ibBetxZ1NGaxmloP5v0Growsoeo9k3hSsTRMefbLG2WOZ
	Y1ySOzGq4B1zpe4NiQy9FRyRTgUSmm22vMiNxNGskV6IywIN/+rZR1el8UaPUnL77/1vKfxwKmj
	EtghSsQ2DL3oN/EYURsbx9MpGlneRaFFatZeQneTqmD0oA5GmCp0ITOkVnUcm4qVOIjuP5GJxRu
	/hHHwia1l5/1HBDbL1LfFiX799PFJQ==
X-Received: by 2002:a17:90b:518c:b0:379:1f28:cdc2 with SMTP id
 98e67ed59e1d1-37c9366af27mr4205011a91.13.1781709570282; Wed, 17 Jun 2026
 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617150143.2152-1-mike@fireburn.co.uk> <CANiq72=me+GZCOW1H5FtfE-b1OY5FXN0yT2S3661vP+S0EDVwQ@mail.gmail.com>
In-Reply-To: <CANiq72=me+GZCOW1H5FtfE-b1OY5FXN0yT2S3661vP+S0EDVwQ@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 17 Jun 2026 16:19:18 +0100
X-Gm-Features: AVVi8CeWuOWKGlZUM8EgPahDPvGN1Vm2nujo09E_7z5rX15dPJ93XA0Nva-RtKI
Message-ID: <CAHbf0-H=bvw77=4ob+AnMFJewYacjxy+v1ZSY0QqDbY-4_D6kA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] rust: crypto: library AES-128 / SHA-256 / HMAC + RSA
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[fireburn-co-uk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[fireburn.co.uk];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:rust-for-linux@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:ebiggers@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:linux-kernel@vger.kernel.org,m:miguelojedasandonis@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[mike@fireburn.co.uk,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25225-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[fireburn-co-uk.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mike@fireburn.co.uk,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gondor.apana.org.au,davemloft.net,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fireburn-co-uk.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E56C769B10D

On Wed, 17 Jun 2026 at 16:13, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 5:01=E2=80=AFPM Mike Lothian <mike@fireburn.co.uk=
> wrote:
> >
> > Both were factored out of an out-of-tree in-kernel Rust DisplayLink DL3
> > dock driver (which needs SHA/HMAC/AES for HDCP 2.2 and RSA for the AKE)=
,
> > but the module is generic. Compile-tested in-tree against drm-next.
>
> Same question as in the other patch series you just sent: is this only
> expected for an out-of-tree driver? Maintainers generally cannot take
> dead code, unless there is a good justification behind it -- is the
> driver expected to land upstream? Do you have a link to the code?
>
> Thanks!
>
> Cheers,
> Miguel

Hi

I've just posted it
https://lore.kernel.org/r/20260617151249.2937-1-mike@fireburn.co.uk

I'd like it upstream if I get it working

Chers

Mike

