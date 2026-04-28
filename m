Return-Path: <linux-crypto+bounces-23504-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF3MNvMT8WlZcwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23504-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 22:09:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C548B7DC
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDF023006D64
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2026 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C293CCFC4;
	Tue, 28 Apr 2026 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivW4zqO2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D83C3420
	for <linux-crypto@vger.kernel.org>; Tue, 28 Apr 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406951; cv=pass; b=GMuUlF3JjeHJT76biDl1XxZcj20FYwZemIF9IMFAy6E5sJmQyy1bIOjTuT673aumG6dJXujM5FPChJ1S66KrjvBz9ZGyOnj4ekDNHynmtL9KLA4xV0O4UvK33Y7HxneXeBw4Vw9LXkmTjSM5oKdapzXinIQ2hTEEZsnUf+I5AoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406951; c=relaxed/simple;
	bh=alPBq/hVKvMunjhPk1t8Cm6f+Q72c8acAg/8x19XGeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmd+qK7mQUKzf9iK7KjQLb3+FU9e86kvIoSf5svNIVamugVS+6wnTZkuzO4eQxanxZ6tTNDAvdl6bVRAJ7rLQWzKsQtbAgM9HXImixbJ+MYJaxrfzBtlfp63A9fdLrB7HmT+0ZzYPBeW3P54sl05M8h6bEoEwWWtSQow7L1NfCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivW4zqO2; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c726ef332so16520816c88.1
        for <linux-crypto@vger.kernel.org>; Tue, 28 Apr 2026 13:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777406949; cv=none;
        d=google.com; s=arc-20240605;
        b=cLNK2742vpVkBGGbnOhqT1292RFFOp3bJQ3G/Nl7J5y6XkaZGAQZx1aaQ609qVbFf+
         TNFVKlhBXWNgCYHITyg1FiaQGqMPbmzPzHFHbWK10tIZyY9vpro4SQ8YRsg3kzSxlhGI
         dd1qHG++HkETwjiEBl80SHvg4x3+o21C1oSCQpKowDX5JsZdRbJn3vpy7TlEGebW0zNg
         AGQKtoKTjVaWuktyec59VNgRdrGclKHS4/MW8BwNplsVTIrdjRsmRik3/nZNfAd3zktl
         QvOog/SWA3MLWlH7GKx3a0ErMnwzZ5eX5iXlDYwBb2jX47AsbPvzTLy3UE7tMRTHhczR
         lCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alPBq/hVKvMunjhPk1t8Cm6f+Q72c8acAg/8x19XGeU=;
        fh=7nTNT2ZRiCkb2RCPzuAOpAeKSGv4kxNQMfw/hOAD0Wc=;
        b=kRa/3D5wDSiPmXCjx/iHZVgBLDbeYJBtl+JlNth3ybmZ7L9Uw4ZX7K+bYrHm+fQfKJ
         aZsinrezmN1C6eLPYgNbagxpPtwnbiDKNlP5bF9NKJPpVv8Dr6wNL1C/eNtZyVn85wRg
         U+CwtpOi13PTk1Jyohtm1AUNaTvPi86k2SSNK+cAo4JQTV/RssombmC38W3zIY6NdTBG
         q/8+i59kon95R9mtCOa48UWERWUNLnCWwmrf3o5jlrbNY+swGWI5z9mgkZoprLGkfBWh
         OeDieHlH0AXJrzmlX1MqDGAKIfvBQTnm6CV/1YyjeDj6E2HMCKRUElHifZw1R6HVoOcY
         ngzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777406949; x=1778011749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alPBq/hVKvMunjhPk1t8Cm6f+Q72c8acAg/8x19XGeU=;
        b=ivW4zqO2gfCet7IFcoGq6L9I4hVY7epiMfRqeCoH5/l9uyMoC6T457wLdt/tgGFyvh
         Iqy+O6LSNY7Ul0o+a/yxFmef/JD1PglLIfSdcrzCbvG1DsdF1toXLv59WiUVxYrJQlMX
         cDu32R1tXUpMbrNUiOLPQ7cr81FSR7n4w+FJXCOfLaXOvF3tMjKg+k9f+2C3CcT3cWQU
         Aq5BYO9mafEbJIFsw5jNox+9dJYPcEn9gxjVHItFenPNGXNU6WDsBW8uyst+EIocmK1m
         CyVHvMYyKAR7C7X0+oxBcOJ3YcKl39FUHEA/MQr2hB/2cuZlydG820jIlp/8uibo0sYq
         Ailw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777406949; x=1778011749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alPBq/hVKvMunjhPk1t8Cm6f+Q72c8acAg/8x19XGeU=;
        b=YuemtAkduC8x+9fUS/dCj3x8ZJ26+uT3kHdA3023iepfYfaQ4jI2juVimQgPLnuMPs
         J6WzQKfSdp1QzSiWUtMgL8cY/zUBXhyHoZQWIaeO5Zn0vRHVWG38wNAMibaDk7TmvFDf
         BKzzVmjYbuzIaX+DRwAanxZkp239gvqOs3hGnKTcyg+DuOv5bnKUK75177jpGc9oGFgg
         QuAYGOOZNGOeAUIlSpjoopZ/4pW/lxkEV1eTu3gNdeIg4bevIB/Jtuxk9C4FzqJ+hYQ6
         0wDD/G3lbAqIjRIIWuzw4JuvpHC0TG5tOsZ8DEBiHMH/2MLjmA3HTt4xIOAcXtUE6a3P
         V4Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+sSPXqLrQ/3wRc4N8a0TuNuzlldrcSR1TW7PeXbnMvJQzZneeXDg2BQ5Zs9+YzHZuaFEz7upYUHxA1wco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uvuLmzgEb3nM44VZxv0B83y+pMLjcd1UB8XFZIlniSge3kJL
	OwUglu8tZhyfdhAtHs84PYTLA43nxun6iDO5gvQA2SZwhEUkCTXoRk0tPGatWgecjyFJBwXp5Yr
	P4pr+/GgK/6Dc1cEjvBYqy+G3FnIga76V1lEIZUwY
X-Gm-Gg: AeBDiesf+hECJVei2YEEyPf5iHEeLfHVpYt8cN339JSn31sq17hpwXtUti8rmeIYVYO
	Z8tgpzbX8w3TsAFGLya0OGzzZiOohz055cPp9z7zwm0C5XOFM1diLaHR7NxaTc2di17lXcrqysm
	3ylS48XW/FcFRUMZN0V6IO8torqYlIEEMZvdqqxAeCUECRQa6TFFHXc6y5ScFwNBARopvL33uLb
	WkLSr1bEVJu0/KYWyIUN8trIscFaNJY9ggcCI0Wi+Ko93OguBND0AV3shlmh6NV0+cTbYPQ4nW8
	2rP8LBIHia1UgqsieK5//Y5qks6LDqSD606cHw2pwpBrzqM+OK08ISJ6GymCshuXnTO6/8FgFpM
	3B6baVdyQltLOpshzyJHMxK6M/zfK5HSV/W/9KFw77zBhWxve25aTcqrJIJiI3TCj2gDZNA==
X-Received: by 2002:a05:7022:225:b0:12c:856:ddcc with SMTP id
 a92af1059eb24-12de2a59d18mr309336c88.27.1777406948122; Tue, 28 Apr 2026
 13:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427104129.309982-7-thorsten.blum@linux.dev> <20260427104129.309982-9-thorsten.blum@linux.dev>
In-Reply-To: <20260427104129.309982-9-thorsten.blum@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 13:08:57 -0700
X-Gm-Features: AVHnY4K_YPGryg7CfOVQlPI-5P8mAN-BEHkXiXTRIvRa0ac18tCzErAvquNFyuk
Message-ID: <CAAVpQUBa4Y-x45j0VFe8koczfw+DXyD5JnHZST1ghJEGbL_OAw@mail.gmail.com>
Subject: Re: [PATCH 3/6] crypto: algif_aead - use sock_kzalloc in aead_accept_parent_nokey
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B07C548B7DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23504-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 3:43=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
> simplify aead_accept_parent_nokey().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

