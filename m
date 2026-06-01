Return-Path: <linux-crypto+bounces-24796-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pV0FAYRzHWqTbAkAu9opvQ
	(envelope-from <linux-crypto+bounces-24796-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 13:56:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446061EB12
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 13:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E0F3041ABD
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA1370D6E;
	Mon,  1 Jun 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7KPh7dD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D2372680;
	Mon,  1 Jun 2026 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314884; cv=none; b=Fh60aOdKWiv0AzuQNN/JBlcyOdeDkzSnH4UVkP5DReIRC6jKpkyXm/huYiNPlbzl6PUrZfUV6o8CkUPyIrhtUJMwoW5gT0sKi1PFCf8pvEOiFs5H7fdrgO7zJXXSsJ3tlfFy6Z5ci1RWXasAMVxEb1MZNqAltpwZyordT+Lx2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314884; c=relaxed/simple;
	bh=WKJnYRzk0ucQNDF08kuaY9Gp4nO9IgzOonENrsgt2zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiEQ+jdv8UkiyHkACFGtQlbuzSbPdczbLZhJXAQni1bC3FJIJAtBZ+qMIQlFpkgjc44SjPeuSIw5Fg2PNg/uK+QGGTy1hrRhfcbMtzRMN+2U82qdnEgwzWY2PyVfwX2DGMPNJjdWUGH/g9AwD+yZFm5l6RJ8w8icRi0X3xKImiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7KPh7dD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E4F1F00899;
	Mon,  1 Jun 2026 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314883;
	bh=U+Sp97KblP2DTSqgSuMklYT2nC6sS71ThPI8f01Ibzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K7KPh7dDkNAIC8yTJEdzkKDm7IcWf7CicVGjzo/NZYvdT8GRI+AJvfakbep0c6bbL
	 Wt5kv/Lpic09d3NWMrf3uiziPFIgAztk1uEamHR6clpCl1j9PQHxerRDpeocwnsRBS
	 XUn3SApaqOtCscz2VGxXnxiJznpDChqHj9GkuucIZE6mDeKoNI92nK9fo1xZODkQg1
	 puL/sqgC6atY4g0cqe3WLJmTnxgLxOQTBLMLHHSfQe/fSSzY4pTW8x9J5WqTJBZzUl
	 xhR6SlmZRTr07niWUmnRJKF/LsPE9U8uPewA3EAcM+HEI43/5Vv2phcFTAn1tf+8CZ
	 tVUUPz1wLbgwA==
Message-ID: <a09e9b6e-83ac-47d2-a641-a4c7ce50875c@kernel.org>
Date: Mon, 1 Jun 2026 13:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/29] crypto: talitos - Remove unused priority field in
 struct talitos_alg_template
To: Paul Louvel <paul.louvel@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <20260528-7-1-rc1_talitos_cleanup-v1-11-cb1ad6cdea49@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260528-7-1-rc1_talitos_cleanup-v1-11-cb1ad6cdea49@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24796-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6446061EB12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 28/05/2026 à 11:08, Paul Louvel a écrit :
> After algorithm properties are now set at definition time, the priority
> field in struct talitos_alg_template is no longer used. Remove it.

Should probably be sqashed (with the above explanation) in the previous 
commit.

> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/crypto/talitos/talitos.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/talitos/talitos.h b/drivers/crypto/talitos/talitos.h
> index 438be8c8f08d..6cf3628c52c2 100644
> --- a/drivers/crypto/talitos/talitos.h
> +++ b/drivers/crypto/talitos/talitos.h
> @@ -203,7 +203,6 @@ struct talitos_ctx {
>   
>   struct talitos_alg_template {
>   	u32 type;
> -	u32 priority;
>   	union {
>   		struct skcipher_alg skcipher;
>   		struct ahash_alg hash;
> 


