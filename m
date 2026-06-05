Return-Path: <linux-crypto+bounces-24922-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEDTNCy3ImpecgEAu9opvQ
	(envelope-from <linux-crypto+bounces-24922-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:46:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337AE647D8E
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:46:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=Php4Wwle;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24922-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24922-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95556300EAA6
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5984D90D6;
	Fri,  5 Jun 2026 11:40:51 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA83FA5DD
	for <linux-crypto@vger.kernel.org>; Fri,  5 Jun 2026 11:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659650; cv=none; b=EsNoWB8pLPjzrz0v4BlGk75LDZhxOlKuElzCBsTom5DwUJoSWogEBi0+8Y48UfzkOCDAoUu6dsUa/aAZQMKSsym/+dFuA3YRQzGWcITumSAkw7L0MssuW3x4VxDXb6iuYw+dazugzn7fGUs9BYQxjUMUL9KTBtxYL3Us9y+Qszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659650; c=relaxed/simple;
	bh=/IA2GhPGcKyKbWYtU5uj8zWUnYHNqAgFTF/iGelYM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzL1uezOoJG841XpKbDTMPPvP/WJ4tkfbCoRWF7NlbhsV7FTOPvvP4pw87d120Ps3RCMHW8h0AjoMpXqXmQwy6Svmw11ZpmGGJ9jeZaN8lrC4XsbwsPSAdVtfII62BFaRwk/VdpqpxKzxYOZ035XgfRiISKVlU5jezA4f4u55aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Php4Wwle; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=GcQZma97cMflM4YVEBJxSBXPm+oi2cPkeKTnkVSao7M=; 
	b=Php4WwleQS6lCJneIOF5VNdWEDlkViSQYBfDJGqMLD3YsuIQTr+VZuul+8LV0ivG7bT8dY3GANZ
	5bCcCNB9Gi/FIuW++HB1WAiI/CAUgX8ZI5XzApdP1SYmcEPR/jaYOa2V9yzTp+XvU6KM5WeF1QJp/
	x7w6X6bhP4jmPp8Qk0h+OBTxSvPe9kuCSr/ft8ecyjEdpxl1qRL68UinKjaBg0Yq2uzG6ZT6X8HYY
	8LQiijtQA7LNjGNU8gbeBWnwFVYCy7kxoeqmqr7f6ePXz1AwUVxqIf0eGGXqLlnUx4hakwLKzelGD
	PX+dqQhYdpOaMCTbCij+pDxd2O8sJ9Q6hNQw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSup-002omE-1S;
	Fri, 05 Jun 2026 19:40:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:40:43 +0800
Date: Fri, 5 Jun 2026 19:40:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-crypto@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, yiyang13@huawei.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
	bird@lzu.edu.cn, ruijieli51@gmail.com
Subject: Re: [PATCH crypto 1/1] crypto: pcrypt: restore callback for
 non-parallel fallback
Message-ID: <aiK1u37QHKxarYmm@gondor.apana.org.au>
References: <cover.1779697691.git.ruijieli51@gmail.com>
 <9baedde966f3bcc64b5cde86c2b9c95943572406.1779697691.git.ruijieli51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9baedde966f3bcc64b5cde86c2b9c95943572406.1779697691.git.ruijieli51@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,davemloft.net,huawei.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-24922-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-crypto@vger.kernel.org,m:steffen.klassert@secunet.com,m:davem@davemloft.net,m:yiyang13@huawei.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:ruijieli51@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,vger.kernel.org:from_smtp,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 337AE647D8E

On Mon, May 25, 2026 at 07:45:21PM +0800, Ren Wei wrote:
> From: Ruijie Li <ruijieli51@gmail.com>
> 
> pcrypt installs pcrypt_aead_done() on the child AEAD request before
> trying to submit it through padata.  If padata_do_parallel() returns
> -EBUSY, pcrypt falls back to calling the child AEAD directly.
> 
> That fallback must not keep the padata completion callback.  Otherwise
> an asynchronous completion runs pcrypt_aead_done() even though the
> request was never enrolled in padata.
> 
> Restore the original request callback and callback data before calling
> the child AEAD directly.  This keeps the fallback path aligned with a
> direct AEAD request while leaving the parallel path unchanged.
> 
> Fixes: 662f2f13e66d ("crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  crypto/pcrypt.c | 4 ++++
>  1 file changed, 4 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

