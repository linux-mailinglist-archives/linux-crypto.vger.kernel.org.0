Return-Path: <linux-crypto+bounces-23360-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC/oFQk66mnrxAIAu9opvQ
	(envelope-from <linux-crypto+bounces-23360-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 17:26:01 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEC4544B6
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 103F93057E4B
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2026 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CA35DA46;
	Thu, 23 Apr 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UfD9SlG8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6483E342C88;
	Thu, 23 Apr 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957714; cv=none; b=PIjbSUhaRQdgPwWyOLCongeWmj7j2W5Hrl967JwOJui71nJE98u+kIFH/Up2l3bIJm01U5Y5fzEAW7q5b0dESkYLvDyw1pFs7OeCW3xqRBNlB9oBngNYr1A3FLZXR/rRnMbfERPf2GOuu4cLppYi0qyV6KPVyYlzWtlj969kiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957714; c=relaxed/simple;
	bh=XIsNAoi30PsM0iJpdf2oChkKJsZYggPFxnfs0dZFUM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F0/+DHXGgFCtEn40ZpWevXo/Z4AJx0l2BSftA5tzl2AtM1iVLL6Szme4YwTxKRo0jZ47YzEo/J/cjBx72vhHPKPNr8Vb+CPe5o0EesYR7RyiRtWrD1SlwJc3AMFzXonx9oz/J6hRbr0YJa85SaRySzsALTk3LuEo5dAkNwql894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UfD9SlG8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [127.0.1.1] (unknown [52.177.6.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5914F20B7165;
	Thu, 23 Apr 2026 08:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5914F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776957707;
	bh=2WGY0Xr4OWcuoDKIFjbEVHuS8imyUOJyUmF5Ad3Krqw=;
	h=From:Date:Subject:To:Cc:From;
	b=UfD9SlG8qmtSdJze3JZv8FkmAj1BKyxhCCKdbuCe+jgLX3FGKQkj3yQa5VtGB6Rj9
	 YoBSzF0PhML3dQ/4N/1UGK5MGtA/q5K+Wbwr+AbM8fCoqq49QTpiqC37sw8FLZ60ZX
	 rQgSpSOY/8vAOJJcH2ny2gClneX0b9jQmL3LdZzs=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Date: Thu, 23 Apr 2026 11:21:41 -0400
Subject: [PATCH v2] crypto: testmgr - disallow RSA PKCS#1 SHA-1 sig algs in
 FIPS mode
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-disallow_rsa_sha1_signing_in_fips_mode-v2-1-a5fe72dd8a71@linux.microsoft.com>
X-B4-Tracking: v=1; b=H4sIAAQ56mkC/5WNSw6CMBRFt0I6toY+AcWR+zCk6RdeAi3pI6gh7
 N3KDswdnTs4Z2PkEjpi92Jjya1IGEMGOBXMDCr0jqPNzKCEpqwAuEVS4xhfMpGSNCghCfuAoZc
 YpMeZ5BSt4zevdQPQKltXLMvm5Dy+j9CzyzwgLTF9ju4qfu/fiVXwvEvdanO1ldDuMaFJkaJfz
 iZOrNv3/Qt9rp+Z4AAAAA==
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-crypto@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jeff Barnes <jeffbarnes@linux.microsoft.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23360-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,foss.st.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFDEC4544B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When booted with fips=1, RSA signature generation using SHA-1 must not be
available.  However, pkcs1pad(rsa,sha1) can currently be instantiated
because it is not present in alg_test_descs; alg_test() falls through the
no_test path and succeeds, after which the algorithm appears in
/proc/crypto as fips-capable.

Add explicit alg_test_descs entries for pkcs1pad(rsa,sha1) and
pkcs1(rsa,sha1) without marking them fips_allowed, so they are treated as
not FIPS-allowed when fips=1 is enabled.

Include both names to cover kernels where RSA sign/verify is provided via
the pkcs1(...) signature template, while pkcs1pad(...) remains for the
traditional wrapper naming and/or RSAES operations.

Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
This series fixes an issue where SHA-1 RSA signature generation remains
available when booted with fips=1.

On a FIPS-enabled system, pkcs1pad(rsa,sha1) can be instantiated even
though SHA-1 must not be available for signature generation. The reason
is that the algorithm is not listed in crypto/testmgr.c's alg_test_descs,
so alg_test() falls through the no_test path and succeeds. Once
instantiated, /proc/crypto reports the algorithm as "fips: yes".

This patch adds explicit alg_test_descs entries for:

  - pkcs1pad(rsa,sha1)
  - pkcs1(rsa,sha1)

without setting fips=1, so they are treated as not FIPS-allowed in
FIPS mode.

Both names are covered to handle kernels where RSA signature operations
are provided via the pkcs1(...) signature template, while pkcs1pad(...)
remains for the historical wrapper naming and/or RSAES operations.

Reproducer / evidence (current behavior):
  1) Boot with fips=1 (confirm /proc/sys/crypto/fips_enabled == 1)
  2) Allocate the transform:
       crypto_alloc_akcipher("pkcs1pad(rsa,sha1)", 0, 0)
  3) Observe that /proc/crypto now contains:
       name   : pkcs1pad(rsa,sha1)
       fips   : yes
       selftest: passed
  4) A simple in-kernel demo module can instantiate the transform and reach
     the signing path in FIPS mode.

With this change, attempts to instantiate these SHA-1 RSA signing
templates in FIPS mode are rejected, preventing SHA-1 signature
generation in approved mode.

Thanks for taking a look.
---
Changes in v2:
- Rewrap commit message body to conform to 75-column limit
- Fix From/Signed-off-by address mismatch
Link to v1: https://lore.kernel.org/r/20260422-disallow_rsa_sha1_signing_in_fips_mode-v1-1-1359bc7d41be@microsoft.com
---
 crypto/testmgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 30671e7bc349..e54d298a26c1 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5306,6 +5306,9 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.sig = __VECS(pkcs1_rsa_none_tv_template)
 		}
+	}, {
+		.alg = "pkcs1(rsa,sha1)",
+		.test = alg_test_null,
 	}, {
 		.alg = "pkcs1(rsa,sha224)",
 		.test = alg_test_null,
@@ -5341,6 +5344,9 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "pkcs1pad(rsa)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "pkcs1pad(rsa,sha1)",
+		.test = alg_test_null,
 	}, {
 		.alg = "rfc3686(ctr(aes))",
 		.generic_driver = "rfc3686(ctr(aes-lib))",

---
base-commit: 8879a3c110cb8ca5a69c937643f226697aa551d9
change-id: 20260422-disallow_rsa_sha1_signing_in_fips_mode-8fbb6229ad54

Best regards,
-- 
Jeff Barnes <jeffbarnes@linux.microsoft.com>


