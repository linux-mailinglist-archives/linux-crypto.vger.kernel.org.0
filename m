Return-Path: <linux-crypto+bounces-21525-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG4bFKgup2nzfgAAu9opvQ
	(envelope-from <linux-crypto+bounces-21525-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:55:36 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF11F587B
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 19:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47583063B7E
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA943EF0BF;
	Tue,  3 Mar 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="daMJGcVP"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E237EFED
	for <linux-crypto@vger.kernel.org>; Tue,  3 Mar 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564100; cv=none; b=QSUVxNv2wyZIsj3LNNQWSgJPUQ24ILZQPQwk9vFNfWa8W8E500YNokXPWtbBw8nAuPVXXA+tkvvn5TDf9wGA9WQEIS9RHwhxQ5J3FyZYB8IYdFhvTrjy8szMEM5lG5Aayjdwr1q7DkoA6edoRRKE7+8A3zyu5VgxiHe15+wZnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564100; c=relaxed/simple;
	bh=+B9N9a0VNwBhIQZAxT1kIzubVJvqrzU0XbMlVw4a2PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4dORr0DT5DTTw12ZXJAVCuSo0Y7PXzEMSx8bcSfrK2ZBSC5DFSL6KuVEupUDj4mFwZt3BH+YzFtP27uU+/J12ckEOeREkGUn/jGBvpRAQAw7dLt1Tl92HxtExQUJdQmTnx8Ts7lkp/rE2YElbew3T03heXR6vtIomByTS/JKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=daMJGcVP; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 46139 invoked from network); 3 Mar 2026 19:54:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1772564095; bh=zwh2kADgvZw65MCFoX1HtfudMZcZ5wfa9E3f2CLwDlw=;
          h=From:To:Cc:Subject;
          b=daMJGcVPw90CcQ/NtdndGOIiXDQQSp29B3g2jgQuGq4+gLKGJS6z+JKAuEicI/Yuf
           zZl1EYiCUeVuvLSfk8FCwapvNdslHaxpqCCMeYAngPIMLm0UuBYIIvzevKl4yQsarf
           ltHUismVs9QYyC6mBzs+Yb6w2MKHFjs5k6lLZqpYOcYhmQCgjW6rghMDeSYtZ0h9GH
           zy4nWiJLdAysZoFhBicSpoXFyEBGOZuscsU2P6w+EMfY/WPUNXuKiFzhmvFCVPKjfM
           DQNtSn//dBqzyWt/meBBjGmaw7mIHxRZ/KKYJN2XWVi4UnWfVH6qqC0+pRLBxm1dvB
           Bpqpyzl46Q8NQ==
Received: from 83.24.116.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.116.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <herbert@gondor.apana.org.au>; 3 Mar 2026 19:54:55 +0100
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
Subject: [PATCH v3 2/2] arm64: dts: mediatek: add crypto offload support on MT7981
Date: Tue,  3 Mar 2026 19:53:50 +0100
Message-ID: <20260303185451.70794-2-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303185451.70794-1-olek2@wp.pl>
References: <20260303185451.70794-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: b80b92edaf8e041f5f39b6bc99eed231
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [gLPh]                               
X-Rspamd-Queue-Id: A6AF11F587B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-crypto=lfdr.de];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	DBL_PROHIBIT(0.00)[0.157.120.128:email,0.167.224.144:email];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:dkim,wp.pl:email,wp.pl:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.153.167.240:email,collabora.com:email]
X-Rspamd-Action: no action

The MT7981 as well as the MT7986 have a built-in EIP-97 crypto accelerator.
This commit adds the missing entry in the dts.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 4084f4dfa3e5..94c7bf0050fc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -150,6 +150,21 @@ sgmiisys1: syscon@10070000 {
 			#clock-cells = <1>;
 		};
 
+		crypto@10320000 {
+			compatible = "mediatek,mt7981-crypto",
+				"inside-secure,safexcel-eip97ies";
+			reg = <0 0x10320000 0 0x40000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3";
+			clocks = <&topckgen CLK_TOP_EIP97B>;
+			clock-names = "core";
+			assigned-clocks = <&topckgen CLK_TOP_EIP97B_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_NET1_D5>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
-- 
2.47.3


