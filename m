Return-Path: <linux-crypto+bounces-25878-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9jUeJ1pLVGo1kQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25878-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:20:10 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E286074690A
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:20:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=gs7twTu3;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25878-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25878-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6B2300C81C
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6772E7367;
	Mon, 13 Jul 2026 02:20:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3B21FF2A;
	Mon, 13 Jul 2026 02:19:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909202; cv=none; b=G12yVBbmNs4IWyFAZVvbOMgIhNAR0jGkV0rmLJQmWEo0/gipz/tfgHrMcspgols50DVHOxfqo1LlL8AGMhGHi7XE58P3Szb6NDuRBdAnvdFbjecxCr6uH694aNjjOCZ/fgkh8fPp7/826s9vzUPVPoLQGUIU55+MwrReiRi6V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909202; c=relaxed/simple;
	bh=vJ/yPYjhnsSIbAr4nmVuLoS9VSbdshrtkY/TR9ki9FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAJOrweVlQQbOM9n4g6wVi28hLxV/gGA7XpZgAbcXhUlI5+h7sG4DhGRp77yjrzgNzd2Fix6VcfqVZpOU37xejL8irSRoxhvNy3V5Y0fW4G8ho74C7Dbi9Fd+H/rBmi2QfqkHxnbFjfpFYuWu+NE5ehFbgIkifmTWbN8mqPAGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gs7twTu3; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=tkaanRFmqn56m8lC1Sw+QFkPskwCH8sTNq0k/iWMcZ4=; 
	b=gs7twTu3TaP0tHxr0h2LKhaw9vWJKMloKWiHfYOUxTCpnObWqqkRVlmyLS7ToTZvDiqOUxPLJsg
	fDkHmmWlVPS4LuVciTY3ACoGPjwthRWrUAWyySc9rkZcA0bbYnDocsnRIQ7VjEJl4nr3MjuUwTE+r
	vdGrYhLBrQAPKZMG0faTqX7QmVCI79FUDffpG4/ATr0+wUvjRED1hfOr4MGcST+NoQUIJDe31Y3yo
	lX1+Chs4Q5D98JYmJq6Ewq09mJwbxuceVB/Pmd0Ln+7E48N2xRTuGBnFH+G4GnT1wZLQUZKAG4cxo
	6B5uA6d7oJaocvEkiLXhX9FhXk88uAAB5LrQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj6Gw-0000000CxIr-2skm;
	Mon, 13 Jul 2026 10:19:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 12:19:54 +1000
Date: Mon, 13 Jul 2026 12:19:54 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leonid Ravich <lravich@amazon.com>
Cc: linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, ebiggers@kernel.org, snitzer@kernel.org,
	mpatocka@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v5 1/5] crypto: skcipher - add per-request data_unit_size
Message-ID: <alRLSqiz3Y_EQfpH@gondor.apana.org.au>
References: <20260630083431.2772-1-lravich@amazon.com>
 <20260630083431.2772-2-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630083431.2772-2-lravich@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25878-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lravich@amazon.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:ebiggers@kernel.org,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E286074690A

On Tue, Jun 30, 2026 at 08:34:27AM +0000, Leonid Ravich wrote:
>
> @@ -39,6 +46,7 @@ struct scatterlist;
>   */
>  struct skcipher_request {
>  	unsigned int cryptlen;
> +	unsigned int data_unit_size;

Please rename to unit_size to align with the proposed acomp patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

