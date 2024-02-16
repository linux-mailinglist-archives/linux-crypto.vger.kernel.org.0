Return-Path: <linux-crypto+bounces-2113-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0B857A94
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Feb 2024 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB421C2263A
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Feb 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583985380F;
	Fri, 16 Feb 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="paic9VLj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE3537FB
	for <linux-crypto@vger.kernel.org>; Fri, 16 Feb 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080414; cv=none; b=u4nJfyDNaOWGiYiL2dadMAue3lP8ZFkN+ZjxWHF53Z6lG9okdoutKGkE/ySmR5htnxiH+W3X0wZbAlcUFpi4m1EP3BjWCr4DS9v3Lt0pindx6EEMj9rdido+9X8FHoJ3vyoPgrnXcP7kXPX6+XmrnLADv6TEwhv4Ixp4OUjG//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080414; c=relaxed/simple;
	bh=/Fv7pZduc9Bvxjs3c+I5eHvPrfvb1kDFVxbm5FfqWTc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TXzhE/sCsc7uRiZiJnEpkh2Frodvbahdf9Ki2MDZHZgvZbop1MDHEJrxGMHAcDbhDTLA0luDjAGqzHSDwVG+3H8fkyaBJDCGKqzDvh/3ndShuAO1xOnDlNvGnv960dhkszggFEScCOHJVnQ4JgEMAoYGJmfsHNK+KwVEZrhvNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=paic9VLj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so217867566b.3
        for <linux-crypto@vger.kernel.org>; Fri, 16 Feb 2024 02:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1708080410; x=1708685210; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN902PZ33RtjgjeWH2GYWtC877xiVrHyazftcFvMCYA=;
        b=paic9VLj5iB9jqOQ7uUKubylKN1a13uNYqBxMszXFySy6AwDGoraMfpiKIdSn/tJbx
         AtFXy2km0WaFV+IGqjfMCFzgiGCH9fLImFZ53UPYkitkoayNT+DYjRp5QUP2CZZqK4vM
         HfkobiS62CI/VmoeUimZCJW7yfKnwmhntyyWcHrFZ9Nz2c3ASXEXiiCAC2kdRNA/0EZJ
         cj60P7QOFkr2TjNct+EnZaox2mw9Q5zUiqRSPZsnB3uUFYdbxEPnIwlzI4gaR/msZ1nE
         NLqgixfq4ACI2xAFLTHsRgeqZJYM8xcZvInGgDOk6gRwgX3SaGgrcO6zSw5YC6RUGwG3
         dHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080410; x=1708685210;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZN902PZ33RtjgjeWH2GYWtC877xiVrHyazftcFvMCYA=;
        b=IfgbSL+Uj5AQdnsh3+48FOQBX1nub9tFhoSpFA4iTDu7C05ctq4bCEvZfaQhVD0EOz
         Yrw2M45ZgyprxhnefTOd0r1RB521YcXAmEjShM8hhgGdkxM9OfcQrH7Q4x1fk0VorIr2
         7NUbRwnP/m0jgwBC875QIVem4wrhScvixUTviOff+Gdt+LBd9tnXriT99QDeLwo19nAb
         nwxz3e2unek7FdrVN8/GWpAhzzGnSj3lHlylUiswrgCPTJ8PY5aLwlwyz1h8AGfjhX3c
         8uiQwQ7sp8w9otMy3i5hJuUsv296xdDt/lKDvTUHAji5XujvXz5TXpqMZuXq5eIxHZMD
         wurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXzDn1nl1RhT5Y5VDqpN5inmfynKKeTkOrB5/w5TRP66nPTsGok0mRFMLHHOWj+hUQ5BQLB+QSP1PS+cjlywJWKlWp9UlW1zg2/8K
X-Gm-Message-State: AOJu0Yz9lX/50QqK6TYnH+0N1ZNeXBW7vMAH31d1bDix5yYol2e9H5Pg
	fpcQOt/Svcg/RUDj3Smb9v26WRIQU+MVygt3BDYeaXG0uRGIJbqVa8Da/sKU7kg=
X-Google-Smtp-Source: AGHT+IG5rkARmaWUictA1Ft2Xt9RaqG2EvVFtFJRmC7NNAJ+R9vH+8s1KCC+Eq70YL/6ULgKJ1LJ7w==
X-Received: by 2002:a17:906:3757:b0:a3d:9e6b:2776 with SMTP id e23-20020a170906375700b00a3d9e6b2776mr2966222ejc.17.1708080410468;
        Fri, 16 Feb 2024 02:46:50 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709060e9100b00a3d11feb32esm1429131ejf.186.2024.02.16.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Feb 2024 11:46:49 +0100
Message-Id: <CZ6FYZLGWT3K.ZBHYDQ7TDN4B@fairphone.com>
Cc: "Andy Gross" <agross@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Thara
 Gopinath" <thara.gopinath@gmail.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bhupesh Sharma" <bhupesh.sharma@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6350: Add Crypto Engine
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Stephan Gerhold" <stephan@gerhold.net>
X-Mailer: aerc 0.15.2
References: <20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com>
 <20240105-sm6350-qce-v1-2-416e5c7319ac@fairphone.com>
 <ZZguvdJTyVgfxm4D@gerhold.net>
In-Reply-To: <ZZguvdJTyVgfxm4D@gerhold.net>

On Fri Jan 5, 2024 at 5:30 PM CET, Stephan Gerhold wrote:
> On Fri, Jan 05, 2024 at 05:15:44PM +0100, Luca Weiss wrote:
> > Add crypto engine (CE) and CE BAM related nodes and definitions for thi=
s
> > SoC.
> >=20
> > For reference:
> >=20
> >   [    2.297419] qcrypto 1dfa000.crypto: Crypto device found, version 5=
.5.1
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++++++++++++++++=
+++
> >  1 file changed, 31 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts=
/qcom/sm6350.dtsi
> > index 8fd6f4d03490..516aadbb16bb 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > @@ -1212,6 +1212,37 @@ ufs_mem_phy_lanes: phy@1d87400 {
> >  			};
> >  		};
> > =20
> > +		cryptobam: dma-controller@1dc4000 {
> > +			compatible =3D "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > +			reg =3D <0 0x01dc4000 0 0x24000>;
> > +			interrupts =3D <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > +			#dma-cells =3D <1>;
> > +			qcom,ee =3D <0>;
> > +			qcom,controlled-remotely;
> > +			num-channels =3D <16>;
> > +			qcom,num-ees =3D <4>;
> > +			iommus =3D <&apps_smmu 0x432 0x0000>,
> > +				 <&apps_smmu 0x438 0x0001>,
> > +				 <&apps_smmu 0x43f 0x0000>,
> > +				 <&apps_smmu 0x426 0x0011>,
> > +				 <&apps_smmu 0x436 0x0011>;
>
> The last two lines look equivalent to me: 0x436 & ~0x0011 =3D 0x426.

I don't understand the IOMMU SID + mask really, but I think I've seen
somewhere before like here that TZ can be a bit picky with the SIDs?

https://lore.kernel.org/linux-arm-msm/opqdrmyj3y64nqqqmakjydn5rkspizufyeavm=
7ec7c7ufqz4wk@ey2a7bq3shfj/
https://lore.kernel.org/linux-arm-msm/11b5db69-49f5-4d7b-81c9-687d66a5cb0d@=
linaro.org/

I don't quite want to risk having some obscure use case breaking because
we cleaned up the dts ;)

But if you're more sure than me that it won't break, let me know!

>
> It's also a bit weird that the mask has one more digit than the stream
> ID. And ordered numerically (by stream ID, first number) it would be a
> bit easier to read. :-)

Sorting them is no problem, can do that for v2.

>
> Thanks,
> Stephan


