Return-Path: <linux-crypto+bounces-21773-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IzKESkvsGlHgwIAu9opvQ
	(envelope-from <linux-crypto+bounces-21773-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 15:48:09 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C90252673
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 15:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF48C33AA47A
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C37399352;
	Tue, 10 Mar 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6+kh1Ie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQqXKQM3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0751397E94
	for <linux-crypto@vger.kernel.org>; Tue, 10 Mar 2026 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151951; cv=none; b=jRzv+3JoxsNH2ACcvCPD9tvfITFggDct/wD7UdFJ7H2eoPzYMXKQV1ySIO/CcRgvy5SAhcoybiESeRKpVqKTYLWQ4pxyHJfxTch6UmjDIzyDoU/VtAWMSn6W7lY3Wj383wq02QPJqPj0JQyhO9y1J3+MIc6+N9SkW0pCumOSzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151951; c=relaxed/simple;
	bh=2PX/oH5yfu8GCXF/56+289Sd+rY/wwgXPJOtAlblqg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYswrghP0BqcL1EGQs+aZnX2LUT2O+QjPbsjldVqoT/XOWcOrYS4HuLszrUJiVi2ePgVki8k8GhO/j7PihJS76x5vvoSm2Vu+d1NKZxGZTymFR0kU5X+OkgtDPfZck68ljHVlzGauXzp1VwxaGhKNpyGh3SfuA/7rXZANOnpWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6+kh1Ie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQqXKQM3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaVAV1502944
	for <linux-crypto@vger.kernel.org>; Tue, 10 Mar 2026 14:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/mbyn5v6NwmEdG+6B8c99cOQW9zb8utuqxEPtdWgWeE=; b=o6+kh1IeXIKYzYbk
	VoonwtXepckW+lS4nuu5BwHJlnHejhovgzwOs8H8iTKd1lUj2uOTZ9yO6umltrPr
	v5Ow7QTcZPXW7PuWCRv2sQJ0MTwiOhQzPZA1J4WTJOlUA6DMmsFAHq/zdhJlCvc6
	A0rEaDHekdTZI1NSlVEUpKAnydiBJgeyha7fI5AYC32y0BGwSoiEgapWPDAW/5DV
	7PrqiPrNgYDi3iEXbbzWXlpPUUVrUXI28d08EsBM+FsH4SJJrvkO9Jlt//FhLsZZ
	tfybMKAI4Ahxg4ZhDs2ENHPv/PGHDUnSneRNsQHVCIiUzigpWd+kGdQboHwsLLpg
	ROp53Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8hukk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-crypto@vger.kernel.org>; Tue, 10 Mar 2026 14:12:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94abae6fee7so1733918241.0
        for <linux-crypto@vger.kernel.org>; Tue, 10 Mar 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773151948; x=1773756748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mbyn5v6NwmEdG+6B8c99cOQW9zb8utuqxEPtdWgWeE=;
        b=dQqXKQM3qyH0f1lCqttfRjDUThv3RdL2zLM0t/YnbaVxkkQ4yJROWd2BlicSPkAfhQ
         l97WGklcWXcAiaSoRi5tmzugKUQCwNzpw+waKwSJw0HHawsGlFzzZJbgdFTzFRcOtkcw
         MqYeePbNfMkJIYULsYf5k4E0B7SxUs0rWmIzoIOJ145OSQ9o/WZTPP1lExZEZSx1u2gp
         R9ked+WJTIT74M1SGVWWdjd8+b+ZnsFZ4JglbtZ2GY6B1xIIKhF9JSAnWo5f+nqPTX01
         K6Y48pbGphdKucqADnUJIcwjLW3eI1BGjpQwOTs3WcAl79lL0EFabi1QbB20H3uUiVua
         bpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151948; x=1773756748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mbyn5v6NwmEdG+6B8c99cOQW9zb8utuqxEPtdWgWeE=;
        b=YRSIQQHp2piRjvWAInWm1ruXLDj2IUapFz+tMqaQuqgCxXFILrG92DLh+LoTR4GaUd
         777RpvlVuNKNTbJ78h+Zl4XFNTe9y8R0+oNrWIfoFc5OcthjDJPzrqHSps7nbjAnbgN2
         gUE58ZRSw9yylrTFpSgOGun/MMmjxzEiYVsZtTE/9veyJZTZ//f4MvMROqpL4HEy2EXk
         yfHG7TJF/tTcIG5N8mFTu0S1elV6NyVmAreCHBtWWrFfsCxbB9psaOtDvEpqGttrp+JQ
         P7Ph/blw6slsJuBnYoRE1XSflaoKPbmBd5QLNXTMozF7rpDOdLIVkxKSywRTphNl8J3I
         H2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA9hBc3EuMO+2/te8nNzo/y998v5shr0mPcPQ/ohrDF/cAJPP4DeBURW8WVpDQG7j8I/QbfIAhyjWEVEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q5JZe9mdkUw9KTihAh0b1SX+OIFsr1L8iocXgpwyMU9qWLwI
	slZzUqcp0NLAwHUpMqPqtipbQ/kqWp/B0dopTfEGxZX8PSYRcrIjU1Um2hiKBbe1liwGMPf9mnH
	G4z30tNJF2VSx+2dXOarZjjNkSzhw0lGH7Qjr6uzqFRSmwhQp62mK9egqMT+UfroPR+s=
X-Gm-Gg: ATEYQzw9xJ+r645CYzUzCYA/En82fMG4gQ9HKU6nau75e+g4GHhtNDSggmV+z5qjksO
	V2siGCBLqogPt1AjSQ++k2t9k1RIQw2pHN7RAV7vh0R6CdVYYoyO5r1vkPfyYsTUnBucZ5BmbOT
	GzVwbeM7OWLsEo9MLB/pkSzCI7OgL/Ta2BohBeljLuZeqFKxx0Wdt+tWcQtGPsuJL0CqRlptLPe
	+RYx1EwO1J48wcm54h5jmKPevCShw2w+UqchQVZLMJF4ohcs12fRfKX1Nc5ziwVDUYZ8AYdbJz/
	NR5nR0CDb+kGQATF69pgYSYN4v+bZD3NDU0sllvVtDkzgxZQMGp6d/6q/+vPpw2AycJqg8c5xdW
	mxBDAPTYj1Lb+RXOMkoTt+BDvilNP4ZqrJ009TAduV8pG9rXxJ/xt7BJJ0JslViK8gxzXrrS/HL
	QLW4I=
X-Received: by 2002:a05:6102:a54:b0:5ff:bd9d:b1dd with SMTP id ada2fe7eead31-5ffe6397839mr2629980137.7.1773151948253;
        Tue, 10 Mar 2026 07:12:28 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:5ff:bd9d:b1dd with SMTP id ada2fe7eead31-5ffe6397839mr2629959137.7.1773151947595;
        Tue, 10 Mar 2026 07:12:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-662a07022ebsm1512263a12.3.2026.03.10.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:12:26 -0700 (PDT)
Message-ID: <7adf07ca-0ff6-476a-8975-8ecb1239a754@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 15:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] arm64: dts: qcom: lemans: Add power-domain and
 iface clk for ice node
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
        David Wronek <davidwronek@gmail.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: Brian Masney <bmasney@redhat.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20260310-qcom_ice_power_and_clk_vote-v2-0-b9c2a5471d9e@oss.qualcomm.com>
 <20260310-qcom_ice_power_and_clk_vote-v2-3-b9c2a5471d9e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260310-qcom_ice_power_and_clk_vote-v2-3-b9c2a5471d9e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyNCBTYWx0ZWRfX4I+ugmXAwCGU
 BVFN4usHd3Zdb/gZ6hX5DhpWjigKKbTvt9zIGS97NFDpvRV/7sksyRZuWnHeVO4/fyahnx+NCtU
 RRXV5QOvFJjVpYkF/z0Za5GFoTjq2Gq8tw5yahDTkp4LM1bG5LS+lU7W1KCaHp7cmznZAnv6I12
 ngMXAKtA+pH54Fg3FaN+QrwqcbwrnfwnOtDaXzC+97NylPoxNBRMfBL7Bv9XfImKYUrgGeHw4ei
 /TBYP4mHyScTLm8qLswQwfKcY3cZtjoBbUeCBvI+0hHDmXptQcPzXKsNPouatgKvpgfG+okVPsA
 or8UwsB9DHekUrTxDZlEpH5Vol2jxs8yAHSQQzU2esL4TyvVha8C4iH6jgMq+SQchDPYLEWHFtu
 Hyp4wPjgBtlpq1NuXwtXhmPI775zt+TpQRl4tN4qQPJNs8w0P5NP+HRnnSuW0OmOTQ+1ZRgdAay
 Iwu4JzFGg/xNqGeOvcQ==
X-Proofpoint-ORIG-GUID: LKm5dUNVxt4dJsrvRj7ojkETbVLRavGD
X-Proofpoint-GUID: LKm5dUNVxt4dJsrvRj7ojkETbVLRavGD
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69b026cc cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=z_dnvKGLtVwtNw_c-ccA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100124
X-Rspamd-Queue-Id: E2C90252673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21773-lists,linux-crypto=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gondor.apana.org.au,davemloft.net,kernel.org,chromium.org,google.com,quicinc.com,gmail.com,fairphone.com,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/26 9:06 AM, Harshal Dev wrote:
> Qualcomm in-line crypto engine (ICE) platform driver specifies and votes
> for its own resources. Before accessing ICE hardware during probe, to
> avoid potential unclocked register access issues (when clk_ignore_unused
> is not passed on the kernel command line), in addition to the 'core' clock
> the 'iface' clock should also be turned on by the driver. This can only be
> done if the UFS_PHY_GDSC power domain is enabled. Specify both the
> UFS_PHY_GDSC power domain and the 'iface' clock in the ICE node for lemans.
> 
> Fixes: 96272ba7103d4 ("arm64: dts: qcom: sa8775p: enable the inline crypto engine")
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

