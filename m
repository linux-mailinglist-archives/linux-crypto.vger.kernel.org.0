Return-Path: <linux-crypto+bounces-25702-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i2MrAsQYTWouvAEAu9opvQ
	(envelope-from <linux-crypto+bounces-25702-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 17:18:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 003AB71D2C8
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 17:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tyFNSz2K;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25702-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25702-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B56E530657A8
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DA372677;
	Tue,  7 Jul 2026 15:02:23 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D8361DA8
	for <linux-crypto@vger.kernel.org>; Tue,  7 Jul 2026 15:02:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436542; cv=none; b=WTqEsJzdfbD5RIZ8b8yOdRBXc6W4Y92GLh9fI98IsA2sSlSfGgSZdkP7ty3DyLlNT8KBjYvh2N0LSN50cQhXaawD/CEA5r3aOU97OZmQTaA50JVpJJKJhnocoaQU+DNaIpPPh3khurp87wOhZk+y5JFgzpdMzPc2/TzGa/g6Qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436542; c=relaxed/simple;
	bh=6NMBOPdnKmfBHXLgTRf5uWAK9hLha/eILz/qnY+Pwhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNpHe/f25XW9EOodq6ND2FNsAHEKWEGWN7Htk7ATGxVx/L2zq4/R+bHdkgQmd3+2mT6yRZ+34XFUwxJ2oFx3VdPUqj+Ln3Id7S+yHDHUVEYZBAqzd5vHQJsJXNhxPtFHZifyTObrsvDOQT1N/MAhN/Y3wXj6wfxPPBY7bI5fvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyFNSz2K; arc=none smtp.client-ip=91.218.175.170
Message-ID: <b15a4ba8-e6fa-430a-b91a-a32a4bb84c52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783436539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKpkvLOBs3T03yECX1ZGbffwPSwv5EOUeHxaLSj/9Go=;
	b=tyFNSz2KpQnjsc0vAYnrdX27ZdsN1VsSZOp1bw1cYZob7zz1Pf2PwGJghxT780lmGTfuL4
	VW3Fwl35zWxz5bAsRciwGEYWrTv4jz8To/Si8fVuKrWOClwu0wXAAbh75LixX9F+eksI/N
	uhltMDYZxywQ/m+K8u3TQvnpWopPF/s=
Date: Tue, 7 Jul 2026 16:02:17 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 30/33] bpf: crypto: Add AES-GCM support
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
 <20260707053503.209874-31-ebiggers@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260707053503.209874-31-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25702-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 003AB71D2C8

On 07/07/2026 06:35, Eric Biggers wrote:
> Add AES-GCM support as requested at
> https://lore.kernel.org/r/CAHAB8Wy1APeCcm7_OfrNYeZFcMXfZ5rUSeDX7-c7WO_rGg2Zig@mail.gmail.com/
> 
> With the library this is straightforward to do.
> 
> The associated data is assumed to be empty.  If control over that is
> needed, support would need to be added for it as well.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


