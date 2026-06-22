Return-Path: <linux-crypto+bounces-25292-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eeEFFKbbOGqkjAcAu9opvQ
	(envelope-from <linux-crypto+bounces-25292-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 08:52:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA56AD081
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 08:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=VyFQE5ka;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25292-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25292-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242FB302351F
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFD3603E8;
	Mon, 22 Jun 2026 06:52:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ADB35F5ED;
	Mon, 22 Jun 2026 06:52:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111136; cv=none; b=p3bSYocRuevCdyfd4meAmxThDYbT1yo1iiIENFX4QG19QhdE0LOH31U/TtCc19bwnY0J7hPxn6KmmUZUUb90aANxUw3UqTfaaSyfTvtKQH5v2BvMRjyFuu3fyZjDSik60u96NstRx9ZL5bIP0WuYL4SNtbkzAw8d9+alGwGBzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111136; c=relaxed/simple;
	bh=QyvI0n2sHD0cASMe1r9eJI/uz150HXGuI2lVG788SjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZnCT7oVR5LeXzrNlbU0VzjvCwbq7LBh0c3JIcu59FpWVWBkM2vlBzHroUjSYa2FiAEA23/dpdJKJWAURvHGnr0jJQ6mmXTO8/T7J7FbyDUkb2AjipaB47BkDlAWKp1+VGIVSiVSgBT0XlirR3C5MxvMnh8Ie5oi1WurocKbNLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyFQE5ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E41C2BCB4;
	Mon, 22 Jun 2026 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782111135;
	bh=QyvI0n2sHD0cASMe1r9eJI/uz150HXGuI2lVG788SjY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VyFQE5kaDCt6t17OcPnL58IO4fdiXV7qWzIV2y7C2dj6A111llfm+mmo1Gsx2vxhk
	 YUaOjZwbiQnHuxjMe7bB+akOw2x2NI5QcV0PgPzUqjx3cCJuCMvjPhKUBEV89t60mz
	 aeEkeGlMsblaI3YM/t5yt8ChGhWRMBRG7HwJecDYdz+lhZ2t7FUmZAhhZm0UbvcYUu
	 FMboo2ZjaAyvbqaCmgk9it+4GtzMmaDuKjHoIsDHjtAa3+5RpOEPeFZ31lGNPjXKFE
	 sYOZMnoGvtv/ZBemTIZoAW8OzAvQ/X2lmhQjWIxcMRTkrq15+eD7gEoFzbf5OuzjNC
	 8kv3UX998Oaug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC6CDB471;
	Mon, 22 Jun 2026 06:52:15 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 01:52:15 -0500
Subject: [PATCH v2] crypto: virtio - bound the akcipher result length
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-disp-3a2c09a8-v2-1-d1a809281db4@proton.me>
X-B4-Tracking: v=1; b=H4sIAJ7bOGoC/x3MQQqAIBBA0avErBuQsaS6SrQwHWs2FgoRiHdPW
 r7F/wUyJ+EMS1cg8SNZrthAfQfutPFgFN8MpMgoQ4T7gF7yjdqSU7OdcLS7Ys06ONLQsjtxkPd
 frlutH7isHnxiAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 linux-crypto@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782111134; l=2094;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=/OPWzrjXfFujjZLqunAHnLbL2LVmSG6t3fb7rk8J+BI=;
 b=oq9Ln5r7vfpEZgRRYFw+5fqFQ0KvggRq+d57Orp3STFjRptIBmAxk6A/ugfhFiKcn7hU+9kf7
 YQk10pUNBgHDnVNuvNgQLg/4jqgbJ/WUb1uX8sPb1ndr5xJFBtVYxUC
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25292-lists,linux-crypto=lfdr.de,hexlabsecurity.proton.me];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:arei.gonglei@huawei.com,m:jasowang@redhat.com,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:replyto,proton.me:email,proton.me:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DBA56AD081

From: Bryam Vargas <hexlabsecurity@proton.me>

virtio_crypto_dataq_akcipher_callback() sets the result length from the
device-reported response length without bounding it to the destination
buffer, which was allocated for the original request length.
sg_copy_from_buffer() then reads that many bytes from the destination
buffer; a backend reporting a larger length over-reads adjacent kernel
heap into the caller's scatterlist (an out-of-bounds read).

Clamp the reported length to the originally requested destination length.
A conforming device reports no more than that, so valid results are
unaffected.

Fixes: a36bd0ad9fbf ("virtio-crypto: adjust dst_len at ops callback")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: Fix the Subject line, mangled in v1 - an over-long subject was wrapped
    and its trailing word leaked into the commit body. No functional change.

Link to v1: https://lore.kernel.org/all/20260620-b4-disp-27caeeac-v1-1-956e8f9c4f01@proton.me/
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index d8d452cac391..64ea141f018c 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -88,7 +88,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	/* actual length may be less than dst buffer */
-	akcipher_req->dst_len = len - sizeof(vc_req->status);
+	akcipher_req->dst_len = min_t(unsigned int, len - sizeof(vc_req->status),
+				      akcipher_req->dst_len);
 	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);

---
base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
change-id: 20260622-b4-disp-3a2c09a8-5ab0e3e3fc23

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



