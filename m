Return-Path: <linux-crypto+bounces-21537-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHL6JJc+p2kNgAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21537-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 21:03:35 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01201F6935
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47DC630B47A9
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B1389111;
	Tue,  3 Mar 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+AH/Fwr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A63890EF
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568017; cv=none; b=JPyJY43zHVf6K9/KYIz6y62BlMpaPAFfg5izakanPFR9ITEh8n7A0kLTmaWclAvTJEobHYYsQhdV7F7YBeY93JdsNIVlvKhMOmltNPf9M04Nid20K9KMNkyeLC7arwx2zBjrylqKeBVxXX6odEerGXs4eyD8GsqUnWL8CHxTvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568017; c=relaxed/simple;
	bh=hWwivSsmttOdBiwD/tUkaDCdWccb5O3I93SN3eCnZrc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJWCtT0u8CD0saRcFhTIwB5yLKQPM6k0MESifjdb6B+wSJMGiaoPCv7IvWy7oww5bQwrQgcjyOP1vAVJwVC+xppkrMpbq8IS1XVmL5Dz/iufP6GD8Z6DPXdU2KWXwIfiqESgls0Fm73aF+0LTEgqjtNw7D/nYiA3zFU88cc4sHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+AH/Fwr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48379a42f76so50168445e9.0
        for <linux-crypto@vger.kernel.org>; Tue, 03 Mar 2026 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568014; x=1773172814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LrVCaQvW0iEI3otUrXDkdYdjfZQ36uxHWa4/LArwCVM=;
        b=Z+AH/Fwro2zRlEE6SGawGziy8ZtT6fglsKGxWTK4HvmK+ObP8sojlQO8zza7NEG2U1
         JxKn+o+zqJ5WN6+pZ+TLVyiacL/4JSte1r7m5wiRGz969oFBJopXHSrnE0nzlDlhkGoK
         YpD35J/Hs/u/j49u3oKxIgGIsT8uSrJENTeWLFvRjaUNvBiHDg88thNiIrPfo1anEAQG
         SLZG31VCK82pnpCKdYnebdIf5ZptEaVVAy9Zkua2VVKVCftBiqaLIZN9o4YU0MdL3ef5
         4pcjEqe3pVTBl1U0g5Yq8zl7pFZmYMqdpL+4FRUNp0pCPfJ9VSPFdonAco96iyt1y4bB
         /YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568014; x=1773172814;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrVCaQvW0iEI3otUrXDkdYdjfZQ36uxHWa4/LArwCVM=;
        b=GlUIrNVo0jR1jDcNIVcVynAUjDBO5ahseGnMLn7autI8KM50BO3i603Kmpsji7D/Qz
         luQoryEQGbdRz45GyT0GC3kXHPCGpOB1tLg+lzl0ElCwMBogsnVZv+tztScxjUuwG1Yy
         uf3weWIhZijmVV9ycHWAoido6YEV0M6CI+fuOTu0w+NCOvQVBk42BZFA75atcZb4lAMp
         WqPNC6zK8eeD14W/bB3oEQNNApZW4JMT8HSvWYn9rA5yyPKN0Ln/7WAD01GQzQ6s/Upr
         g0/JYBFLLBI9/JvaITqcr8j/HTp9Zzm2Kmcs6SCv+4xUZ9V6aY8DcYGsnAsXqW29KNIU
         epWA==
X-Forwarded-Encrypted: i=1; AJvYcCUJfgSBUOUSslYGTB6DFgSDkiS/qKZPDHFXTpO/BAAI/wvvDgNjwAHsKaED3V2SaK7txvhIy1SdDtoBpnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXg4Wx+KTD06FxavOfwX8NkalFBPoqAsSGdND7hNsSqstgc3W
	O3VHFZd6OZ+gNBwuwIvQSK8I0kYVgB4fXpCwJ1PNIIeBBTJdgoeqKrAm
X-Gm-Gg: ATEYQzx4Dck25b7cc/yb9rXaZkG0/+4QCg3Tr5npaxQAi9aQ3PPynUcc4wJ9FxRMztA
	ShuFn+zLUKiWG1l2SwyCcci/I3SdCuyRpcjHSMiZ5owO8u/EjpTXYfUkI9w3C7ODB03EzRH89Zy
	duUxRXeoIrF0taBjbtacN6uxxhqtRh0RzeOTTs2gvE3yTgCp5oZc1v+9mtQLbz+GUBI7zREsz3n
	ZZQW9iJ9rRpc0e/qZF9kcnlEUXknOS+1UyPTHWQ3K0N3SoUZC293IKHeWFZss4cGI9fjxX+nIw3
	a+6RUDOmQPgAjG71XPfcXRM2fX613ueynAY8jIjFR5KmCVX5ewPrMdD7GnhTvQCIGRbpfcEgEPC
	3a+o1qyNDdARIciF1xEY1qEP52CmcxUaBznPzJ+LQNlA3qyay3xvWG8rnHegHcGrQvWa1BM/kDd
	Dbw2EtpqGAMn4w2AJSNe6/G3Z+uNC7VSFDVf+F9mQAe7OcAhzqH9xnAQ==
X-Received: by 2002:a05:600c:3b22:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-483c9bff7b0mr280384695e9.22.1772568013945;
        Tue, 03 Mar 2026 12:00:13 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485133a91b1sm21667245e9.12.2026.03.03.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:00:13 -0800 (PST)
Message-ID: <69a73dcd.7b0a0220.1ac46b.9bfc@mx.google.com>
X-Google-Original-Message-ID: <aac9yrt6MhSXBSbO@Ansuel-XPS.>
Date: Tue, 3 Mar 2026 21:00:10 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: airoha: en7581: add crypto offload
 support
References: <20260303193923.85242-1-olek2@wp.pl>
 <20260303193923.85242-2-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303193923.85242-2-olek2@wp.pl>
X-Rspamd-Queue-Id: F01201F6935
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-crypto=lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,collabora.com,kernel.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,1faa1000:email,1fbf0200:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1e004000:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:39:18PM +0100, Aleksander Jan Bajkowski wrote:
> Add support for the built-in cryptographic accelerator. This accelerator
> supports 3DES, AES (128/192/256 bit), ARC4, MD5, SHA1, SHA224, and SHA256.
> It also supports full IPSEC, SRTP and TLS offload.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/arm64/boot/dts/airoha/en7581.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
> index ff6908a76e8e..4931b704235a 100644
> --- a/arch/arm64/boot/dts/airoha/en7581.dtsi
> +++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
> @@ -300,6 +300,18 @@ rng@1faa1000 {
>  			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		crypto@1e004000 {
> +			compatible = "airoha,en7581-eip93",
> +				"inside-secure,safexcel-eip93ies";
> +			reg = <0x0 0x1fb70000 0x0 0x1000>;
> +
> +			clocks = <&scuclk EN7523_CLK_CRYPTO>;
> +
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			resets = <&scuclk EN7581_CRYPTO_RST>;

I guess you can drop the extra new line between clocks interrupts and resets.

Does the driver supports these property tho? For example the clock is just
enabled or tweaked to a specific frequency? Same question for resets.

> +		};
> +
>  		system-controller@1fbf0200 {
>  			compatible = "airoha,en7581-gpio-sysctl", "syscon",
>  				     "simple-mfd";
> -- 
> 2.47.3
> 

-- 
	Ansuel

