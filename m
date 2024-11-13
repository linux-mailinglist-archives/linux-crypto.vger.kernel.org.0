Return-Path: <linux-crypto+bounces-8071-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CD9C6734
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 03:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A905B2AA3F
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 02:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D913A257;
	Wed, 13 Nov 2024 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A21gXlkm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E4135A4B;
	Wed, 13 Nov 2024 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464332; cv=none; b=aUVZY/w2Yd8Mdbx4Hs4wdpGqZGPqyOB5xOx47LnGTFef/FwVWCEA/ZdMRBnleDbmoyR1Cj+SF/Cwk3EGmX4nsVbSGcDdkYU1aiZL2M0TpA89D+TM2Z5uet6p5oczlGftktciiEHeDXJ34m3bA5U5JQPpunHknpukjpMfD622HYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464332; c=relaxed/simple;
	bh=R+T49BRN37UUA5w4UFkPqOWDNVqfE+JbaKZSCTrnzx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eLjf3UCTMkcQiSvUYmNcLJts8IyNX/oFBio/Y1a11iKc9pcFdWmuTaREC3Wy43FcPTOurw/PAb8QkozGbeLKk07NquHIEhdIKp7XwBmeGuV0inygPJtOY18J5BRe1yAWGGK6Vq1IwysvBhAyGkaZzp1tm1EuSmhzePzzRp2XxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A21gXlkm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRTIM029670;
	Wed, 13 Nov 2024 02:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cscGNRmqzHVHhytO3tYOq3
	UoktN7JezYFawqRhjsW70=; b=A21gXlkmYKQJWHak2kuEU8M8DH2vcuhTwjAZUs
	zOZ7i1JkHUAt16hf+XOANkcQgget5Apd0ZgFpMYyr0lLD4ld5P1iQxwbxfvqNPa9
	KRdIJ4yrpBKA0mgeAaBaOB/cb8RXA5T/IQd5nNH+n4RTxEIgpI/BMK107pYd/XTO
	/7b++M5ENkYYdKVCG07+xDgVjo1nS9ovFuVcQUgGXb6+p5GFJFQVFH4o00rb6jz/
	6iBu/MA5HZCjDQSgSh5eiAs82fvphe80SFkPbWjVc4A9z7b6QlD/6PcPsIiRzNGB
	z0faNp/IP8wpUtNPfxM4xiqOZfQXqjwbrqo5EYKvjfNWmKiA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0469954-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:18:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD2Idsp026944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:18:39 GMT
Received: from hu-yrangana-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 18:18:35 -0800
From: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller"
	<davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul
	<vkoul@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_yrangana@quicinc.com>
Subject: [PATCH V3 0/2] Enable TRNG for QCS8300
Date: Wed, 13 Nov 2024 07:48:17 +0530
Message-ID: <20241113021819.2616961-1-quic_yrangana@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bsmnPPvQMWzXKpAyX35NASZABM0jqcGk
X-Proofpoint-ORIG-GUID: bsmnPPvQMWzXKpAyX35NASZABM0jqcGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=568 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130018

Add device-tree nodes to enable TRNG for QCS8300

This series depends on below patch series:
https://lore.kernel.org/all/20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com/ - Reviewed

Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
---
Changes in v3:
 - Drop DT label as per review comments
 - Link to v2: https://lore.kernel.org/all/20241107121513.641281-1-quic_yrangana@quicinc.com/

Changes in v2:
 - Mistakenly uploaded the base dtsi change instead of marking dependency
 - Link to v1: https://lore.kernel.org/all/20241106110002.3054839-1-quic_yrangana@quicinc.com/

---
Yuvaraj Ranganathan (2):
  dt-bindings: crypto: qcom,prng: document QCS8300
  arm64: dts: qcom: qcs8300: add TRNG node

 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                   | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.34.1


