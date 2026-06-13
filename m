Return-Path: <linux-crypto+bounces-25112-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7SQQKeQbLWrFbgQAu9opvQ
	(envelope-from <linux-crypto+bounces-25112-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Jun 2026 10:59:16 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C767E2EA
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Jun 2026 10:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=epo6qyN8;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25112-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25112-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6E630221F0
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Jun 2026 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCD399352;
	Sat, 13 Jun 2026 08:59:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9CE38E8C9
	for <linux-crypto@vger.kernel.org>; Sat, 13 Jun 2026 08:59:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341153; cv=none; b=qdbD06Q4hvIpFkMlnwtl6rJM5S5wO4reX6WAr+xc97YC+m05HyrTIOldNV1opfNObe5QfKodtUWjV8tUrvvFq6eGiqT0cGAEoc7OvewVEG4ZqfGg0ldc9qFT9nX0NEekobpIazM2PgLRACn5KW0xUU3VdGjR/DmPZ/DWc+EWxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341153; c=relaxed/simple;
	bh=00clscMus6r7SEHDxIAWGdr/EK2RPZmGO8KjEBtp9RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAlPdGJwTBfWi5Lw0h3w9gE6AKKhyh4QewuwTXJ0npf8UtoAGqZkaH7Fw2iiuF6cLoBY53h75nRD/c0Mq15Mgg4tM24ZzOPBUaKN8pcwX9iHbzCR3Pv6fmkeMdCVYy0oo8+LldqHoXZhj6FRYaHgbRB/rYENsZGQ/6nNdGNHV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epo6qyN8; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b613a17bso14792645e9.3
        for <linux-crypto@vger.kernel.org>; Sat, 13 Jun 2026 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781341149; x=1781945949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIbL4P1VbZmrGr/aVmx2oP8ImiTJmIIkN72TtfvPmNk=;
        b=epo6qyN8oU+51ORAgiiTONSRkvYxV5GklSAsL17j6Kr01/GBlmVl1dGA1ElLs6jy6c
         1uVuw8/ca8SxP4UFPl63sfL5yKf5Vjs9v0+SYbPaqZUlW9k1sYZ+dDl9Y+p1b+yEfj+U
         sxa1d5U6Sgq6fqjHqMpwGs+2ggRsjC9fLcHn+n6pXQZZLPdPKd36htPR7R092nJa/ldy
         VS871HKVn2/BshP9pMKEZ4XHdQ9dkQ4i5aEJUMS3R0Tw+dvzxRza2Czcdu12wn6d9aF/
         Gol/XTSeUG25YFgPyhbi5mv7oqIVQAJwGcf5LdynU+qRscz9XQhqTEbhMO99qSAhQRvC
         +JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781341149; x=1781945949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIbL4P1VbZmrGr/aVmx2oP8ImiTJmIIkN72TtfvPmNk=;
        b=JX01ix9bYTAgPoz0CM1JxNv7QvBXk/JyF/VSASgEimHn764libJwg5zR599XnM6LrZ
         0CawljTShqxiFAoyOAh4uPvGSdI5PM+U2fcdCvQJThQyIMFF5uPXQXD9ij7Vb7+yg7KH
         KBXWexBHoeHN/bGx72ksNnHYBw79oO0NOezi1OZQkKw/Eq1jTBuAUo5F0TyJLuwF48ui
         5q6Nei2eKaWVY6B92DQp3SuRKmfgt8sYz/WziKv+xtmmgx3Ulzkm0EOKWbLuJw4ydnpG
         KB5U+eZwHHxGv+jGI+uVVvAxIXENtGIuw3VMderzJlBsW1nNoPkJSSAJ/XaUUGzXpbYY
         uZVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vg0JLHeuMTjc6XYDXJb/DK3Fv/IBw76uMzeMabXtOKY7OjdDnFK3nIwKRm/uT2P+mmtfj94MJL9opbi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFlYby1W+ukH1CYiyl5ENan6q6dy7x/OccV/GTzsycd+1hXoi
	0djF6+P+AZvxEYuFarQTNYxdPwwU80jPFWjobnOC+YQr00osAo6PEb8/
X-Gm-Gg: Acq92OGEacXpmdKd+6D7/B1tor34ciXPIa64rgVSPfAVVnrYDbKgsYDZeOWcbiZ3qaH
	xt/hkdFu+QjurYHDGz9iBaW5vVw7/HlAM5EK0qo8T82P3Ca16uAzXHRBrf5FgFVz+X/6rc4PQ8C
	SeYWK9HRBNa/XkTPqcvEQYwpf3ON45sQOd8hL9K9BVldTKLvcnxqD7eakY1CTOMIAZXjZiZ32aj
	MKY9UcYtttLIVTqlG+9MLJJ8LulfEwbgSBfz7Nr5Yq7WGPFTr2YGb/o4J1/MSmAAJZjV+vrTIot
	Ag2C4bBkCpO6lrQokzhycutD+RzSszh1POTvx5/uG7ljTgbbkEYPe/NoG2GKA6A/ckjM4x8+IGT
	YKcXAvWM52XVZkJgvM7TEfvz3X2DW61jCRdT9OHcTgaSEWTTQnYAg213ayl1ZxZNZ2G+bOqRX2r
	n2WA4fnhmLE97nhMYBGfk75wSHvqxyA1GUGRwTcM5DAE0zUv2c4n3B5g0CGGu07NNOe0icLuBqB
	/EeeEZSQBAGA17Z7+D7wsToTOuDFg==
X-Received: by 2002:a05:600c:8b56:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490ec507e3cmr75280425e9.23.1781341148835;
        Sat, 13 Jun 2026 01:59:08 -0700 (PDT)
Received: from workstation.speedport.ip (p200300d507395e7b52cb516e4912de49.dip0.t-ipconnect.de. [2003:d5:739:5e7b:52cb:516e:4912:de49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm13849081f8f.8.2026.06.13.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:59:08 -0700 (PDT)
From: Mert Seftali <mertsftl@gmail.com>
To: T Pratham <t-pratham@ti.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Dan Carpenter <error27@gmail.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mert Seftali <mertsftl@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] crypto: ti - Use list_first_entry_or_null() in dthe_get_dev()
Date: Sat, 13 Jun 2026 10:58:58 +0200
Message-ID: <20260613085858.32580-1-mertsftl@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25112-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:t-pratham@ti.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:error27@gmail.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mertsftl@gmail.com,m:lkp@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mertsftl@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mertsftl@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D8C767E2EA

dthe_get_dev() fetches a device from the global device list with
list_first_entry() and then checks the result for NULL. However,
list_first_entry() never returns NULL: on an empty list it returns a
bogus pointer computed from the list head. The NULL check is therefore
dead code, and an empty list would be treated as a valid entry and
moved around as if it were a real device.

Use list_first_entry_or_null() so the existing NULL check works as
intended and an empty list is handled gracefully.

Fixes: 52f641bc63a4 ("crypto: ti - Add driver for DTHE V2 AES Engine (ECB, CBC)")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202606111933.69GGTKxr-lkp@intel.com/
Signed-off-by: Mert Seftali <mertsftl@gmail.com>
---
 drivers/crypto/ti/dthev2-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ti/dthev2-common.c b/drivers/crypto/ti/dthev2-common.c
index a2ad79bec105..cc0244938267 100644
--- a/drivers/crypto/ti/dthev2-common.c
+++ b/drivers/crypto/ti/dthev2-common.c
@@ -40,7 +40,7 @@ struct dthe_data *dthe_get_dev(struct dthe_tfm_ctx *ctx)
 		return ctx->dev_data;
 
 	spin_lock_bh(&dthe_dev_list.lock);
-	dev_data = list_first_entry(&dthe_dev_list.dev_list, struct dthe_data, list);
+	dev_data = list_first_entry_or_null(&dthe_dev_list.dev_list, struct dthe_data, list);
 	if (dev_data)
 		list_move_tail(&dev_data->list, &dthe_dev_list.dev_list);
 	spin_unlock_bh(&dthe_dev_list.lock);
-- 
2.54.0


