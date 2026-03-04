Return-Path: <linux-crypto+bounces-21567-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNzYCOwYqGkVoAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21567-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 12:35:08 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A51FF0DF
	for <lists+linux-crypto@lfdr.de>; Wed, 04 Mar 2026 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB713040A8E
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2026 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1E2350A37;
	Wed,  4 Mar 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8pZhTA6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112E3451AE;
	Wed,  4 Mar 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624087; cv=none; b=mx9xFt2wT1IKYyJpzt0zaztJJrQalBuwioy4hbSoFAIsx7dbwpaI88OVYQMXE2C/kkfIzvNmc1jr9f9SPtXICJIpFwwyPVmZeGkf0oIDciflBYgBWAe9JQ2sNEKHGxkZXR7tNIJ0VziqanuLR0nSXQ/MzMb1NcEXvc+BmaCLLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624087; c=relaxed/simple;
	bh=8ynUVUDyth5bSt/By20k6bJWU9I97gy1nrt2iENQfHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbQyEfjCN5gKpjRRnKySdPnOIVI9Af8fo6huOQSuhDQH4+537r6k8rxn23osxpjbTVXqzKvw+vHhiek7eiu6O/VMXXIRHDtbIToq9SPbAvtgOUXuYMqbfKUnd5xqUdBbAv1Frd6clYVb7moGVHa/IxICBVMh/sTROGK5qPfCAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8pZhTA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F1FC19423;
	Wed,  4 Mar 2026 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772624087;
	bh=8ynUVUDyth5bSt/By20k6bJWU9I97gy1nrt2iENQfHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8pZhTA6EhprRj40CnGqbIRNhfj1qcvYxaVvXz9neh16grGyd57KyQXsPDmzkzyzd
	 pyo4tgOInkzbL1RPptLdgqPHLZ9pFvN2R/rO4nQy0pivE3AGYgBC5A7UST7SRpGAmO
	 auQa8sQp/G8i0Wd6U9qmRYUJyI697qHud/eii+OZ4YG+RthlAqAP3V2I+FCJttXueO
	 c346ig/LwSV5U81xG8gs34KXaYaPW4/HeaWYtlYqYi4hajinmEBduJjQCosAgX5jmx
	 dgTgYGycoZ7lEzPR84ocX84KLvrUVxYrCMa2+eE1u8vTE0CTkHpgLuf4/Il2MZw/Dv
	 rdtWvNpCZLndQ==
Date: Wed, 4 Mar 2026 12:34:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: rng: mtk-rng: add SMC-based TRNG
 variants
Message-ID: <20260304-defiant-echidna-of-examination-b1e798@quoll>
References: <04622e0bc917aed4145a9a3b50b61f343fc89312.1772585683.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04622e0bc917aed4145a9a3b50b61f343fc89312.1772585683.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 7D8A51FF0DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21567-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 12:55:27AM +0000, Daniel Golle wrote:
> diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> index 7e8dc62e5d3a6..6074758552ac3 100644
> --- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> +++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
> @@ -11,12 +11,15 @@ maintainers:
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
> +          - mediatek,mt7987-rng
> +          - mediatek,mt7988-rng

Not compatible with each other?

>        - items:
>            - enum:
>                - mediatek,mt7622-rng
> @@ -38,9 +41,22 @@ properties:
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

Use rather positive list, so drop "not:" and use cntains for only one
compatible - mediatek,mt7623-rng.

> +            contains:
> +              enum:
> +                - mediatek,mt7981-rng
> +                - mediatek,mt7987-rng
> +                - mediatek,mt7988-rng
> +    then:
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

Use four spaces for indentation.

> +    };
> -- 
> 2.53.0

