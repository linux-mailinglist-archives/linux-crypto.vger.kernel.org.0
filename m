Return-Path: <linux-crypto+bounces-23261-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBlqFt1o5mnBvwEAu9opvQ
	(envelope-from <linux-crypto+bounces-23261-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 19:56:45 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E84324E4
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 19:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0485531BB1FB
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182834FF54;
	Mon, 20 Apr 2026 16:35:17 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1F34DCEB;
	Mon, 20 Apr 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702917; cv=none; b=eU77FW6iLWR6YhSLvRbHXAZ1Krs3IiwPtIYAXA75neXjSu/n8iJqgK3OXLzs9eOx2Vdl2/+1Mfd38SCAFdLNSuuqDSUykm86OqgahvhyIq3TMs/lYZrMnSuc+6OyEpXCaaERXnlAxznvIoI6LnWkUiXmQrhCq34EkcO7wdYzYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702917; c=relaxed/simple;
	bh=1/iPn3iPrzTgb2spInQs33z8H+5LKdefDqGBLJORlDA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEp2b9+Bljl5IWVFaidgMf8qDYTaBXTnArHsV1F1V3BGsLd08Now8cGwX0F1WnjCVlEHDDk5TjUbA1ziwBrww35/WfPNmxlbxvV3+cYEHakiqk+ri0/hfaz3JhB7CkFKx0RZz248/+PUuP0skFFeUwXnIx6oSz3A+gSGbtJfM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wEraa-000000001CJ-002i;
	Mon, 20 Apr 2026 16:35:12 +0000
Date: Mon, 20 Apr 2026 17:35:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 2/3] dt-bindings: rng: mtk-rng: add SMC-based TRNG variants
Message-ID: <63aa9d62fef13e0991c17b16a836d8b5667aca96.1776702734.git.daniel@makrotopia.org>
References: <912fe579eccf577f3064b69d6c945e2c9087cab8.1776702734.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912fe579eccf577f3064b69d6c945e2c9087cab8.1776702734.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23261-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[selenic.com,gondor.apana.org.au,kernel.org,gmail.com,collabora.com,mediatek.com,makrotopia.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 4B3E84324E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add compatible strings for MediaTek SoCs where the hardware random number
generator is accessed via a vendor-defined Secure Monitor Call (SMC)
rather than direct MMIO register access:

  - mediatek,mt7981-rng
  - mediatek,mt7987-rng
  - mediatek,mt7988-rng

These variants require no reg, clocks, or clock-names properties since
the RNG hardware is managed by ARM Trusted Firmware-A.

Relax the $nodename pattern to also allow 'rng' in addition to the
existing 'rng@...' pattern.

Add a second example showing the minimal SMC variant binding.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * fix indentation in example

v3:
 * drop not: in compatible conditional
 * add reg/clocks/clock-names: false for mt7981-rng
 * add else: requiring reg/clocks/clock-names for others

v2: express compatibilities with fallback

 .../devicetree/bindings/rng/mtk-rng.yaml      | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
index 8f2f4c32a0cfc..38e67861b88fa 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
@@ -11,12 +11,13 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^rng@[0-9a-f]+$"
+    pattern: "^rng(@[0-9a-f]+)?$"
 
   compatible:
     oneOf:
       - enum:
           - mediatek,mt7623-rng
+          - mediatek,mt7981-rng
       - items:
           - enum:
               - mediatek,mt7622-rng
@@ -25,6 +26,11 @@ properties:
               - mediatek,mt8365-rng
               - mediatek,mt8516-rng
           - const: mediatek,mt7623-rng
+      - items:
+          - enum:
+              - mediatek,mt7987-rng
+              - mediatek,mt7988-rng
+          - const: mediatek,mt7981-rng
 
   reg:
     maxItems: 1
@@ -38,9 +44,23 @@ properties:
 
 required:
   - compatible
-  - reg
-  - clocks
-  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7981-rng
+    then:
+      properties:
+        reg: false
+        clocks: false
+        clock-names: false
+    else:
+      required:
+        - reg
+        - clocks
+        - clock-names
 
 additionalProperties: false
 
@@ -54,3 +74,7 @@ examples:
         clocks = <&infracfg CLK_INFRA_TRNG>;
         clock-names = "rng";
     };
+  - |
+    rng {
+        compatible = "mediatek,mt7981-rng";
+    };
-- 
2.53.0

