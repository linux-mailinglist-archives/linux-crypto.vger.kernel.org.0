Return-Path: <linux-crypto+bounces-23012-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOTRHr683mntHwAAu9opvQ
	(envelope-from <linux-crypto+bounces-23012-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 00:16:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0773FECE1
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 00:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8FC3053E32
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E938423D;
	Tue, 14 Apr 2026 22:15:07 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11077389E07
	for <linux-crypto@vger.kernel.org>; Tue, 14 Apr 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204907; cv=none; b=U2FizanLAL8s1vuEwpvuaktCp4PfdnqSUXAXXPwIdC/P/l8T2fOdXcAkLIzHUefQ48UY5mzPCpwk/I4eV7Gx2oJJEjYZkGZ0BJ7EdvkMU/KV1NCkHQh99UBqjt0Km7ekS3wiR6GOXtWjLpl8uKEmL6DcRTuhSrt/hQTaTzu4RyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204907; c=relaxed/simple;
	bh=UZW2AHoIhNhn+yCefOAfuBYpbKa6HnpLM9+FljlMqQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrZ3LourbcrzyzsoMfGrl0SZh9t/goFQ3w9cJaezhEzi0wgCXd0WeOd5C+XBsbvqIRNPgSN1O3xU4XBnxVUXkeZ616dw0kOAQ3lmXJFZTIdrcQVW/7iovWN1ZmYV0hrWeFYiEFqPMQtjAZakeFWnlsjVv/cTejA5koacF6ukL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8401F10605;
	Wed, 15 Apr 2026 00:14:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7B4F6602E52E; Wed, 15 Apr 2026 00:14:55 +0200 (CEST)
Date: Wed, 15 Apr 2026 00:14:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jason Donenfeld <jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ignat Korchagin <ignat@linux.win>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Tadeusz Struk <tstruk@gigaio.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: lib/mpi - Fix integer underflow in
 mpi_read_raw_from_sgl()
Message-ID: <ad68X6BveJXqynUk@wunner.de>
References: <59eca92ff4f87e2081777f1423a0efaaadcfdb39.1776003111.git.lukas@wunner.de>
 <20260414175903.GC24456@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414175903.GC24456@quark>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,kernel.org,gmail.com,gondor.apana.org.au,linux.win,redhat.com,gigaio.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23012-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: 8B0773FECE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:59:03AM -0700, Eric Biggers wrote:
> On Sun, Apr 12, 2026 at 04:19:47PM +0200, Lukas Wunner wrote:
> > Yiming reports an integer underflow in mpi_read_raw_from_sgl() when
> > subtracting "lzeros" from the unsigned "nbytes".
[...]
> 
> This code (which has no tests...) is unnecessarily hard to understand,
> though.  I haven't been able to fully understand the logic yet, but it
> looks like it still has bugs, including still reading past the given
> nbytes.  It should be possible to replace it with something simpler and
> less error-prone.

mpi_read_raw_from_sgl() skips over leading zero bytes in the scatterlist
and then over leading zero bits in the first non-zero byte, before it
starts copying data to the newly-allocated MPI.

One possible simplification is to use memchr_inv() to search for the
first non-zero byte, instead of open coding it.  See the patch below.
If you think it's a step in the right direction, I can submit the patch
in the next cycle.

-- >8 --

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index cb001aa..72e7ac7 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -17,6 +17,7 @@
 #include "sg_sw_sec4.h"
 #include "caampkc.h"
 #include <crypto/internal/engine.h>
+#include <linux/count_zeros.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -219,12 +220,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		/* do not strip more than given bytes */
-		while (len && !*buff && lzeros < nbytes) {
-			lzeros++;
-			len--;
-			buff++;
-		}
+		lzeros = count_leading_zerobytes(buff, min(len, nbytes));
+		len -= lzeros;
+		buff += lzeros;
 
 		if (len && *buff)
 			break;
diff --git a/include/linux/count_zeros.h b/include/linux/count_zeros.h
index 5b8ff5a..29d9d67 100644
--- a/include/linux/count_zeros.h
+++ b/include/linux/count_zeros.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_BITOPS_COUNT_ZEROS_H_
 #define _LINUX_BITOPS_COUNT_ZEROS_H_
 
+#include <linux/string.h>
 #include <asm/bitops.h>
 
 /**
@@ -50,4 +51,14 @@ static inline int count_trailing_zeros(unsigned long x)
 		return (x != 0) ? __ffs(x) : COUNT_TRAILING_ZEROS_0;
 }
 
+static inline size_t count_leading_zerobytes(const void *start, size_t len)
+{
+	void *first = memchr_inv(start, 0, len);
+
+	if (!first)
+		return len;
+
+	return first - start;
+}
+
 #endif /* _LINUX_BITOPS_COUNT_ZEROS_H_ */
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index 9359a58..011434d 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -347,11 +347,9 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	lzeros = 0;
 	len = 0;
 	while (nbytes > 0) {
-		while (len && !*buff && lzeros < nbytes) {
-			lzeros++;
-			len--;
-			buff++;
-		}
+		lzeros = count_leading_zerobytes(buff, min(len, nbytes));
+		len -= lzeros;
+		buff += lzeros;
 
 		if (len && *buff)
 			break;


