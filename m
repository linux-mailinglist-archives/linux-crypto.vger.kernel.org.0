Return-Path: <linux-crypto+bounces-22437-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SATMI0+TxWlG/QQAu9opvQ
	(envelope-from <linux-crypto+bounces-22437-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 21:13:03 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBF33B4B6
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB446300B51C
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDF3A4504;
	Thu, 26 Mar 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJNjV9YJ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E043A3800;
	Thu, 26 Mar 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555973; cv=none; b=BfP6l4qdyRu2uOiAmSpRCnlSFpgc4wqVWGWkP+NMmVqHtPYxs/sSclOB7XIZpbXtiYIoDD8BxMDPDsc8NwdZU/3O62mfLJaeQVIi8f/X1PhzzzQLZ9keapWi2Vj2x4pPs+sIBPB3/4uZThWcHgrUGmyyNdKnjPQATV+ovpz1s8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555973; c=relaxed/simple;
	bh=Jncs6DjzXM9ebzv1x3ezfUU5Po/qgF4SZLeP17IU7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaPpCbh/IbyH2lvxpc8OofbAZmms3gCpNEytt9e5lsZsIb0DTfIYAtZYZEv5aqrmAz9LMBX2MlRQb3/Bexklrvfti2Hh1Qs5MXn6BoDHr2zTTGimItqzBifOhMDq1o1EbMaqDFhvmK+8d8Grilq3f0XXq8sLJeXSlUNHxD3HEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJNjV9YJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5FC19423;
	Thu, 26 Mar 2026 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555973;
	bh=Jncs6DjzXM9ebzv1x3ezfUU5Po/qgF4SZLeP17IU7gQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hJNjV9YJP3MOknABU+M4uPH5auJM6rEiAndYCc+kq4jOBJaMwKFDBlEptLvWPGrAZ
	 STPz8Jp7E8DmOfpsrdi7+X3BRQPomzgZIxhq19FadUiK/PMTP6LE9qA2DUaFBDHu8g
	 VapmWXBJ2cl4FmE8jEgewKmrUfCE2OHOuu3CLHPLl42hHt94BmQ7ogShyaGgyTogee
	 /D2Mqw7iGiFdbtmEaA4tzOeiCmnFXvMBu8u4K6aQL1F1NLlEVDQOJDl3pVpw66jOKD
	 SgJyva9DlU91njD9kNB2o41JGptkdvb6noJCfZh2rVq3lRTIhugs29Lromblh7cLmW
	 m2P32X4AcO0QQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/3] crypto: Remove arch-optimized des and des3_ede code
Date: Thu, 26 Mar 2026 13:12:42 -0700
Message-ID: <20260326201246.57544-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22437-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C0CBF33B4B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DES and 3DES are cryptographically obsolete and insecure by modern
standards.  Continuing to maintain highly specific, complex assembly and
glue code for them, especially when the code isn't testable in QEMU
(s390 and sparc), is unnecessary and risky.

Thus, this series removes the architecture-optimized DES and 3DES code
for the three architectures that had it: s390, sparc, and x86.

This series is targeting cryptodev/master.

Eric Biggers (3):
  crypto: s390 - Remove des and des3_ede code
  crypto: sparc - Remove des and des3_ede code
  crypto: x86 - Remove des and des3_ede code

 arch/s390/configs/debug_defconfig |   1 -
 arch/s390/configs/defconfig       |   1 -
 arch/s390/crypto/Kconfig          |  16 -
 arch/s390/crypto/Makefile         |   1 -
 arch/s390/crypto/des_s390.c       | 502 ------------------
 arch/sparc/crypto/Kconfig         |  14 -
 arch/sparc/crypto/Makefile        |   2 -
 arch/sparc/crypto/des_asm.S       | 419 ---------------
 arch/sparc/crypto/des_glue.c      | 482 -----------------
 arch/x86/crypto/Kconfig           |  14 -
 arch/x86/crypto/Makefile          |   3 -
 arch/x86/crypto/des3_ede-asm_64.S | 831 ------------------------------
 arch/x86/crypto/des3_ede_glue.c   | 391 --------------
 13 files changed, 2677 deletions(-)
 delete mode 100644 arch/s390/crypto/des_s390.c
 delete mode 100644 arch/sparc/crypto/des_asm.S
 delete mode 100644 arch/sparc/crypto/des_glue.c
 delete mode 100644 arch/x86/crypto/des3_ede-asm_64.S
 delete mode 100644 arch/x86/crypto/des3_ede_glue.c


base-commit: f9bbd547cfb98b1c5e535aab9b0671a2ff22453a
-- 
2.53.0


