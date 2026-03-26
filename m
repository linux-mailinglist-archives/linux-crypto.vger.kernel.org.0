Return-Path: <linux-crypto+bounces-22396-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEaCKxp7xGlXzgQAu9opvQ
	(envelope-from <linux-crypto+bounces-22396-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:17:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33232D94D
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94A9C303F540
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052F1DFD96;
	Thu, 26 Mar 2026 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZGebSXv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9A18CBE1;
	Thu, 26 Mar 2026 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484209; cv=none; b=OQbzfxFfiO00Y6wNN6mrSKUa07f5L+ZHuPC7s5sxDkbiSr3uoAWC564D97j9hGeiqGRwmGIN97X0fhobDBXe6si+1BB/u3zKBqjwOi/8eW6dwp6M0VvPI/j+kMSlEjfv01vLXfu5F3VNCQuxgpMxpGUVDT1vaIWoDQseuNwM5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484209; c=relaxed/simple;
	bh=918U/x2A5qoTqvvGZC+deWV3o/6uEV0Q2smpsC2conA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUUhAVI284CILQGsnNz0EXE2AH7SPKYYmVA2tUgRgwlpK7GrFyfYha6MvDe8S6bU0SMIBHz7MsyWerCMczalpesELsfko7TgerP7rOWqjOKP590egLrfTbB4qnNZLTmnP6vKtxCnf3lkFj4lM9Cclj8kvrRQLHqXvaWylDxJ/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZGebSXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849B6C116C6;
	Thu, 26 Mar 2026 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774484209;
	bh=918U/x2A5qoTqvvGZC+deWV3o/6uEV0Q2smpsC2conA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZGebSXvt9wMCQ4YVgJ8u7tlfd41R6hSaMOdFf/RY/qQomb9LDBNJ4UgzGrni43GO
	 cZfDFDN2zPUjDWO0ANmxqvgax1YtKdPe6smTuIEq9+IZFovugvgKAzBKzZJqkXRUdQ
	 be7+huksfBSGpfTUM+mwjocWijdadt+akNTwtE2/nW75vuruNwUxbac6NB+gnAWQV2
	 c/aaWVON6OsvYgwMXxFL2I1iAFh/KWX8krb+4o7iksnYd96vzWWcRWacGNs49Kbz+d
	 YTVcV4RPtJ3eQ3nPfrKWdfjBXpmR25G6BsZLndFt+exPIaLN+RMcYCXFY50PF2Xr3/
	 YdlZ/dBcA/1ew==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Stephan Mueller <smueller@chronox.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 06/11] crypto: intel/keembay-ocs-ecc - Use crypto_stdrng_get_bytes()
Date: Wed, 25 Mar 2026 17:15:02 -0700
Message-ID: <20260326001507.66500-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326001507.66500-1-ebiggers@kernel.org>
References: <20260326001507.66500-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22396-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B33232D94D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the sequence of crypto_get_default_rng(),
crypto_rng_get_bytes(), and crypto_put_default_rng() with the equivalent
helper function crypto_stdrng_get_bytes().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-ecc.c b/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
index 59308926399d..e61a95f66a0c 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
@@ -228,16 +228,11 @@ static int kmb_ecc_point_mult(struct ocs_ecc_dev *ecc_dev,
 		      OCS_ECC_OP_SIZE_384 : OCS_ECC_OP_SIZE_256;
 	size_t nbytes = digits_to_bytes(curve->g.ndigits);
 	int rc = 0;
 
 	/* Generate random nbytes for Simple and Differential SCA protection. */
-	rc = crypto_get_default_rng();
-	if (rc)
-		return rc;
-
-	rc = crypto_rng_get_bytes(crypto_default_rng, sca, nbytes);
-	crypto_put_default_rng();
+	rc = crypto_stdrng_get_bytes(sca, nbytes);
 	if (rc)
 		return rc;
 
 	/* Wait engine to be idle before starting new operation. */
 	rc = ocs_ecc_wait_idle(ecc_dev);
@@ -507,18 +502,14 @@ static int kmb_ecc_gen_privkey(const struct ecc_curve *curve, u64 *privkey)
 	 * strength associated with N.
 	 *
 	 * The maximum security strength identified by NIST SP800-57pt1r4 for
 	 * ECC is 256 (N >= 512).
 	 *
-	 * This condition is met by the default RNG because it selects a favored
-	 * DRBG with a security strength of 256.
+	 * This condition is met by stdrng because it selects a favored DRBG
+	 * with a security strength of 256.
 	 */
-	if (crypto_get_default_rng())
-		return -EFAULT;
-
-	rc = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
-	crypto_put_default_rng();
+	rc = crypto_stdrng_get_bytes(priv, nbytes);
 	if (rc)
 		goto cleanup;
 
 	rc = kmb_ecc_is_key_valid(curve, priv, nbytes);
 	if (rc)
-- 
2.53.0


