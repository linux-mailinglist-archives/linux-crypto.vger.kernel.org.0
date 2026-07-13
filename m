Return-Path: <linux-crypto+bounces-25906-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xCWlOrOqVGp4pAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25906-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 11:06:59 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83B7491C0
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 11:06:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=IH4bU3lK;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25906-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25906-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F0E23051C7E
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC363DBD43;
	Mon, 13 Jul 2026 09:02:09 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1743DBD57;
	Mon, 13 Jul 2026 09:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933329; cv=none; b=NgsswUFhKnldLe/6CQVWy9fYj752LFsOF4rC7ZvF/qtg5a3x2Lg4a2b+y+R9qPZwYENXRpiGCkTZkeeGB2U3gqbWRCPQAAmPnQoC1FiD88PHPutt7t/3JbhZWIhvdp2quGhT+JDfHqy2+71aj3Pkm2LcqMuFTXG0KG89J+ksRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933329; c=relaxed/simple;
	bh=6EXhuE/eB04dFZzHnTVbb+fqxi2+QFcuE2hXEjUmVQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IscPK2YTXKnLTboyzxYSIplQqQqdBJ7q4YocsyhXk61u88q1UrG9QF9/hC3C3OtuixwaNPmYPn8fgtB55thf7rOJs9CmfTs3u2QpnOC8QX8fO0PR7JY/nJx+HbKjDLvDvG+GJ/CGz6bpRlqGa1Nn7T8eT8ZYZ5uQMRyJevTl9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IH4bU3lK; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BNwiur73z9ZKcEaSTwnm4ubr4IDbGUdhOCGvro4ilfc=; b=IH4bU3lKTM1jxZaX9RsJ5oLPux
	VI/tfUrEZwRmRC5tVk7HEG19DkT6jjmtNtggiVf8pUC6vzhWBqry4oapulR8lsoo7iBhEUrhxtXSG
	GJCOxDAmNWB7rJqXgE0bP4Igcie7bmEMlOfdJ5JP9V/BAutaWM9gRAGO+urpk0LzrplbuGjG+6UQA
	/8Wg+2pYmI3jIzIcE1707purm0DLOPEHLImlkbseEvuVJswN5pnUEuFN60cKOpISVoikL/XUo7NYi
	oBuoXdFNsmDRZgYL04AGTIWFoPezklWxvG9/+mvjTt460aEhGys4r9/ueY6bcz3EUy5DR7xQ/+J/A
	vWR7R3jQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wjCXk-001O5g-0O;
	Mon, 13 Jul 2026 09:01:40 +0000
Date: Mon, 13 Jul 2026 02:01:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nayna Jain <nayna@linux.ibm.com>, 
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/aes - use bool for encryption/decryption
 flag
Message-ID: <alSpYVYCcT_D4V8K@gmail.com>
References: <20260711145216.747128-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711145216.747128-3-thorsten.blum@linux.dev>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25906-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:nayna@linux.ibm.com,m:pfsmorigo@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linux-crypto@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,gondor.apana.org.au,davemloft.net,ellerman.id.au,kernel.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E83B7491C0

On Sat, Jul 11, 2026 at 04:52:17PM +0200, Thorsten Blum wrote:
> Use bool for the CBC encryption/decryption flag passed through
> p8_aes_cbc_crypt() to aes_p8_cbc_encrypt().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Breno Leitao <leitao@debian.org>

