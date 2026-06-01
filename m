Return-Path: <linux-crypto+bounces-24784-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P+iNjpQHWooYwkAu9opvQ
	(envelope-from <linux-crypto+bounces-24784-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 11:26:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1861C646
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D523065DE7
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B638F935;
	Mon,  1 Jun 2026 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h4w/9QSv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B32201004
	for <linux-crypto@vger.kernel.org>; Mon,  1 Jun 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305487; cv=none; b=JFoJxZHoMfcuO0eXtC+5Fozqb9NCqGBqp1DeRNGM1LEaapxfHOYUNm2x+TI7aqt32qOxJiOLKoXwT1iRooaRcWOZ3XmFzA+t7jq3SCdRyXaBQYFX6gBXeRBt2NPhwtkob+X4BP8zcQU91gXxOajuQYJ4kb0MDGeh5JwfkkPBuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305487; c=relaxed/simple;
	bh=j/gvaqYS1F/8rzBxer7eqfUq1FJ5JDJr4LyygljEqNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nGyVTSQxF2+hrGWm1bZmFS+JWRUkHWdKCsVD7tWvOTc0rIXClfZGHX8upYFTaSc9JT6ZCk+OgOIRKqeHQvNlZdR7qdZZK5iKPxuZe4MbMsCeFNyNi/WOkm3fBKULxLeTBNHwMtJzsUBtjrwQtnSa6MFRz7wyrrTiCdGOMQ/bCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h4w/9QSv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 788D24E42DD1;
	Mon,  1 Jun 2026 09:18:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 483AC602AB;
	Mon,  1 Jun 2026 09:18:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 044B7108881A3;
	Mon,  1 Jun 2026 11:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780305480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9wm/CqkWxiyphbpZmHCocTiGIxjyJmn0FoTfyyyYf9c=;
	b=h4w/9QSv8y8Mho4GFBImGv4iVg+lPXv1qQuwjm4sOrMhx91sIUeKJsAoRvFQB35ICvzZaT
	mzzjEAeAbo4IMcIyu6MkqoKGQYejLK8AVQXq7Y0Cqtg8+wMiT1Do79QPL9SOnSYi9r734z
	tNrhMzxubIg7dDRCEOEEuipa/zhk12+bv2nsDkYOULWY3jLGuUoku9tfmn2IAjQDioQbIo
	x1Qzd3Eb/+Uf/4274AshtPt80twMyaM63HniNl5VRiH675Qf91/yID/9s/Tuns1VspOPc5
	vNdGF9QIJBjAq8WG1GaeyrBh/MhU+GEUxvYvF2UToDVGJJA0VwdGOAKYtzDlWA==
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 11:17:53 +0200
Message-Id: <DIXLMBNKMF1N.2FVTXFA6MP1NF@bootlin.com>
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Herve Codina"
 <herve.codina@bootlin.com>, <linux-crypto@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/29] crypto: talitos - Driver cleanup
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <1488f7b3-cda0-4267-827c-fae23b17c1e8@kernel.org>
In-Reply-To: <1488f7b3-cda0-4267-827c-fae23b17c1e8@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24784-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DC1861C646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>> The Freescale Integrated Security Engine (SEC) aka "Talitos" driver
>> implementation is a monolithic ~3800-line file that mixes SEC1 and SEC2
>> hardware variants with hash, skcipher, aead and hwrng algorithm.
>>=20
>> This series reorganises the driver to improve readability and
>> maintainability.
>
> Did you analyse the cost of this series ? bloat-o-meter gives the=20
> following result, allthough I'm a bit surprised there are only added=20
> items, no removed items:

When you say 'cost', do you mean cost in terms of code size ? performance c=
ost ?
or both ?
Regarding code size, I trusted the differences shown in the cover letter by=
 git:

> 13 files changed, 3810 insertions(+), 3707 deletions(-)

There is 103 insertions more than deletions. This is due to the fact that
splitting up SEC1/SEC2 code requires additional function and structures.
I find it acceptable given the readability improvement.

As for performance, I ran ftrace with the function graph tracer, hashing a =
100kb
file.

Without the series applied:

be935f36ae14489758e28a83cfec418d3ad600b64628166f275c7ae6aac7b9af  ./test_10=
0k.bin
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0) + 20.256 us   |  ahash_init();
 0)               |  ahash_do_req_chain() {
 0)               |    ahash_update() {
 0) + 41.088 us   |      ahash_process_req();
 0) + 54.272 us   |    }
 0) + 61.536 us   |  }
 ------------------------------------------
 0)  sha256s-196   =3D>    <idle>-0  =20
 ------------------------------------------

 0) + 45.248 us   |  ahash_done();
 ------------------------------------------
 0)    <idle>-0    =3D>  sha256s-196 =20
 ------------------------------------------

 0)               |  ahash_do_req_chain() {
 0)               |    ahash_update() {
 0) + 39.552 us   |      ahash_process_req();
 0) + 53.472 us   |    }
 0) + 68.576 us   |  }
 ------------------------------------------
 0)  sha256s-196   =3D>    <idle>-0  =20
 ------------------------------------------

 0) + 39.680 us   |  ahash_done();
 ------------------------------------------
 0)    <idle>-0    =3D>  sha256s-196 =20
 ------------------------------------------

 0)               |  ahash_do_req_chain() {
 0)               |    ahash_finup() {
 0)               |      ahash_process_req() {
 0) + 16.800 us   |        ahash_done();
 0) + 96.192 us   |      }
 0) ! 103.616 us  |    }
 0) ! 121.344 us  |  }

With the series applied:

be935f36ae14489758e28a83cfec418d3ad600b64628166f275c7ae6aac7b9af  ./test_10=
0k.bin
# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0) + 20.576 us   |  ahash_init();
 0)               |  ahash_do_req_chain() {
 0)               |    ahash_update() {
 0) + 32.896 us   |      ahash_process_req();
 0) + 46.688 us   |    }
 0) + 54.016 us   |  }
 ------------------------------------------
 0)  sha256s-196   =3D>    <idle>-0  =20
 ------------------------------------------

 0)               |  ahash_done() {
 0)               |    ahash_update_done() {
 0)   9.312 us    |      ahash_update_finish();
 0) + 44.416 us   |    }
 0) + 73.216 us   |  }
 ------------------------------------------
 0)    <idle>-0    =3D>  sha256s-196 =20
 ------------------------------------------

 0)               |  ahash_do_req_chain() {
 0)               |    ahash_update() {
 0) + 33.120 us   |      ahash_process_req();
 0) + 46.912 us   |    }
 0) + 61.664 us   |  }
 ------------------------------------------
 0)  sha256s-196   =3D>    <idle>-0  =20
 ------------------------------------------

 0)               |  ahash_done() {
 0)               |    ahash_update_done() {
 0)   8.928 us    |      ahash_update_finish();
 0) + 42.720 us   |    }
 0) + 69.440 us   |  }
 ------------------------------------------
 0)    <idle>-0    =3D>  sha256s-196 =20
 ------------------------------------------

 0)               |  ahash_do_req_chain() {
 0)               |    ahash_finup() {
 0)               |      ahash_process_req() {
 0)               |        ahash_done() {
 0)   5.696 us    |          ahash_finup_done();
 0) + 29.760 us   |        }
 0) ! 107.168 us  |      }
 0) ! 113.696 us  |    }
 0) ! 131.840 us  |  }

It looks like there is a slight performance penalty with ahash_finup().
Otherwise, there is a slight performance improvement for the other measurem=
ents.
I do not know if there is a better way to measure the performance impact of=
 this
series. If you know, do not hesitate to share it to me.


Best regards,
Paul.

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


