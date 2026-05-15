Return-Path: <linux-crypto+bounces-24164-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0aJiqRB2pU9AIAu9opvQ
	(envelope-from <linux-crypto+bounces-24164-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:33:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6A5582FD
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71645301D112
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 21:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF03EDAB0;
	Fri, 15 May 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYL3YWM0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D754048B6
	for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879734; cv=none; b=jj+vql0r5x0ci9hAKLbL6yVgVqCVwQJbQOOBtqR9o3zLuGVC+3foby5K1zxXJP2hhs8zL1zfsGQgi7Q7PBni9hBvEyP5o/0f8ThtvQ7sNN8jgHTVQNOolc9/YjwqDH7CmqBTNiHk/b/SUdq4V6c0L7NsPzaAn5ELa7p6Fk8zFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879734; c=relaxed/simple;
	bh=ILT1qaKW78nRQkC/CMCLSzr2h8dTPOcGoDMHkPnSKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9OyhjR63ixrI5ybHRrtV0Ggo9oh5A5dMo2O4d7TF8rkhfFqJMURybQ9Y/Ym0pQVnUhT380FJjQ1vo0NoHGTU+mdrONsL+q5KicYxCwGuE3XRcNRtTr6dhWoKPuCv+eONr6jRQMKGfZNipJtgzROeuaOiiyHhRBL7RA+ZBAY+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYL3YWM0; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c1a170a50so288789c88.0
        for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879732; x=1779484532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=IYL3YWM0K72+PKBjUIotlkyudmp1jTzkcWSk+FsrFVXzSnegkXpcBDTHvkmgtyv013
         1Fz+1cDxxzxpwH2cjTMD3XcK8OrL3KyPSBFqH8USMoVoBphH/PDfMppdjjf5WM9Uu+zw
         zdblTDDlg3ILJFwS88bKz+DpkkC4R874roDAz+B70ThKNQTz3lnAY6Vm18brrdmeKYlL
         nrRDow22yM9/5xyVwtbnB/WqwizcqZ8UTLFg96EIfVlIoQZejH3ZXpbdDCcTFwuaBYDe
         SBIe7CCRHOt+kHRuouqHqrJpRS0HE1SBm0toraK+5jwMRSnRo9h+dKmUj5IEOAw9IoLh
         DUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879732; x=1779484532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=W3AdC6NVEVST8MoDFKpTXnFaiQ/OS2UpnDoGT4F83/df+WNvKygg7CcQ3nkbYZgjYL
         OMyGwkie+GojiMH3wf+IQPHvIdlkw7jfXqr96wWLg4d9j/B1EdCQWbebEJSbHdZhR3Ac
         v/xRNGhO1ZgBgp3rJHoyCHBPJPXWnq8LzGXsUlznXl2WI5aOrKINpN5c1GXP2fT4emha
         iZoS+EjY3OCNZg6SEDgTSF3gUSx+OQXBBX7QrCSWJPxrlX4vKUVQpXLiyyFsrocy3+gj
         lhAJYYW2PI2k0H+9VI9iY65/OaLo4yRoHoVD7SAUHGWsgJRbhxTE03HWTbpgP+O0s1uD
         KDkg==
X-Forwarded-Encrypted: i=1; AFNElJ9Rd7hraxikrOqqpdGVbSJ3Zc+SvUyTviVtgy3KDZ0M3pMOqnr25qIU1BrI1Xgp3OKmvVPdeBe+tpyHWrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDnHpbZmrD9VMdy9zwBnfaJcQkrqHKy2zrIMGG2QIQuCI5PlH
	ArJ7e14olDwOiwm7h/jS5BHGTZ/pl4T3V89QA+77AmCTMckldk2T6zff
X-Gm-Gg: Acq92OE5N1lKsWkNTmSJ/0OIsqpNd94VUR2cqjUSQ7ZbUvSka+iecBVBjAyMd6/FSoV
	sD1oa14HhrQzMPbh7wayx4B8jCPwPM3N9PoTrJywoby7h156G8758Xra4PdK83zXblzMTRBXGBL
	qNQwMoOzUELJxWKytxyhyQaO1uZwYAv0a5mrMnJCZzy7gYR8zXFs+0YmRC7s7HbjtB1rCaGAtMu
	3KWfB6o6mtJGU1bjhSiY4re6XWp+5U0FtynOQTXZUCLNwvU93LTf5BDJpluVCnfIeWeBTMroXMt
	TItt05IjjtRfMQKdo70h5ebl5aeofzHSwPQfBP6u1ej7XrcEpp3PUshbTWE+rtPc3MBJ3JrDzvX
	r3ZPYzuW8JFMEY38Ixxn7Or0HIEDPdvF4noQs9agGCxwooiHIBEPHmhPeXtuLTwR4dcUMBUfbhs
	4Q/ruqmsFp/Esyq8YlkqtInCOMGtDAt3eIwm3HCk+2LA==
X-Received: by 2002:a05:7022:6621:b0:134:a710:d908 with SMTP id a92af1059eb24-1350451887emr2398095c88.13.1778879732067;
        Fri, 15 May 2026 14:15:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11245224c88.12.2026.05.15.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:31 -0700 (PDT)
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
Subject: [PATCH v16 28/38] x86: Add early SHA-384/512 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:14:00 -0700
Message-ID: <20260515211410.31440-29-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: 9FF6A5582FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24164-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apertussolutions.com:email]
X-Rspamd-Action: no action

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

On newer TPM 2 implementations, SHA 384 and 512 banks may be available
for use. If these banks are enabled in firmware, they will be used for
the Dynamic Launch. The DLME will also use these algorithms to measure
configuration information into the TPM as early as possible before using
the values. This implementation uses the established approach of #including
the SHA-512 library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha512.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha512.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 071a90f23ae0..527cba7e4560 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
 slaunch-objs			+= lib-sha256.o
+slaunch-objs			+= lib-sha512.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha512.c b/arch/x86/boot/startup/lib-sha512.c
new file mode 100644
index 000000000000..2afd5c5935cd
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha512.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha512.c"
-- 
2.47.3


