Return-Path: <linux-crypto+bounces-25935-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Gj1H05CVWq8mAAAu9opvQ
	(envelope-from <linux-crypto+bounces-25935-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 21:53:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D85EB74EE7B
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 21:53:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W21rSi7L;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25935-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25935-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E42C43040975
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57333E37A;
	Mon, 13 Jul 2026 19:50:57 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FC286A4
	for <linux-crypto@vger.kernel.org>; Mon, 13 Jul 2026 19:50:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972257; cv=pass; b=bO9GTXUhdpKK3NtKFGW4MYt4X1ij5kIJ1pCpEUmYaiyfMbR2UxltuynII1Int/g8beQ4tCfo7JPJmxBSO0OIVcQRMxxSL+hR2de5ppeDQyeDIKo9FPTonJ9R7u2JALHCgSWzFuPFQ4UFTbekATcRYA/XnVU1KkHxFQbgpv2NrTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972257; c=relaxed/simple;
	bh=WwNb7skWA3MZwpPs//3DgvdHZZvs+tMEE+2mcL5O9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhQuNV18Cijs3MALg3lWCfLMaQQqGNRgIWqgcD/nkc3v08kEQEnqf7y2Zr/X6C1Qr66rZWPvJy4NxX4dT8y6KwgZkDZHuAFROmp1KklWwN+zt9IrX0KlVxFvzxq2EjhNjDCpRzJlJcv1bIcA5fjJkHeXSADQVTVk9q7i5er1QUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W21rSi7L; arc=pass smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso326111a12.1
        for <linux-crypto@vger.kernel.org>; Mon, 13 Jul 2026 12:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783972254; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6KFUFxZRaKlv+iJjr9YH740MwHQfGVmMMpHDa9oaz32BXz0F38CgTYPzpxAAPEOCv
         RJGpDPTQQtEh+Oyt21x+s6Ggdb6oDmNNg70M71/nYqx9Qdkp27lU3lnh8b96o38TCdAe
         dSxS0Mcz34r2TDLJOkf+BmI/P5DOZdDS9lU8QJs7GELu7JJRjf4Cx39CnEajh3pT6rwj
         Z8SRX5IGjeSxovNAdMvU2s5J3dkAUScibsAAWxwPyj3cxpVZdDrxhUO5L5+838JhFRNz
         UqUw3Q3gzHu0dQWG+CEnd/Q/GWfAu8NBgX0eV2pLwI4j+0vZ3tLptWdJsC0kHBBOvnHc
         MKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6OK0Ylxf3hKqW72/eIaX7E6yAXMtYubXbOm4uCCdDs=;
        fh=TAqh05QatoJFNSA56+RpkFmxHGPSOutgq9s6zseHujM=;
        b=WUC2mLSNPbFdiRI2zBHOaxHPGmv9YcK+IsdFohX2f6byvS4gbep1wm6qFYUZc9S5gs
         1VMxfjNrZLIJhFVdxFf84aupGRTONrtIv05zsdly7UtJXif/InhZMINNpJX3WSk+qpZ0
         B2+J7qqikLf5M4OHdSQvc3ZxarcLd3RxJj31A6h4JWfWSLRqt1QPZGwpJhSCs+mdTRs1
         BKhDxcaKGpeTlgI8jeRCegfPM2oY23LZjVVhVD+2Si/i8BnE+wW4yG2dMMXWbNDxtmfp
         Sl8gUwczkDRD1K4hFP0txtKi/Jo3KSF815aEkk3wtZNi7FStdW27GI6lvkTUJKTf8qCW
         GItA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783972254; x=1784577054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V6OK0Ylxf3hKqW72/eIaX7E6yAXMtYubXbOm4uCCdDs=;
        b=W21rSi7LV9I3RCDuSkyj8+dXGMVtoExgnPi19zyNeg6p0O1hNe+Rk3EVz+fIcJwXEy
         7gIVPOsDk6Cqx8om8PQCxEavxWJVssMkCCeS82il5Jkwlvdv+ycSZFSj3xgTt789OThz
         K58is3cQldBK3jUVoc7KUo8DnKoYBXY5/zG/5/ZgyZozx93SNC9OCIYEwzM7ScvxWZW4
         PVHJtCd8NsCx3WgO37bZYJH4irbdeirObsdcHJI6VPnZKc9HY4LEfkqTUQuFahYuzII0
         2o5imxllfyBSDTtJwePLeSbV318N5cBonsM9Bk9vkIypnrC+oLwORkihJVCAusdNsO/R
         8aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783972254; x=1784577054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6OK0Ylxf3hKqW72/eIaX7E6yAXMtYubXbOm4uCCdDs=;
        b=Cwq5yUor5dJQYXcjqhgnGODvZJ2pBxFP/azupkCitG6Rx7RneLWYdeQRYPWuoDrOd1
         g0zWPxgklThN6mNfQhGfAov5Ta2r5Fzd1xEj2RwmRUZMDRCo2NKzGp0jYMPLAFUpUaMY
         iMKmcNr4WgzpMmoZHoDJhTPyTFqM1uLpAp7/vIMtdJFQFB/Se16PHk7sV9ylAfN0XszF
         lYKFeBW98eHzaGW9f4lgXz2pH8aGKKCUeI2uNgq3PrJ12jPY9CySHDf8iZD9ZV1TJdkw
         LP2FkTQP1AiINLEopdPkfPegFe2z9QIxA/KgIpZhXxwGF1Yawfe52UK0ESXd/BJJysy0
         uzNg==
X-Gm-Message-State: AOJu0YzAMVmYGGMjks6JPup76EPSwLOPgS3kvFSrHrIhsErZkxXtyVos
	T70XX4MqklvICS1Iw0Bo3lAscL1IIM037hFoQGK+fP33SdPjf5WnDdXXcMWFiOlZKpQiGT2UItL
	j0VF8XkoqGIM3U+Hvkwg5GQW4I7jLkbU=
X-Gm-Gg: AfdE7clFZDxRU02Kb4URjlnguNa6zNnucie2U+nwQ7ETNDUUk4TcSgMxndklChKV5GB
	jvyEhBtGhtOygEkLcCZuCv014wMpEYve728QMv6rmRPvoeHW7fXWx/knlnwFru8Mz0/1JkD1NRR
	ZTKM72dlvpSxVLUSAsEASvDwlT7tgJHHZGOqauYdjDCSPiEeniPUNHb7fnuqPp3ak80QpwWsLuB
	pH8qy52+XusS656OxBdSp7WmjUHrsem+WGETzraTcgVikLMfcc4osHkyPPOOT16LVV3F40me7WL
	PUccOHPsynhBENzHxuCe8Xg7FhoZHkY2JTsfpIWM22M7lXwpWbZk/a01EEBsWCi9VwdHOSpdAlp
	cmTSi+UJgHk6AMtc710dJhV75zqZqvfhWUrvFtYTbyxFP6ANUxqxFFI6SpV3+5VxOfkPeDgPXSC
	aFlQ+fCJA=
X-Received: by 2002:a05:6402:158c:b0:695:572a:7abb with SMTP id
 4fb4d7f45d1cf-69c5f1040b6mr4701341a12.22.1783972253740; Mon, 13 Jul 2026
 12:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713050740.3687230-1-rosenp@gmail.com> <3d606437-ab63-41e7-88d3-fb6e47014a8a@arm.com>
In-Reply-To: <3d606437-ab63-41e7-88d3-fb6e47014a8a@arm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 13 Jul 2026 12:50:42 -0700
X-Gm-Features: AUfX_myB5_1798M1lWU26yLsGYb_TRR3RWDzOIaUSflFEnHS74eD3KyofQfHvkQ
Message-ID: <CAKxU2N8TSSm_7cSOV5nrGGBXju=yiVGsuEtNRWjE6YO1crh4yA@mail.gmail.com>
Subject: Re: [PATCH] crypto: cesa: check for sram_dma NULL
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-crypto@vger.kernel.org, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Boris Brezillon <bbrezillon@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25935-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robin.murphy@arm.com,m:linux-crypto@vger.kernel.org,m:schalla@marvell.com,m:bbhushan2@marvell.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:bbrezillon@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D85EB74EE7B

On Mon, Jul 13, 2026 at 4:58=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 13/07/2026 6:07 am, Rosen Penev wrote:
> > dma_map_resource() might fail. In such a case, don't call
> > dma_unmap_resource()
>
> Hmm, AFAICS it's more that if *anything* in mv_cesa_get_sram() fails, we
> could end up calling dma_unmap_resource() via the cleanup path for
> subsequent engines which never had their mv_cesa_get_sram() call at all
> (and thus all of engine->pool, engine->sram and engine->sram_dma will be
> unset). While for one where dma_map_resource() itself did fail,
> engine->sram_dma will be non-NULL here (but still invalid to unmap). I
> think this needs a bit more work to differentiate between the
> successfully initialised state which needs cleanup, and the partially or
> fully-uninitialised states which don't.
Sounds like this should have an extra check for dma_mapping_error then.
>
> Thanks,
> Robin.
>
> > Fixes: 37d728f76c41 ("crypto: marvell/cesa - Fix DMA API misuse")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/crypto/marvell/cesa/cesa.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvel=
l/cesa/cesa.c
> > index 57c9295be711..bcbb909c48d8 100644
> > --- a/drivers/crypto/marvell/cesa/cesa.c
> > +++ b/drivers/crypto/marvell/cesa/cesa.c
> > @@ -406,7 +406,7 @@ static void mv_cesa_put_sram(struct platform_device=
 *pdev, int idx)
> >       if (engine->pool)
> >               gen_pool_free(engine->pool, (unsigned long)engine->sram_p=
ool,
> >                             cesa->sram_size);
> > -     else
> > +     else if (engine->sram_dma)
> >               dma_unmap_resource(cesa->dev, engine->sram_dma,
> >                                  cesa->sram_size, DMA_BIDIRECTIONAL, 0)=
;
> >   }
>

