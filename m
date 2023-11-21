Return-Path: <linux-crypto+bounces-220-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644987F2796
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 09:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF6281A8A
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFFB1D6B6
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959BEC8
	for <linux-crypto@vger.kernel.org>; Tue, 21 Nov 2023 00:04:26 -0800 (PST)
X-ASG-Debug-ID: 1700553863-1eb14e538c1b410001-Xm9f1P
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id mfwIhfALunJr26Ki (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 21 Nov 2023 16:04:23 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 21 Nov
 2023 16:04:22 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 21 Nov
 2023 16:04:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <49da551d-a43c-48b8-af31-965103a390ec@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Tue, 21 Nov 2023 16:04:19 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
To: Dave Hansen <dave.hansen@intel.com>, kernel test robot <lkp@intel.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <seanjc@google.com>,
	<kim.phillips@amd.com>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
	<jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
CC: <oe-kbuild-all@lists.linux.dev>, <CobeChen@zhaoxin.com>,
	<TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>, <Leoliu@zhaoxin.com>
References: <20231115071724.575356-1-LeoLiu-oc@zhaoxin.com>
 <202311160022.csCILGmA-lkp@intel.com>
 <541fff8a-ad8f-43f5-9a44-c64302698029@intel.com>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <541fff8a-ad8f-43f5-9a44-c64302698029@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1700553863
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 973
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117045
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2023/11/16 3:21, Dave Hansen 写道:
> 
>> vim +/asm +43 arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
>>
>>      35	
>>      36	/* Zhaoxin sm2 verify function */
>>      37	static inline int zhaoxin_gmi_sm2_verify(unsigned char *key, unsigned char *hash, unsigned char *sig,
>>      38					unsigned char *scratch)
>>      39	{
>>      40		uint64_t cword, f_ok;
>>      41		cword = (uint64_t)0x8;
>>      42	
>>    > 43		asm(".byte 0xf2, 0x0f, 0xa6, 0xc0"
>>      44			:"=c"(f_ok), "+a"(hash), "+b"(key), "+d"(cword), "+S"(scratch), "+D"(sig));
>>      45	
>>      46		return f_ok;
>>      47	}
>>      48	
> 
> When you go fix your compile error, can you please look around the tree
> and see what folks do for replacing .byte?  AS_SHA1_NI, for example.

Thank you for your advice. We have found the root cause of the compile 
error and conducted detailed testing again. A corrected version will be 
released soon.

Sincerely.
Leoliu-oc




