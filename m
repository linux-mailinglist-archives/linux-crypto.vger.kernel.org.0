Return-Path: <linux-crypto+bounces-24465-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BxJEDpTEGodWQYAu9opvQ
	(envelope-from <linux-crypto+bounces-24465-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:59:38 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BF5B4AB3
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5E1B313DED2
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3F233956;
	Fri, 22 May 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORSs6x6/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC020010A
	for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454237; cv=none; b=q+zt5WS25Ws2JuxQQhBpt4JGDFMYw2bIgjpA4a2ML8ibjgrWbp+V/dlH8mJCBmM8PUcrs/29OnXlVJew9gjHlOx2gFHmiqZF/71Jzmdu165kmRoHMSGELRQgfALuity/6X9Sxaskrrc7kRjRkmzG9gpc5yAdA7DexkhTsCPPxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454237; c=relaxed/simple;
	bh=DetfmDtz3uAbzO1L3LrRbAIoEbfDqa3ShaOhDK60Ac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSaUJ3Sk4keTlxQdJC+XUAS07r+u1S2xwZ1I7PcGeEoqYm4twNljFRjfRw2jbjOZ5gVqyVc63X5gzKdX3pqlSwPVZ3d+APQpR7Vc4wJBoPA6P98TjAcvHDsjfpwnoPJPI3Kgap+znJjwo4BWy0Es36N3HDnWkuW6Ak9cTgviq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORSs6x6/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 May 2026 14:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779454223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8hVE5+6s6jiU8WshmJ7oYYjT5kpzvW6nDpmjJBlgwM=;
	b=ORSs6x6/gqR/DIlhUDYLap/jwsiUCzRCALT7FEQgYhWi2+ZN/IXBe/WGLrPd37KBxq2rQj
	Xi/yjm3VTTnQ3GwLzVO/ZE0t/v3CZYB2VmruhTdDiCrtfX2ZpBM98Cv3wl3oz2TzYfZpZ7
	XRBk09UncFodO+e4Ki6uUsEOa58q5lo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sock: add sock_kzalloc helper
Message-ID: <ahBRCxCXbCq5LeCc@linux.dev>
References: <20260427104129.309982-7-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427104129.309982-7-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24465-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D08BF5B4AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Herbert,

On Mon, Apr 27, 2026 at 12:41:30PM +0200, Thorsten Blum wrote:
> Add sock_kzalloc() helper - the sock equivalent to kzalloc().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/net/sock.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index dccd3738c368..20bf406dff2d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1904,6 +1904,11 @@ void sock_kfree_s(struct sock *sk, void *mem, int size);
>  void sock_kzfree_s(struct sock *sk, void *mem, int size);
>  void sk_send_sigurg(struct sock *sk);
>  
> +static inline void *sock_kzalloc(struct sock *sk, int size, gfp_t priority)
> +{
> +	return sock_kmalloc(sk, size, priority | __GFP_ZERO);
> +}
> +
>  static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
>  {
>  	if (sk->sk_socket)

Can you take this series or should I resend this to net-next?

Thanks,
Thorsten

