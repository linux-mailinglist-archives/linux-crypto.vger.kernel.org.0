Return-Path: <linux-crypto+bounces-24163-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DOkG/KOB2oe8wIAu9opvQ
	(envelope-from <linux-crypto+bounces-24163-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:24:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46663557F5E
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 647CF305FA84
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A1404892;
	Fri, 15 May 2026 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9OputCr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6B2404891
	for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879731; cv=none; b=JkbZyXjLk8oFj4bYFfoNYYcPgxpWkfb2GPQPNg7X8+rbCOzwViows7o7z8z444IOE29nByS+d7odaYpNcQpyPJgXDKC4GqRYDAdITf+D7HBjUVJxJ0DbBivmbAfdC8tgys4zVKX+JwHsy5lyn2bWknCekjHwF0+Mxfwe9MWN6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879731; c=relaxed/simple;
	bh=kbvK6cuaNQpZn6Q9g72Q+TOpf/2ROUnAJihI0oZoubo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXxa+lL76pvLTsaTrYRbqID4PSBUfaxVoVEj/+GjlTWDm6w2lRtz+jESTT6WI/6QB7+ZbLV/9Xz0r/4AUpqlcOk0hUlTT72ZbSdbgYJ38BqoDdSVDNx6sWF27hdMqkEUc+qz21kLmT2y4DE3WhwRanw6ux6IlxrYRwrwt95nGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9OputCr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c156c4a9efso374980eec.1
        for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879729; x=1779484529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=o9OputCrmArK0qB9XWlHF/QKy9zlHBWFInzZrLIt4PpmYMpSYUW/atSgYmLlgUM3f3
         XQigHp+a4Zv2AXXBarW6f+KVLGlpORIk3Lz9XpkEPVhgevaX3pNxUgtWBbvcp0bd2SOT
         bXAHdAnn35Nia+1dkLc0jWevh3S7Wpl0bpu8juF223uNnqlu6TjcLkJ29SE3/imlzEsJ
         qrQ0p/s8SbX3PesAM/CSUB23lxUVz/gXlmeAStw17Jra8vDv4spFo+sgBeCI+aTcdrG5
         4KPpFb8pNCMi68b71RFVGuY1sy7Y+uTy06kpVfSsgaeC6RLXeGW1CiQT8dg76RfN0yjZ
         jzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879729; x=1779484529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=LsAjasVGN5FT/ZhK2jI+s4UopsHaXWQkyLBefVNszzSb3wV4R5Fo4de9TPJwzH3eVj
         7guVeSQFh60aY96IqQ3EKRNVvptWRNLR38FeK4c77QN8VwNy9N7D1asM73OPPHunQCL1
         hquZiSYp5Np7pBwYUnH72sjAlSkKy34AO8BQx5ww8TXP3oK0QXdipOXXt5oM7sXG6Dv/
         jVzf+ZkHkI6N/wPJ+Jm2+8wVhvIVHmCio6yoaRLst83Ni3vDGOmO1UdsvlReLNgZ97aZ
         jevE5j9zbVh6r50egjOryqzNgWAH/6hHcY0ic22PcUZlCQ/u9npknxwY7mIsMXG8Mpwy
         8zJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/S5TAxMx1p+4yaiOvmbIg3oVsaSywpm55cPHD9FP8h1kubiRS6gimhLguQWYJ9Iutm7d22r6kg41/dAPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3J+h9EBl25MveDBtQgaUjpJfjDbkiA6Y2Gz2d5wecrNReC+IC
	rVjv4SowDuF2n61M5ONbRUUfDGRxF9Ill9spP8SukoZq0ZfxGbkZX1SQ
X-Gm-Gg: Acq92OE/pFzNHqcI5lN/O8u2SX/J+/4TqGOEzKdAoc6d2jzHkXrrS/W8PxYpCiGZ2nH
	LudNduPlNAj5wOkTMoZ3RYjgiO/FkNLLv9BKVCyDkip3HdRwsPpCsKff8yTmRyJyb8xijng4eGn
	zC0S3H2DXuV0FRBNZJ2FPqmJgOr4nXJtyfK3LAx0Mh8jK6eaqoZWhVXomid4yAJPZpeSerjfPrT
	XTy1ShOdeBvf+lFAywPErghQR6LLj2h5X3mYWv0/a4SPmmeouikl2GeCdM+Sq5hlmDXrh1Ev0Dc
	eeBdnT5lb0dnIaW6+Awp1xRC469dYIsmtRxLNpbfSQmKMMwvYnw4yNxKqpRlj0hw9+S1h/yYOIU
	5a5zC4y5/vaYGnPHZuVeT/39TdfZ1tdQKX38NFGj/nwbei/pxI9sj+jFq3S0voBSeHu2WMhsv70
	cTmkuXMNh7oqPtD5ew1++RdIhwfm0Zy6A=
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id 5a478bee46e88-30398618b3fmr3091136eec.17.1778879729276;
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm8268038eec.4.2026.05.15.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 27/38] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:59 -0700
Message-ID: <20260515211410.31440-28-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46663557F5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24163-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,kernel.org,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[rossphilipson@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apertussolutions.com:email]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information
into the TPM as early as possible before using the values. This
implementation uses the established approach of #including the SHA-256
library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha256.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e283ee4c1f45..071a90f23ae0 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
+slaunch-objs			+= lib-sha256.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha256.c b/arch/x86/boot/startup/lib-sha256.c
new file mode 100644
index 000000000000..f60df97f9244
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.47.3


