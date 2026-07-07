Return-Path: <linux-crypto+bounces-25712-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id azVyCIKDTWrn1QEAu9opvQ
	(envelope-from <linux-crypto+bounces-25712-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 00:53:54 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA427204E6
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 00:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=vCKj38Wl;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25712-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25712-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692F43044233
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70A36C59E;
	Tue,  7 Jul 2026 22:50:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D5365A17
	for <linux-crypto@vger.kernel.org>; Tue,  7 Jul 2026 22:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464650; cv=none; b=XAX2FN35dehEaVGmcIkVS/seiBJ4VobAnI2DXB17/DJV5icSn5cZgXCkZF4D8jpTglY0EgGz6LHM/hqvllIgBdPy4pDZ+xAjb/8+x7Mvl8KwI0d/bL2jQJV/TvCtNG3LWhxIjPDI219AmNIMeguiwlTeKF32XuSSj2dDFa0up94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464650; c=relaxed/simple;
	bh=XrURLRuzhMeyoRPP6TzJ5HNr3YHPQdsgGNCGP2PPneQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ0MQLeU5052b2eqqPkPEJjqa7+y0uf+gK27ygfFGhPM84rRc42LRfIAZ14mhj+9oSekhCGCuj5QxzhC4lNJOTGRnSykubD8tb9cOj1rCt7WYJg3P1npUCwBZA2GE2PDx7WYspEE6eeR6W2CJeH+xyaGvY2BEPMAFqKAugGE5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCKj38Wl; arc=none smtp.client-ip=91.218.175.173
Message-ID: <d1cdfc23-b336-49a9-8833-29f05b5b9fec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783464636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDhFZdkqIsuCQS1YUJXiuPYtigAq8mHM0eUb6fGKMNM=;
	b=vCKj38WlCBYO2+9hiCqGs/OawSen1DAgyo8kWtsRAhxENjGZfbMohWuiFR9+hglcCOn9/R
	c3MWaA8asmDsZRv9YKX23WmT2bkGKDoWMAxy/y68m+mmNqf7MAcvirGo4oo+5Er0hSX36Z
	OfM/14ydBYXLXByrNGJrGHpKvNJld0w=
Date: Tue, 7 Jul 2026 23:50:33 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 29/33] bpf: crypto: Use AES-CBC and AES-ECB libraries
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
 <20260707053503.209874-30-ebiggers@kernel.org>
 <10eafa42-1142-4ed2-a485-f46c496bddfb@linux.dev>
 <20260707182049.GA2238@quark>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260707182049.GA2238@quark>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25712-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DA427204E6

On 07/07/2026 19:20, Eric Biggers wrote:
> On Tue, Jul 07, 2026 at 04:01:13PM +0100, Vadim Fedorenko wrote:
>> cc +bpf
>>
>> On 07/07/2026 06:34, Eric Biggers wrote:
>>> BPF crypto was implemented using the lskcipher API, which doesn't seem
>>> to be going anywhere.  It supports only "arc4", "cbc(aes)", "ecb(aes)",
>>> and only with unoptimized implementations.
>>>
>>> Library APIs also have been found to be a much better approach, for a
>>> variety of reasons, including reduced overhead, greater flexibility, and
>>> having to be explicit about the crypto algorithms that are supported.
>>>
>>> We can safely ignore the theoretical "arc4" support in BPF crypto as
>>> unused, which leaves "cbc(aes)" and "ecb(aes)".  Why these algorithms
>>> were chosen, it's unclear.  Regardless, I'll assume that "cbc(aes)" and
>>> "ecb(aes)" need to continue to be supported for backwards compatibility.
>>
>> That was done for single use case of decrypting small blocks in TC
>> layer with "cbc(aes)", with assumption of extending it later.
> 
> What protocol is using AES-CBC?  And is the kernel encrypting or
> decrypting the data elsewhere, or it is just routing an encrypted packet
> and only the BPF program decrypts it?

That's a "home-made" part of UDP encapsulation, the kernel routes it
further based on the info collected by BPF decrypt program.

> Does this mean the AES-ECB support is unnecessary and can be dropped?

Let's keep it if it doesn't hurt.

>> This change looks great, but it would be great to CC bpf folks just to
>> be aware of the refactoring.
> 
> Sure.  I'm only looking to apply patches 1-13 for now; the rest (bpf,
> fscrypt, keyrings, libceph, mac80211, macsec, mac802154, smb, ksmbd,
> tipc) are proof of concept, showing how the library APIs can be used in
> a wide range of kernel subsystems.  I didn't want to spam the entire
> series to 20 mailing lists.  I'll resend them individually later.

Ok, cool. But you can keep my Rb anyways - I checked the code and run
tests.

> 
> Thanks!
> 
> - Eric


