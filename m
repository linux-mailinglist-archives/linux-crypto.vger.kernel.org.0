Return-Path: <linux-crypto+bounces-25831-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EEFiDQQ4UWqoAwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25831-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 20:20:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C573D4C3
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 20:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=vdwF9NwG;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25831-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25831-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069903013B5E
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58935DA40;
	Fri, 10 Jul 2026 18:20:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D02DAFAF
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 18:20:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707646; cv=none; b=ulzzSW+aZ4AG+nFvurf0jQG8WiDsSlOxovw3EovumFc3AAS6TSToiAOa07CAolVIGIN4PhsnWpELtZJ69lmg7XTMt240s7tm1oOAXp2aAGGghQdw7oBCw3BxzboI236zLR4hh3VcUNwe9d/HG738FvQayPTwB0XFPm9u2lf13b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707646; c=relaxed/simple;
	bh=NozzP4WIU6ME+FJLjKVkAfBhlev+BMMNfGoR638Y1cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZ/uABs2B7gDOzOVsu1/CNJldo1ANaTm0DEq2l1XdFpmnJKE8YCpZfuU1Pw1PJ4JD5X4M5upj0LM+D7FraVdt5ddXJipckqqGJhhONe7pybMJd6gsRRXIIKN92YjElHzFNkTnNsTqJoeUzbdB6RccnLnaycfrt7r5zDW4kTuWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vdwF9NwG; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 502A81A0F47;
	Fri, 10 Jul 2026 18:20:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D9B560342;
	Fri, 10 Jul 2026 18:20:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DDC111BD2C1A;
	Fri, 10 Jul 2026 20:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783707642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hOZVc+0GwZ0qgc1rGj8TAPqIGL8UuZAY2qhVTxtTUTY=;
	b=vdwF9NwGG4UuqwdQrfkX5ygqUb7Wk+h2pfSv9JAdH864Ddep7rOuSQeSHc816l5Z4jR0ZC
	fAL0mJBi72dhZoZWv6e5UoTStWrq+BpSmt9NoZEcdRYJFv0G8RmoG/ZlaB1rvvZU64K2uA
	XQRJ8Vi4BftZfTYQdgzAXj3FMd/4B2g2Y6VJNuZFkj+NNWu3LuGx5ttTS219LR5yZ9+CwW
	vssoyUobX+N0I/mK39LO9dGljoOCh/ih2qh6AGDNrQItJuFcJvYhIm7hKi9xRbJzkL/uLs
	JXWOV/tx8YxbbLcgVAtVHVDKgm+fMQ3rgbpO0FiYLkdN/EPQKWA3tUZNdo/ulA==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 10 Jul 2026 20:20:32 +0200
Subject: [PATCH v2 1/2] dt-bindings: rng: Rename the title of the EIP-76
 file
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-1-4eab557b0e70@bootlin.com>
References: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-0-4eab557b0e70@bootlin.com>
In-Reply-To: <20260710-schneider-v7-2-rc1-eip76-upstream-v2-0-4eab557b0e70@bootlin.com>
To: Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25831-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:j-choudhary@ti.com,m:thomas.petazzoni@bootlin.com,m:pascal.eberhard@se.com,m:wsa+renesas@sang-engineering.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miquel.raynal@bootlin.com,m:krzk@kernel.org,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 928C573D4C3

Be a little more precise in the title by giving the family name and the
own name of the hardware block. Despite the original compatibles, this
file describes a SafeXcel EIP-76 hardware random number generator.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/rng/inside-secure,safexcel-eip76.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/inside-secure,safexcel-eip76.yaml b/Documentation/devicetree/bindings/rng/inside-secure,safexcel-eip76.yaml
index f501fc7691c6..92d906998211 100644
--- a/Documentation/devicetree/bindings/rng/inside-secure,safexcel-eip76.yaml
+++ b/Documentation/devicetree/bindings/rng/inside-secure,safexcel-eip76.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rng/inside-secure,safexcel-eip76.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Inside-Secure HWRNG Module
+title: Inside-Secure SafeXcel EIP-76 HWRNG Module
 
 maintainers:
   - Jayesh Choudhary <j-choudhary@ti.com>

-- 
2.54.0


