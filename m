Return-Path: <linux-crypto+bounces-21650-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ij4mJDNMqmnwOwEAu9opvQ
	(envelope-from <linux-crypto+bounces-21650-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 04:38:27 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC421B329
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 04:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE967300BEB7
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2026 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31936C9D9;
	Fri,  6 Mar 2026 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC6Zukg5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6736C5A4;
	Fri,  6 Mar 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768296; cv=none; b=r/3/YtVRNi1/EF6MGmCTHmd4dFVYCCjnoBrjK6XerspC2Pz8E0WfUG+wHFp2YGlAUw0bLM+IacS+Y0SA93TXM38u2AZN+NDpdyBvgi5TVNNkmoG3agwr+VqniVGdcUlkxc5g89rYLiKsiZpiPuRiXVSe8o9h6bvLYiuW0J4LxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768296; c=relaxed/simple;
	bh=GOaBsCpqI/oIzE5UIqkG63R4UPYgquErrFVbpCT1olc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEjuN+FHvrGBRLAO3BugQZm6uNqtfdIIEJtlNsQXs7cuNxO69SvNxn/ZJxLXsalFc74jkIOMTChy0GMq6vUimb8bxm1L+D9/aBhkiYKtVj9BtDQvlscUVtCxWFzzULF9SgfsCVXcZm1uzlejj1FdbaW/1cOQ4R1/wj98Gxgrq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC6Zukg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B447C2BCB0;
	Fri,  6 Mar 2026 03:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772768296;
	bh=GOaBsCpqI/oIzE5UIqkG63R4UPYgquErrFVbpCT1olc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC6Zukg5Q8ahnFiMzNRSiML/IBBLKtGx1o5dCHV03BkrvN8T5kS0nKGdg8e5TwFaE
	 8w4Hu8Ptlf5LxaXa48eaqsYIK05TMbv5tu2ST3QBtGEingorAaV8+yJxynFr5m2r6j
	 Dpc/5OxQSi3Qs+NTuPn6fVomFPPIoIpQaT6wRYFUhEFd3NblYi7X9u8MOWblELCAcv
	 JpSXr2lm/vSdVhpUnJJCQDaF5CWVejS1V7vmFVtcEG/0R9z7IKxPAcVq/RTCi/ANQg
	 hy8JQ4Uwv6mE5Ux0M/cdGPY2Q1hxrNl/sSx0mUhgb4bXGalfg2QN2SJNfkJKw+vMnB
	 Pnm1OqvgJ268w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 3/3] lib/crc: tests: Add a .kunitconfig file
Date: Thu,  5 Mar 2026 19:35:57 -0800
Message-ID: <20260306033557.250499-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306033557.250499-1-ebiggers@kernel.org>
References: <20260306033557.250499-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87EC421B329
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21650-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add a .kunitconfig file to the lib/crc/ directory so that the CRC
library tests can be run more easily using kunit.py.  Example with UML:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc

Example with QEMU:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc --arch=arm64 --make_options LLVM=1

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 lib/crc/.kunitconfig

diff --git a/lib/crc/.kunitconfig b/lib/crc/.kunitconfig
new file mode 100644
index 000000000000..0a3671ba573f
--- /dev/null
+++ b/lib/crc/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_CRC_ENABLE_ALL_FOR_KUNIT=y
+CONFIG_CRC_KUNIT_TEST=y
-- 
2.53.0


