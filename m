Return-Path: <linux-crypto+bounces-24154-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL7CCwuOB2rB8AIAu9opvQ
	(envelope-from <linux-crypto+bounces-24154-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:20:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE33557CE2
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 23:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 456F8304039D
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F040628E;
	Fri, 15 May 2026 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9V33mfU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E23FF1D3
	for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879707; cv=none; b=ZMGvMpUIGFSpXVYkH3UBY2eJwdXfqEDErBhbkrNCV6tbDWukgrky6TFra4jRqxAjpgD6kxJa1YjtGX2GDYkGmw2f8pbqHQEJzt3XXxghu0R/gVD0FxfA9vlWcxgaNfwWQbTNGTfFzWEhNGYwVjfru6C22T1kNSfCxJNb+k+KJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879707; c=relaxed/simple;
	bh=qtwiEWwByfHHxjTrlTyTKX/7jH6vLFs54iG3FoiDWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXhBfAi5A/c4kGraEdxp4cfpHkTBM4FxUUBLHH3fZf1Adl1VJ2FphV/QAVNaUXkkbw/jIkSLpZIOs1uSYxckStUdmg17XXW77IDB5IXP9+6fJ8C0pg09O0quv2KsF06ncDEGwozpjPrqXv77aOQ0wDXqr/q+ASt34C9O27a74vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9V33mfU; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1329fc4bf77so361568c88.1
        for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879704; x=1779484504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=s9V33mfUWQSz9b71/QS4bizbbARZHMDNvH7LsGEPdS45xkCfL7xQwNunkkk5UbevFy
         w0xSUPPpNM6DkKIOd8ilLXHV6pV05emWyPPWFgqfn9kayoO8I56TjLnTQkA83RLVQort
         j3HRyLu0UnCxhI9MZTxUqlGCDn49YnoTpH+Vqlwk9N40NWTRpfCfLfKeRrdYlaes3gpg
         yuziZP3k99tvGWE9sgFtiQ24002qiDICOLKL1JqwUpsBbLdAm5ybiYLaAYzWLrd9GBNt
         fY1FVQCWMDnCoY4L+hfoMxL2Tdsqm96Us8LZih0uGUthsPQYzPfDuEnCoG59+ipp3xMP
         vflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879704; x=1779484504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=DB08lkHV5ybJ2zfHDvLHeE9Dz2k8qhvf30EzyrueEuO0BUc9FYtfLFrJ7GPcXjnQB/
         gPB8bYvqaDbr2Y+iKswcj6PhI1i2cgf2bwKf0du97gS/AoLnjse2GtYqA3mBWZMY/l1S
         gidKbsKVNqqrrV1+IomPetxKS67vs20PnASBlrMfdjyZeQpoMdeQpI169AHR6MRQYfbb
         V2t/hQ/uiHNBi0EkHE6WFoMjPVf33uvuRyvQBlTWSNmumyFBAHI3AsWIBU5u7rDKa4Cx
         wgZCgu+iKOLq/b/uBT9DqTh192lwPu65eyoQfsNRTDnncpOEwKxMSY70zVFYIkZmfmku
         X27g==
X-Forwarded-Encrypted: i=1; AFNElJ+ucRhlw2mAwIDdWLLzK2Ks22GYacnI6XX3PtrYHS02M6biQamCVjCEm7eVYug1r4O41oaZsIz8USjWphA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6CppdSxUBPvYThBVS5M6yj+j43xQ/ie21PLehuJFA4G4zMDr
	LYPzMVQM46X7enwba1IE2TsDezYBp3XosE/fu4j268WZ8SV5eu5bJmnx
X-Gm-Gg: Acq92OG6zj6KlWHPFdzS16ApEsBa3m6bumlR3WWsVvlh7ZvL62qdtJcc2HItS7UEqTW
	Is9+4oP69u4M6kWAKD1DDgZOM7VhqypOetsXwhDqpANWKBIarDeBoWZ0AvqccxzPUgJNcIIgvJk
	CcMRRAB5OHiudmh+nZqpRTI1btJkshfNdtpIT6owm7tsWvcmu4c0MJxpq6Nk2FS9F0lmV1z7J5J
	9SEjN3H4cZXv/uAbSNdkHZbo4HasWAE/BEEgkUDESFxgJO2qjJ4ZKCRM4sTb8UIo/SpjnwutoB4
	w/09syOZkTxzGBn9EHJOaie+IadP9NkjRwVWFKdKGq9Qnw3VJxMrZLtQDKUCf0xe9NHqjOdLA//
	14LmmWZYyWXNweQjAXBE6sp8JM/hn+Ydq+yxOBavM/r1Wxp1KTfG+QRNhZZKct+jmNovvMGWsCf
	KGh2ilyLsSC9GjUPHLgzeY+65GG/xUOUw=
X-Received: by 2002:a05:7022:239d:b0:133:598c:2b45 with SMTP id a92af1059eb24-1350494e3f6mr2888720c88.31.1778879703912;
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740638c88.15.2026.05.15.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
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
Subject: [PATCH v16 18/38] x86/efi: Secure Launch Resource Table EFI definitions header file
Date: Fri, 15 May 2026 14:13:50 -0700
Message-ID: <20260515211410.31440-19-ross.philipson@gmail.com>
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
X-Rspamd-Queue-Id: DDE33557CE2
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
	TAGGED_FROM(0.00)[bounces-24154-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Secure Launch EFI definitions are contained in the Secure Launch
Specification. The definitions are split out into a separate header
file for compilation purposes for EFI vs non-EFI environments in the
kernel.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/slr_efi.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/linux/slr_efi.h

diff --git a/include/linux/slr_efi.h b/include/linux/slr_efi.h
new file mode 100644
index 000000000000..5de87a9b38aa
--- /dev/null
+++ b/include/linux/slr_efi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EFI Definitions for Secure Launch Resource Table
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_EFI_H
+#define _LINUX_SLR_EFI_H
+
+#include <linux/slr_table.h>
+
+#ifndef __ASSEMBLER__
+
+/* EFI Support */
+
+/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
+#define SLR_TABLE_GUID			EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* Secure Launch EFI runtime protocol */
+#define EFI_SLAUNCH_PROTOCOL_GUID	EFI_GUID(0x534189e0, 0x6fde, 0x413d,  0xbe, 0x91, 0xcd, 0x4e, 0x8d, 0x67, 0x2f, 0xea)
+
+struct efi_slaunch_protocol {
+	efi_status_t
+	(__efiapi *setup_dlme)(struct efi_slaunch_protocol *this,
+			       u64 dlme_base,
+			       u64 dlme_header_offset,
+			       u64 dlme_table);
+
+	efi_status_t
+	(__efiapi *launch)(struct efi_slaunch_protocol *this);
+};
+typedef struct efi_slaunch_protocol efi_slaunch_protocol_t;
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_EFI_H */
-- 
2.47.3


