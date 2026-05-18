Return-Path: <linux-crypto+bounces-24215-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SME+K+p/Cmoo2AQAu9opvQ
	(envelope-from <linux-crypto+bounces-24215-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 04:56:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F50565369
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 04:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA15A301990D
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6D37BE7E;
	Mon, 18 May 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fCrtoeTB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7437BE9A
	for <linux-crypto@vger.kernel.org>; Mon, 18 May 2026 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072970; cv=none; b=sXhZ8O5fJqEV5/a8/ea/EdSx+7wphH6lvD3hJlmz2AqJ8jJ/N0SXKa2obxXm7hw/HPt5SqpFJbk/FcfpE1km3hE53ilkcFoNvUM7YjispQmpowKTE//hsBGsLgAPPno3eIF+e4nNAAcG6xPLjrhifzZV2v2upnUmPbZt/bk+uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072970; c=relaxed/simple;
	bh=nWdcb7LR/RMtxf5/DGHk8UmN8DeWPfr2xQFxibfmB2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWUpKwbgkrcqlKDnHa2CIVHFwvOTgs3g0OXmoLf3oCXw6L5/1XlJDmi+8Wy++QW7TMPNQKVzdkF6CxbgO1VKCTgWSb23sD0ELZIuNtQQNlckDvCp54GzIUNrE9cUszlgQdR2T57oSwEDfWPLg3SoHhLStOshGeXfjOV6H11kIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fCrtoeTB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EMC0FbXrD7L3egqP3e+7RWZ/sRC3RGSGbDZBHJp2HjM=;
	b=fCrtoeTBo4DZ+IfWggUJCU6p0kRZnakhCZHGHWsSqdlLv+0zbPK3SbqJRe2PZQ
	Cxbx4yO4otR5TXt/skNae6wFojoKePEkuJkaMXPcI1oQ0xP+p3WWMRQ6zub0ckq+
	ecpmVitpcf5IIoGkVyCbP9aFreByaK8l/N93rO9wrJcqQ=
Received: from [127.0.0.1] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3N2uqfwpqj3zKBw--.44682S2;
	Mon, 18 May 2026 10:55:39 +0800 (CST)
Message-ID: <9f625d9d-6820-442e-9527-1b2802309993@163.com>
Date: Mon, 18 May 2026 10:55:38 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] authencesn: Refactor in-place decryption
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
 Scott GUO <scottzhguo@tencent.com>
References: <20260515083645.4024574-1-scott_gzh@163.com>
 <4e9aee15-62e6-4d71-a836-250c5376a8fd@163.com>
 <8aaa00f3-d8e0-4de0-918b-1f025b632eb9@163.com>
 <agp6lDddmDZaoH6L@gondor.apana.org.au>
From: Scott Guo <scott_gzh@163.com>
In-Reply-To: <agp6lDddmDZaoH6L@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N2uqfwpqj3zKBw--.44682S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyftFy5CrWfZry3tF4kCrg_yoWfWFc_uF
	1jywn7Kr4DuFs5Aayagw4UXr93WrWrCr1jva93ZrWfGa4kXF98G3W0grySvFsrC3yrKr9I
	kFZYqw1rAr13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM9a9DUUUUU==
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/xtbCxAsnxGoKf6s0iwAA3n
X-Rspamd-Queue-Id: 24F50565369
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24215-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[scott_gzh@163.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

BTW, I am wondering whether we should disable inplace decryption for 
now? I think that to mitigate vulnerabilities like Fragnesia, maybe 
something has to be done on the memory side. Maybe something like 
forcing a pagefault when trying to write to these pages?

在 2026/5/18 10:33, Herbert Xu 写道:
> On Fri, May 15, 2026 at 07:01:43PM +0800, Scott Guo wrote:
>> Another thought: even with this fix, Fragnesia should still funciton. It
>> just block current PoCs which pass in the page cache in the position for
>> auth data.
>>
>> Avoid changing the auth part would not be enough because attacker would
>> still be able to link a page cache page within the cryptlen part and
>> override it with the 4 bytes from sequence number.
> 
> Exactly.  The real fix is to not put read-only pages into the
> destination scatterlist.
> 
> The whole point of a destination is that it will be written to.
> 
> Cheers,


