Return-Path: <linux-crypto+bounces-8784-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46329FD1E3
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Dec 2024 09:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AEA3A0661
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Dec 2024 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B21531C5;
	Fri, 27 Dec 2024 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRbVPi6y"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F134204E;
	Fri, 27 Dec 2024 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735287556; cv=none; b=I8eEEatzih62mKeUtKmr17oTxCSxQHsTvrp0ZGn2QO4cHEexea75fJlchiR/1JJ/mVTtzx84yVHkHd49mECd4VO9PsBUNvt1up8voPFooeAlrlBL9r15JBiwmkkX4nTzUvXd9viCzL9tSsSqWFf6rIDmeLzw8Td47vubn4mhWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735287556; c=relaxed/simple;
	bh=21Ni2vTUVWKZS+HibH+v8Zeq/if8TO6moLO1tWSJXnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj4eIq0Judx16kJ96lZ1yrjjZhYdIYVejKYtcb4MVBEuLW4miF4UUx+VIx1VNH74+izeWN+6flrKonQA0U0VHSsSfV86znXdCW48+wXJOeE5syKzXzRpJpIgP+eQJOAUU/hvB9WlyrY5gUulnjVtdDtzaTbM4vKBS87UtzzMyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRbVPi6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EAEC4CED2;
	Fri, 27 Dec 2024 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735287555;
	bh=21Ni2vTUVWKZS+HibH+v8Zeq/if8TO6moLO1tWSJXnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRbVPi6yo5Dls9u/sUlJvvj+vGpFGhqsIuA3UJKJbxIFhakx6TGppx6JU7IALSFwj
	 Kkcn82wrBfbk/NfxMY5ABm6DxjG5RCT50eUlq0LDnuikAUTwcO3+ItV/b2AWEcu8Gp
	 RK7J3eOKwyjUvlCUfO+XK34Wpc+aOoK3oexoLtp91BRxs/eNps8tJdgDJ3KRyAOSP/
	 gIt8clc0JAG4TzQNDCVtt12fmRWEHf9tugTJiH9z7I9ohvvItrgW0bVml+3HJYppMr
	 CcgQow1JBoWZW3z928tOmsQj/NCyYLBpAlgeYLqo9yeGuM8vR7oE3LJllMdSyUa80j
	 caAaH2GUv80kw==
Date: Fri, 27 Dec 2024 09:19:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com, quic_mmanikan@quicinc.com
Subject: Re: [PATCH v3 1/4] dt-bindings: crypto: qcom,prng: document ipq9574,
 ipq5424 and ipq5322
Message-ID: <em477lhkwznm4sdpetyailvimkgpfyhgvbnwjkzlbuw5snsvpu@azbescsq63d7>
References: <20241226114500.2623804-1-quic_mdalam@quicinc.com>
 <20241226114500.2623804-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226114500.2623804-2-quic_mdalam@quicinc.com>

On Thu, Dec 26, 2024 at 05:14:57PM +0530, Md Sadre Alam wrote:
> Document ipq9574, ipq5424 and ipq5322 compatible for the True Random Number
> Generator.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


