Return-Path: <linux-crypto+bounces-25223-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eg8QMoG+Mmoh5AUAu9opvQ
	(envelope-from <linux-crypto+bounces-25223-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:34:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6477969B09C
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:34:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LF6BMTJx;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25223-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25223-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79411318954F
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD27436356;
	Wed, 17 Jun 2026 15:11:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EB3A05F2;
	Wed, 17 Jun 2026 15:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709110; cv=none; b=UsqHURtiBNl2E+SCblYXiMYW38BGkZ9HEkN4trXMcID2GDtgfoz5D+WF1q57HqmPV3G6+EW4v2aU/OdtNFb2oSpdIoTtkqb+v8o1ZBwxNH5H0Y1KJq9AwNjhFmO8moynA8yPCH+L+k6HXOx8uXg2LSYl/JNvqLNHQgzxlSegWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709110; c=relaxed/simple;
	bh=KfT8N6eL2rs8lb1ZUfm5PeIOKBQuhfscJvqUIJfFtj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPfe7Jk4Jn54r02efnlBRc7x1IsjWKJsO6Nqo87mzX/mUwGJOPLxjsXKbtqHKDTTEJnZczwmAWrvIAA02Ue7Td0MJWKi9kZ2qRk4xlwL9H0EJF0D+C/yPsXQeS5iHcHDDGG8BNV1Kmu3ZvhzCClkBZ0mKTQPvH097y0bNgKV860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF6BMTJx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CBE1F000E9;
	Wed, 17 Jun 2026 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709108;
	bh=rMX8J8Qkf3Q16gjxAm2YgOc6pGKMIOI+MS9wQsOdgnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LF6BMTJxjw86hBTKsJ/Z0dik+S8S4xO+VgRdZNWA/lBBrnkpUV1HY/fh+DSow4SS+
	 kQ689863cCwskcmv/cmBCWPFwhfnp7pdHQtRfsIslHT1xWXv30eleMRz4jH6BKqVbS
	 4YDA96oWgshvSAUJo93GY9keN/j2HsIZE7Z0r63024M0YDpnDuUrY048WPnQQSsWPi
	 rrIZP35AqhDpEXmWhzg1mUWzP88mnDVGJPPC6CEepgs+w7OjLGjitJKq78jPo4zpt6
	 eJAogu4fdE96AOItA3kAmxiLGG+mE3ng+BHk3227SdrnSVeee9YX/7I3bPifl+FS5l
	 m7xtM3IQLW8PQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Jad Keskes <inasj268@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexander Clouter <alex@digriz.org.uk>,
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jad Keskes <inasj268@gmail.com>
Subject: Re: [PATCH v4 2/2] hw_random: timeriomem-rng: add configurable read
 width and data mask
In-Reply-To: <20260617114642.1911191-1-inasj268@gmail.com>
References: <20260617114436.1909659-1-inasj268@gmail.com>
 <20260617114642.1911191-1-inasj268@gmail.com>
Date: Wed, 17 Jun 2026 17:11:45 +0200
Message-ID: <87se6lciby.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25223-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:inasj268@gmail.com,m:krzk+dt@kernel.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:conor+dt@kernel.org,m:alex@digriz.org.uk,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[selenic.com,gondor.apana.org.au,kernel.org,digriz.org.uk,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fw13:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6477969B09C

Jad!

On Wed, Jun 17 2026 at 12:46, Jad Keskes wrote:
> The TODO for supporting read sizes other than 32 bits and masking has
> been sitting in this driver since 2009.  Implement it.
>
> Add reg-io-width (1, 2, or 4 bytes) and mask support.  The read loop
> dispatches on width using readb/readw/readl so a configured 1-byte
> access doesn't trigger a bus error on hardware that rejects 32-bit
> reads to that address.  The mask is ANDed with the value before storing.
>
> These are platform properties, not runtime policy -- width depends on
> SoC integration, mask reflects which output bits carry entropy.
>
> The alignment check in probe is updated to verify the resource is
> aligned to the configured width instead of hardcoding 4-byte alignment.

So this is the 4th version of the same thing within 24 hours and without
any explanation what the difference between v1/2/3/4 is.

Please stop this frenzy and send out new versions only if there is a
good and documented reason. Otherwise give people the time to review
your patch. All of this is documented in Documentation/process.


