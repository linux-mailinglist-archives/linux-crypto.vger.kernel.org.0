Return-Path: <linux-crypto+bounces-25129-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l53zEm6nLmpm1gQAu9opvQ
	(envelope-from <linux-crypto+bounces-25129-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 15:06:54 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF192681124
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 15:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="fvQ/mhW6";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25129-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25129-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFB830131DD
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142435E929;
	Sun, 14 Jun 2026 13:06:32 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D213386423
	for <linux-crypto@vger.kernel.org>; Sun, 14 Jun 2026 13:06:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442392; cv=none; b=gnq+dPfpR72BU80VPKjXkkJyiyY80Q7bxRXoi8/1fcIoDKmdDtWd6ylCHK+llx66yZCez3GA6AWAWCahzxm6s7rzgfO0V1euTUTAQjT++NX02Xwx5yX1yPXcDS1QwYFoSvwfsjkENAN7H1BmQIJb+o0Vsaab/MUB5fn68JWvx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442392; c=relaxed/simple;
	bh=nKb+W2wmLqLuHK9GreXOyec5jACQecKb+WCn9wI9HhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgMYkaWlmSWI7xvwEsJPWf785ezTXwExKKJZI8T5A9DOnSOoyob9/lkDHmHzDU8Xh28bshNv7IcWM6sEKOa9IEN7PB2zNrsqNQLVNsYI2rMaF/g4Zvb9Jvra7nODkwSf6NF8KaP+vBaWih5vpIdAhRQXOE7labgye/oCSv/GrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvQ/mhW6; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ce9de10985so32886736d6.0
        for <linux-crypto@vger.kernel.org>; Sun, 14 Jun 2026 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442388; x=1782047188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjXLO5H1+5ds8HPQ/tLoLCzBushFbkoltn8TPIfOX1c=;
        b=fvQ/mhW6nFjRZdyqv8JHXQy0hCwPVwJMs3A0GDp0CeWb5MR2BvJKh3F4WN5p2IryWk
         HmNyeAZj9d37U1qqrjFPr8Lj/hsmpXarpwASjGKVA6bXtQk29b8EhRNQOFPZmFogIZ7M
         ir3SunPfGUnKF2O83V45RAk7RRcQJ9xkjULKW0dBDPTCJ8uY/xhZ/sHRyrz/FMoWABRM
         cgqCoox8+oXnYjJp4R3BJAW2E6YLFNyvMDd+sxJ+xuqXfmZmUcDeI4lmJzFtKmnXU59T
         CxwEQ2mVl8KmGwoaRf2Y3MZScafBa1r13Fl26cV17ToKcKs8Tq9EXN/splufPb9ztnfy
         ncLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442388; x=1782047188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjXLO5H1+5ds8HPQ/tLoLCzBushFbkoltn8TPIfOX1c=;
        b=deP09Bp1+RF2TF/qggN/Twx20VNKCzH/KF034II1aPDhC/AOyfnugxIsmmFPbf+Wh7
         /GD75Vg+QbkA811OLpafPFGnklzmGzrdeOOIyVighZfr03LF8FJ1IYKT0DOZOkekD/Fy
         OtfViPhfRqHye4VZWBIjjyjY0p4pz5tkquBJBMVP/7MmuCqLSs90P1duoKrEhFmWha92
         ZdndPVC7BhTMcezQALmB3fFJG0zhUSrq+M+z3R7qj4rQWOLwHvBnYrhg63ljVi8FsPSd
         K7fsT07imXJzOLoMh3cu/ULAOB+J7rRx2f74Xtb12MyaK7v+rIhzf7ngaA6sZxeSdJXz
         awQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lmyk7Y/RZVJ75RcTH2qXM/qQ4HSeRfIGxjljkeS6sCovP2/+Cl/9fNlRd/DMpJIeN12Xx1VpkvEfwPB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKc3dv14CYvcWUzVQhZtNQuQNKcXfdQRxH7acYvaChGGddERl4
	sFIy4q7sYrI4FgbirMd+rK4N8S9IxExiYPR9sPU98Y1EvXWrHYMz5DKO
X-Gm-Gg: Acq92OHZ+J+dpI1OFgcHev6Lo0D32mhMl9Xh5Up5uYxg0nLs1zwfh35WFttQbBhq/qO
	m1A0hh3TUwGwxSdJk/+vwNhlEKm9Dk4XaS06933bUfC2F74/v4ECeVf0x57Q63c3VQxHlUSrjmj
	/H53nJXXzd+J1u+MSBBC8a1kuuf02Agn0nkQ0UNs3AghIvuR0Wn8H/LYVC+KK4ZreotEUN7ejmL
	sJUfmQNQZamuTVz0FGw9eUlzehiaZPjr+5XWm/BhYSuUH3gHhiTUyA4AdbrZSI5wC17CDpi13RV
	REVg6B0MM219nSCCiUEnkwFm1Qdfb5GnAjXf42CsFQ0gK33HwumMY2dXIwW2Uq0J8oGhJeO4obq
	U56XRtxmazD+H/8WSxnjvfBs8sK/0H0WczT567We3N8rOtWdZsU9AXmquLLQvRJ4LUa09tmcIF7
	3IaUwZ907KILRNWVw2URhtb1HdOrrp3uEnR+L+1L/lGMNDj5d1SWJkaGetbT9PCCMKD+IX+8Q+W
	TSpIiS4Xp3LecWJujHsEN1kOEsHzos4Up8R7ejzAwc=
X-Received: by 2002:a05:6214:5f83:b0:8ac:a91c:c99 with SMTP id 6a1803df08f44-8d317b453c6mr134108656d6.29.1781442388310;
        Sun, 14 Jun 2026 06:06:28 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301a32d5csm77937106d6.12.2026.06.14.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:06:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: qat - bound the live migration import parser
Date: Sun, 14 Jun 2026 09:06:17 -0400
Message-ID: <20260614130619.2519534-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25129-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:giovanni.cabiddu@intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:kees@kernel.org,m:qat-linux@intel.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF192681124

adf_mstate_mgr_init_from_remote() sets the section-walk cursor to
mgr->buf + preh_len from a remote-supplied preh_len, and the default
preamble checker only rejects preh_len > mgr->size. A remote preamble
with preh_len == mgr->size moves the cursor one region past the
allocation while n_sects is still honoured, so adf_mstate_sect_validate()
reads sect->size before the section header is proven in bounds. The
remote stream reaches this parser from the destination-host VFIO
migration path (qat_vf_resume_write), so a malformed import reads out of
bounds in the destination host kernel (fatal under KASAN / panic_on_warn).

Patch 1 rejects section headers not fully contained in the state buffer.
Patch 2 adds KUnit coverage and is offered separately so it can be taken
or dropped on its own. The parser was driven on QEMU x86_64 under KASAN
via the patch 2 suite (Level-2: buggy code unchanged, surrounding VFIO/PF
environment synthesized); the boundary trigger reports the out-of-bounds
read on the unfixed parser and is gone after patch 1, with two benign
controls passing on both trees.

Michael Bommarito (2):
  crypto: qat - validate migration section header is in bounds
  crypto: qat - add KUnit coverage for the migration import parser

 drivers/crypto/intel/qat/Kconfig              | 16 ++++
 .../intel/qat/qat_common/adf_mstate_mgr.c     | 18 ++++-
 .../qat/qat_common/adf_mstate_mgr_test.c      | 81 +++++++++++++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr_test.c

-- 
2.53.0


