Return-Path: <linux-crypto+bounces-23327-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNIIFgUD6Wl5SgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23327-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 19:19:01 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA394493C8
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123DF304DC82
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2026 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF87382373;
	Wed, 22 Apr 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qe7I1ofq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B193859FB
	for <linux-crypto@vger.kernel.org>; Wed, 22 Apr 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878246; cv=none; b=jP9xl/H+CtL4C4l0gk4ui89yUdLM+iv7zrN7HgXuxa/xQSsor9QS2pXE7x5T22mnH0dyUrCmgil608D+f2OBAdkV2aDJ4syDh5d+SXDbuHUYUjYftiFNxIUbIjSss+P3ZBqNn4xUwPtziSD+0Jf4Afh2GcZ2PyBGgBFimaUgwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878246; c=relaxed/simple;
	bh=3TSqmtAh8p9lAZuOtWE+Y2L1mmkvlXd6fQl3N6yASMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pCOcA31gsUoZZNS/sC+qXpitd8cad8BhyaXXNac3QLXNk7MQyn4B2QzIMkMm3LLqzoExyh3mPKK3jqVfXnjeKdADqSLIvhSrrzhOKaeK1mccMqsGXIUfKtLIKSZfptQU9MAlW6HX91L6k2uHFrJXC0UwTd2wx62Ujf9Isp795aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qe7I1ofq; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso3971152f8f.0
        for <linux-crypto@vger.kernel.org>; Wed, 22 Apr 2026 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776878243; x=1777483043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuqi0pEQ4aDjkPf/VIftR9YnRng2yC+64fHr+GUwwKA=;
        b=qe7I1ofqyMnIEvPjFJncvywGBEWDwl+3GTGgzVn8uBuv40cpWeyIz6ETv0a7BJIF32
         BBnNGwxshF9aELGDdT2NP2LhHFR9Y1Dklcb65OUPzRCluD8DLJkNduR9pKaaxPxRUJpf
         GDzX7T8RW09o2qXDm4lufXnby4cgZLKtru+tK1S/qvjXXWSfMAJvvh6J5yQdZnLXx04o
         tJo28Et+1yK7ncKrJSHC8UofiMNggjNQZJEhEHUn+Oh8JvnBW7Se4LMQ0wcB0YlsedND
         9mdBm6eaVdO1s/KcAnHcGtOVS4VB5WVxGM2a3wW+yaQKfZe2a8iBy8/PITfif89kXsHF
         /bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776878243; x=1777483043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuqi0pEQ4aDjkPf/VIftR9YnRng2yC+64fHr+GUwwKA=;
        b=D1BdgsoWqqu5xu9J+SIUvMgiO7wKnpg1+TvXk2BMHht+n9+uQF1WVBL15yI+NQe6/8
         djz3aXiCsz26jS77xjjYRcklxxtpJBsa/uBfiPEKnZw11tpLZEow5N5ITCh/Ciuhw6fM
         /u8hjrUtLxgvSoIvCD3H/Limbf6D394iG5DN5qiInbvrvmprbojnwnjXGGhom36D2olm
         x4UnLsOCPkjbWW2ENNDVKuC3WPU1bfP8bvvDlk9adObsJII52awTpsF+98L7GtwmwXsn
         +aj2aCvpLOxwU1N0qP3elINatqj0iNdlDra5vBWAOB/QYQ3hC6mOoTyzefyT8vyo7gNb
         OYkQ==
X-Gm-Message-State: AOJu0Yxck7VQm74No2Njpq07lF9sLczI+8FuyGW7IFZ+mW3PY7LErHvP
	2wIQXkYoamBZDv1ryWAaeyCOVgn1Nm1K1VSWF1yKIBy8gNBi65qFuNrB6P2AafsQgGqB8NSzgA=
	=
X-Received: from wrre15.prod.google.com ([2002:adf:fd0f:0:b0:43f:ece8:6610])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:adf:e789:0:b0:43f:e94a:e773
 with SMTP id ffacd0b85a97d-43fe94ae82dmr21574127f8f.27.1776878243132; Wed, 22
 Apr 2026 10:17:23 -0700 (PDT)
Date: Wed, 22 Apr 2026 19:17:03 +0200
In-Reply-To: <20260422171655.3437334-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260422171655.3437334-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=ardb@kernel.org;
 h=from:subject; bh=+mzv579oicQpnDQky32vkIYpBcS6q+p6cFrwRCDc7Xs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfMl0+QsWclLTI08gu6hEhMu7A35euEEW6dSWKjl9/l72
 /V02k53lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcjGZkWBPU73Lj+qWTd63+
 v1Vte9Jum7H+F++3/57q01c99cpjXszwT3Ges/Pv8JpTnFHXRMzrzzjrnd5eURr07u203D1/Nu1 cxAIA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260422171655.3437334-17-ardb+git@google.com>
Subject: [PATCH 7/8] lib/raid6: Include asm/neon-intrinsics.h rather than arm_neon.h
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-raid@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Christoph Hellwig <hch@lst.de>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23327-lists,linux-crypto=lfdr.de,git];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA394493C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ard Biesheuvel <ardb@kernel.org>

arm_neon.h is a compiler header which needs some scaffolding to work
correctly in the linux context, and so it is better not to include it
directly. Both ARM and arm64 now provide asm/neon-intrinsics.h which
takes care of this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 lib/raid6/neon.uc            | 2 +-
 lib/raid6/recov_neon_inner.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
index 355270af0cd6..3dc20511103a 100644
--- a/lib/raid6/neon.uc
+++ b/lib/raid6/neon.uc
@@ -24,7 +24,7 @@
  * This file is postprocessed using unroll.awk
  */
 
-#include <arm_neon.h>
+#include <asm/neon-intrinsics.h>
 #include "neon.h"
 
 typedef uint8x16_t unative_t;
diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
index f9e7e8f5a151..06b2967fb8b6 100644
--- a/lib/raid6/recov_neon_inner.c
+++ b/lib/raid6/recov_neon_inner.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
  */
 
-#include <arm_neon.h>
+#include <asm/neon-intrinsics.h>
 #include "neon.h"
 
 #ifdef CONFIG_ARM
-- 
2.54.0.rc1.555.g9c883467ad-goog


