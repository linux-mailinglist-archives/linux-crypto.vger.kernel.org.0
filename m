Return-Path: <linux-crypto+bounces-25425-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3lcKINBPmrRCAkAu9opvQ
	(envelope-from <linux-crypto+bounces-25425-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:08:19 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D76CB937
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g8IDHv4d;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25425-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25425-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE94E300A491
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E03AA4E4;
	Fri, 26 Jun 2026 09:08:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804573BAD95
	for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 09:08:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464896; cv=pass; b=BfxFuuWBkFlYlOwBbLjTaHOXYgQwh1iig7nXHto4l1CZnTgXkON/oKrb69RCN+lK4UHIN1ILnTShitAEJ6Jk114MDaqsyCeMp7YFjtz8pmqL2U5rM6rZ3Z5NeRjkDQ7JyGCDT5HvmB78TDQJq+vZL9RlKAEHtSUvdnI1phJZHzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464896; c=relaxed/simple;
	bh=SleXc4XUPzTEfsJqAo8humXjM9TKDFTOibVY0DSadSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNYS+OBstFys84/dTjy8wptdy1xeME038ckEbfSe9dhhxLvrvQHeRzjAWEZytmKvhw2cfGq8QT5GR/QJdmniTInqoC4H+VIL3Cq1EArufT/WYiaQV7C+ndAUleIUtwIUOgrYzQk2T4GGShGnZiplcQSMX/CPMR+5xYqTswcLeNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8IDHv4d; arc=pass smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37d826e9811so345066a91.1
        for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 02:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782464895; cv=none;
        d=google.com; s=arc-20260327;
        b=DHk0JVKz2VDRlDYuXgZ10DaF9+PQPmIvPNMOTYgilabkVjJTWMJT1dWxvVTBHte2d7
         JLE4qEUW+8CrbosDoPb9+fUo89oGMPSjal1gTk4fRHS8LrB3GrwjjhHy+6zcpSLIzjMY
         Gq+uZW8US1j6EJJjbR6985AnV8ZjeyX1ykIdnHpBq0BNd0wbRxKcjBzZ3twtCp+Oz9QS
         pWJ5dW5bc27k4ehaIUCWXrtnlGNUhIR7MKWOs4spbqb19298txd7CugQtRyiOR0OYv/n
         iCm7BzKuTlIqcnA9lfM2k6+qL+dZ8FgZPEgHwVmYeAKFWWapvQK2JHXZ6aOdQd3LdFAN
         fPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YELoGVNkXEHaosFNV1YMMW7OXYfGxmS9bTmZwMdEliY=;
        fh=ySUfXnS4Xiqer06cM2/c7GefWiSMn2mZOXkbtzk412c=;
        b=Zq9QARCuPe+qkg4rlQg/xiXXjOHswvwtVcD6QUsSM4ZpAa8EAusfx2zAB3ZqOOepjz
         vOgA04XlavVUGsfLXPev1GuS9VBcoh4lhfYGWaNl9mzXhRu+bdBSNcoSxF4OEvtn/b6s
         fREHhqppdh4HxuHiSLJQhqSAddSfe/DYqT8qUIKRRT1d6jND8+vDvWiIOVp5CnOXyXTU
         wtQg1t/lboW2e6nc8+5BiePMwtgPwdHJ2rniB+pElvqnFLWqhxrKuMZTufA05yYoGg7Z
         7yZDknl8NjYr32Bb0UOZJ6vNhvvjxqBN+Bj1KhR++k58kih+RTXXGYVepJC0Nq2ElapD
         C6HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464895; x=1783069695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YELoGVNkXEHaosFNV1YMMW7OXYfGxmS9bTmZwMdEliY=;
        b=g8IDHv4dRSLlP+L51DN7/tzt16ZBF3l9+Nj4KlLejQZjfq1Ss/eLM1IKXAzb/YBNxw
         pvnBXWhENXfHplEL8L0y0TsC68m3aK/yi0rdM0ibjoP5xBBZJCT+Fqp+8ZNMOm1hX6ty
         o8U/hvZa8swwXSCueVOj7ADH5KT8nvTfzNp532IOwQFB30cCXAKbb533TnK9vqaCXnmq
         ppm7Zbq8xstDOVdMQWqi9YBo9dtiXNcMzqXx4qkpkf0f3Z63v0BIGUTSkibqzZAWBclg
         xuI5xz7W72HssPn3z2eMLDOKmvkrr21WK2ONRV4GgjK89+XsJlGN2rcikLJGX88CWIe/
         8nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464895; x=1783069695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YELoGVNkXEHaosFNV1YMMW7OXYfGxmS9bTmZwMdEliY=;
        b=FbGclEkFyw/HY22W/NR2VWNOBrJJpLXJClFx7p5CCmjg1/k/sZCbU4VBFGmUs6QEi1
         b6cHwvGJ3kbSoANbQxrKkAks4fJxs8YHmQML873Y0KlKMy3YN5Cdv1WYqP3uEqyLHUt2
         xofEuhxEZKFOj1lhIFxb4od0Bpzmb7UZgxQ2zIFGGDDTfeMULf5Z7MPvJtzF135rogrd
         PanrkGycWk4s16VIQFpqhywmFFlLPT5kss15vYHhAU6OK3nVT0V2vr297B/50xVLFkj4
         kqb2KKNrORDlYNagngYAik0Fq01i3rJS0ba9f8qxfKkrmDh8imJcl6hrY49L4yGLDRdK
         y5cg==
X-Forwarded-Encrypted: i=1; AHgh+RqnYh5wrnNggOSiQz9ep3/qlEykFIf2Tb+04eUxpoHNQio2X9IblnocnrtvnSumQ//+w12G0HbsvnsQ1wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJq80/zAPi0G2PPBRY3KmlzLnueU62Ij3eon2NmLMB4nyUbo5W
	zD6TCI0gCsp/l8GH6XhabazYA1mxPiY4fVESnLVn13jp17uPIxXd4u3S7Jbriyg6EyTLOnS9ugJ
	fgkBe3zdLsGJtnV3g5fMZ3eFQgBoX8g==
X-Gm-Gg: AfdE7cluzmhvEpCzOIyMSN6xFgkObFVsmhTOiECU7ez7dA0qS60Lx3I0+O5abwB3wQ8
	EJM2DWY4b1hgn+l+eBNKcsiQ+Cfau+JepKJfynzramTLjy+GkFnYX6ZRCmBP5/+nAgrmNO+qV2l
	SaNFgLATPwgw95IvKctO3rIpO5IqOyACPWWwfBr/xDEW9Nqi9QtAiufGwtb6cypgG6DG9NKjixI
	WcqSjqExcSukAIMGQsqGZDzfgfEDJOJxkdcb+3u61vZVmmUYmd6Ch6Jm9uCL9Lr15dtx4Nfu8bH
	iQ3SsfV9Ow6q1mN4zJTZYYydl25cqdRy5OqGnX5mNVlZeYFJDnguJYQZEIqdOmULxtAR8k0U0VR
	kuDnt/Q==
X-Received: by 2002:a17:90b:17c2:b0:36d:633a:e7e5 with SMTP id
 98e67ed59e1d1-37df9f3821dmr6019651a91.3.1782464894705; Fri, 26 Jun 2026
 02:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626090302.42134-1-mhun512@gmail.com>
In-Reply-To: <20260626090302.42134-1-mhun512@gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 26 Jun 2026 18:07:58 +0900
X-Gm-Features: AVVi8CfZ0h7fnYUqI6mt4QJ2kzjpnk6pAq6GOOX65tUuQgaat8eWX7odRlW0Yn4
Message-ID: <CAGEsz8H9a5+F48X9nbO9bMthJg4bLLsy-tufW+xQnEGyWL83wQ@mail.gmail.com>
Subject: Re: [PATCH] hwrng: omap: disable runtime PM on resume failure
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25425-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsaxena@plexity.net,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhun512@gmail.com,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[selenic.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 406D76CB937

Please ignore this patch.

I noticed after sending it that this patch was not properly checked
against the existing omap-rng probe error-path cleanup discussion, and
it should not be reviewed as-is.

Sorry for the noise.

Thanks,
Myeonghun

2026=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:03, M=
yeonghun Pak <mhun512@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> omap_rng_probe() enables runtime PM before calling
> pm_runtime_resume_and_get().  If the resume call fails, the error path
> currently jumps to err_ioremap and returns without disabling runtime PM
> again.
>
> Add a runtime-PM-only error label and route the resume failure through it=
.
> The label is placed after the runtime PM usage-count unwind, so later
> probe failures keep using the existing pm_runtime_put_sync() path while
> this early failure only disables the runtime PM state that was already
> enabled.
>
> Fixes: 61dc0a446e5d ("hwrng: omap - Fix assumption that runtime_get_sync =
will always succeed")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/char/hw_random/omap-rng.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/o=
map-rng.c
> index 5e8b50f15dc3..44b8bb4a24a8 100644
> --- a/drivers/char/hw_random/omap-rng.c
> +++ b/drivers/char/hw_random/omap-rng.c
> @@ -455,7 +455,7 @@ static int omap_rng_probe(struct platform_device *pde=
v)
>         ret =3D pm_runtime_resume_and_get(&pdev->dev);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Failed to runtime_get device: %d\n",=
 ret);
> -               goto err_ioremap;
> +               goto err_pm_disable;
>         }
>
>         priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> @@ -499,6 +499,7 @@ err_register:
>  err_register:
>         priv->base =3D NULL;
>         pm_runtime_put_sync(&pdev->dev);
> +err_pm_disable:
>         pm_runtime_disable(&pdev->dev);
>
>         clk_disable_unprepare(priv->clk_reg);
> --
> 2.47.1

