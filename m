Return-Path: <linux-crypto+bounces-17547-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D1C190C4
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Oct 2025 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFA29355D7A
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Oct 2025 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30CF31D377;
	Wed, 29 Oct 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqPYPJAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz98l66P"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC123128B1
	for <linux-crypto@vger.kernel.org>; Wed, 29 Oct 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726341; cv=none; b=ljBFtWMXvuPtJ26vzYh43QJGUk/JMU/W6djlhs2xWN7OtChZOj4nQ2tfWjMGLr+LIQVBAc7/lnsbllQU58S9RfzZbIPglAw9Gy5i9I7EsCv99v99/Gl3yZS+ueoi6qXcX4LG9YjtnEjYA8rZsRSPG6HPKP2sp/vp3BpUOx4xO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726341; c=relaxed/simple;
	bh=w43bHQGv/zAaKHwokTSoj0q1EvK3cCGUoMxNLVzLHPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3Qhu6q7h50nEcyPcQPbZDTE876Wd+prEengALjmuNndmOa/jB3txtSY0sunf54czjaD/8uCHLUAXJ5n+Z5zKP4TKkpYV11s2miq9Q6QXA6ysm+51dzjlordhq2F2EV4hRc80f1nExUfrwT3jcmsKTZuV3xzHB/4kqtPKJ36y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqPYPJAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz98l66P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vGED3678128
	for <linux-crypto@vger.kernel.org>; Wed, 29 Oct 2025 08:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=; b=pqPYPJAiNMOoiw9G
	1rPqYQ1PkKiDKu6cjLY+e2QQeI2dRgXksuFKkHIgGb5bH5mpoWSWwOfNcdvyi5OS
	3tJoDUH9qwLdguGsvAg9U/BEFA8/J6FBz3ZgdqPzbXHcUu6QRh1mwXkI0s3JU88a
	KbZguItQZixrFRI72sERi7T2V9Q04CeXnxhIfDbkOXcO85KGZU4/jaPUjpe/sVkK
	0CkYXjzbW3ziNW+KpC3oerNJJuZb0BiwsXbyiKzTJlAsuxUYa3fHe184eYbzbSK4
	59mtEXDFW5ec07H82x6dxl8Ol1vog6DSyI17aE88pO7uocQpsR9ab2HeQVhYlcrb
	APh+xg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1hrv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-crypto@vger.kernel.org>; Wed, 29 Oct 2025 08:25:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so4997762b3a.2
        for <linux-crypto@vger.kernel.org>; Wed, 29 Oct 2025 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761726338; x=1762331138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=;
        b=Xz98l66PXmW/vTQ5kCjCR1fSShVZy0Zp5YrWXGEIdEZ4Zy1OttFeKni3KFy1y0Od4w
         EM/5AfJF/uCcKpSmkomhVD/0sC21C/geZ5Vti4OATn4KqxELM+BMsakBKeVn0ymY5nuJ
         u4OTSFjXns9tP5JT8gBGywrwJJG1+/tdwM/10iO+I9HVIFSeuEE1osXe6q9m5ZSgDZ5H
         govVDr9ASx8NkiqCSgYkjjiRWCigY/5A+Z12lU0vtZ8gs3lVHqJxMUi+jtSg3EFR9dCj
         OohfN8RpqwVOsaKK2tM6iGZh4PyALtmyVNWtSms+6gtjcWI/ee75C5T4NkRy/lqYhDOF
         1c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726338; x=1762331138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50Cp3I5mBMY7GPkVlH2aGvh/9PRy+BGUwsmDasOX5G0=;
        b=GSjc6XVuJc9p7NsNQsPjV0tc6NWJOVE12gDSWJKRSHwgOk8al1JBuORBCCJShWgHDD
         fxsRmE9SpUWLHu1Ky/qURnCLrrQWFJ25NyVNqPVXtZBT9qS7A0aztQb2ZilvLOy5gyE2
         OvN140swwbU33SJAuVe+Lgo1i3Baka4ssaoIHyESnp+ZdX0SIXwWP8wbgJDcN8xT3Nao
         KW/qVDP3O4RNGu+bkIfUCCtTSvlHtwwNV6zfdw41jFjfnZWjwlP+kjlWpIej86awOxGS
         JNDoQbX+1c6QMbZ87R/4Hkt48ghafalnxxoGCeS6AORJQ/bR4JGK8+d16RQLiD1UT8mN
         akhA==
X-Forwarded-Encrypted: i=1; AJvYcCX9+Y29AVKnDhyUVPpghRm9FfBOh4j20I+lksEIqaarWmcf0czUAEtM6UDZLK0XlUOEVMKXkidWoJqUFTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqcx+F1wma9f/rbfVkL7iRoT056O4IerTlyPtfBNMfB7S/L6Q1
	qx7xGaQljyQH+frU0odS4m2bO3sQcehSpeWuyf9tHBB25l6HxmF1RAP9R/lJx2w1BKriYYiIcxR
	O+AZFnjY1zHBTcNDns0im5Hjp2KVkBa9Ifes612kgLeVND1gn8NyfzQC2qMcqX1HIg5Y=
X-Gm-Gg: ASbGncu0Gs5hIgrewDQT3Pa/jbqNyp3UKjcKpTTECOAbByRufqbAlIMBTe56BDUM+SJ
	O2MMZUtpVc9T3isWYyFvcOGEJThLum+QRGWLOl5Oojg/9DMbIZegC6TgY54sXP8hSSAK5khOhKf
	bb4b/0gkG53qyDA3bk0VQ8oIelKPMQc4rvP9lgS44bdyM9Xh4HtPzJy04kYTktcmh3SomWsP62e
	6kbOdEq/uBRIDne6LOk/+BFqybiopH2lEof6FBQMmb978eGQL72we08kYNVYIvi3ugthSQj4R4D
	Jk5bsXmly2c8EXiI0+qkMz1OKxYmYEFUgLk5pBSPRIc74eYQebC/eA2og6kX8t6z9t9wRJ7Ey1e
	sTjE8Ou4oLPYTv9wzCHr3besqnX1NaxBq95V7TaY9qQYsvU883A==
X-Received: by 2002:a05:6a00:3e04:b0:7a2:76a9:9bf0 with SMTP id d2e1a72fcca58-7a4e53f47eamr2802453b3a.31.1761726337575;
        Wed, 29 Oct 2025 01:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkr279komHitpMFYSLX57z9xYrZhE70hIU2j2mahLHGOiFc3l7/MU04d5SWTk1X9QMqcI2g==
X-Received: by 2002:a05:6a00:3e04:b0:7a2:76a9:9bf0 with SMTP id d2e1a72fcca58-7a4e53f47eamr2802417b3a.31.1761726337088;
        Wed, 29 Oct 2025 01:25:37 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm14158850b3a.35.2025.10.29.01.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:25:36 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:25:29 -0700
Subject: [PATCH v2 1/3] dt-bindings: crypto: qcom,prng: Document kaanapali
 RNG
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-crypto-v2-1-b109a22da4f7@oss.qualcomm.com>
References: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
In-Reply-To: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761726334; l=960;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=SWFaejhCBdbBAfLWu5s/QWExunI5LAeom61uGwA2pZI=;
 b=/AvSxPMJLFyU/Dzv85BBKtBK8RgdwXpFW/pU71hx+9yFVaibNBVFOyIdTecVihUljGcx0SRv2
 KEfTegPnQopCHsl6gZ8N6fZo9GB4b9HTRGOaWh4bmEpL8/msqsHxGhx
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=6901cf82 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ou92kEv10uOBaGRFQZkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8dC19UJ94YH1ZWAu_ZykxPER7E7Y_GBL
X-Proofpoint-ORIG-GUID: 8dC19UJ94YH1ZWAu_ZykxPER7E7Y_GBL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MSBTYWx0ZWRfX+cvBozlUU++m
 KSfIFsuabaEf6VOzzD7zP9vqJWdTrrQN1Wk/GF915fo30aKfl7jA/kPs8lNzE4NGSPCFxGmwXkS
 ZmZbevPN7qQTXlBaHdqcXmvHq/1HEs4UqWud4J8QS/+e8Pl9WVuaR7WlBl68mtBykD70kj6PPzI
 xhID3eqh7h5YMIrc2lxyRAvagOPbWNtuDA8wm8PPygL1xCSKSRgV9zE97aO5mAq0MtlD2+4TKm9
 5p8US7Fs+urnDtTfXCdo0iD1NAg8I+L27fkr6s9a2pIM05IEfG+C0mRLJf4F+008kmcBZaF/XRg
 Loz4klOeU6aZjK1akOAytCv9o5pybg8QOhQiuhWaRr1D7epf8TKuTNk0a4+yYqtRCbZZfV1vEh2
 hpBug4MJ74bIAjZlXunPgHbK3a665g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290061

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document kaanapali compatible for the True Random Number Generator.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d3..597441d94cf1 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,ipq5332-trng
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
+              - qcom,kaanapali-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.25.1


