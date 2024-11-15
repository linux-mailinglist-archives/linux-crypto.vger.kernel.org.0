Return-Path: <linux-crypto+bounces-8125-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111619CF22A
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB33282166
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087D1D54D6;
	Fri, 15 Nov 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGvD1L6N"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433271D515E;
	Fri, 15 Nov 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689592; cv=none; b=pvC8LyDf/AJsZCYF+415hwbtK3eN8xffbh2G8wpnS9C6HAYX7VPDSqstzvYJXGYRlhc5ceHAEVQg11w3Uzd258x9wHcTVvfBoSEJWbqV46YZxeLnezeNFDLV2FUKogkUzKMlXkwRPqLhT15dYrVaC2eZKCtCI500ZzfuWVijOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689592; c=relaxed/simple;
	bh=G0JemIHFXM2HV0VP6hkAKzdgoqd98BpgIb7tqEZ7VEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WieNOMBhbfoP93yX+K7j5h36H43uEVKfRMlVQIG+e+jFC0EayadkIZM5nvRj0NxzAY6kNUZTGSeNFJx8TYwDl0fsIx94lH3ONdAWj1GV1IOXKc52ElSIUrM71gkXxCmhZ4T2MJZE660LiH+sS+MiNtsDNOejSwhUXZWcxoWROHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGvD1L6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5202C4CECF;
	Fri, 15 Nov 2024 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689592;
	bh=G0JemIHFXM2HV0VP6hkAKzdgoqd98BpgIb7tqEZ7VEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGvD1L6NzsRX5uP+gEf+BLGcdf9hhY+fhIdEf/92DrstzdgT/TyBFFOk+iVYoiIm3
	 RRMJgRYLIX5br+F1gNl1e+vjtXZbw5eoJIohfeUQOndXzhOwNb7dT46wL5F20P9Xpl
	 jeKWxwAFcv499KP5A5opuNF+0cfu+26bAeZyHywyYKvg6uhr9Fr57KfXdf9sXvbDBj
	 wFtLqOp8m129uhzGlcmx27iiPtBV/b72t4qDiVhhbR3TG+3gYnERBzqUAg6cCKC8Qt
	 MwiSdF9a9inRTGjp+zs90D3iULdIuFg2tI3lBVaK9Xr8bH5HL0IzEU4RHFnKCg1S8H
	 AgLLpefTiinBw==
Date: Fri, 15 Nov 2024 10:53:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom-qce: document the QCS8300
 crypto engine
Message-ID: <173168958952.3356409.1833757085964982374.robh@kernel.org>
References: <20241113055830.2918347-1-quic_yrangana@quicinc.com>
 <20241113055830.2918347-2-quic_yrangana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113055830.2918347-2-quic_yrangana@quicinc.com>


On Wed, 13 Nov 2024 11:28:29 +0530, Yuvaraj Ranganathan wrote:
> Document the crypto engine on the QCS8300 Platform.
> 
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


