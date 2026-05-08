Return-Path: <linux-crypto+bounces-23837-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO5FCUZP/Wm1aQAAu9opvQ
	(envelope-from <linux-crypto+bounces-23837-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 04:49:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCE4F0EE4
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 04:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0DC3025D01
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DD175A84;
	Fri,  8 May 2026 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDIPWXri"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEE2BDC1C
	for <linux-crypto@vger.kernel.org>; Fri,  8 May 2026 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208563; cv=pass; b=SfZa5uK+rZiouhiosHdStEDYCcZKduetSrGm3Gs6HsC+9tuwwMEjyF7aD1c/YsoNO3YI8aHK1M4H7SlnV5cJrxp0Yo+GFj/jd7jG4Nh1MMQSyE6n1T1EutpVpH0xr5lfZFJ4M3iJmvtrG436X2DI+zbclbpydlFra/0BZOsZmUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208563; c=relaxed/simple;
	bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdoOYQZTgkI5od0LlrPf/zUv/4IDZ0eQZpjyHjpoeVN4l4VikrGgmh5C/0FHuP8RA7RVu01hP4eUTanw4B7isRW/3AinCSXCXpOXvaW0r9dirEWa6Xj46ASNd1EGutDjI+M96Bn27ScWpPs61VaSbZmKvRH40rY1gpnC1MIERfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDIPWXri; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8bc379fcb51so798316d6.0
        for <linux-crypto@vger.kernel.org>; Thu, 07 May 2026 19:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778208559; cv=none;
        d=google.com; s=arc-20240605;
        b=X5n2OnIoD1KXQGVplM0HGxzGlBOPJUIx3MjF+3AfyaePXLVaTldhWgbL/a+TYMSb/o
         U2wkBYKZd5j2+N2EENA2lq5N/PaS0lR9Rs6u7KSYYhWBeicx//5yvwrEzkuYkuM8jiz0
         pnVHDm6Nz7M0etc4lTtRq0RR47XPO4Evk/jSOfyU7lFRJvRJX/2UYPKIAiFGj7yGcuII
         L10mLptAYdz5hMw5xLPQ6Gvdai+SVFd4dN6l+Kxh4OYWSaI4+nueZO7Q1a978ohdKmIs
         gntQPBcNk9oLHdo4hMOtyVjcCLfZkA4HHwa1050lvap+3ru6nty8cISbA7lGWq6NFp1U
         p2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        fh=Bchi/oEUDDtfooq5ip/o4h6xh/qQrz5WlP+htOYaHnc=;
        b=LT2+h12EazLzAs1JWoZaQtA44zFn0ylXd41gf6WuFw7EzTBvJFlS1/EcLYxn3hHK1n
         eDKZ/zCzkf8HlIlCRC93G/lzhgaGMkhWe+KriUxMo9miCHOCLKaPNow6uot52/GXuzlz
         X1PzUrTOZV7CJs4F5XuNKYyw4NCfG3pLAmfi6I3lD30yIVfLryEyNTgpdWLXyHv7/sp0
         1Wkfsz+XuOoEKv+l+JJsTNOf4YlqkR+zjnOCqwPQlZiw6sjLPeDILDgbXZaBRc9W/eyK
         j07eUOgM1CQY+Zv79zfe96b/qjGqLECC8Q+gCfC4LQsbZ0uNLD7mgLlT/+avboWwtsvn
         Lb0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778208559; x=1778813359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        b=YDIPWXriG5BzJ7Qs+RDR3hpC3vGMiQoVNZupWRSm1RIMM090/b/mXE+9YeASWD0KC0
         M64hjX0TpSCkf54hRp3mWqcQaJkGUkLqrBEfxwan8Ao/dWNI/fEEYnMK4vU4NiMfzMzs
         HpmaO99kk4pv1vVBqm9diAuZFhmIpEKCR/fuh+gp3WonJe8C2BDHVwPGaUg1WO6kPpse
         M6s0ai0AoJlx8RdrGd34ZWrxqadb/hx+Ju6vtM3KTgRM4S30c5PONsq5iiQx0fxKmXYi
         IEzh5MKuzsp6NrRNUsHM29lLsvqUnj2tPbQqYlzKZch4V+6m+i+hWpIebMG0nDqv07mA
         mN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778208559; x=1778813359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        b=SlRENcKJvN/1HFXrfZwAZnvLjDhY/jkse1xGIFdxfFI6/g95j9zpN6CHqGVbg2HYP0
         ataBW93OBGNEp/gFFefQLdUNoG9wcGJtjQaYUxCUjuAMaFTUoBFZjIA160iEqAIOnnVv
         PAWLmAnDyHBrGW5goAOTIgiwMoIJRk+g09oXV6B2gyXzadgbLySw1a9bPmFvhr9zGmcU
         MDYe0v6+3XA7Bz29YumtvB0aQ85pTX4HrrNVvwNVAmnJ4PqQyugCTefc/pLu5E/1OXYC
         zmOL3TQk91wbhz2X0JMbqhDLjLYgcu89GRvHx0uSSVOxG/dG80helzMEgoyzmJJI5Pbq
         OFng==
X-Gm-Message-State: AOJu0YyZuGBzHqXnwXm0/weIkEzCeOUeK64tGu/r1bF+opuhmQuzoEy1
	CgWNud44q8Fy7ffwL0k/K/HpsEuUpCW9p5nOzOT64jgWlbRl+aHu3U47Hpbx1wnxb6pzt7jI3H7
	9aEPU2Hwu7q8EGETEguHZpPeWDvuw2Bg=
X-Gm-Gg: Acq92OHs7uz5skvn2/zdckMXvZx64SCHFsAV8blzk5MrhrwT6a1sbkbVVKpsbzJ4Bfr
	mWDui591tTEoli02u6+ViYV4sDJpa+42WB3yO8Tx4zVb4ShEL0eb+9gf5JvxhqgqM1IKOgSGUCH
	U3/Hcmxnmt9S5RQGuSZ5I6KkdA6Jt8v5vRG65DoSLbf81DZH7xx+Mw4S656PJsWuYdOYgTnOT2L
	fXBINWsPTY1hOZofiipbRUf+d9tYvgnkv/u1t+W+InblhMyj/Sxek/bj82pkBT0Uo+cNiKCmu1/
	Y3ubIozOipSzjGBiJBmlF/M31Tt1vRthyv6p9vB/vo6VZfvRQeX3YYbT4CBmTMmoqxpmeSm9w4u
	rgwpISnI=
X-Received: by 2002:a05:6214:19c5:b0:8ac:a205:f118 with SMTP id
 6a1803df08f44-8bc462028c9mr117592396d6.8.1778208559255; Thu, 07 May 2026
 19:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507233748.327004-1-aaron1esau@gmail.com> <af1K4d8cxGOvlJxY@gondor.apana.org.au>
In-Reply-To: <af1K4d8cxGOvlJxY@gondor.apana.org.au>
From: Aaron Esau <aaron1esau@gmail.com>
Date: Thu, 7 May 2026 21:49:08 -0500
X-Gm-Features: AVHnY4LhR7RMGGpnWHlWBULBtuXHcvG_1OCmZcim96NpoSF4yVzYSeKu9cq309g
Message-ID: <CADucPGTSNG3m=v9HuyZ=qr_-Qycccc9jjKU5K7O3LrHdEXgRaA@mail.gmail.com>
Subject: Re: [PATCH] crypto: acomp - fix dst-folio branch setting src instead
 of dst in acomp_virt_to_sg
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 95FCE4F0EE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23837-lists,linux-crypto=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Herbert,

The patch was generated against v6.15-rc6 (82f2b0b97). The buggy line
is at crypto/acompress.c:240 in that tag, and the index hash
f7a3fbe54 matched (I just checked again).

Could you double-check?

Thanks,
Aaron

