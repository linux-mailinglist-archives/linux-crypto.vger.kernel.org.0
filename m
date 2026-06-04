Return-Path: <linux-crypto+bounces-24894-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GbPkGcZzIWq0GgEAu9opvQ
	(envelope-from <linux-crypto+bounces-24894-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 14:47:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9235640073
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 14:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=u+WL7aI7;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24894-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24894-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31D73044704
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E5643D50C;
	Thu,  4 Jun 2026 12:39:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28C39A4D6;
	Thu,  4 Jun 2026 12:39:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576754; cv=none; b=H1+p4UEStvGtC4nPoa1hLWEElxYJtoRjbcM5btjy0MJ8B+wBmmHPbLz5yEV5JECPbfpKUp7XPKneCJTEYrdOiBUVz5LMoUA+Tbc073N7u5s5igIp40IirPEgWZra4brWyLenLC4lBjD3rf9lvItwIP5yWRrUKG3jebPD+W3wnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576754; c=relaxed/simple;
	bh=tCruOqXpL2smJuUxf0Bv0TD88+WGYP61Zyqd4NpuWoU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BitzIck5ltbeZqY+K2VngRvhzt2iT8oszsfgAk919QyhLqooTamXzRlm1ImZL5kLv13vUQJEpkk903Q8M+cLmAyTI2jxzRwuByrpXi4J6ZQ2b0B7WWImMRxZE+l/xFXL/vAR2CXXSgIFohob6Lpn0ZH3GSX/qlLrzrrvPZCJFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u+WL7aI7; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4EDB2C63453;
	Thu,  4 Jun 2026 12:39:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0ED885FEF7;
	Thu,  4 Jun 2026 12:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 630BA106A1945;
	Thu,  4 Jun 2026 14:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780576751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sep+FfkjsDJ0MMTKrD5vx+i+ogB7pZQrVFCsI2ueKeY=;
	b=u+WL7aI71+ZzLDQbIMdzPKX3jrLYseHBM9Ko9jv7UhFQ4yBzpQjgk3heVdf0BCdxE9bkWV
	haLzMGw4+qzaLApdRLLaFwjGTnDxXtCE9MTZeSn5d1j3aN2V7SEi3w7q6vPUdFpL+7+FOt
	VKE1EU9BZvJ9Pf0fXMpO5amOadKIaaGcTHMvUmvpMUZYRSpLHERRe7rJ28FgQvLXnxKRew
	Zz42s0RDv/kiIGk8peU1Cbe/oLhf7X/TGs4wkb4GWw5dmSAm7sktLVJ0L2o3YFQrcQBB9U
	82IyfFYfOlQ/FSH3JSkB+6dKSnEA3DjkFOVH4LCt1ftRWLIW+Qy3R6d3+j0uuw==
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 14:39:09 +0200
Message-Id: <DJ09S2IMIFW0.3IISVIS7CVIXT@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Herve Codina"
 <herve.codina@bootlin.com>, <linux-crypto@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/29] crypto: talitos - Remove unused priority field in
 struct talitos_alg_template
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <20260528-7-1-rc1_talitos_cleanup-v1-11-cb1ad6cdea49@bootlin.com>
 <a09e9b6e-83ac-47d2-a641-a4c7ce50875c@kernel.org>
In-Reply-To: <a09e9b6e-83ac-47d2-a641-a4c7ce50875c@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24894-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thomas.petazzoni@bootlin.com,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chleroy@kernel.org,m:paul.louvel@bootlin.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9235640073

On Mon Jun 1, 2026 at 1:54 PM CEST, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 28/05/2026 =C3=A0 11:08, Paul Louvel a =C3=A9crit=C2=A0:
>> After algorithm properties are now set at definition time, the priority
>> field in struct talitos_alg_template is no longer used. Remove it.
>
> Should probably be sqashed (with the above explanation) in the previous=
=20
> commit.

Ok.

>
>>=20
>> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
>> ---
>>   drivers/crypto/talitos/talitos.h | 1 -
>>   1 file changed, 1 deletion(-)
>>=20
>> diff --git a/drivers/crypto/talitos/talitos.h b/drivers/crypto/talitos/t=
alitos.h
>> index 438be8c8f08d..6cf3628c52c2 100644
>> --- a/drivers/crypto/talitos/talitos.h
>> +++ b/drivers/crypto/talitos/talitos.h
>> @@ -203,7 +203,6 @@ struct talitos_ctx {
>>  =20
>>   struct talitos_alg_template {
>>   	u32 type;
>> -	u32 priority;
>>   	union {
>>   		struct skcipher_alg skcipher;
>>   		struct ahash_alg hash;
>>=20




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


