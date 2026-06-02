Return-Path: <linux-crypto+bounces-24834-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qjBWKskSH2pIfAAAu9opvQ
	(envelope-from <linux-crypto+bounces-24834-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 19:28:41 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C7630B48
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 19:28:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=famDYgPC;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24834-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24834-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92DE7300F953
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915513F8EB4;
	Tue,  2 Jun 2026 17:26:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73210380FC7
	for <linux-crypto@vger.kernel.org>; Tue,  2 Jun 2026 17:26:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421185; cv=none; b=XRrITGWFUO0pzQ0HdgyLjj+BJaiWfwXs1ioLd2ATLNMOQoLS5uCZ5SAZD0TneCT4JMrgv9h6EyBD5b0CZUiTt3xkDDE65CC5l9v/qj8jLAN531X+YYSCTxu8gMI7jLXz8lZdOVHNpgZ3VBbPSNOvKNqYzfdRYTqEF6wqmwv71+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421185; c=relaxed/simple;
	bh=QJHorl3xOeduBvAKtKAREWRw7Npws2A6veRs5qeSZwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTBPq01wAq3vEpZIAi0pwSftxr4LDQP8xm27vEcxw2dwkTWEZqg3VZqKM5X++RdBYJNvK2QjSiE7c21Nu2gIEHLVnCi16y9XbiOCGIt0/fwdIbNpXYwf7/2rayb7Vh5OcuTQ7j/Gi3I9Co9fFn2eL1veLPnVaMGH6xcgvmTH+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=famDYgPC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F171F0089B;
	Tue,  2 Jun 2026 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421184;
	bh=crzGd2e/H3YsozTRXg+pjftVc81TUrCT6e7aIghwWBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=famDYgPCte0YZKqGrIiLMcLIZoRLMsY5KriRL2Skv6hg40j/hMAZ5T2xqFr1/OQQ3
	 NvkJ9CDhklH1EFBRZDiew6vHmjDmX6t59GiKy0zWsqEMbf+qttZNt9kuWpO6Z1JMm9
	 N3dh0BZKnGw3vn0aj+OQcGh+DhG2eOMndAshDnszcWDK50/Il/BJh5wDVXXtQdAUa+
	 Oc8We7frZXMZ2ziZN2REiIS+O6UEg1Q6Jo454aIphzrzHEUpAZM0mIOt89CxsHSo26
	 KLgO778dWRpruz6KcGHNIt8ft/dWbWdZAEdKdUzplwQ3Rkl5euuziu4nmFZfr01Uu7
	 vr+FzLwBlzC+w==
Date: Tue, 2 Jun 2026 17:26:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-crypto@vger.kernel.org
Subject: Re: [bug report] crypto: omap - switch from scatter_walk to plain
 offset
Message-ID: <20260602172622.GA2503276@google.com>
References: <ah6SJiFErFV17cMi@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6SJiFErFV17cMi@stanley.mountain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-24834-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C1C7630B48

On Tue, Jun 02, 2026 at 11:19:50AM +0300, Dan Carpenter wrote:
> Hello Eric Biggers,
> 
> Commit 42c5675c2f5b ("crypto: omap - switch from scatter_walk to
> plain offset") from Jan 5, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> drivers/crypto/omap-des.c:842 omap_des_irq() error: we previously assumed 'dd->in_sg' could be null (see line 844)
> drivers/crypto/omap-des.c:872 omap_des_irq() error: we previously assumed 'dd->out_sg' could be null (see line 874)
> 
> drivers/crypto/omap-des.c
>     823 static irqreturn_t omap_des_irq(int irq, void *dev_id)
>     824 {
>     825         struct omap_des_dev *dd = dev_id;
>     826         u32 status, i;
>     827         u32 *src, *dst;
>     828 
>     829         status = omap_des_read(dd, DES_REG_IRQ_STATUS(dd));
>     830         if (status & DES_REG_IRQ_DATA_IN) {
>     831                 omap_des_write(dd, DES_REG_IRQ_ENABLE(dd), 0x0);
>     832 
>     833                 BUG_ON(!dd->in_sg);
>     834 
>     835                 BUG_ON(dd->in_sg_offset > dd->in_sg->length);
>     836 
>     837                 src = sg_virt(dd->in_sg) + dd->in_sg_offset;
>     838 
>     839                 for (i = 0; i < DES_BLOCK_WORDS; i++) {
>     840                         omap_des_write(dd, DES_REG_DATA_N(dd, i), *src);
>     841                         dd->in_sg_offset += 4;
> --> 842                         if (dd->in_sg_offset == dd->in_sg->length) {
>                                                         ^^^^^^^^^
> Dereference.
> 
>     843                                 dd->in_sg = sg_next(dd->in_sg);
> 
> Imagine that sg_next() returns NULL, then the next iteration through the
> loop will crash.
> 
>     844                                 if (dd->in_sg) {
>     845                                         dd->in_sg_offset = 0;
>     846                                         src = sg_virt(dd->in_sg);
>     847                                 }
>     848                         } else {
>     849                                 src++;
>     850                         }
>     851                 }
>     852 
>     853                 /* Clear IRQ status */

Pre-existing bug.

- Eric

