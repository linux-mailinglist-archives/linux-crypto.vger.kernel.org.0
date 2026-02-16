Return-Path: <linux-crypto+bounces-20909-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KSTJTLNkmnxyAEAu9opvQ
	(envelope-from <linux-crypto+bounces-20909-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Feb 2026 08:54:26 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5632141630
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Feb 2026 08:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA18C300BCBE
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Feb 2026 07:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E1E571;
	Mon, 16 Feb 2026 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3HZUODM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026A267B89
	for <linux-crypto@vger.kernel.org>; Mon, 16 Feb 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228461; cv=none; b=LiMPNHYcvZWD+DLfDJbiF8UsKpuK3BG5HlKhlV0QWfpPfqbwYDGhP2y+svmBKMiU8P+Poa4cH63iAUh0axq3DkgmAWKWXOqzVhTcCrnZtaZa0hrB1MzqbSOp5fb85+weT4KKYj9WvhRSaF+dPk8vdv9OKaGHl9LjQUEdnNzWGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228461; c=relaxed/simple;
	bh=hJHCqRRnankEoC/ErtC2hAAeRlqcyizmIk/mir5pSks=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DxGzkeNPkClI/cgCxRwTtpyfy4qO62suxgZ4h3RjAqOXc5sQ3dwZ70aTHy5Cad5WTXGdy2o/jtiT5YiWcSqb2JUgbpwBAsJoYXjRsRwxEiUCx7OTxGF8VsL2qPceyoGmL15NySDvS0eNQbvSQctiKaYA3HtN7rtHZjY8zk0Gl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3HZUODM; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771228447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJHCqRRnankEoC/ErtC2hAAeRlqcyizmIk/mir5pSks=;
	b=G3HZUODMvtoogeed1XFbneGODNDFnbuOfeHNYf5KJrz7EnBtOA8efe5w4od6wv1bmVMR7Y
	0ytucaPzok6gtuYcP2hzx2FjfDjUiCkEY07KwZy4cT1aW0JR692rlU4umqKwyIzPmSl7vD
	0KaWsxAX59a/IN2USDzNatyBDh4p0go=
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix OTP sysfs read and error
 handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAFXKEHb+D__WYugjdbqUSSnubfsOeibfH-Q33eJGjG3kvfndwg@mail.gmail.com>
Date: Mon, 16 Feb 2026 08:53:34 +0100
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 stable@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3F0A8DE-C8F4-4D45-B98D-60E896EFCEA2@linux.dev>
References: <20260215124125.465162-2-thorsten.blum@linux.dev>
 <CAFXKEHbCrp57ruvCF2TXXcnoJF93Z5bdUd7Nt5WtM9_abtc66w@mail.gmail.com>
 <2E9C85C9-AD05-4BB3-A945-5ADECCB5C7E4@linux.dev>
 <CAFXKEHb+D__WYugjdbqUSSnubfsOeibfH-Q33eJGjG3kvfndwg@mail.gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20909-lists,linux-crypto=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5632141630
X-Rspamd-Action: no action

On 16. Feb 2026, at 07:14, Lothar Rubusch wrote:
> [...]
>=20
> This would work. I'd squash this fixup together with the proposed
> patch and resubmit a fixed version.
>=20
> 8<-------------------------------------------------------------->8
> root@dut02:~/atsha204a-modif# insmod atmel-i2c.ko
> root@dut02:~/atsha204a-modif# insmod atmel-sha204a.ko
> root@dut02:~/atsha204a-modif# cat =
/sys/bus/i2c/devices/1-0064/atsha204a/otp
> =
0001ED86032D0002154C033750FFFFFF20B0F703DB0CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> 8<-------------------------------------------------------------->8

Thanks for verifying and testing. v2 can be found here:

=
https://lore.kernel.org/lkml/20260216074552.656814-1-thorsten.blum@linux.d=
ev/

Best,
Thorsten


