Return-Path: <linux-crypto+bounces-25879-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wm/MAblMVGpckQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25879-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:26:01 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54378746959
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=KhrGvfbS;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25879-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25879-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4803013487
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F772F1FC3;
	Mon, 13 Jul 2026 02:25:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8365265620;
	Mon, 13 Jul 2026 02:25:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909542; cv=none; b=pUdzGJwJgDS//tLRS40tpf8G/FdxG55XWKn7jAyt1DX2T/7wLiovERYXcBfHKhohJ7CzL3NXUu8tFUX4zT4HPg6A9d7xmdN9pHe5PIEp6akTL6oQX34n1hJY9nYsvGsdww6r0iK5pBydXgnozgXOYyqxfCCBKnn1FCPPeFYZQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909542; c=relaxed/simple;
	bh=BTmsNUZw84kKsPm5OqELn5hld4bHjW+j5E6nvpoGmHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd5VpXCxW7u4IvlkiLiv/2eIQldvzegcFC0/3bNWbYawRlI3QE6zqxFqz8SXmqQqxeqW2tS+h7xc6Jus/hX97w9k5lLSGrfq6pxhVJfHV54Qve4kCEN1PvXnvhtTxprZ/EivYvtSv1KlMCiLL9blYYyTfbjAEsIhMZFBcB8zRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KhrGvfbS; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=dbsKWOlsBrJrT7FSZx32kZiPCen7W8kvZEdP9N+VlDE=; 
	b=KhrGvfbSf1kw6jznU/xEllPdh4/BUGYFBQ8WGpiILH/zfaxE6yUeK/bMZhFtL+fctBAsSnWaTpf
	W6N/kf5FtXc4zXrfQrIyB1wN8n1DItLp5booHlkzvQPoNsNHm0GtwhyLQQnYnRhQ/ILwxkfBO2vqp
	Bw3ewjic1IagnpsJ2rijvU0CWHWV38JIJBlxoGPGIKJsXCZDbtMBl04EqCysVb7s/x/+i0/13IPPk
	VUN3c/FUvw0zt2P5Q4+I0Pkc4lyzUC8TnO2bmco9lXVO4MdUWkwQdbBFfqfoxfOnBTWgY2VoY7CPF
	X7y+ggcfgu2Y+j72j8p22uOA2uXakjMjLHVA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj6MR-0000000CxNg-1rhY;
	Mon, 13 Jul 2026 10:25:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 12:25:35 +1000
Date: Mon, 13 Jul 2026 12:25:35 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Leonid Ravich <lravich@amazon.com>
Cc: linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, ebiggers@kernel.org, snitzer@kernel.org,
	mpatocka@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v5 2/5] crypto: dun - data-unit-number dispatch template
Message-ID: <alRMn--pY1ELYmBJ@gondor.apana.org.au>
References: <20260630083431.2772-1-lravich@amazon.com>
 <20260630083431.2772-3-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630083431.2772-3-lravich@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25879-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lravich@amazon.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:ebiggers@kernel.org,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54378746959

On Tue, Jun 30, 2026 at 08:34:28AM +0000, Leonid Ravich wrote:
> Add a dun(...) skcipher template that wraps an inner skcipher whose IV
> is a wide data-unit-number counter (e.g. dun(xts(aes),le)).  When the
> caller sets skcipher_request::data_unit_size, the template splits the
> request into cryptlen / data_unit_size sub-requests on the inner cipher,
> walking the IV +1 per unit.  Each inner ->encrypt/->decrypt is a direct
> call, so only the outer dispatch into the crypto API is indirect -- the
> per-unit work is not.

This shouldn't be a template.  The default data-unit handling
should go into the mid-API layer (so skcipher.c).  It should
transparently split things up *if* the underlying algorithm does
not support multiple units.

The eventual goal of course it to add unit support to all underlying
algorithms so that the mid-API code does not trigger.  But for your
patch-set this would keep the work to a minimum.

Again you should align this with the existing acomp patch-set:

https://lore.kernel.org/all/20260125033537.334628-15-kanchana.p.sridhar@intel.com/

In face as the acomp work has not been merged yet, just cherry-pick
that patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

