Return-Path: <linux-crypto+bounces-25531-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AQWcEdN2RWrAAgsAu9opvQ
	(envelope-from <linux-crypto+bounces-25531-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 22:21:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C98636F1699
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 22:21:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dEJPQP4I;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DyZCzMsb;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25531-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25531-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F4FA30C24C1
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2026 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3EE3BB67F;
	Wed,  1 Jul 2026 20:18:07 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B702371D07
	for <linux-crypto@vger.kernel.org>; Wed,  1 Jul 2026 20:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937087; cv=none; b=W7paNg2HNOKpchRb0EN4mUoqP1cQqQmzcdO3SPMMf/viInlyCs5LWLl5eCHA86Jq62xVYSwDr2iWtg9yBseREEPPaOWiJdTYZsyh1lz7h35aT7rHEPgUlbuQSDl6pKZOE3mJW6Dm9ErK8RXHMSA7AF0MvXAOIyd6psTumjfd9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937087; c=relaxed/simple;
	bh=Eze2ioRdq2rIO2XoIkqX6nNtdm7cYbxnuQNbvnOoajE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwwlm8C5oaGrDXcEC4NmZ+kyYFRZJQCbaYDWh4UQmXoxn1NsfGC8WMLKk5POOagF1Epxfb21mqrfe4a0yA3NnYvYWbhMS676ondZqIyt/pWrNDRdrKjVCGeGcD4JQTUx2dx7uGmDTNluRLSDuEwSdWBU6p097brPZHNd6p8jg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEJPQP4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DyZCzMsb; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmb7Q1630469
	for <linux-crypto@vger.kernel.org>; Wed, 1 Jul 2026 20:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=; b=dEJPQP4ITFS8647p
	h1fmsJ6dgeHyDHH0+enPUAWqOCeh1Yr65C8UKnFV8p9o79BhLpbdUvmaurmgO7AY
	DPpkoYFpIF54KImEGqGKZuvM6enoLDQ1kfpnw7mzWtN+1Ts463yYTdLEjGl5SGi0
	bS3bEc0yTsCkStI0rDPtxUm5TLuuv7eGq50XB2VQ4LhtzJzsLtkL/k72Q7PSQgGw
	Fgc54XSFKcWFbeOmMBFbfbcMQzv29pn9KbhCkGOUpRJSJrKUAB6dgRn1h7zBXGMZ
	9wZxbv1C2RX1v10x5uFDO/J/BYWwz0riN6wZY6CFXxdS1gwJmTIfaSTJB5FpxSkz
	sGmYew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f563mh0n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-crypto@vger.kernel.org>; Wed, 01 Jul 2026 20:18:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37f72223fc9so885122a91.3
        for <linux-crypto@vger.kernel.org>; Wed, 01 Jul 2026 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937085; x=1783541885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=;
        b=DyZCzMsbFma8dqvNj9z6kgZ/tHWOVe+521VBvxU0VKMTAuJFA/94MuNMMznwmqaULP
         16J+nT9AmNr6Iw7rI1d2R8uJxARP3v2QlWzSx32UF6i7fz07YE+ZGqvyVoQ4P/CAN/h4
         kXW8eM293iERZ5y3qaodbNUykufBM5U4beVZR4T4fM+TpCFpkR1paqS2WNGHOFmZtAXu
         DMWEKXvvieYUBQ1SfBjIUsom0f988yvaTk6ZWZc4ctp8XF9+CHveFacEDgWuRAy/4QE+
         /oMklyK60R8LkuueaSggzu8I6D/j00ubvjzesEBQjn7n3kROy5ey1bkq8bk1l98US12D
         YZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937085; x=1783541885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyrH2W2sfwjDNEPGQYVoT+aVr52hlGBGd2sgUDya5+k=;
        b=nareLISjAkwHJI8uT8nz+X7+MhAxIeyxqdPv9vpoVB5sSWj1siNqfZz4KSeHUcQfSh
         EC9sKcUhAFhjDPKNroefuZVORJtsc2CeAX/hIS5L7PYbUeZPzdFFjcHrv5dKnBCpC4uR
         fhUIf2UUAGO6OLCXutSg8JvdTMElCl5vfrlIAQASqdrsdBtXWn3LF1d+D3zn9pGfK/e4
         /nnuo6RniJIpY7IH3WFhdp2fVevk7l/r4PvMdoK8f8zG5CPKYaaVlUiEY679n5Syd2KK
         d1DbypLjOEcdp2G3uULLQeyasqURH+KPV+71iNX6qXZ5emQycqTO5ftuSB1RYcQ41Qgm
         Ucjw==
X-Forwarded-Encrypted: i=1; AHgh+RrxrBkIiayg69/VGXxOIjKoqOx7c9fPMRrx3nuQoIMXunfzmPoNLfdl265a8Z5nDFmqahjSTReq9Am5hsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA21if3mBygjbO8z/iUhhHc8XE8JBXPZxhnPKbEtPrVRwTpW+V
	Xj6a6V8bYUYITmOkOUOQPamme8teh5kAz11b7OdFHEmejmhkxB4DcswCpZQ5lWZ9ZUrInirsSlR
	oWFoF7VIJqEK40Gp2Hf8RnWfhENYk232mP/0ciDK85gWtnmHzGtqGT5kYiEktHYxuy2w=
X-Gm-Gg: AfdE7cmYknBSeISNXWJ+7SQuJBS00/YOeS/+nicFBywErDgYyQIKytUFGjUSBZ2IZHR
	Thv2FF9gkHJB7JSBTblmtNQ1WEcO8lZ6Snw+6QgKJNXaUPU8A5vrjbA9L5ezpZSYuQYGCk8e32/
	UuZO+wq4Jk8RRmHVmQYTymn7+SEB4qakKm8wMaCrFoKkjfjLreP2gUXqUKjPYRAJWD1yh1k3hRN
	uEulomSc8yvdd6tZN2Aab2jBtmiXOzObMJ0ga6z72HMTmaxFocvAZRwJuifXYUpBfBWMApftwe4
	pSkg5VDDi7KKnAkO35b98yhJ/OwW5hr4DghHKFr+D95ek+/PYuWq4AkAawSq2CGFocy671fQrQ2
	MEYCFfUmlCsxmEozlGx3QJ9mx9JA8DEeM1CiYFtiEbKs2
X-Received: by 2002:a17:90b:1fc5:b0:380:a5a9:7586 with SMTP id 98e67ed59e1d1-380aa09529emr3081005a91.6.1782937084658;
        Wed, 01 Jul 2026 13:18:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc5:b0:380:a5a9:7586 with SMTP id 98e67ed59e1d1-380aa09529emr3080968a91.6.1782937084168;
        Wed, 01 Jul 2026 13:18:04 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:18:02 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 01:47:15 +0530
Subject: [PATCH v2 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-shikra_crypto_changse-v2-5-66173f2f28b3@qti.qualcomm.com>
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
In-Reply-To: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: QnEBeQw-D7y0PUg6MdnHT_tOkobkDwS0
X-Proofpoint-ORIG-GUID: QnEBeQw-D7y0PUg6MdnHT_tOkobkDwS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX8DtBpyKytouk
 OvumwbSgH/W8EYMNIAflnog/fxizimjG8AakXzIhjBpd/wnJi6OpgWdWYebzzlpHey7IxekoJGJ
 AoO4vY9dnz4fwi2BDeAuQb/8GLsslJK9NcShgm5Ak2WyQ0HWA6Tm1GINrXYfVkm5VPW6P2n6GcN
 MbNkGnMipPv7EP4aI4bRIJIWrWE5kW7JnDrSDjdHkp8qR19lDuXUdnFx+tsZHJ7dlG1R1p9cm67
 IdpuALERQqx5o2Gt7QU36znnIMhzk5iEVuWBCn202MEmTRSO9yg1lLWm4UJcdOskJ1GZcaCiKRe
 4CnIXrO9Em6ZiJd/WdcG18znGvC9yoAOjyrHWACUiOVI5wa+jMRJEKVuq1IKDTFDR9iy00Xj1Vs
 3cPLfjgm2HheeHbpXU9wq1FeCu1B8MfqsAzxGsYF+HbozctcahvoBHRj04z9FKMvPSwTTay7uUc
 X1RPtJsjQAhWz+JIpEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX/yymvIbxFdLy
 8tUpMVY7CEwKUQexhO22lE3dQGWNYSoUAGTIYjfNmbyFSNGusTGuWOHe2fSC6My3MP9rrWoyQai
 u1iiNPy0Q7P+MeNV1+pt33lbi7S1eJ0=
X-Authority-Analysis: v=2.4 cv=UopT8ewB c=1 sm=1 tr=0 ts=6a4575fd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=SaiSOrgfs3erbmmhS0kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25531-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qti.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,devicetree.org:url];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C98636F1699

Upcoming Shikra BAM DMA uses 7 IOMMU entries and not 6, so increase the
`iommus` maxItems constraint.

Fix below error:
dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[25, 132, 17], [25,
134, 17], [25, 146, 0], [25, 148, 17], [25, 150, 17], [25, 152, 1], [25,
159, 0]] is too long
      from schema $id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 0923fb189ada..e72adc172af1 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -48,7 +48,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 6
+    maxItems: 7
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.34.1


