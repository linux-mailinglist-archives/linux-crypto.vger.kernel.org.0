Return-Path: <linux-crypto+bounces-23373-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLa9Mx0U7mkxqgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23373-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 26 Apr 2026 15:33:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34696469FC6
	for <lists+linux-crypto@lfdr.de>; Sun, 26 Apr 2026 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805B4300BDA6
	for <lists+linux-crypto@lfdr.de>; Sun, 26 Apr 2026 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806935A927;
	Sun, 26 Apr 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WsE19gSk"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360433FE36
	for <linux-crypto@vger.kernel.org>; Sun, 26 Apr 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210394; cv=none; b=UG6zxJmzOaHvchocJzNpExhUOaL15ZkmLA/KOhmxXYGJLLu950xgwvYd88LA5S+5evloBJR08LbVAT/oORen8vAvndLjePSXxnl5+5PnRv5T6ddCgPlkGlLtJhQtNwFMsYgGigLPNMVxxLb4+dUeYlQi8ItLta40+pemEzUvLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210394; c=relaxed/simple;
	bh=G884qd97PNIxFyanL5+UkLxO8fmPu7J/+fwd9gPZOR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsu+zjbT8Rb6FkIcnsi6uPoy4CefSnifnf53GjPJDYV2kAo71rYbGcPRhOS0OYjmg/nfl9bld6lzAeiII227GVQmWGmIr+d4a7fJGrPvNtXIMEdIYPnGK9V6ljgAASFos7Jf1kRYh54VdBdjD56ImPtHh0Qm5fMjhuxiYnrf87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WsE19gSk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 26 Apr 2026 15:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777210390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G884qd97PNIxFyanL5+UkLxO8fmPu7J/+fwd9gPZOR8=;
	b=WsE19gSk0wj+TVv11MRCqO70eJqdJIYZTDkuTcxHRdA1Z/2eX9AE+eMmp+QRigvfhinfBC
	8wa4yJzFa4j8lkMkswAbKZhLYamRAujoAcaph+IooMc6H+EZAyzBYTyQXg8e+4ZJ3VCVpM
	o/0DCI0D9/H4wP0HsplB+6MoArqXyt4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, ardb@kernel.org, linusw@kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] crypto: atmel-sha204a - fix memory leak at
 non-blocking RNG work_data
Message-ID: <ae4UD-JGUarmSMiK@linux.dev>
References: <20260422210936.20095-1-l.rubusch@gmail.com>
 <20260422210936.20095-2-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422210936.20095-2-l.rubusch@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 34696469FC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23373-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]

On Wed, Apr 22, 2026 at 09:09:34PM +0000, Lothar Rubusch wrote:
> The driver allocated memory for work_data in the non-blocking read
> path but never free'd it again.

Yes, 'work_data' is allocated once on the first nonblocking RNG request
and reused for subsequent requests, but the memory is eventually freed
on device removal in atmel_sha204a_remove().

The memory might be retained unnecessarily after use when the device is
idle (probably negligible), but it's not a memory leak.

Best,
Thorsten

