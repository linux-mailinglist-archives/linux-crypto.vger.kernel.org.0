Return-Path: <linux-crypto+bounces-23303-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKu5EvLm52lbCgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23303-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 23:06:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0F43F9EC
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0674301963E
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7C37A49C;
	Tue, 21 Apr 2026 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTl8sRa0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C539A80E;
	Tue, 21 Apr 2026 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805595; cv=none; b=c0cWpv48EuGD9SIDk/+VP9bzMTMAwvXzmzth02JV9p0/bUOGrEk1SGfYC1YCJf29y44jbkFlKgpvFG1CpOmQv8j6tU8UFANEh3OYHhdm2X1PySlJ3J/2PR6q0MUoPjMTkB7Wl7uwGYD9uaZiyHOOV+ZHQmK9700apyg7KyjXWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805595; c=relaxed/simple;
	bh=89HlTdVmwqhIWOEWRxLYQTfdZYwTZpcS32dM+ACP5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxTrM+8o0S5EVWsq51qXpTessEdHHxpxEvBpaF7qo8zGumCWzFDtnhe5MLtdn4WUv9BTBUCt/7cUBwPkbQpazsbg/hS6CXGogFB3ecFmOhQWIPXBad2yjg7inmfE30qOCDgdiG/aSuqOIo05nK/YXMWEKrdRN3m1nnrugk+PRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTl8sRa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E8C2BCB8;
	Tue, 21 Apr 2026 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776805595;
	bh=89HlTdVmwqhIWOEWRxLYQTfdZYwTZpcS32dM+ACP5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTl8sRa0msjOCNb1tonVMirQXijDqt5Jid/BenlsAnKK/dif4r7BCPV6wAbNwSMpc
	 uoUQuUx9mySao0MBY4+06nxQIIMzRAhmUkKWtdUYQ2P75TLML9i7bhHXtwv+13Hw5C
	 h/ycuJJMg6rmr3y4drCR69swL/ntcCqtfB1WKPKJgYiAspb37HNq7+r2gakf2KzR9E
	 ax9OmD9D4KkkTt6kf7iqv90dB8P07WGlYE2Ijp4iotJWiMoAFWYv90n5Amu9izkdBj
	 9n/doIJBdhm4jjwWbK1cf6cHG3m1YwSaJNf3XKS9OikwNMujfwin7sOavkERYQk9RD
	 VB/m/WA08ypsA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 3/8] lib/crc: tests: Add a .kunitconfig file
Date: Tue, 21 Apr 2026 14:05:49 -0700
Message-ID: <20260421210554.36096-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421210554.36096-1-ebiggers@kernel.org>
References: <20260421210554.36096-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23303-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunit.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57D0F43F9EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit c13cee2fc7f137dd25ed50c63eddcc578624f204 upstream.

Add a .kunitconfig file to the lib/crc/ directory so that the CRC
library tests can be run more easily using kunit.py.  Example with UML:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc

Example with QEMU:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc --arch=arm64 --make_options LLVM=1

Link: https://lore.kernel.org/r/20260306033557.250499-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 lib/crc/.kunitconfig

diff --git a/lib/crc/.kunitconfig b/lib/crc/.kunitconfig
new file mode 100644
index 0000000000000..0a3671ba573f0
--- /dev/null
+++ b/lib/crc/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_CRC_ENABLE_ALL_FOR_KUNIT=y
+CONFIG_CRC_KUNIT_TEST=y
-- 
2.53.0


