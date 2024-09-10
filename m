Return-Path: <linux-crypto+bounces-6766-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2E9742BD
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2024 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC294B2659A
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED11A4F11;
	Tue, 10 Sep 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYC4Gpac"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BB1A3BCA;
	Tue, 10 Sep 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994352; cv=none; b=bZC9puGVUB6LsW7CORqSEgj7K4LsO7Tq5fEi3rSflpaStdlxnWek4m3MjEg3nNqDUT1SaTE65OHj5gS5KrXjEVnONsoFgWsGElnV9KbV6gnRzj0oliuFacneVwfDVKdK1bu615ajMs+zzIBuIsjZngvMTxqfeLxYKKXshTCdSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994352; c=relaxed/simple;
	bh=CaWyE92ZBQSrGh3tXpllIFGJz2SibU/kUSp+gG30Sl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhPD6QKI8Z9Sg7CS1CYUrCz3Y4gSnVH1U9lRvjlibF3k5IXkauBqybNOto20RGpFuLBKOUN//1leWKKdWkmhp4EKlTr+vudTWgkMma7Sp4cgU8qPhki8kgnluy7YjdUTRSJC0wvM8z6cAtw4XMA3RRC3Ca/VFWPcrlAnWV33fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYC4Gpac; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEU1bw018978;
	Tue, 10 Sep 2024 18:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	9/LRuRXw0uLIeLeujDzzzM5Xzumpw91KerQQxRHwtjM=; b=UYC4GpacyNaVLyiU
	LpmdxieqGokmwWCcqgcPfal3QjsLtxVBBJsBXBIHv1u/INL+mJYUfFvj0ReMyVwe
	8eKHu47d0fbBiDqGSc5UWGsTKSmpzV9yHPbo9pMmWD8iIdOlTBWJdSHjh3g08+gi
	YsfD3x3tCMnEimau2kTc1tw43J308Szzk+5wvXmWV/p4QQ28aK/8R6CtAwu33+K9
	kDJrS90frqvOEF6gMUuxgylT3MEGC4I7YGHNOT5Jny8jc5+qqZ6kfMq0oDisKquc
	5U9nquLI0q/EFYAtREbmj0+PwGvc76k6U0klpZrvREirjgf6NCeJRjXsQlyvt9uK
	xVX+pQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q9mfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 18:49:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48AInwMM012976;
	Tue, 10 Sep 2024 18:49:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q9mfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 18:49:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFTeQh003176;
	Tue, 10 Sep 2024 18:49:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15tw84g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 18:49:57 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48AInuSe26870288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 18:49:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9534358054;
	Tue, 10 Sep 2024 18:49:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914D458045;
	Tue, 10 Sep 2024 18:49:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Sep 2024 18:49:54 +0000 (GMT)
Message-ID: <db72bf45-91f7-4a91-ad08-22a986922dd6@linux.ibm.com>
Date: Tue, 10 Sep 2024 14:49:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] crypto: ecdsa - Drop unused test vector elements
To: Lukas Wunner <lukas@wunner.de>, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>, Vitaly Chikunov <vt@altlinux.org>,
        Tadeusz Struk <tstruk@gigaio.com>
Cc: David Howells <dhowells@redhat.com>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ignat Korchagin <ignat@cloudflare.com>, Marek Behun <kabel@kernel.org>,
        Varad Gautam <varadgautam@google.com>,
        Stephan Mueller
 <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-crypto@vger.kernel.org,
        keyrings@vger.kernel.org
References: <cover.1725972333.git.lukas@wunner.de>
 <f160f2418c98204817f93339e944529987308b32.1725972334.git.lukas@wunner.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <f160f2418c98204817f93339e944529987308b32.1725972334.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VXivFPAVDhRo6AOdXjPXqf6p8Yn_jZwf
X-Proofpoint-ORIG-GUID: 399WovLOuU0XbOepGgJSaoQ2Xdf9trym
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100138



On 9/10/24 10:30 AM, Lukas Wunner wrote:
> The ECDSA test vectors contain "params", "param_len" and "algo" elements
> even though ecdsa.c doesn't make any use of them.  The only algorithm
> implementation using those elements is ecrdsa.c.
> 
> Drop the unused test vector elements.
> 
> For the curious, "params" is an ASN.1 SEQUENCE of OID_id_ecPublicKey
> and a second OID identifying the curve.  For example:
> 
>      "\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
>      "\xce\x3d\x03\x01\x01"
> 
> ... decodes to:
> 
>      SEQUENCE (OID_id_ecPublicKey, OID_id_prime192v1)
> 
> The curve OIDs used in those "params" elements are unsurprisingly:
> 
>      OID_id_prime192v1 (2a8648ce3d030101)
>      OID_id_prime256v1 (2a8648ce3d030107)
>      OID_id_ansip384r1 (2b81040022)
>      OID_id_ansip521r1 (2b81040023)
> 
> Those are just different names for secp192r1, secp256r1, secp384r1 and
> secp521r1, respectively, per RFC 8422 appendix A:
> https://www.rfc-editor.org/rfc/rfc8422#appendix-A
> 
> The entries for secp384r1 and secp521r1 curves contain a useful code
> comment calling out the curve and hash.  Add analogous code comments
> to secp192r1 and secp256r1 curve entries.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   crypto/testmgr.h | 115 +++++------------------------------------------
>   1 file changed, 10 insertions(+), 105 deletions(-)
> 
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index 9b38501a17b2..ed1640f3e352 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -652,21 +652,16 @@ static const struct akcipher_testvec rsa_tv_template[] = {
>    */
>   static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   	{
> -	.key =
> +	.key = /* secp192r1(sha1) */
>   	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
>   	"\xd4\x09\x73\xcf\xea\xd0\x15\x07\x3d\xa5\x8a\x8a\x95\x43\xe4\x68"
>   	"\xea\xc6\x25\xc1\xc1\x01\x25\x4c\x7e\xc3\x3c\xa6\x04\x0a\xe7\x08"
>   	"\x98",
>   	.key_len = 49,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x01",
> -	.param_len = 21,
>   	.m =
>   	"\xcd\xb9\xd2\x1c\xb7\x6f\xcd\x44\xb3\xfd\x63\xea\xa3\x66\x7f\xae"
>   	"\x63\x85\xe7\x82",
>   	.m_size = 20,
> -	.algo = OID_id_ecdsa_with_sha1,
>   	.c =
>   	"\x30\x35\x02\x19\x00\xba\xe5\x93\x83\x6e\xb6\x3b\x63\xa0\x27\x91"
>   	"\xc6\xf6\x7f\xc3\x09\xad\x59\xad\x88\x27\xd6\x92\x6b\x02\x18\x10"
> @@ -676,21 +671,16 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp192r1(sha224) */
>   	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
>   	"\x78\x05\x73\xe9\x79\x1d\x6f\x7c\x0b\xd2\xc3\x93\xa7\x28\xe1\x75"
>   	"\xf7\xd5\x95\x1d\x28\x10\xc0\x75\x50\x5c\x1a\x4f\x3f\x8f\xa5\xee"
>   	"\xa3",
>   	.key_len = 49,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x01",
> -	.param_len = 21,
>   	.m =
>   	"\x8d\xd6\xb8\x3e\xe5\xff\x23\xf6\x25\xa2\x43\x42\x74\x45\xa7\x40"
>   	"\x3a\xff\x2f\xe1\xd3\xf6\x9f\xe8\x33\xcb\x12\x11",
>   	.m_size = 28,
> -	.algo = OID_id_ecdsa_with_sha224,
>   	.c =
>   	"\x30\x34\x02\x18\x5a\x8b\x82\x69\x7e\x8a\x0a\x09\x14\xf8\x11\x2b"
>   	"\x55\xdc\xae\x37\x83\x7b\x12\xe6\xb6\x5b\xcb\xd4\x02\x18\x6a\x14"
> @@ -700,21 +690,16 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp192r1(sha256) */
>   	"\x04\xe2\x51\x24\x9b\xf7\xb6\x32\x82\x39\x66\x3d\x5b\xec\x3b\xae"
>   	"\x0c\xd5\xf2\x67\xd1\xc7\xe1\x02\xe4\xbf\x90\x62\xb8\x55\x75\x56"
>   	"\x69\x20\x5e\xcb\x4e\xca\x33\xd6\xcb\x62\x6b\x94\xa9\xa2\xe9\x58"
>   	"\x91",
>   	.key_len = 49,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x01",
> -	.param_len = 21,
>   	.m =
>   	"\x35\xec\xa1\xa0\x9e\x14\xde\x33\x03\xb6\xf6\xbd\x0c\x2f\xb2\xfd"
>   	"\x1f\x27\x82\xa5\xd7\x70\x3f\xef\xa0\x82\x69\x8e\x73\x31\x8e\xd7",
>   	.m_size = 32,
> -	.algo = OID_id_ecdsa_with_sha256,
>   	.c =
>   	"\x30\x35\x02\x18\x3f\x72\x3f\x1f\x42\xd2\x3f\x1d\x6b\x1a\x58\x56"
>   	"\xf1\x8f\xf7\xfd\x01\x48\xfb\x5f\x72\x2a\xd4\x8f\x02\x19\x00\xb3"
> @@ -724,22 +709,17 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp192r1(sha384) */
>   	"\x04\x5a\x13\xfe\x68\x86\x4d\xf4\x17\xc7\xa4\xe5\x8c\x65\x57\xb7"
>   	"\x03\x73\x26\x57\xfb\xe5\x58\x40\xd8\xfd\x49\x05\xab\xf1\x66\x1f"
>   	"\xe2\x9d\x93\x9e\xc2\x22\x5a\x8b\x4f\xf3\x77\x22\x59\x7e\xa6\x4e"
>   	"\x8b",
>   	.key_len = 49,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x01",
> -	.param_len = 21,
>   	.m =
>   	"\x9d\x2e\x1a\x8f\xed\x6c\x4b\x61\xae\xac\xd5\x19\x79\xce\x67\xf9"
>   	"\xa0\x34\xeb\xb0\x81\xf9\xd9\xdc\x6e\xb3\x5c\xa8\x69\xfc\x8a\x61"
>   	"\x39\x81\xfb\xfd\x5c\x30\x6b\xa8\xee\xed\x89\xaf\xa3\x05\xe4\x78",
>   	.m_size = 48,
> -	.algo = OID_id_ecdsa_with_sha384,
>   	.c =
>   	"\x30\x35\x02\x19\x00\xf0\xa3\x38\xce\x2b\xf8\x9d\x1a\xcf\x7f\x34"
>   	"\xb4\xb4\xe5\xc5\x00\xdd\x15\xbb\xd6\x8c\xa7\x03\x78\x02\x18\x64"
> @@ -749,23 +729,18 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp192r1(sha512) */
>   	"\x04\xd5\xf2\x6e\xc3\x94\x5c\x52\xbc\xdf\x86\x6c\x14\xd1\xca\xea"
>   	"\xcc\x72\x3a\x8a\xf6\x7a\x3a\x56\x36\x3b\xca\xc6\x94\x0e\x17\x1d"
>   	"\x9e\xa0\x58\x28\xf9\x4b\xe6\xd1\xa5\x44\x91\x35\x0d\xe7\xf5\x11"
>   	"\x57",
>   	.key_len = 49,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x01",
> -	.param_len = 21,
>   	.m =
>   	"\xd5\x4b\xe9\x36\xda\xd8\x6e\xc0\x50\x03\xbe\x00\x43\xff\xf0\x23"
>   	"\xac\xa2\x42\xe7\x37\x77\x79\x52\x8f\x3e\xc0\x16\xc1\xfc\x8c\x67"
>   	"\x16\xbc\x8a\x5d\x3b\xd3\x13\xbb\xb6\xc0\x26\x1b\xeb\x33\xcc\x70"
>   	"\x4a\xf2\x11\x37\xe8\x1b\xba\x55\xac\x69\xe1\x74\x62\x7c\x6e\xb5",
>   	.m_size = 64,
> -	.algo = OID_id_ecdsa_with_sha512,
>   	.c =
>   	"\x30\x35\x02\x19\x00\x88\x5b\x8f\x59\x43\xbf\xcf\xc6\xdd\x3f\x07"
>   	"\x87\x12\xa0\xd4\xac\x2b\x11\x2d\x1c\xb6\x06\xc9\x6c\x02\x18\x73"
> @@ -779,22 +754,17 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
>   
>   static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>   	{
> -	.key =
> +	.key = /* secp256r1(sha1) */
>   	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
>   	"\x22\xd6\x9a\xaa\x87\x17\xec\x4f\x63\x55\x2f\x94\xba\xdd\x83\xe9"
>   	"\x34\x4b\xf3\xe9\x91\x13\x50\xb6\xcb\xca\x62\x08\xe7\x3b\x09\xdc"
>   	"\xc3\x63\x4b\x2d\xb9\x73\x53\xe4\x45\xe6\x7c\xad\xe7\x6b\xb0\xe8"
>   	"\xaf",
>   	.key_len = 65,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x07",
> -	.param_len = 21,
>   	.m =
>   	"\xc2\x2b\x5f\x91\x78\x34\x26\x09\x42\x8d\x6f\x51\xb2\xc5\xaf\x4c"
>   	"\x0b\xde\x6a\x42",
>   	.m_size = 20,
> -	.algo = OID_id_ecdsa_with_sha1,
>   	.c =
>   	"\x30\x46\x02\x21\x00\xf9\x25\xce\x9f\x3a\xa6\x35\x81\xcf\xd4\xe7"
>   	"\xb7\xf0\x82\x56\x41\xf7\xd4\xad\x8d\x94\x5a\x69\x89\xee\xca\x6a"
> @@ -805,22 +775,17 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp256r1(sha224) */
>   	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
>   	"\x7b\x03\xa5\x78\x9a\xb5\xea\x14\xe4\x23\xd0\xaf\xd7\x0e\x2e\xa0"
>   	"\xc9\x8b\xdb\x95\xf8\xb3\xaf\xac\x00\x2c\x2c\x1f\x7a\xfd\x95\x88"
>   	"\x43\x13\xbf\xf3\x1c\x05\x1a\x14\x18\x09\x3f\xd6\x28\x3e\xc5\xa0"
>   	"\xd4",
>   	.key_len = 65,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x07",
> -	.param_len = 21,
>   	.m =
>   	"\x1a\x15\xbc\xa3\xe4\xed\x3a\xb8\x23\x67\xc6\xc4\x34\xf8\x6c\x41"
>   	"\x04\x0b\xda\xc5\x77\xfa\x1c\x2d\xe6\x2c\x3b\xe0",
>   	.m_size = 28,
> -	.algo = OID_id_ecdsa_with_sha224,
>   	.c =
>   	"\x30\x44\x02\x20\x20\x43\xfa\xc0\x9f\x9d\x7b\xe7\xae\xce\x77\x59"
>   	"\x1a\xdb\x59\xd5\x34\x62\x79\xcb\x6a\x91\x67\x2e\x7d\x25\xd8\x25"
> @@ -831,22 +796,17 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp256r1(sha256) */
>   	"\x04\xf1\xea\xc4\x53\xf3\xb9\x0e\x9f\x7e\xad\xe3\xea\xd7\x0e\x0f"
>   	"\xd6\x98\x9a\xca\x92\x4d\x0a\x80\xdb\x2d\x45\xc7\xec\x4b\x97\x00"
>   	"\x2f\xe9\x42\x6c\x29\xdc\x55\x0e\x0b\x53\x12\x9b\x2b\xad\x2c\xe9"
>   	"\x80\xe6\xc5\x43\xc2\x1d\x5e\xbb\x65\x21\x50\xb6\x37\xb0\x03\x8e"
>   	"\xb8",
>   	.key_len = 65,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x07",
> -	.param_len = 21,
>   	.m =
>   	"\x8f\x43\x43\x46\x64\x8f\x6b\x96\xdf\x89\xdd\xa9\x01\xc5\x17\x6b"
>   	"\x10\xa6\xd8\x39\x61\xdd\x3c\x1a\xc8\x8b\x59\xb2\xdc\x32\x7a\xa4",
>   	.m_size = 32,
> -	.algo = OID_id_ecdsa_with_sha256,
>   	.c =
>   	"\x30\x45\x02\x20\x08\x31\xfa\x74\x0d\x1d\x21\x5d\x09\xdc\x29\x63"
>   	"\xa8\x1a\xad\xfc\xac\x44\xc3\xe8\x24\x11\x2d\xa4\x91\xdc\x02\x67"
> @@ -857,23 +817,18 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp256r1(sha384) */
>   	"\x04\xc5\xc6\xea\x60\xc9\xce\xad\x02\x8d\xf5\x3e\x24\xe3\x52\x1d"
>   	"\x28\x47\x3b\xc3\x6b\xa4\x99\x35\x99\x11\x88\x88\xc8\xf4\xee\x7e"
>   	"\x8c\x33\x8f\x41\x03\x24\x46\x2b\x1a\x82\xf9\x9f\xe1\x97\x1b\x00"
>   	"\xda\x3b\x24\x41\xf7\x66\x33\x58\x3d\x3a\x81\xad\xcf\x16\xe9\xe2"
>   	"\x7c",
>   	.key_len = 65,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x07",
> -	.param_len = 21,
>   	.m =
>   	"\x3e\x78\x70\xfb\xcd\x66\xba\x91\xa1\x79\xff\x1e\x1c\x6b\x78\xe6"
>   	"\xc0\x81\x3a\x65\x97\x14\x84\x36\x14\x1a\x9a\xb7\xc5\xab\x84\x94"
>   	"\x5e\xbb\x1b\x34\x71\xcb\x41\xe1\xf6\xfc\x92\x7b\x34\xbb\x86\xbb",
>   	.m_size = 48,
> -	.algo = OID_id_ecdsa_with_sha384,
>   	.c =
>   	"\x30\x46\x02\x21\x00\x8e\xf3\x6f\xdc\xf8\x69\xa6\x2e\xd0\x2e\x95"
>   	"\x54\xd1\x95\x64\x93\x08\xb2\x6b\x24\x94\x48\x46\x5e\xf2\xe4\x6c"
> @@ -884,24 +839,19 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
>   	.public_key_vec = true,
>   	.siggen_sigver_test = true,
>   	}, {
> -	.key =
> +	.key = /* secp256r1(sha512) */
>   	"\x04\xd7\x27\x46\x49\xf6\x26\x85\x12\x40\x76\x8e\xe2\xe6\x2a\x7a"
>   	"\x83\xb1\x4e\x7a\xeb\x3b\x5c\x67\x4a\xb5\xa4\x92\x8c\x69\xff\x38"
>   	"\xee\xd9\x4e\x13\x29\x59\xad\xde\x6b\xbb\x45\x31\xee\xfd\xd1\x1b"
>   	"\x64\xd3\xb5\xfc\xaf\x9b\x4b\x88\x3b\x0e\xb7\xd6\xdf\xf1\xd5\x92"
>   	"\xbf",
>   	.key_len = 65,
> -	.params =
> -	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
> -	"\xce\x3d\x03\x01\x07",
> -	.param_len = 21,
>   	.m =
>   	"\x57\xb7\x9e\xe9\x05\x0a\x8c\x1b\xc9\x13\xe5\x4a\x24\xc7\xe2\xe9"
>   	"\x43\xc3\xd1\x76\x62\xf4\x98\x1a\x9c\x13\xb0\x20\x1b\xe5\x39\xca"
>   	"\x4f\xd9\x85\x34\x95\xa2\x31\xbc\xbb\xde\xdd\x76\xbb\x61\xe3\xcf"
>   	"\x9d\xc0\x49\x7a\xf3\x7a\xc4\x7d\xa8\x04\x4b\x8d\xb4\x4d\x5b\xd6",
>   	.m_size = 64,
> -	.algo = OID_id_ecdsa_with_sha512,
>   	.c =
>   	"\x30\x45\x02\x21\x00\xb8\x6d\x87\x81\x43\xdf\xfb\x9f\x40\xea\x44"
>   	"\x81\x00\x4e\x29\x08\xed\x8c\x73\x30\x6c\x22\xb3\x97\x76\xf6\x04"
> @@ -925,15 +875,10 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
>   	"\x0b\x25\xd6\x80\x5c\x3b\xe6\x1a\x98\x48\x91\x45\x7a\x73\xb0\xc3"
>   	"\xf1",
>   	.key_len = 97,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x22",
> -	.param_len = 18,
>   	.m =
>   	"\x12\x55\x28\xf0\x77\xd5\xb6\x21\x71\x32\x48\xcd\x28\xa8\x25\x22"
>   	"\x3a\x69\xc1\x93",
>   	.m_size = 20,
> -	.algo = OID_id_ecdsa_with_sha1,
>   	.c =
>   	"\x30\x66\x02\x31\x00\xf5\x0f\x24\x4c\x07\x93\x6f\x21\x57\x55\x07"
>   	"\x20\x43\x30\xde\xa0\x8d\x26\x8e\xae\x63\x3f\xbc\x20\x3a\xc6\xf1"
> @@ -955,15 +900,10 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
>   	"\x6b\x93\x99\x6c\x66\x4c\x42\x3f\x65\x60\x6c\x1c\x0b\x93\x9b\x9d"
>   	"\xe0",
>   	.key_len = 97,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x22",
> -	.param_len = 18,
>   	.m =
>   	"\x12\x80\xb6\xeb\x25\xe2\x3d\xf0\x21\x32\x96\x17\x3a\x38\x39\xfd"
>   	"\x1f\x05\x34\x7b\xb8\xf9\x71\x66\x03\x4f\xd5\xe5",
>   	.m_size = 28,
> -	.algo = OID_id_ecdsa_with_sha224,
>   	.c =
>   	"\x30\x66\x02\x31\x00\x8a\x51\x84\xce\x13\x1e\xd2\xdc\xec\xcb\xe4"
>   	"\x89\x47\xb2\xf7\xbc\x97\xf1\xc8\x72\x26\xcf\x5a\x5e\xc5\xda\xb4"
> @@ -985,15 +925,10 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
>   	"\x17\xc3\x34\x29\xd6\x40\xea\x5c\xb9\x3f\xfb\x32\x2e\x12\x33\xbc"
>   	"\xab",
>   	.key_len = 97,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x22",
> -	.param_len = 18,
>   	.m =
>   	"\xaa\xe7\xfd\x03\x26\xcb\x94\x71\xe4\xce\x0f\xc5\xff\xa6\x29\xa3"
>   	"\xe1\xcc\x4c\x35\x4e\xde\xca\x80\xab\x26\x0c\x25\xe6\x68\x11\xc2",
>   	.m_size = 32,
> -	.algo = OID_id_ecdsa_with_sha256,
>   	.c =
>   	"\x30\x64\x02\x30\x08\x09\x12\x9d\x6e\x96\x64\xa6\x8e\x3f\x7e\xce"
>   	"\x0a\x9b\xaa\x59\xcc\x47\x53\x87\xbc\xbd\x83\x3f\xaf\x06\x3f\x84"
> @@ -1015,16 +950,11 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
>   	"\x21\x67\xe5\x1b\x5a\x52\x31\x68\xd6\xee\xf0\x19\xb0\x55\xed\x89"
>   	"\x9e",
>   	.key_len = 97,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x22",
> -	.param_len = 18,
>   	.m =
>   	"\x8d\xf2\xc0\xe9\xa8\xf3\x8e\x44\xc4\x8c\x1a\xa0\xb8\xd7\x17\xdf"
>   	"\xf2\x37\x1b\xc6\xe3\xf5\x62\xcc\x68\xf5\xd5\x0b\xbf\x73\x2b\xb1"
>   	"\xb0\x4c\x04\x00\x31\xab\xfe\xc8\xd6\x09\xc8\xf2\xea\xd3\x28\xff",
>   	.m_size = 48,
> -	.algo = OID_id_ecdsa_with_sha384,
>   	.c =
>   	"\x30\x66\x02\x31\x00\x9b\x28\x68\xc0\xa1\xea\x8c\x50\xee\x2e\x62"
>   	"\x35\x46\xfa\x00\xd8\x2d\x7a\x91\x5f\x49\x2d\x22\x08\x29\xe6\xfb"
> @@ -1046,17 +976,12 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
>   	"\xdf\x42\x5c\xc2\x5a\xc7\x0c\xf4\x15\xf7\x1b\xa3\x2e\xd7\x00\xac"
>   	"\xa3",
>   	.key_len = 97,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x22",
> -	.param_len = 18,
>   	.m =
>   	"\xe8\xb7\x52\x7d\x1a\x44\x20\x05\x53\x6b\x3a\x68\xf2\xe7\x6c\xa1"
>   	"\xae\x9d\x84\xbb\xba\x52\x43\x3e\x2c\x42\x78\x49\xbf\x78\xb2\x71"
>   	"\xeb\xe1\xe0\xe8\x42\x7b\x11\xad\x2b\x99\x05\x1d\x36\xe6\xac\xfc"
>   	"\x55\x73\xf0\x15\x63\x39\xb8\x6a\x6a\xc5\x91\x5b\xca\x6a\xa8\x0e",
>   	.m_size = 64,
> -	.algo = OID_id_ecdsa_with_sha512,
>   	.c =
>   	"\x30\x63\x02\x2f\x1d\x20\x94\x77\xfe\x31\xfa\x4d\xc6\xef\xda\x02"
>   	"\xe7\x0f\x52\x9a\x02\xde\x93\xe8\x83\xe4\x84\x4c\xfc\x6f\x80\xe3"
> @@ -1084,15 +1009,10 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
>   	"\xed\x37\x0f\x99\x3f\x26\xba\xa3\x8e\xff\x79\x34\x7c\x3a\xfe\x1f"
>   	"\x3b\x83\x82\x2f\x14",
>   	.key_len = 133,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x23",
> -	.param_len = 18,
>   	.m =
>   	"\xa2\x3a\x6a\x8c\x7b\x3c\xf2\x51\xf8\xbe\x5f\x4f\x3b\x15\x05\xc4"
>   	"\xb5\xbc\x19\xe7\x21\x85\xe9\x23\x06\x33\x62\xfb",
>   	.m_size = 28,
> -	.algo = OID_id_ecdsa_with_sha224,
>   	.c =
>   	"\x30\x81\x86\x02\x41\x01\xd6\x43\xe7\xff\x42\xb2\xba\x74\x35\xf6"
>   	"\xdc\x6d\x02\x7b\x22\xac\xe2\xef\x07\x92\xee\x60\x94\x06\xf8\x3f"
> @@ -1119,15 +1039,10 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
>   	"\x8a\xe9\x53\xa8\xcf\xce\x43\x0e\x82\x20\x86\xbc\x88\x9c\xb7\xe3"
>   	"\xe6\x77\x1e\x1f\x8a",
>   	.key_len = 133,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x23",
> -	.param_len = 18,
>   	.m =
>   	"\xcc\x97\x73\x0c\x73\xa2\x53\x2b\xfa\xd7\x83\x1d\x0c\x72\x1b\x39"
>   	"\x80\x71\x8d\xdd\xc5\x9b\xff\x55\x32\x98\x25\xa2\x58\x2e\xb7\x73",
>   	.m_size = 32,
> -	.algo = OID_id_ecdsa_with_sha256,
>   	.c =
>   	"\x30\x81\x88\x02\x42\x00\xcd\xa5\x5f\x57\x52\x27\x78\x3a\xb5\x06"
>   	"\x0f\xfd\x83\xfc\x0e\xd9\xce\x50\x9f\x7d\x1f\xca\x8b\xa8\x2d\x56"
> @@ -1154,16 +1069,11 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
>   	"\x22\x6e\xd7\x35\xc7\x23\xb7\x13\xae\xb6\x34\xff\xd7\x80\xe5\x39"
>   	"\xb3\x3b\x5b\x1b\x94",
>   	.key_len = 133,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x23",
> -	.param_len = 18,
>   	.m =
>   	"\x36\x98\xd6\x82\xfa\xad\xed\x3c\xb9\x40\xb6\x4d\x9e\xb7\x04\x26"
>   	"\xad\x72\x34\x44\xd2\x81\xb4\x9b\xbe\x01\x04\x7a\xd8\x50\xf8\x59"
>   	"\xba\xad\x23\x85\x6b\x59\xbe\xfb\xf6\x86\xd4\x67\xa8\x43\x28\x76",
>   	.m_size = 48,
> -	.algo = OID_id_ecdsa_with_sha384,
>   	.c =
>   	"\x30\x81\x88\x02\x42\x00\x93\x96\x76\x3c\x27\xea\xaa\x9c\x26\xec"
>   	"\x51\xdc\xe8\x35\x5e\xae\x16\xf2\x4b\x64\x98\xf7\xec\xda\xc7\x7e"
> @@ -1190,17 +1100,12 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
>   	"\xfe\x3a\x05\x1a\xdb\xa9\x0f\xc0\x6c\x76\x30\x8c\xd8\xde\x44\xae"
>   	"\xd0\x17\xdf\x49\x6a",
>   	.key_len = 133,
> -	.params =
> -	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
> -	"\x00\x23",
> -	.param_len = 18,
>   	.m =
>   	"\x5c\xa6\xbc\x79\xb8\xa0\x1e\x11\x83\xf7\xe9\x05\xdf\xba\xf7\x69"
>   	"\x97\x22\x32\xe4\x94\x7c\x65\xbd\x74\xc6\x9a\x8b\xbd\x0d\xdc\xed"
>   	"\xf5\x9c\xeb\xe1\xc5\x68\x40\xf2\xc7\x04\xde\x9e\x0d\x76\xc5\xa3"
>   	"\xf9\x3c\x6c\x98\x08\x31\xbd\x39\xe8\x42\x7f\x80\x39\x6f\xfe\x68",
>   	.m_size = 64,
> -	.algo = OID_id_ecdsa_with_sha512,
>   	.c =
>   	"\x30\x81\x88\x02\x42\x01\x5c\x71\x86\x96\xac\x21\x33\x7e\x4e\xaa"
>   	"\x86\xec\xa8\x05\x03\x52\x56\x63\x0e\x02\xcc\x94\xa9\x05\xb9\xfb"


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

