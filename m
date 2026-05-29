Return-Path: <linux-crypto+bounces-24718-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBi7I3zBGWqGywgAu9opvQ
	(envelope-from <linux-crypto+bounces-24718-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 18:40:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8436605CA2
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08D83220F09
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8B359A66;
	Fri, 29 May 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="VDZ+Mibz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08863D1A97;
	Fri, 29 May 2026 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069852; cv=none; b=PeEQJeMs4ALPf/k7GSZnSF9I4wp2l9t7xG8iYSTr+sI+7s/WdmxF8YZ8KpJFRAos7DlSG4/Vy50sZiZRglToxQg43p/p8ijWxV0qcaJGUVSvgfqpoSxWZQUDh4auD78bsTjqSPcTGsDjNFKbjopbqCCUV3QwbsKCpSv4NkM8Kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069852; c=relaxed/simple;
	bh=SjcJryr33uIhZxUinLbLFv9BZ+5skmOnZPbvt/KLvHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0BqSqBcN50+QrH520Hry/M3LhNQ6L9E7LSiTAXqwd8ON13zzMantt8dZgT76Pi/Qn+/EGIapsuAJElNw/AXgKmwfc+YD5OYG/WWuaiiIz1E+F/dBJjCMoix/VPi0UPl53nEdO5rc/UBV1e3aH9iZhIMSgUanoZJvM7jOcmEANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=VDZ+Mibz; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1780069841;
	bh=SjcJryr33uIhZxUinLbLFv9BZ+5skmOnZPbvt/KLvHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=VDZ+MibzE28FkttrrfLf6qavJB4TW8ix3yZIq0B77mG0lk8pjdpelLuCxXy8mWmAt
	 rvNhcKXDBQ8zFClGf17fqwKZzwN9E2EDIhXHaD6FDvo40q55TpC1IYeRQuoat2UXwa
	 u4WpT81SqppABYiHc5Px/GykUj/i3oCXiMUHVGGSF66D5q+AbKyw05aKyi2RmLz7ZQ
	 CCn3TqtUcwT8lyKjpGHJgycAdMCEtk/ywGw2tSC36b1Lm/TFQU4fNUpQ1KbIhoGKey
	 CNe/FLIftHDJ5BaItmgUTVYf80i4B+aa58UzQ0UUI1gZg8sP7KbM+yx3p8dXeOkGD/
	 xZ0aA0dx1dYB0o/EDtphJcumlaHq4ANWDQDwfiqyrctbpZfe8vGYix7v2yTuB6BYKf
	 o5S9aqGiLDqjE6FEj3h8vtAcg+eR6QwGwIum2sW6KLBhhloR+5DvNCFCHmWcHiupSw
	 KAnw8QTT5DKzmF0JmjjNxsk4fRnc8M6t7oHMKywGq1nK8PyoLCvAJgOG88jg0LL9fP
	 cZpVDrp06cxz98dIvUOaj66CYx7V/Y0Z0Lp42n5oz9wQySUEW+Lh54JB/6oV/Kv54c
	 Wf7fVodG41epV/EdNsYVZ9qgMDOJfKgqEopMWEqirybn+/OdwTuGUdwoemouyF1/Lw
	 glhYraFQ73vx+0rgAZ8kDobE=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Fri, 29 May 2026 18:50:26 +0300
Subject: [PATCH 1/2] rust/bindings: add hw_random.h
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-rust-hw_random-virtio-rng-v1-1-b3153dd90311@pitsidianak.is>
References: <20260529-rust-hw_random-virtio-rng-v1-0-b3153dd90311@pitsidianak.is>
In-Reply-To: <20260529-rust-hw_random-virtio-rng-v1-0-b3153dd90311@pitsidianak.is>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, manos.pitsidianakis@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=SjcJryr33uIhZxUinLbLFv9BZ+5skmOnZPbvt/KLvHg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFHYlhNMVJnMU0wMjM5cWcxTjNYVi9nR3BqcnNzCkdKcFNJR1B6bDY2YXlmQmZH
 bktKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWhtMXpBQUt
 DUkIzS2Nkd2YzNEowTWxkRC85ZzJ2RkFhUUM4WSs1b2tJVDY3ZHBwUWg4bUVhVGp3Sll4VXczUw
 pyMkJjT0R1Nk9BbWVTdGFnYVFnYU9HQyt1NXMzMnl6eWxHcjlWUWNrZXJOSkVEOWZISlZTL3RRO
 UFtUURYZ1RaCmhsN2xWQzFZZit3aE5JNHlldksrUWtpMkplK3lBUkZDREdGUU1YV2FFOHp6dHkw
 RUZuK0R5NEhYVzBNZXA3ZGIKZXVOVXBpR3FHNWR5bGZnTVpoM3NySG5nVUZVblpHVEpnZUFjam5
 5dHZRcHJzRmJPTEUwT1BvSlF6WElTcVFBcApEV0p4cnhtMk5FLzVKN1RXVVdwK3NZN3VIOWx0bX
 NKUmxlbG5PMjlWWFlaL2c5MTZ4cm9TQkRLdnV5UzVpanRsCmh4aGR1VUNwNFJxNCtiaHdRazkyT
 TlMMERGMFM1aGlMMlNSWlA4elRFY3NZaUFwdnI1K3ZXUy9tVHlncTdWdFAKM1NRdDBYVG82NUt3
 SkFsWjgwdGl4R01yQWFUdkxtckh0aGk3dXRPS01vTGZHa0g1RFlIcmIvd1RMM0ZRUGswSgoyREF
 YL3Y4RHJ6YlNQQ2hGQTd5N2VhZExYYzhvKytCSUFNSXFTYTlWZit5WmU3Q0E0clkrY0VHMHgwZU
 1sQ3oyClhXOUR3Q1NqR2NOL0ZpQVBuTHdyWmN4U1FyV2doanlMcmtMSXhXeHlIZDNmK2VMc3dFY
 2d4SXV4OGdJRk5kWXQKb1BSU3MwSHQydk9NWGtmcEVxV2dWUHJzSG5LUFNQY1VZbUdsTEpkOGov
 VDBMOVF1ZjJ1MVFvdXUwZ3pqcnBoKwoycDU0N2xNOFM5b2Z5SnhmSkZZR0xQQ1BIU2paTGVIc20
 xVWZXOGtzNWwzSGZrSWdkK0NzREpOckdDN3dOdndICkUwd0xNZz09Cj1VWGw3Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pitsidianak.is,none];
	R_DKIM_ALLOW(-0.20)[pitsidianak.is:s=mailSelector];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gondor.apana.org.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24718-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manos@pitsidianak.is,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[pitsidianak.is:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pitsidianak.is:email,pitsidianak.is:mid,pitsidianak.is:dkim]
X-Rspamd-Queue-Id: E8436605CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Generate bindings for include/linux/hw_random.h.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3c8b897041bcef879edefdfb9627ca9cafe90e93..40731a278c1759f2658d04438d051169d074a1ac 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -60,6 +60,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/hw_random.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>

-- 
2.47.3


