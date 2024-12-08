Return-Path: <linux-crypto+bounces-8452-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0209E8587
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Dec 2024 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CC21634FB
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Dec 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CA1420DD;
	Sun,  8 Dec 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/4wS3YU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A44A3C;
	Sun,  8 Dec 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733665925; cv=none; b=rNEcKothk3mbLNS0eeBaqBL3eHQ2waQCREuBBcJt4sjy66AC93OIBsLuW8kOPjO4foC+OoJwHa413UucFZloqprEftkTMPR/kbZzEAI7UvIebkZ9PI3PqKesu+xuOjx11NExmPpglhNHhjeL1zXuBf23/YJFuZ+HfIXJ7/ucHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733665925; c=relaxed/simple;
	bh=hvWjEDmy4O8YGSRLEEjZ1ZNc3amylAe4wSOiynAgU5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSaqUvYUxOH7QrFqF6Ip9cqiiwDvgeZ9YrP+fQIPoh/kcw6TJyeY9QAVUAp3ro4yzyfCiRrTXWsShKClc8znvyrRUd9rNl1b45lLSY7UPYR8+eI7wfgxTjpZkakDYsY1sobwmWRLykUS/7b2AUPWTl+oFd/fatu32QNBkRTwdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/4wS3YU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8AGRS9030113;
	Sun, 8 Dec 2024 13:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bCpUFc
	ZofvTOCWHWC1Pef+GGECradF0Lle8gtAIGJzE=; b=C/4wS3YUxZBtuLMMBME4wc
	VcrrGjY0+xz1DB8b6gmOuSivuc9/KhIu655PY/9nL3uwTD2TD3S+2NfAkUhyU+Or
	wXTGQ5yqQDB9v8L2jQS7q499hDZ30OLFJeH09jIWFWRnHGuokyie/MqTAuPhVDBy
	jke0bG+/1OhHNq8cjIIx+NUZRa8dzfaf7FFEdl00C+g3byZzW/KZeYaUmp6WmZ5V
	9t7KxvWVcpU7RX+6mxpc2LEM090X1m5acoZP38mxApdPrABG65krbYFVZH6NfQkN
	rTblaKn30SOfQXP0gANRgwe6IJWpuM7e02lOS5m75avFebVWXK7uAuYvFPBhb7Xw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8d1m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 13:51:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B8DpsDA000306;
	Sun, 8 Dec 2024 13:51:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8d1m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 13:51:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8CvlQo023015;
	Sun, 8 Dec 2024 13:51:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjhxrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 13:51:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B8Dpr0B65274362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Dec 2024 13:51:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387D758055;
	Sun,  8 Dec 2024 13:51:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D518158043;
	Sun,  8 Dec 2024 13:51:49 +0000 (GMT)
Received: from [9.179.1.228] (unknown [9.179.1.228])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  8 Dec 2024 13:51:49 +0000 (GMT)
Message-ID: <438fc29c-65e6-445d-8a2c-cb2051f50c4c@linux.ibm.com>
Date: Sun, 8 Dec 2024 19:21:48 +0530
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] cpumask: work around false-postive stringop-overread
 errors
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, kees@kernel.org,
        nathan@kernel.org, yury.norov@gmail.com, steffen.klassert@secunet.com,
        daniel.m.jordan@oracle.com, linux-crypto@vger.kernel.org,
        linux@weissschuh.net, gjoyce@ibm.com
References: <20241205123413.309388-1-nilay@linux.ibm.com>
 <2024120757-lustrous-equinox-77f0@gregkh>
 <2024120710-cahoots-obituary-d32d@gregkh>
 <d81e9a7a-2209-4fb2-93fe-1fd2afece176@linux.ibm.com>
 <2024120822-unnerving-childless-bf01@gregkh>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2024120822-unnerving-childless-bf01@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s8wg7gbjvmCuSvH1ubLLEXCZkaYcpfMu
X-Proofpoint-ORIG-GUID: Yy5YJnUuFsaU9ZaepYEIHmfvOYtObZVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412080113



On 12/8/24 18:58, Greg KH wrote:
> On Sun, Dec 08, 2024 at 03:51:10PM +0530, Nilay Shroff wrote:
>>
>>
>> On 12/7/24 17:14, Greg KH wrote:
>>> On Sat, Dec 07, 2024 at 12:43:19PM +0100, Greg KH wrote:
>>>> On Thu, Dec 05, 2024 at 06:04:09PM +0530, Nilay Shroff wrote:
>>>>> While building the powerpc code using gcc 13, I came across following
>>>>> errors generated for kernel/padata.c file:
>>>>>
>>>>>   CC      kernel/padata.o
>>>>> In file included from ./include/linux/string.h:390,
>>>>>                  from ./arch/powerpc/include/asm/paca.h:16,
>>>>>                  from ./arch/powerpc/include/asm/current.h:13,
>>>>>                  from ./include/linux/thread_info.h:23,
>>>>>                  from ./include/asm-generic/preempt.h:5,
>>>>>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>>>>>                  from ./include/linux/preempt.h:79,
>>>>>                  from ./include/linux/spinlock.h:56,
>>>>>                  from ./include/linux/swait.h:7,
>>>>>                  from ./include/linux/completion.h:12,
>>>>>                  from kernel/padata.c:14:
>>>>> In function ‘bitmap_copy’,
>>>>>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>>>>>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
>>>>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>>>>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>>>>       |                                 ^
>>>>> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>>>>>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>>>>>       |         ^~~~~~~~~~~~~
>>>>> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>>>>>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>>>>       |                          ^~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>>>>>   259 |                 memcpy(dst, src, len);
>>>>>       |                 ^~~~~~
>>>>> kernel/padata.c: In function ‘__padata_set_cpumasks’:
>>>>> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>>>>>   713 |                                  cpumask_var_t pcpumask,
>>>>>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
>>>>> In function ‘bitmap_copy’,
>>>>>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>>>>>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
>>>>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>>>>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>>>>       |                                 ^
>>>>> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>>>>>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>>>>>       |         ^~~~~~~~~~~~~
>>>>> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>>>>>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>>>>       |                          ^~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>>>>>   259 |                 memcpy(dst, src, len);
>>>>>       |                 ^~~~~~
>>>>> kernel/padata.c: In function ‘__padata_set_cpumasks’:
>>>>> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>>>>>   713 |                                  cpumask_var_t pcpumask,
>>>>>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
>>>>>
>>>>> Apparently, above errors only manifests with GCC 13.x and config option
>>>>> CONFIG_FORTIFY_SOURCE. Furthermore, if I use gcc 11.x or gcc 12.x then I
>>>>> don't encounter above errors. Prima facie, these errors appear to be false-
>>>>> positive. Brian informed me that currently some efforts are underway by
>>>>> GCC developers to emit more verbose information when GCC detects string
>>>>> overflow errors and that might help to further narrow down the root cause
>>>>> of this error. So for now, silence these errors using -Wno-stringop-
>>>>> overread gcc option while building kernel/padata.c file until we find the
>>>>> root cause.
>>>>
>>>> I'm hitting this now on Linus's tree using gcc14 on x86-64 so this isn't
>>>> just a problem with your arch.
>> Thanks Greg for confirming that this is not isolated to PowerPC!!
>>>>
>>>> Let me try this patch locally and see if it helps...
>>>
>>> Yes, fixes the build for me, so either this is a real fix, or something
>>> else needs to be done for it, so I'll give a:
>>>
>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> for now.
>> Okay so now we've an evidence confirming that this is no longer PowerPC specific 
>> issue. Hence as Yury suggested, in another mail[1], fixing this error by disabling
>> stringop-overread globally for GCC13+ and CONFIG_FORTIFY_SOURCE=n, I will spin a 
>> new patch and submit it.
>>
>> [1] https://lore.kernel.org/all/Z1HTdtvNjm-nZSvJ@yury-ThinkPad/
> 
> That feels wrong, unless this is a compiler bug.  And if it's a compiler
> bug, can we fix the compiler please or at least submit a bug to the gcc
> developers?
> 
Yes this seems to be a compiler bug. Please see here : 
[1] https://lore.kernel.org/all/202411021337.85E9BB06@keescook/
[2] https://gcc.gnu.org/pipermail/gcc-patches/2024-October/666872.html

> I'm slowly moving all my boxes/builds over to using clang to build the
> kernel due to rust kernel work, so I guess I can do that here as well as
> I don't think this issue shows up for that compiler, right?
> 
Yes this error doesn't show up for LLVM/clang. We've two options here:
1) To disable this error globally for GCC-13+ until we find the root cause. Maybe when 
   GCC folks add more diagnostics and contexts around -Wstringop-* compiler warning as
   discussed in [2] above.
or 
2) Silence this error only for file kernel/padata.c compiling which this error manifests
   as of today.

Yury suggested option #1 above so that we may avoid random victims hitting this error. 
What do you suggest? 

Thanks,
--Nilay

