Return-Path: <linux-crypto+bounces-25647-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mF8KJ/XjS2q3cAEAu9opvQ
	(envelope-from <linux-crypto+bounces-25647-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 19:20:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F750713CC3
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 19:20:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aUwJ1iel;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25647-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25647-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DBB43027716
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jul 2026 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428636F8EB;
	Mon,  6 Jul 2026 17:13:24 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC22F5313
	for <linux-crypto@vger.kernel.org>; Mon,  6 Jul 2026 17:13:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358003; cv=none; b=EQuTuwIOX5yvZYUPX39duDznSiDX/iS7hs0fogvxZNDQ7pLbQikBuLyASBZjdGj1L7nXcRbc9zSyHrWzyrk7vapXl26eQRXnKdXtSbcslIk1Cg+T3qzoc0DsdIU75Y1u9gralinxr/Jvr+TBfMmnK2UZSph2pHEX353HG64NuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358003; c=relaxed/simple;
	bh=e6qWc66kU+xXDmvKGlirsKMaIbvc1QxArJkePbV+wf4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC0YR0O2PmSVhxDS5SW+eaaCgGZPTJgUQtCYrVt65UHB2SdW9nTO5fsajoXxtXiva1URuzFXPP4A5Ryg0WnftvIgBetdyoxx4JDx/2t3KxnhiFTslh0Xrxz2KGC5O3Lp5uKgw961JzEaeFqTf/3NG2puE7dhz58cA/gmRl7LNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUwJ1iel; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F5B1F00AC4
	for <linux-crypto@vger.kernel.org>; Mon,  6 Jul 2026 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783358002;
	bh=mpqsxHTdNQuABlRbSrSTXdX6rgBTyZ1QRwkSHQqkvs8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aUwJ1ielEp9fKqMoRpbf7+KlsAEkx1ItUo/4tUkjlvyTMT/NZIU/Sfs9aLmDyh/pU
	 dws1njqufItlb4Ts99FlfeGkNaAmFAP7jmRVp9CFbufRmxNFLiMPUqN9dVeeQezBJp
	 27WL0AcS7DIU9vkvih713YctIfY+JQ6QonKsU8skRLVL5z/6z3EAp4XBXQsVEryUe5
	 hYHk5hc4FyjFw8sKxD7w8NaMdcn3Hn0U7HTHVjCh6VhngzLmp3012I/7OCSheRIjY7
	 cDatDpx7O8gSH3cDoY+eDfHzEnfSJhGwNxBdfiyXteiz3VS3hxmUmZKRt3SHYb3CXI
	 wA/fAxKf5T3GA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b03d41976so27699821fa.3
        for <linux-crypto@vger.kernel.org>; Mon, 06 Jul 2026 10:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpnMXi7wgBgCHEPC8eZhej3rweU8eHj2jLbnh//AWx8DKupQIO5885jILzG9iyAwx4S6PfMBQrrWH4s0tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAGX0i6iOl8EnweRgbzRxOdxgwlnqmvZJmytJvdJrjc8izaTx
	EbAqquVOIyFS4QSsM5HGsFZJbI4pOOZvmM9AEoewPU007SUBYOWbR/erIhycWyI0txJIy7w78C+
	aPaCodVTfzaV99HXnlfYncwyoTOu/OxGfkzI7mwp28g==
X-Received: by 2002:a05:651c:546:b0:39b:32b3:b31f with SMTP id
 38308e7fff4ca-39c5fd2f09bmr3944171fa.5.1783358001073; Mon, 06 Jul 2026
 10:13:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:13:19 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:13:19 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260706-busy-grumpy-limpet-c59789@quoll>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704004408.2303468-1-shengchao.guo@oss.qualcomm.com>
 <b693a9d2-4f1d-4c17-8a63-99c7ac79ed41@oss.qualcomm.com> <20260706-busy-grumpy-limpet-c59789@quoll>
Date: Mon, 6 Jul 2026 13:13:19 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mcg-6XajFJCjTDgGACQ7YLGggw5TEtHv4QMEA=dFLOhTg@mail.gmail.com>
X-Gm-Features: AVVi8Ce2TYLFYmgt3xidz5HirHvkB2ef9twCkJ6HFyZf4MtkHSN7YtUE_SSftbg
Message-ID: <CAMRc=Mcg-6XajFJCjTDgGACQ7YLGggw5TEtHv4QMEA=dFLOhTg@mail.gmail.com>
Subject: Re: [PATCH RESEND] dt-bindings: crypto: qcom,inline-crypto-engine:
 Document Nord ICE
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shawn Guo <shengchao.guo@oss.qualcomm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Harshal Dev <harshal.dev@oss.qualcomm.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25647-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:shengchao.guo@oss.qualcomm.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:lumag@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:deepti.jaggi@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:kuldeep.singh@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F750713CC3

On Mon, 6 Jul 2026 08:54:22 +0200, Krzysztof Kozlowski <krzk@kernel.org> said:
> On Sun, Jul 05, 2026 at 11:15:45PM +0530, Kuldeep Singh wrote:
>> On 04-07-2026 06:14, Shawn Guo wrote:
>> > Document Inline Crypto Engine (ICE) on Qualcomm Nord SoC.
>> >
>> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> > Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
>> > ---
>> > It was included in the Nord SA8797P DTS series [1] due to that
>> > the prerequisite changes were picked up by Bjorn for 7.2. Resend it to
>> > Herbert as the dependency is gone now with 7.2-rc1.
>> >
>> > [1] https://lore.kernel.org/all/20260526051300.1669201-1-shengchao.guo@oss.qualcomm.com/
>> >
>> >  .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml   | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> > index db895c50e2d2..d690eff2e86d 100644
>> > --- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> > +++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> > @@ -17,6 +17,7 @@ properties:
>> >            - qcom,hawi-inline-crypto-engine
>> >            - qcom,kaanapali-inline-crypto-engine
>> >            - qcom,milos-inline-crypto-engine
>> > +          - qcom,nord-inline-crypto-engine
>> >            - qcom,qcs8300-inline-crypto-engine
>> >            - qcom,sa8775p-inline-crypto-engine
>> >            - qcom,sc7180-inline-crypto-engine
>> > @@ -63,6 +64,7 @@ allOf:
>> >              enum:
>> >                - qcom,eliza-inline-crypto-engine
>> >                - qcom,milos-inline-crypto-engine
>> > +              - qcom,nord-inline-crypto-engine
>>
>> With below patch, we don't need nord entry here.
>> https://lore.kernel.org/lkml/20260702-b4-shikra_crypto_changse-v2-1-66173f2f28b3@qti.qualcomm.com/
>
> Patch has conflict. This (Nord) should go after above one, with this
> fixed.
>

The other series still hasn't made its way upstream. This one's simple, can we
queue it now and rebase the other one?

Bart

