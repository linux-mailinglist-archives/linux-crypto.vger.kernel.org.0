Return-Path: <linux-crypto+bounces-21524-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGXZFoUup2nlfgAAu9opvQ
	(envelope-from <linux-crypto+bounces-21524-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:55:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 006471F584C
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2820B302DABF
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB62F690F;
	Tue,  3 Mar 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RZ0+TCdY"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989523A5E75
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564099; cv=none; b=GHPDxGvfzWi0oQ8qlR6zGgKnArcJb5zOF97gwnltlZwDQ5+JDj/KJ2uSEKukSRZpFbd7muGSYZuQousOt02lmZgDS9kNKjR8YB0UViYk7pXwcLAqJwS5ssKOJABYfTO9cJoT5DjPIBQu0CM/pqP1ibLwUFi8xapK3lI691ocuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564099; c=relaxed/simple;
	bh=TOindIGzZKxIs2LOXvCcEzadt2uDTnIUZ8L3R0dvn5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNvm7ruTPT6UiMsKacfF0OHLlB66S8mB4pFAROIcLjKGohVBa06HT9RdrBk2l7D7rLtqoa9VGENa3gngtFWjRE/fuWHKMqOLee7EgvYkyBP+oDfW5TqbwlTqdDb/aoAVeVHYSOtncFwCchGJsEdqIiExQBWZ3bsvHX8QVN+YTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RZ0+TCdY; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 41929 invoked from network); 3 Mar 2026 19:54:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1772564093; bh=n4z6FdYhYaFqV+h14J68jBQV7uz/eMFVd1la7jJI9Rk=;
          h=From:To:Cc:Subject;
          b=RZ0+TCdY33t4IZsm9S44lHbyCE7C9ekSDNPvB61rNzz4EvBI7OXSSNDg/h7P638cj
           94/2JSrimDIAJR3yILSpIStygYCOCcCnWceWxnU04ni4EmyR9Eui5qBA8ComSVkZ0T
           Bk6IlPH8+/Pxm7urQkxkFlEpRkhkUEyleuj008i3Yry9qCyx5pcbJHfRpXiyh9rD5l
           geWBknao5EEX6LAXCOWoWcqWyNGvqeUFb9hVaA5rrOYuWf1ch3GBO34yBVgVC9WlLA
           POouYUtmBF9lsiGlOx33CH5aqDlkhwwbxbiBkMEJWKiSSFsuPxbOtrnLtuILGSDy/Q
           x3RANrXvQwE3w==
Received: from 83.24.116.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.116.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <herbert@gondor.apana.org.au>; 3 Mar 2026 19:54:53 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	atenart@kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v3 1/2] dt-bindings: crypto: inside-secure,safexcel: add compatible for MT7981
Date: Tue,  3 Mar 2026 19:53:49 +0100
Message-ID: <20260303185451.70794-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 312696ebf01c215835820228deefb2c6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [oNOx]                               
X-Rspamd-Queue-Id: 006471F584C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[wp.pl];
	TAGGED_FROM(0.00)[bounces-21524-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[wp.pl];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:dkim,wp.pl:email,wp.pl:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,collabora.com:email]
X-Rspamd-Action: no action

The MT7981 as well as the MT7986 have a built-in EIP-97 crypto accelerator.
This commit adds a compatible string for MT7981.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v3:
- drop oneOf
v2:
- just add compatible strings
---
 .../devicetree/bindings/crypto/inside-secure,safexcel.yaml   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/inside-secure,safexcel.yaml b/Documentation/devicetree/bindings/crypto/inside-secure,safexcel.yaml
index 3dc6c5f89d32..a34d13e92c59 100644
--- a/Documentation/devicetree/bindings/crypto/inside-secure,safexcel.yaml
+++ b/Documentation/devicetree/bindings/crypto/inside-secure,safexcel.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - marvell,armada-3700-crypto
+              - mediatek,mt7981-crypto
               - mediatek,mt7986-crypto
           - const: inside-secure,safexcel-eip97ies
       - const: inside-secure,safexcel-eip197b
@@ -80,7 +81,9 @@ allOf:
         compatible:
           not:
             contains:
-              const: mediatek,mt7986-crypto
+              enum:
+                - mediatek,mt7981-crypto
+                - mediatek,mt7986-crypto
     then:
       properties:
         interrupts:
-- 
2.47.3


