Return-Path: <linux-crypto+bounces-736-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B480E6E2
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Dec 2023 09:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D9B1F22239
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Dec 2023 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AA433DE;
	Tue, 12 Dec 2023 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hnpCdoSS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0448D0;
	Tue, 12 Dec 2023 00:55:35 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC6vmsf018148;
	Tue, 12 Dec 2023 08:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=WiwISKr
	ta03GsjC7RA50OM5yZACKJsWKrxM3ona5Oqo=; b=hnpCdoSSSHB0wzGZX2CvdMw
	oODqFuk3HCJ1TbQLzzP1Z++E7yFkF9M+sc0DiikFKkl/v13mt7/y1fIUmcortQHb
	Gv9XKJ+BdszKCy6U3fNxr/FE+OD8PRFRcvjE9rb2AiontUAM5YkcRGHE1VpU+usb
	3nWkUGUJt5IfvA04kbtJWs9GRtL1G47CX7fvYRXfiuxJYZ+w3LT3cMlBUkD200ov
	AgR3ufkICqq5Xm+TZgR5zKmSVNZc0en/lQGi31nkYAER+95TZBxIsIXGkMsOdAS8
	r7a0D38AqtvUbWHsg0lIveENb+8RvCspiYe26DmMc6Ba5hr1lOA2JShncshrehA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxgbb0hch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 08:55:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC8tMCp024837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 08:55:22 GMT
Received: from hu-omprsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 00:55:17 -0800
From: Om Prakash Singh <quic_omprsing@quicinc.com>
To: <quic_omprsing@quicinc.com>
CC: <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
Subject: [PATCH V1 0/2] Add QCrypto support for SC7280
Date: Tue, 12 Dec 2023 14:24:51 +0530
Message-ID: <20231212085454.1238896-1-quic_omprsing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ga7g9SJwXb4jzUx8ZjyKwDpiYfdliJD2
X-Proofpoint-ORIG-GUID: Ga7g9SJwXb4jzUx8ZjyKwDpiYfdliJD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 spamscore=0 adultscore=0 mlxlogscore=612 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120070

Document SC7280 support for QCrypto driver and add QCE and Crypto BAM DMA nodes

Om Prakash Singh (2):
  dt-bindings: crypto: qcom-qce: document the SC7280 crypto engine
  arm64: dts: qcom: sc7280: add QCrypto nodes

 .../devicetree/bindings/crypto/qcom-qce.yaml  |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.25.1


