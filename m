Return-Path: <linux-crypto+bounces-25156-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxQhFOogMGoFOgUAu9opvQ
	(envelope-from <linux-crypto+bounces-25156-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 17:57:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C234F687FAE
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 17:57:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hftmdIKO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VLEoMAag;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25156-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25156-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730CA310BBC8
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659440E8DF;
	Mon, 15 Jun 2026 15:50:38 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AA40E8CE
	for <linux-crypto@vger.kernel.org>; Mon, 15 Jun 2026 15:50:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538638; cv=none; b=RmToGgO8gHfqcbnk8yPJaH1jpYVCsbMkZvvFaGJ8dUOi+m4S2i0LBUALHIip9f8Iue/IckNg/9v3Yw+Wp4r68ZofeQFWllTXuFyQgYag3dJI6naRfgnQf1dDG7h83QJPUM38lYGtnyV7aSGTkyN3WpJp+QToABvJ8mNHps3IZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538638; c=relaxed/simple;
	bh=jQ3wLVE7GjY3KrZpgyZfT+6PvlaYTHrdGrhp4PJA/FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8dTBd2tFwD5ZGea5sFqy4D4D0Mw89LvG0zI2Jz8YefniG9v77aXiWYbqG0MNSVHL7DGnseoW6ic5KCQ9/ZuAoLINaoSs0syqXMNYkByM1iZBAk91ctB47jAE+/i/b7GROVFZF9kZo9ppb4rP1I4tXMNubf6StEq38Mph4VUbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hftmdIKO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLEoMAag; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhNDK446947
	for <linux-crypto@vger.kernel.org>; Mon, 15 Jun 2026 15:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=; b=hftmdIKO1iYG5q9R
	txKvEz3EJl8Nps5FsUNOFsdRrKYPakclaekoTbFSc+Gx/VC+/o/Ml4us8F7alC9S
	zR0kWe7yMcsL7fPmYOP6GTeOA80zIMUh5CznbmrMqcP3Jt0EemBDuQwxZ5txaSgc
	B2BI4D2f2KUDbFGW0mC7HeX4SilS7tDvhI7d8C58wA9CfIHTzLadkkHkYq+Fg/2y
	F5vpqpj3eDMMsWzEYpKl4kHBRZQs208xZGhn6Jb+fM4kFVGzEu9u3rIoQl7B4ZPe
	/yTvZu/ZDrHP7xGPMpE7jL0lhex5hYEu6JxvyjfFqHyynlcj9I3BTFKPabNyn0kP
	EJnlGQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0hjcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-crypto@vger.kernel.org>; Mon, 15 Jun 2026 15:50:36 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963d7e5ac77so1173698241.2
        for <linux-crypto@vger.kernel.org>; Mon, 15 Jun 2026 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538636; x=1782143436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=;
        b=VLEoMAagVxvyhduVPED/o+hcjZoafVDG4Zgbrndrj/h4a3/xf2azYJ24ZYESXIwVoJ
         ve9kGbv1vhUdNEBX9jDsnkQ66mRsQBmG0spKxn7iaVR258Nso++4qco9AfeFYn4lwMyW
         OtnOEjydAuhi/P6FkkOl5tFj70vcv1yttijOFLj2CZdqbQbBGxBntyAPkR7gTl4rRF9n
         tqQmK7XSy77M5drfpkj5G3ThxLtmMPMP9iS8Fee1Yt8cXSkpnSwULz+QU0T+otx07gdG
         YIhq5eycRJOY4jP9NKVQJBrl/+A3rqJWCMstkFDXHkxmcoEgKjRV5L3INKXDGN/fKsav
         z2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538636; x=1782143436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL3WkxaAIXpqgOzUtt1ueuSKLkNRCCjmcACm38hAbmw=;
        b=GozGneAxJc2PoMZ9YA8fk5jzZ5ykEftKA5DDGA/DxRlw8CViBxO1K02Z91rr6oeiku
         2cW7hD1uIgPu2VLEyTA3uRjBT/YXN/z3MsCoBJcrZ2TqJiG8QohrtiaC+Z5Cc6GZbBoa
         4O3OqLXNrfAbX+t2rVqW6zDF8OGJBvMR1xD+7j/3kqwqgojjwWveXhF4YguCfmJl5S8V
         icEdDkDVdB0tsFvhODj0qFsORcuRxV7zK2n8hHNIU+uSw6WOJ4beXSfuowO/o3u9kMUB
         AsiaDF2UcwR58sK9Jv7cLQ0D12MY/32NjUn1jCOza1lQ5KVMH9Z5OiojNIiCS6gBuKUa
         MvUg==
X-Gm-Message-State: AOJu0Yw0XuJj9rPbcmU7OV1IHMDG//mwQgFiP579A7RgQHHmYJSoUtQG
	sUVuU98bnn+MqwsLHUDA0hrjKrpqag3DU5MBhsPfS0LHPHxEd6XrIQsPKJdC0hTlLfH5zy9b2Mk
	xw/yAKLBKzPzZsiWYh16mToKCg8C26h2lQa2FcbKwQ3QBCD3gn4xl3Tj33kmx/lCR8IA=
X-Gm-Gg: Acq92OFbl1INHrFqDpoUlEkV0RzC9/7+EG8pXDSVNVSFfT1LoYY4YotqMKAjuYwtHnh
	nN9uXG+0WgWv/D+yaHOo2lQZNI9xmSttqwT83oonIe7ekGbMnMD8ALdI/iH822OuJvX+Uy0BVJi
	5Wkg/th9MRl2u7APa553bvtSwnnchkOFqatX3NkW6KUdtqDFupEPED6N6LF5E7k4TK7JXiYjxYO
	o84MNe5GoD1LpEW//lnjjEA8diy7t5yTbdhWoVQGieNPc72UPNvPEHlfdUYyv021l9NE2h2DEm7
	Q5RdhJSkn5aYuyZ0Qw9wUGdAZxg64Da2Tsi6HNIHR4Gs+TXTrJoVax/ZT3tYaRBuhQ3Ps5OJoLB
	lkA+ne7RuxknllZ/IGtlxssrtKlGH3i7tDtfCFVoSUZ0Pesy0XRo=
X-Received: by 2002:a05:6102:5812:b0:631:23fa:38d7 with SMTP id ada2fe7eead31-71e88c56801mr6703001137.14.1781538635627;
        Mon, 15 Jun 2026 08:50:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5812:b0:631:23fa:38d7 with SMTP id ada2fe7eead31-71e88c56801mr6702979137.14.1781538635163;
        Mon, 15 Jun 2026 08:50:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:49:58 +0200
Subject: [PATCH v2 7/8] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-qce-fix-self-tests-v2-7-dc911f1aad42@oss.qualcomm.com>
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
In-Reply-To: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jQ3wLVE7GjY3KrZpgyZfT+6PvlaYTHrdGrhp4PJA/FE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB8zdAFIxUHikN73T7KAyXFU5NTKujwi+FmJj
 9Rv5g4joB2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfMwAKCRAFnS7L/zaE
 w2RAEACygrV04TmSEgKNzna+3CMJoCsR0G+gJIIImhCtU2OJBJLsg5ksC4DM6kMrPzOifVoMPi7
 Je/NVIdO8jKqOnpWXfw1vK6RIU+TnBIHPAo8zwDl5RYFawd/R9aNfwkq8n2vv4ImmeaMJhdIDD7
 4+nnQ3/xuTVZA7EEfhJn6FwPZ06g+dntFrm0ajut945qIFmE55Ut5R9gb/5+utrrrZ8jklitMmq
 RcUITJcgSZpPI88B9s1IJggylLCFoTpeSeeN2Jh4cPPY6vdL4+JsNLTZIfybVuvf3fROq+xGdC2
 yanPVctQTPDB6HFOGJVzRzlwGsArdGC3CyAHkuTqZQwLbgeQMVvd1ZTzqXqSdeM3SOSpiaLRpcS
 GZOmIPgW7r7Jdr1BAnsGpruLuBR8rhKtK/Ggjdfl6SXKa7mGZ0Iwv+mDRpC1zSlHqwwm3gqLLvZ
 WyZH4PHAAWtvXMl+riDsPjjGJwfwNf1Iv7glgX9xfn9N/LW9RaIPKFy6UbBOBbqN/1K9NzaJfdi
 VLkFcO9On2FuGfALcjheMSC6yrDTLyjnZF+Us7Hv60xQFK3g0H4EoV0Q/765Md7rZjq84KVcc/a
 NptjcPHIURtJcTLgc0qKDXQb8DbT4XR1SM7znD7DlBf93lepI4BdCiP5QjfssXtpTZqQu6hE9ji
 NeQXPgKORQpAzPg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX1twODbti1VTR
 j3Kp8OoVq474/pc/Y7BFHVkDG0ffbxsUNLEYEGLz7B3yw+bS6TFBWcC7cuzhj5NhoA4e676Ncr7
 Y2MKzoF8AIN8YlWa2hzHLq0H8GqSJKA=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a301f4c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX6lsQEivHuS/g
 1RcyB5kjxRx7ZCRszzSbajO/MpJ4rhI1t6Gnujgy6Qa1qinroeTfkcixT65a2lSm26gitrJ0DFv
 xsbGcWYbZdjhaOQjy6BpYXq9zp51G3CkqArfTaOY/If8ClVUz18TDn1SZRXYcjASwwgCT+2o8Bp
 phsglESjQ6XrWCbvQIDAsq4a8zunVY+kQ8ENMb0xfLU5gwTxyVZi7Xn0edws2xYJ3mA9geuEhg0
 3tKQiAXKniqgcTMO0FZgLGyOg3jjR2vauOwuuOod2YEF+TXmBlEoxAX7mVX8sQGKUDsND3DtHmJ
 gkIwgziDe148rFK6HuOOiPzRTBNL+01+IA88nqh7sWJYBTTBVy8S01mBhacF3D+wKbG+K+z/ezy
 Oc1FT9V6rIzXztMLEDhtJfPtWMYz6a8vns4cGyvNO8SgpUq46dVY8srpKyqUMn0YRdtWYMCm25W
 I7QGTX54VOh9Rskp42A==
X-Proofpoint-GUID: JpCmliCHaeG5DiHU9axos7jdivIKFrFX
X-Proofpoint-ORIG-GUID: JpCmliCHaeG5DiHU9axos7jdivIKFrFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150167
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25156-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,mm-sol.com,oss.qualcomm.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:svarbanov@mm-sol.com,m:cotequeiroz@gmail.com,m:kuldeep.singh@oss.qualcomm.com,m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:stable@vger.kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C234F687FAE

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6a511e5d7f6290a1df0093e463f39f5f2db25f88..46d3e3eb53b271e2ce755847bbcc83f81b9bda7e 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -516,6 +516,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			ctx->need_fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		ctx->need_fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3


