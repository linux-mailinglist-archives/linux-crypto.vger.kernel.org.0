Return-Path: <linux-crypto+bounces-22711-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFGVFGMizmnElAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22711-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 02 Apr 2026 10:01:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DD385926
	for <lists+linux-crypto@lfdr.de>; Thu, 02 Apr 2026 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE2F33082874
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2026 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2B38F65F;
	Thu,  2 Apr 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjZ/eeqr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828F194AD7;
	Thu,  2 Apr 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116682; cv=none; b=tADTGhlJBOir4tmWC//4t6A9GX1piGBIuIz6gLCicX6xkuq4k6FdzA/G6/Cwce+wQFWm7DdZ4G/OllTGtwuWgGkIcD4u9pThY3kO67I/u/IYqho7sz3/68r4ymodHOLsvI/+ATEtMVbRpXqk8yJGMMZderu4ijNu3c3MXdwItMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116682; c=relaxed/simple;
	bh=dmzEjMz+G0kGZ86c7hnlol8UGuYu8HaYTRIYsCVzu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFy7ji7GMGAVwQuRv9uAjDLRqAIr+mkJ4IhtekF0UAtkxrbphZA1+ZIlCCRmverFw3XMAb6fLqEIyT1sfWaXhuJG+zaXG727WpiF8/r/J37BRkszq+aEuAiHxHtkRt0QihZzcqJS1oLEgzbLweq2em80KJ4F2ec+cpUdn2ZfVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjZ/eeqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2521FC19423;
	Thu,  2 Apr 2026 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116681;
	bh=dmzEjMz+G0kGZ86c7hnlol8UGuYu8HaYTRIYsCVzu4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjZ/eeqrI8C+38ObBE+mYnEkkApVuzxGZSYasUYMzxD0PNPmUnD+W2Hk6Ea2hW3/c
	 znNaLRljOm1YPBZb9wGOHniUFUR+6DUt7ylQICrDzpOCjkuuPujlh5mPdGHNdVEfQF
	 WhrXmX1DCQXu9MU5Y8xYzu1nUFTA4F/i4dr6h0FSH5j4gOjRdrk0lbr9Ex3/Wv357k
	 1pWmc+CA3gQ8ciQmV2ecQBDGY2yH9diri7j+t8kzcuuFB+kGZ1+y90fPQ45cdbfUkt
	 epc6s7LE2RPsRrKg1z4XWSucu1FQ6JWubSZU7oZJEteDAbzP8UZmC/FYrMoAulyROM
	 Jno7reZ2hfXgA==
Date: Thu, 2 Apr 2026 09:57:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: mtk-rng: add SMC-based TRNG
 variants
Message-ID: <20260402-towering-transparent-malamute-1e44b8@quoll>
References: <0a951e34b7030e514091d6c0922c5982ae349221.1775090165.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a951e34b7030e514091d6c0922c5982ae349221.1775090165.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22711-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[selenic.com,gondor.apana.org.au,kernel.org,gmail.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E31DD385926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:37:02AM +0100, Daniel Golle wrote:
> Add compatible strings for MediaTek SoCs where the hardware random number
> generator is accessed via a vendor-defined Secure Monitor Call (SMC)
> rather than direct MMIO register access:
> 
>   - mediatek,mt7981-rng
>   - mediatek,mt7987-rng
>   - mediatek,mt7988-rng
> 
> These variants require no reg, clocks, or clock-names properties since
> the RNG hardware is managed by ARM Trusted Firmware-A.
> 
> Relax the $nodename pattern to also allow 'rng' in addition to the
> existing 'rng@...' pattern.
> 
> Add a second example showing the minimal SMC variant binding.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: express compatibilities with fallback
> 
>  .../devicetree/bindings/rng/mtk-rng.yaml      | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> index 7e8dc62e5d3a6..34648b53d14c6 100644
> --- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> +++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> @@ -11,12 +11,13 @@ maintainers:
>  
>  properties:
>    $nodename:
> -    pattern: "^rng@[0-9a-f]+$"
> +    pattern: "^rng(@[0-9a-f]+)?$"
>  
>    compatible:
>      oneOf:
>        - enum:
>            - mediatek,mt7623-rng
> +          - mediatek,mt7981-rng
>        - items:
>            - enum:
>                - mediatek,mt7622-rng
> @@ -25,6 +26,11 @@ properties:
>                - mediatek,mt8365-rng
>                - mediatek,mt8516-rng
>            - const: mediatek,mt7623-rng
> +      - items:
> +          - enum:
> +              - mediatek,mt7987-rng
> +              - mediatek,mt7988-rng
> +          - const: mediatek,mt7981-rng
>  
>    reg:
>      maxItems: 1
> @@ -38,9 +44,19 @@ properties:
>  
>  required:
>    - compatible
> -  - reg
> -  - clocks
> -  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:

As requested last time - drop

> +            contains:
> +              const: mediatek,mt7981-rng
> +    then:

missing constraints for mediatek,mt7981-rng. So does it have IO space
and clocks or not?

> +      required:
> +        - reg
> +        - clocks
> +        - clock-names
>  
>  additionalProperties: false
>  
> @@ -53,3 +69,7 @@ examples:
>              clocks = <&infracfg CLK_INFRA_TRNG>;
>              clock-names = "rng";
>      };
> +  - |
> +    rng {
> +            compatible = "mediatek,mt7981-rng";

No improvements.

Also, make the example complete since binding claims you have clocks and
reg.

I am not sure it should be even same file, but if you are making it same
file, then make it correct.

Best regards,
Krzysztof


