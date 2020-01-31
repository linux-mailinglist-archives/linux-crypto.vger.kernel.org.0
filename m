Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5014EB6B
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jan 2020 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgAaLGL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jan 2020 06:06:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbgAaLGL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jan 2020 06:06:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VB4m8C071838
        for <linux-crypto@vger.kernel.org>; Fri, 31 Jan 2020 06:06:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubcuc1nc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-crypto@vger.kernel.org>; Fri, 31 Jan 2020 06:06:08 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-crypto@vger.kernel.org> from <freude@linux.ibm.com>;
        Fri, 31 Jan 2020 11:06:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 11:06:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00VB64VW61276208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 11:06:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D29142042;
        Fri, 31 Jan 2020 11:06:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2C342041;
        Fri, 31 Jan 2020 11:06:03 +0000 (GMT)
Received: from funtu.home (unknown [9.145.166.162])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jan 2020 11:06:03 +0000 (GMT)
Subject: Re: [PATCH 3/3] crypto/testmgr: add selftests for paes-s390
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, heiko.carstens@de.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191113105523.8007-1-freude@linux.ibm.com>
 <20191113105523.8007-4-freude@linux.ibm.com>
 <20191122081611.vznhvhouim6hnehc@gondor.apana.org.au>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Fri, 31 Jan 2020 12:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191122081611.vznhvhouim6hnehc@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20013111-0016-0000-0000-000002E27DF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013111-0017-0000-0000-000033454D16
Message-Id: <403c438d-1f3e-f25d-8df2-4f03d9ef731c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-30,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310098
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 22.11.19 09:16, Herbert Xu wrote:
> On Wed, Nov 13, 2019 at 11:55:23AM +0100, Harald Freudenberger wrote:
>> This patch adds selftests for the s390 specific protected key
>> AES (PAES) cipher implementations:
>>   * cbc-paes-s390
>>   * ctr-paes-s390
>>   * ecb-paes-s390
>>   * xts-paes-s390
>> PAES is an AES cipher but with encrypted ('protected') key
>> material. So here come ordinary AES enciphered data values
>> but with a special key format understood by the PAES
>> implementation.
>>
>> The testdata definitons and testlist entries are surrounded
>> by #if IS_ENABLED(CONFIG_CRYPTO_PAES_S390) because they don't
>> make any sense on non s390 platforms or without the PAES
>> cipher implementation.
>>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  crypto/testmgr.c |  36 +++++
>>  crypto/testmgr.h | 334 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 370 insertions(+)
> So with your cleartext work, I gather that you can now supply
> arbitrary keys to paes? If so my preferred method of testing it
> would be to add a paes-specific tester function that massaged the
> existing aes vectors into the format required by paes so you
> get exactly the same testing coverage as plain aes.
>
> Is this possible?
>
> Thanks,


So here is now a reworked version of the paes selftest invocation within the testmanager code.
I picked your suggestions and now the paes ciphers are able to deal with plain aes key values
and so can benefit from the generic aes testcases.
Please note, this patch needs as a prerequirement some other patches which enable the
base functionality in the zcyrpt device driver and the pkey kernel module. These patches
will come with the next s390 subsystem merge for the 5.6 development kernel. If you agree
to this patch, then Vasily will push this patch with the s390 subsystem together as part of the patch
series.

Thanks and here is the patch for the testmanager:

============================================================

From fb82ea49910b8cde33ca7286c8855c0326e78177 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 22 Jan 2020 14:43:23 +0100
Subject: [PATCH] crypto/testmgr: enable selftests for paes-s390 ciphers

This patch enables the selftests for the s390 specific protected key
AES (PAES) cipher implementations:
  * cbc-paes-s390
  * ctr-paes-s390
  * ecb-paes-s390
  * xts-paes-s390
PAES is an AES cipher but with encrypted ('protected') key
material. However, the paes ciphers are able to derive an protected
key from clear key material with the help of the pkey kernel module.

So this patch now enables the generic AES tests for the paes
ciphers. Under the hood the setkey() functions rearrange the clear key
values as clear key token and so the pkey kernel module is able to
provide protected key blobs from the given clear key values. The
derived protected key blobs are then used within the paes cipers and
should produce the very same results as the generic AES implementation
with the clear key values.

The s390-paes cipher testlist entries are surrounded
by #if IS_ENABLED(CONFIG_CRYPTO_PAES_S390) because they don't
make any sense on non s390 platforms or without the PAES
cipher implementation.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
 crypto/testmgr.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 82513b6b0abd..6c4a98102825 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4156,6 +4156,15 @@ static const struct alg_test_desc alg_test_descs[] = {
             .cipher = __VECS(tf_cbc_tv_template)
         },
     }, {
+#if IS_ENABLED(CONFIG_CRYPTO_PAES_S390)
+        .alg = "cbc-paes-s390",
+        .fips_allowed = 1,
+        .test = alg_test_skcipher,
+        .suite = {
+            .cipher = __VECS(aes_cbc_tv_template)
+        }
+    }, {
+#endif
         .alg = "cbcmac(aes)",
         .fips_allowed = 1,
         .test = alg_test_hash,
@@ -4304,6 +4313,15 @@ static const struct alg_test_desc alg_test_descs[] = {
             .cipher = __VECS(tf_ctr_tv_template)
         }
     }, {
+#if IS_ENABLED(CONFIG_CRYPTO_PAES_S390)
+        .alg = "ctr-paes-s390",
+        .fips_allowed = 1,
+        .test = alg_test_skcipher,
+        .suite = {
+            .cipher = __VECS(aes_ctr_tv_template)
+        }
+    }, {
+#endif
         .alg = "cts(cbc(aes))",
         .test = alg_test_skcipher,
         .fips_allowed = 1,
@@ -4596,6 +4614,15 @@ static const struct alg_test_desc alg_test_descs[] = {
             .cipher = __VECS(xtea_tv_template)
         }
     }, {
+#if IS_ENABLED(CONFIG_CRYPTO_PAES_S390)
+        .alg = "ecb-paes-s390",
+        .fips_allowed = 1,
+        .test = alg_test_skcipher,
+        .suite = {
+            .cipher = __VECS(aes_tv_template)
+        }
+    }, {
+#endif
         .alg = "ecdh",
         .test = alg_test_kpp,
         .fips_allowed = 1,
@@ -5167,6 +5194,15 @@ static const struct alg_test_desc alg_test_descs[] = {
             .cipher = __VECS(tf_xts_tv_template)
         }
     }, {
+#if IS_ENABLED(CONFIG_CRYPTO_PAES_S390)
+        .alg = "xts-paes-s390",
+        .fips_allowed = 1,
+        .test = alg_test_skcipher,
+        .suite = {
+            .cipher = __VECS(aes_xts_tv_template)
+        }
+    }, {
+#endif
         .alg = "xts4096(paes)",
         .test = alg_test_null,
         .fips_allowed = 1,
-- 
2.17.1


