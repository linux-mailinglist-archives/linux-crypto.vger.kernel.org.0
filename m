Return-Path: <linux-crypto+bounces-22581-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIduGYhSymnQ7gUAu9opvQ
	(envelope-from <linux-crypto+bounces-22581-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 12:38:00 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D63597B8
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 12:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93FF53009F38
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135393B583C;
	Mon, 30 Mar 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jo460ajS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC93B6BEB
	for <linux-crypto@vger.kernel.org>; Mon, 30 Mar 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866508; cv=none; b=bRyjtqu5meei7JqhV+WgmbCQ09rpOQ3csVzZZfgcXsapFifIcmKIL3It+WWY22feZmrRkFxDNLHPglUUbcufXyQi+ivDeC86/LVutsZoZmuwKesn1/dH4rPSE+0kh2NzKJ8S/LnuYJRRpJIVtxJf4VL0wo0CjUa6xfLug6oV/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866508; c=relaxed/simple;
	bh=RS385VPDleBfp1bmhBrra0A0DkwvGMLnN++JSJ10NTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfItOTmbxv4PZXQ4uPNIYLzTp0G61b/+Eldq12M6wp/5C4tF2HIdCFNKROzMD4vEKE/BPMCmQHYJx5I9igOiqrv6euIUs9hGcvyFy3HkyzemeSJpIeBF8rDJWeFDUYW8Zdgi4i2t8djRV1kWlGHRcl+sLhlvRHluPEihysQGJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jo460ajS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A89254E42866;
	Mon, 30 Mar 2026 10:28:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5EAB85FFA8;
	Mon, 30 Mar 2026 10:28:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EB1D10450601;
	Mon, 30 Mar 2026 12:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774866504; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5RqGKX5OEOPSMRA6JcG3jBau2b2QXhFOzsKnGj4WdfI=;
	b=jo460ajSdk6xjufaXRzXewidZKJg5dEfjTkYw+0T+CgS07pmhbg+HJZK32nuI/28HJlUkQ
	YeWiSDwmXyTNefHT2DLBrp9pweWWBwzDVmBdCwVbW4EoXjcgSaINBPumlYZeF8MSo2o4Z4
	gdhg4LYT5nj6mGQt8kHWSXljuSOQiJ/nXMy7GVIzkDsJX8r/pFQdysdeS/IqOUEzxMojDu
	CJlM4gd+aqS0oFzrqv7qlgJt90HiaxGPDmJCtpJkFyWqrsvMpjWArT4BLBbMTf3jfKEGVR
	l1nOQx02Hl4/EyPIiTreCTCTMip6GAts5afBcibtD97r2Kklj4kMO/ZvyU/R9Q==
From: Paul Louvel <paul.louvel@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	David Howells <dhowells@redhat.com>
Cc: Paul Louvel <paul.louvel@bootlin.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] talitos SEC1 ahash 32k request limitation
Date: Mon, 30 Mar 2026 12:28:17 +0200
Message-ID: <20260330102820.29914-1-paul.louvel@bootlin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22581-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: D27D63597B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The first patch fixes the ahash request size limitation of 32k in the
talitos driver. This limitation is due to the fact that the driver was
using a single descriptor for the whole request, which is not enough to
handle larger requests. A change in the crypto core introduced the
regression. The patches split the request into multiple descriptors if
needed, allowing to handle requests larger than 32k.

The second patch is just cosmetic changes in order to make the code more
readable and consistent with the fix.

Thank you,
Paul.

Paul Louvel (2):
  crypto: talitos - fix SEC1 32k ahash request limitation
  crypto: talitos - rename first/last to first_desc/last_desc

 drivers/crypto/talitos.c | 254 +++++++++++++++++++++++++--------------
 1 file changed, 166 insertions(+), 88 deletions(-)

-- 
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


