Return-Path: <linux-crypto+bounces-25881-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkPZM5pSVGqmkgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25881-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:51:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DA746CD2
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 04:51:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P7GWtJzn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25881-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25881-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619CF30097D9
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 02:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24702376A00;
	Mon, 13 Jul 2026 02:47:00 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D328CF4A;
	Mon, 13 Jul 2026 02:46:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910819; cv=none; b=CeESXfB19mq6yY7T7qmuOGgHhwmMyFH2fc8wYKVEi/OMin6M6ejnuDfIzVWXoP8g3RxG1rXAYeboKu4GVQkCm5iollKCxnIl8cZzbrH8YuqFfd6FG139KwayzimO2HChhEcKNy5ToGDRop1UIEZTdnKHLTOQsoQQUNMqHTlN6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910819; c=relaxed/simple;
	bh=/b3kJbOFF0E/b/f4VSpOrBDVMaZaC4kFhGCvRcd8O7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV3srUYL4bQERyQl7CoJRx7Wlzqu5B0JpU9nAddjmzWF/2ML6VaTIgWXpORn/vJq7OnipPaWZ6D5i9vA2gUP27yQ9dT+S2v1bPwgD4s8bYuxwNSoiTxSyZPHnbTqwqgzcs34Ygvo84imzsORwSresPky+699Za52pYRZUL+bPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7GWtJzn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B61F000E9;
	Mon, 13 Jul 2026 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910816;
	bh=NVNxpvdr75jR60pjmjlxX2uPtAPAPcc1WMu92AUb6WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P7GWtJznmtHWeTVEJdLRSnknDOYL6w64XGx9CnpdLMTXshE4Sc452duIZd+egY966
	 tLG4RSFlntGawHD/OQOjE9ckNNvMPqql4mL7WjZjE7bkdJS3WOd6EH+/A27KX5RsP4
	 kaes39SomNTK12GW39eimt3iuhCVVuBYygVLEApYdpGg2tfc3Xlj0fGRSnOsyOjzGI
	 OeBmeFmYAF0ZVxXoga5lBC9Hj7oymysD5vljL+2G6KWzz/XrtZxroJo2zNK9W297MW
	 W7EeXY2KZMWETv/6C6qPn2bNFtx+KhYciT/tM24I+hgjVl2kpCmMFuDY/lrtWtyQys
	 IOldlMvx2RFxA==
Date: Sun, 12 Jul 2026 22:46:54 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Huth <thuth@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] crypto: pcrypt - Disallow nesting of the pcrypt
 wrapper
Message-ID: <20260713024654.GE4362@quark>
References: <20260701143947.944593-1-thuth@redhat.com>
 <alRNusgXIT06hTow@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alRNusgXIT06hTow@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:thuth@redhat.com,m:steffen.klassert@secunet.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25881-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B6DA746CD2

On Mon, Jul 13, 2026 at 12:30:18PM +1000, Herbert Xu wrote:
> This doesn't fix the problem completely since you can nest in other
> ways, e.g., pcrypt(cryptd(pcrypt(...))).  How about handling the name-
> too-long error more gracefully?

Could we just delete pcrypt instead of continuing to try to fix all the
weird problems it has?  A web search for pcrypt just finds CVEs and
advice not to use it, e.g.
https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations

What is the rationale for keeping it?  Who cares about it, other than
people looking for vulnerabilities?

- Eric

