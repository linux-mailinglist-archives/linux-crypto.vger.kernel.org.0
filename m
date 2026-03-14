Return-Path: <linux-crypto+bounces-21956-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /POwKCQ8tWkEyAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21956-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 11:44:52 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E328CBCA
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D024304226D
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4F29A312;
	Sat, 14 Mar 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zTyuSPUi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9772628D
	for <linux-crypto@vger.kernel.org>; Sat, 14 Mar 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485089; cv=none; b=nUzQuNah+FYK1myDUQZ8e+FRwa8mGusgdBIO6kf7kmtwyOlxKMTCHBCosvLe6YlUdfKUiLXOpsUTBIjZCbWwuYGe7SQf7p3L3r7tDDagi3EJvNzSmkvdQQ+Z34xFacbEwdY9O4ymTSyDECuHh8ttGp/uem2qRXvgvO1o+6+hVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485089; c=relaxed/simple;
	bh=JRTrpJicVZv9hm9N78kmTjwXo8LD4y4qDOoJuGvR+Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcARnTvAUbv+RZ3Z1uj5DItbSOc+HIYz5VSoqBJ7diug5N4KBcKgeyHJOHb4IsW4TDmFsveNKtVZknhe83no/mWFy0v7ENGEMqaAwp26l+y8EqQS8pOI5/t8msCVMZTU2XzR6zMz0aLs0BXIGK6PFhOjauk12suQUUmDUaoL9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zTyuSPUi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4CE8D1A2E36;
	Sat, 14 Mar 2026 10:44:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21DC56003C;
	Sat, 14 Mar 2026 10:44:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87C2C10369E03;
	Sat, 14 Mar 2026 11:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773485083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dTC/sqBnMIFHHDI7XhSbSaOIZ7PKMXbJl4q3w7ZEZGk=;
	b=zTyuSPUioyoc4Qg94QN8MG4zUoQeCxhRes+PPku5Vd9ogHnHsM/jycywwSkkXe/q7aM62W
	UjmdJgm+wVWABp7kNw9WSCqSPg84U6axxpZ7ySdPsKEhrImSHhWnXjpATZR8rRbcKPJnJI
	COrmUpRtFc5MBWpBYW26NqpqlC6EheRVfh6B7qNSO5WGDUYC+zNhjoD6W1fg3OOjqQwAPd
	obll7UwONi2qa6289K655FH9YkATW7dBkV/Ljie1g/CBB/BEin0yFlgb4O+yKhLjyQfO8U
	X6f07ajCtt0T1Fye079B0iSMmWt5JXLqaFeOIUwgx8k24DB7Gr2GQivLzv28mw==
Message-ID: <25a017e8-37f3-45ea-8849-8bad894111da@bootlin.com>
Date: Sat, 14 Mar 2026 11:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: replace broken libkcapi link in Crypto API
 documentation
To: Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260313-crypto-api-libkcapi-broken-link-v1-1-a218033d7f05@bootlin.com>
 <91914036-071a-4503-8fe3-9c69cd1f8a41@infradead.org>
Content-Language: en-US
From: Paul Louvel <paul.louvel@bootlin.com>
In-Reply-To: <91914036-071a-4503-8fe3-9c69cd1f8a41@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-21956-lists,linux-crypto=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chronox.de:url]
X-Rspamd-Queue-Id: F39E328CBCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I have just checked this morning on the same browser, and indeed, it works.
It was broken for the past few days.
Please ignore this patch then.

Regards,
Paul.

On 3/14/26 12:46 AM, Randy Dunlap wrote:
>
> On 3/13/26 3:00 PM, Paul Louvel via B4 Relay wrote:
>> From: Paul Louvel <paul.louvel@bootlin.com>
>>
>> The "User Space Interface" section of the Crypto API documentation
>> contains a link to the libkcapi project that no longer works.
>>
>> Update the link to point to the correct upstream location so that
>> users can access the library documentation.
>>
>> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
>> ---
>> The "User Space Interface" of the Crypto API documentation has a broken
>> link to libkcapi. Replacing it with a working one.
>> ---
>>   Documentation/crypto/userspace-if.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
>> index 021759198fe7..79e41845f611 100644
>> --- a/Documentation/crypto/userspace-if.rst
>> +++ b/Documentation/crypto/userspace-if.rst
>> @@ -23,7 +23,7 @@ user space, however. This includes the difference between synchronous
>>   and asynchronous invocations. The user space API call is fully
>>   synchronous.
>>   
>> -[1] https://www.chronox.de/libkcapi/index.html
>> +[1] https://www.chronox.de/libkcapi/
>>   
>>   User Space API General Remarks
>>   ------------------------------
>> @@ -406,4 +406,4 @@ Please see [1] for libkcapi which provides an easy-to-use wrapper around
>>   the aforementioned Netlink kernel interface. [1] also contains a test
>>   application that invokes all libkcapi API calls.
>>   
>> -[1] https://www.chronox.de/libkcapi/index.html
>> +[1] https://www.chronox.de/libkcapi/
>>
>> ---
>> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
>> change-id: 20260313-crypto-api-libkcapi-broken-link-65069e8ce688
>>
>> Best regards,
> Hi,
> Either link works for me (with the same content).
> Could it be browser-dependent?
>
>
-- 
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


