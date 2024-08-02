Return-Path: <linux-crypto+bounces-5781-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8AE9457F2
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2024 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89F6B232D3
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2024 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0450535280;
	Fri,  2 Aug 2024 06:09:38 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB01757D
	for <linux-crypto@vger.kernel.org>; Fri,  2 Aug 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578977; cv=none; b=obGMSk4O0J60UR9rqP6Wm0edRT5yGDVWmKYPCGo2k21OrJW9A93rkTMyakhPkS88pf5+0ac0s0LsHb+3+9dW15IC13n6daxTTabTNgJ1Bp+Utu/8Iq4ZNkoKjgygL+lOJ+qKrW9RaOlOcLHFRnzLeHxlDscqnlc6YFwOgQ2+J4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578977; c=relaxed/simple;
	bh=eY5CYBhHdY9Embw168kCOaK1tJrxFZxka2jLoEcluUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpdVqhznB54LRChnQmesxxO7CM1jnlh2M5tmrym5gky/HnC0TpEJXfCnqzumJhPHDC5pt4mYJDQkpwj6XVaLTMAYD8KxsG6j2lcBeFjyyLfad0isEPA3vCDvAY0QdrJONLMbm1GxKuG4jutmcOJFWu2c9oMgHjeDbQgoBbKOFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sZlLG-001uxZ-14;
	Fri, 02 Aug 2024 14:09:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Aug 2024 14:09:27 +0800
Date: Fri, 2 Aug 2024 14:09:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Huaxin Lu <luhuaxin1@huawei.com>
Subject: [PATCH 2/2] Revert "lib/mpi: Extend the MPI library"
Message-ID: <Zqx4F9Lxe0vpNILZ@gondor.apana.org.au>
References: <Zqx3_BkW-PuWM8D9@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqx3_BkW-PuWM8D9@gondor.apana.org.au>

This partially reverts commit a8ea8bdd9df92a0e5db5b43900abb7a288b8a53e.

Most of it is no longer needed since sm2 has been removed.  However,
the following functions have been kept as they have developed other
uses:

mpi_test_bit
mpi_set_bit
mpi_rshift

mpi_add
mpi_sub
mpi_addm
mpi_subm

mpi_mul
mpi_mulm

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/linux/mpi.h           |  74 --------
 lib/crypto/mpi/Makefile       |   3 -
 lib/crypto/mpi/mpi-add.c      |  51 ------
 lib/crypto/mpi/mpi-bit.c      | 143 ---------------
 lib/crypto/mpi/mpi-cmp.c      |  46 +----
 lib/crypto/mpi/mpi-div.c      | 234 -----------------------
 lib/crypto/mpi/mpi-internal.h |  53 ------
 lib/crypto/mpi/mpi-inv.c      | 143 ---------------
 lib/crypto/mpi/mpi-mod.c      | 157 ----------------
 lib/crypto/mpi/mpicoder.c     | 336 ----------------------------------
 lib/crypto/mpi/mpih-div.c     | 294 -----------------------------
 lib/crypto/mpi/mpih-mul.c     |  25 ---
 lib/crypto/mpi/mpiutil.c      | 204 ---------------------
 13 files changed, 10 insertions(+), 1753 deletions(-)
 delete mode 100644 lib/crypto/mpi/mpi-div.c
 delete mode 100644 lib/crypto/mpi/mpi-inv.c
 delete mode 100644 lib/crypto/mpi/mpi-mod.c

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 89b720893e12..80d2be12502d 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -40,79 +40,21 @@ struct gcry_mpi {
 typedef struct gcry_mpi *MPI;
 
 #define mpi_get_nlimbs(a)     ((a)->nlimbs)
-#define mpi_has_sign(a)       ((a)->sign)
 
 /*-- mpiutil.c --*/
 MPI mpi_alloc(unsigned nlimbs);
-void mpi_clear(MPI a);
 void mpi_free(MPI a);
 int mpi_resize(MPI a, unsigned nlimbs);
 
-static inline MPI mpi_new(unsigned int nbits)
-{
-	return mpi_alloc((nbits + BITS_PER_MPI_LIMB - 1) / BITS_PER_MPI_LIMB);
-}
-
-MPI mpi_copy(MPI a);
-MPI mpi_alloc_like(MPI a);
-void mpi_snatch(MPI w, MPI u);
-MPI mpi_set(MPI w, MPI u);
-MPI mpi_set_ui(MPI w, unsigned long u);
-MPI mpi_alloc_set_ui(unsigned long u);
-void mpi_swap_cond(MPI a, MPI b, unsigned long swap);
-
-/* Constants used to return constant MPIs.  See mpi_init if you
- * want to add more constants.
- */
-#define MPI_NUMBER_OF_CONSTANTS 6
-enum gcry_mpi_constants {
-	MPI_C_ZERO,
-	MPI_C_ONE,
-	MPI_C_TWO,
-	MPI_C_THREE,
-	MPI_C_FOUR,
-	MPI_C_EIGHT
-};
-
-MPI mpi_const(enum gcry_mpi_constants no);
-
 /*-- mpicoder.c --*/
-
-/* Different formats of external big integer representation. */
-enum gcry_mpi_format {
-	GCRYMPI_FMT_NONE = 0,
-	GCRYMPI_FMT_STD = 1,    /* Twos complement stored without length. */
-	GCRYMPI_FMT_PGP = 2,    /* As used by OpenPGP (unsigned only). */
-	GCRYMPI_FMT_SSH = 3,    /* As used by SSH (like STD but with length). */
-	GCRYMPI_FMT_HEX = 4,    /* Hex format. */
-	GCRYMPI_FMT_USG = 5,    /* Like STD but unsigned. */
-	GCRYMPI_FMT_OPAQUE = 8  /* Opaque format (some functions only). */
-};
-
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
-int mpi_fromstr(MPI val, const char *str);
-MPI mpi_scanval(const char *string);
 MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int len);
 void *mpi_get_buffer(MPI a, unsigned *nbytes, int *sign);
 int mpi_read_buffer(MPI a, uint8_t *buf, unsigned buf_len, unsigned *nbytes,
 		    int *sign);
 int mpi_write_to_sgl(MPI a, struct scatterlist *sg, unsigned nbytes,
 		     int *sign);
-int mpi_print(enum gcry_mpi_format format, unsigned char *buffer,
-			size_t buflen, size_t *nwritten, MPI a);
-
-/*-- mpi-mod.c --*/
-void mpi_mod(MPI rem, MPI dividend, MPI divisor);
-
-/* Context used with Barrett reduction.  */
-struct barrett_ctx_s;
-typedef struct barrett_ctx_s *mpi_barrett_t;
-
-mpi_barrett_t mpi_barrett_init(MPI m, int copy);
-void mpi_barrett_free(mpi_barrett_t ctx);
-void mpi_mod_barrett(MPI r, MPI x, mpi_barrett_t ctx);
-void mpi_mul_barrett(MPI w, MPI u, MPI v, mpi_barrett_t ctx);
 
 /*-- mpi-pow.c --*/
 int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);
@@ -120,7 +62,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);
 /*-- mpi-cmp.c --*/
 int mpi_cmp_ui(MPI u, ulong v);
 int mpi_cmp(MPI u, MPI v);
-int mpi_cmpabs(MPI u, MPI v);
 
 /*-- mpi-sub-ui.c --*/
 int mpi_sub_ui(MPI w, MPI u, unsigned long vval);
@@ -130,16 +71,9 @@ void mpi_normalize(MPI a);
 unsigned mpi_get_nbits(MPI a);
 int mpi_test_bit(MPI a, unsigned int n);
 void mpi_set_bit(MPI a, unsigned int n);
-void mpi_set_highbit(MPI a, unsigned int n);
-void mpi_clear_highbit(MPI a, unsigned int n);
-void mpi_clear_bit(MPI a, unsigned int n);
-void mpi_rshift_limbs(MPI a, unsigned int count);
 void mpi_rshift(MPI x, MPI a, unsigned int n);
-void mpi_lshift_limbs(MPI a, unsigned int count);
-void mpi_lshift(MPI x, MPI a, unsigned int n);
 
 /*-- mpi-add.c --*/
-void mpi_add_ui(MPI w, MPI u, unsigned long v);
 void mpi_add(MPI w, MPI u, MPI v);
 void mpi_sub(MPI w, MPI u, MPI v);
 void mpi_addm(MPI w, MPI u, MPI v, MPI m);
@@ -149,14 +83,6 @@ void mpi_subm(MPI w, MPI u, MPI v, MPI m);
 void mpi_mul(MPI w, MPI u, MPI v);
 void mpi_mulm(MPI w, MPI u, MPI v, MPI m);
 
-/*-- mpi-div.c --*/
-void mpi_tdiv_r(MPI rem, MPI num, MPI den);
-void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor);
-void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor);
-
-/*-- mpi-inv.c --*/
-int mpi_invm(MPI x, MPI a, MPI n);
-
 /* inline functions */
 
 /**
diff --git a/lib/crypto/mpi/Makefile b/lib/crypto/mpi/Makefile
index 477debd7ed50..415279a95fde 100644
--- a/lib/crypto/mpi/Makefile
+++ b/lib/crypto/mpi/Makefile
@@ -18,9 +18,6 @@ mpi-y = \
 	mpi-bit.o			\
 	mpi-cmp.o			\
 	mpi-sub-ui.o			\
-	mpi-div.o			\
-	mpi-inv.o			\
-	mpi-mod.o			\
 	mpi-mul.o			\
 	mpih-cmp.o			\
 	mpih-div.o			\
diff --git a/lib/crypto/mpi/mpi-add.c b/lib/crypto/mpi/mpi-add.c
index 9056fc5167fc..b47c8c35f5fe 100644
--- a/lib/crypto/mpi/mpi-add.c
+++ b/lib/crypto/mpi/mpi-add.c
@@ -13,57 +13,6 @@
 
 #include "mpi-internal.h"
 
-/****************
- * Add the unsigned integer V to the mpi-integer U and store the
- * result in W. U and V may be the same.
- */
-void mpi_add_ui(MPI w, MPI u, unsigned long v)
-{
-	mpi_ptr_t wp, up;
-	mpi_size_t usize, wsize;
-	int usign, wsign;
-
-	usize = u->nlimbs;
-	usign = u->sign;
-	wsign = 0;
-
-	/* If not space for W (and possible carry), increase space.  */
-	wsize = usize + 1;
-	if (w->alloced < wsize)
-		mpi_resize(w, wsize);
-
-	/* These must be after realloc (U may be the same as W).  */
-	up = u->d;
-	wp = w->d;
-
-	if (!usize) {  /* simple */
-		wp[0] = v;
-		wsize = v ? 1:0;
-	} else if (!usign) {  /* mpi is not negative */
-		mpi_limb_t cy;
-		cy = mpihelp_add_1(wp, up, usize, v);
-		wp[usize] = cy;
-		wsize = usize + cy;
-	} else {
-		/* The signs are different.  Need exact comparison to determine
-		 * which operand to subtract from which.
-		 */
-		if (usize == 1 && up[0] < v) {
-			wp[0] = v - up[0];
-			wsize = 1;
-		} else {
-			mpihelp_sub_1(wp, up, usize, v);
-			/* Size can decrease with at most one limb. */
-			wsize = usize - (wp[usize-1] == 0);
-			wsign = 1;
-		}
-	}
-
-	w->nlimbs = wsize;
-	w->sign   = wsign;
-}
-
-
 void mpi_add(MPI w, MPI u, MPI v)
 {
 	mpi_ptr_t wp, up, vp;
diff --git a/lib/crypto/mpi/mpi-bit.c b/lib/crypto/mpi/mpi-bit.c
index e08fc202ea5c..c29b85362664 100644
--- a/lib/crypto/mpi/mpi-bit.c
+++ b/lib/crypto/mpi/mpi-bit.c
@@ -32,7 +32,6 @@ void mpi_normalize(MPI a)
 	for (; a->nlimbs && !a->d[a->nlimbs - 1]; a->nlimbs--)
 		;
 }
-EXPORT_SYMBOL_GPL(mpi_normalize);
 
 /****************
  * Return the number of bits in A.
@@ -93,85 +92,6 @@ void mpi_set_bit(MPI a, unsigned int n)
 	a->d[limbno] |= (A_LIMB_1<<bitno);
 }
 
-/****************
- * Set bit N of A. and clear all bits above
- */
-void mpi_set_highbit(MPI a, unsigned int n)
-{
-	unsigned int i, limbno, bitno;
-
-	limbno = n / BITS_PER_MPI_LIMB;
-	bitno  = n % BITS_PER_MPI_LIMB;
-
-	if (limbno >= a->nlimbs) {
-		for (i = a->nlimbs; i < a->alloced; i++)
-			a->d[i] = 0;
-		mpi_resize(a, limbno+1);
-		a->nlimbs = limbno+1;
-	}
-	a->d[limbno] |= (A_LIMB_1<<bitno);
-	for (bitno++; bitno < BITS_PER_MPI_LIMB; bitno++)
-		a->d[limbno] &= ~(A_LIMB_1 << bitno);
-	a->nlimbs = limbno+1;
-}
-EXPORT_SYMBOL_GPL(mpi_set_highbit);
-
-/****************
- * clear bit N of A and all bits above
- */
-void mpi_clear_highbit(MPI a, unsigned int n)
-{
-	unsigned int limbno, bitno;
-
-	limbno = n / BITS_PER_MPI_LIMB;
-	bitno  = n % BITS_PER_MPI_LIMB;
-
-	if (limbno >= a->nlimbs)
-		return; /* not allocated, therefore no need to clear bits :-) */
-
-	for ( ; bitno < BITS_PER_MPI_LIMB; bitno++)
-		a->d[limbno] &= ~(A_LIMB_1 << bitno);
-	a->nlimbs = limbno+1;
-}
-
-/****************
- * Clear bit N of A.
- */
-void mpi_clear_bit(MPI a, unsigned int n)
-{
-	unsigned int limbno, bitno;
-
-	limbno = n / BITS_PER_MPI_LIMB;
-	bitno  = n % BITS_PER_MPI_LIMB;
-
-	if (limbno >= a->nlimbs)
-		return; /* Don't need to clear this bit, it's far too left.  */
-	a->d[limbno] &= ~(A_LIMB_1 << bitno);
-}
-EXPORT_SYMBOL_GPL(mpi_clear_bit);
-
-
-/****************
- * Shift A by COUNT limbs to the right
- * This is used only within the MPI library
- */
-void mpi_rshift_limbs(MPI a, unsigned int count)
-{
-	mpi_ptr_t ap = a->d;
-	mpi_size_t n = a->nlimbs;
-	unsigned int i;
-
-	if (count >= n) {
-		a->nlimbs = 0;
-		return;
-	}
-
-	for (i = 0; i < n - count; i++)
-		ap[i] = ap[i+count];
-	ap[i] = 0;
-	a->nlimbs -= count;
-}
-
 /*
  * Shift A by N bits to the right.
  */
@@ -241,66 +161,3 @@ void mpi_rshift(MPI x, MPI a, unsigned int n)
 	MPN_NORMALIZE(x->d, x->nlimbs);
 }
 EXPORT_SYMBOL_GPL(mpi_rshift);
-
-/****************
- * Shift A by COUNT limbs to the left
- * This is used only within the MPI library
- */
-void mpi_lshift_limbs(MPI a, unsigned int count)
-{
-	mpi_ptr_t ap;
-	int n = a->nlimbs;
-	int i;
-
-	if (!count || !n)
-		return;
-
-	RESIZE_IF_NEEDED(a, n+count);
-
-	ap = a->d;
-	for (i = n-1; i >= 0; i--)
-		ap[i+count] = ap[i];
-	for (i = 0; i < count; i++)
-		ap[i] = 0;
-	a->nlimbs += count;
-}
-
-/*
- * Shift A by N bits to the left.
- */
-void mpi_lshift(MPI x, MPI a, unsigned int n)
-{
-	unsigned int nlimbs = (n/BITS_PER_MPI_LIMB);
-	unsigned int nbits = (n%BITS_PER_MPI_LIMB);
-
-	if (x == a && !n)
-		return;  /* In-place shift with an amount of zero.  */
-
-	if (x != a) {
-		/* Copy A to X.  */
-		unsigned int alimbs = a->nlimbs;
-		int asign = a->sign;
-		mpi_ptr_t xp, ap;
-
-		RESIZE_IF_NEEDED(x, alimbs+nlimbs+1);
-		xp = x->d;
-		ap = a->d;
-		MPN_COPY(xp, ap, alimbs);
-		x->nlimbs = alimbs;
-		x->flags = a->flags;
-		x->sign = asign;
-	}
-
-	if (nlimbs && !nbits) {
-		/* Shift a full number of limbs.  */
-		mpi_lshift_limbs(x, nlimbs);
-	} else if (n) {
-		/* We use a very dump approach: Shift left by the number of
-		 * limbs plus one and than fix it up by an rshift.
-		 */
-		mpi_lshift_limbs(x, nlimbs+1);
-		mpi_rshift(x, x, BITS_PER_MPI_LIMB - nbits);
-	}
-
-	MPN_NORMALIZE(x->d, x->nlimbs);
-}
diff --git a/lib/crypto/mpi/mpi-cmp.c b/lib/crypto/mpi/mpi-cmp.c
index 0835b6213235..ceaebe181cd7 100644
--- a/lib/crypto/mpi/mpi-cmp.c
+++ b/lib/crypto/mpi/mpi-cmp.c
@@ -45,54 +45,28 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 }
 EXPORT_SYMBOL_GPL(mpi_cmp_ui);
 
-static int do_mpi_cmp(MPI u, MPI v, int absmode)
+int mpi_cmp(MPI u, MPI v)
 {
-	mpi_size_t usize;
-	mpi_size_t vsize;
-	int usign;
-	int vsign;
+	mpi_size_t usize, vsize;
 	int cmp;
 
 	mpi_normalize(u);
 	mpi_normalize(v);
-
 	usize = u->nlimbs;
 	vsize = v->nlimbs;
-	usign = absmode ? 0 : u->sign;
-	vsign = absmode ? 0 : v->sign;
-
-	/* Compare sign bits.  */
-
-	if (!usign && vsign)
+	if (!u->sign && v->sign)
 		return 1;
-	if (usign && !vsign)
+	if (u->sign && !v->sign)
 		return -1;
-
-	/* U and V are either both positive or both negative.  */
-
-	if (usize != vsize && !usign && !vsign)
+	if (usize != vsize && !u->sign && !v->sign)
 		return usize - vsize;
-	if (usize != vsize && usign && vsign)
-		return vsize + usize;
+	if (usize != vsize && u->sign && v->sign)
+		return vsize - usize;
 	if (!usize)
 		return 0;
 	cmp = mpihelp_cmp(u->d, v->d, usize);
-	if (!cmp)
-		return 0;
-	if ((cmp < 0?1:0) == (usign?1:0))
-		return 1;
-
-	return -1;
-}
-
-int mpi_cmp(MPI u, MPI v)
-{
-	return do_mpi_cmp(u, v, 0);
+	if (u->sign)
+		return -cmp;
+	return cmp;
 }
 EXPORT_SYMBOL_GPL(mpi_cmp);
-
-int mpi_cmpabs(MPI u, MPI v)
-{
-	return do_mpi_cmp(u, v, 1);
-}
-EXPORT_SYMBOL_GPL(mpi_cmpabs);
diff --git a/lib/crypto/mpi/mpi-div.c b/lib/crypto/mpi/mpi-div.c
deleted file mode 100644
index 45beab8b9e9e..000000000000
--- a/lib/crypto/mpi/mpi-div.c
+++ /dev/null
@@ -1,234 +0,0 @@
-/* mpi-div.c  -  MPI functions
- * Copyright (C) 1994, 1996, 1998, 2001, 2002,
- *               2003 Free Software Foundation, Inc.
- *
- * This file is part of Libgcrypt.
- *
- * Note: This code is heavily based on the GNU MP Library.
- *	 Actually it's the same code with only minor changes in the
- *	 way the data is stored; this is to support the abstraction
- *	 of an optional secure memory allocation which may be used
- *	 to avoid revealing of sensitive data due to paging etc.
- */
-
-#include "mpi-internal.h"
-#include "longlong.h"
-
-void mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den);
-void mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor);
-
-void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor)
-{
-	int divisor_sign = divisor->sign;
-	MPI temp_divisor = NULL;
-
-	/* We need the original value of the divisor after the remainder has been
-	 * preliminary calculated.	We have to copy it to temporary space if it's
-	 * the same variable as REM.
-	 */
-	if (rem == divisor) {
-		temp_divisor = mpi_copy(divisor);
-		divisor = temp_divisor;
-	}
-
-	mpi_tdiv_r(rem, dividend, divisor);
-
-	if (((divisor_sign?1:0) ^ (dividend->sign?1:0)) && rem->nlimbs)
-		mpi_add(rem, rem, divisor);
-
-	if (temp_divisor)
-		mpi_free(temp_divisor);
-}
-
-void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor)
-{
-	MPI tmp = mpi_alloc(mpi_get_nlimbs(quot));
-	mpi_fdiv_qr(quot, tmp, dividend, divisor);
-	mpi_free(tmp);
-}
-
-void mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor)
-{
-	int divisor_sign = divisor->sign;
-	MPI temp_divisor = NULL;
-
-	if (quot == divisor || rem == divisor) {
-		temp_divisor = mpi_copy(divisor);
-		divisor = temp_divisor;
-	}
-
-	mpi_tdiv_qr(quot, rem, dividend, divisor);
-
-	if ((divisor_sign ^ dividend->sign) && rem->nlimbs) {
-		mpi_sub_ui(quot, quot, 1);
-		mpi_add(rem, rem, divisor);
-	}
-
-	if (temp_divisor)
-		mpi_free(temp_divisor);
-}
-
-/* If den == quot, den needs temporary storage.
- * If den == rem, den needs temporary storage.
- * If num == quot, num needs temporary storage.
- * If den has temporary storage, it can be normalized while being copied,
- *   i.e no extra storage should be allocated.
- */
-
-void mpi_tdiv_r(MPI rem, MPI num, MPI den)
-{
-	mpi_tdiv_qr(NULL, rem, num, den);
-}
-
-void mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den)
-{
-	mpi_ptr_t np, dp;
-	mpi_ptr_t qp, rp;
-	mpi_size_t nsize = num->nlimbs;
-	mpi_size_t dsize = den->nlimbs;
-	mpi_size_t qsize, rsize;
-	mpi_size_t sign_remainder = num->sign;
-	mpi_size_t sign_quotient = num->sign ^ den->sign;
-	unsigned int normalization_steps;
-	mpi_limb_t q_limb;
-	mpi_ptr_t marker[5];
-	int markidx = 0;
-
-	/* Ensure space is enough for quotient and remainder.
-	 * We need space for an extra limb in the remainder, because it's
-	 * up-shifted (normalized) below.
-	 */
-	rsize = nsize + 1;
-	mpi_resize(rem, rsize);
-
-	qsize = rsize - dsize;	  /* qsize cannot be bigger than this.	*/
-	if (qsize <= 0) {
-		if (num != rem) {
-			rem->nlimbs = num->nlimbs;
-			rem->sign = num->sign;
-			MPN_COPY(rem->d, num->d, nsize);
-		}
-		if (quot) {
-			/* This needs to follow the assignment to rem, in case the
-			 * numerator and quotient are the same.
-			 */
-			quot->nlimbs = 0;
-			quot->sign = 0;
-		}
-		return;
-	}
-
-	if (quot)
-		mpi_resize(quot, qsize);
-
-	/* Read pointers here, when reallocation is finished.  */
-	np = num->d;
-	dp = den->d;
-	rp = rem->d;
-
-	/* Optimize division by a single-limb divisor.  */
-	if (dsize == 1) {
-		mpi_limb_t rlimb;
-		if (quot) {
-			qp = quot->d;
-			rlimb = mpihelp_divmod_1(qp, np, nsize, dp[0]);
-			qsize -= qp[qsize - 1] == 0;
-			quot->nlimbs = qsize;
-			quot->sign = sign_quotient;
-		} else
-			rlimb = mpihelp_mod_1(np, nsize, dp[0]);
-		rp[0] = rlimb;
-		rsize = rlimb != 0?1:0;
-		rem->nlimbs = rsize;
-		rem->sign = sign_remainder;
-		return;
-	}
-
-
-	if (quot) {
-		qp = quot->d;
-		/* Make sure QP and NP point to different objects.  Otherwise the
-		 * numerator would be gradually overwritten by the quotient limbs.
-		 */
-		if (qp == np) { /* Copy NP object to temporary space.  */
-			np = marker[markidx++] = mpi_alloc_limb_space(nsize);
-			MPN_COPY(np, qp, nsize);
-		}
-	} else /* Put quotient at top of remainder. */
-		qp = rp + dsize;
-
-	normalization_steps = count_leading_zeros(dp[dsize - 1]);
-
-	/* Normalize the denominator, i.e. make its most significant bit set by
-	 * shifting it NORMALIZATION_STEPS bits to the left.  Also shift the
-	 * numerator the same number of steps (to keep the quotient the same!).
-	 */
-	if (normalization_steps) {
-		mpi_ptr_t tp;
-		mpi_limb_t nlimb;
-
-		/* Shift up the denominator setting the most significant bit of
-		 * the most significant word.  Use temporary storage not to clobber
-		 * the original contents of the denominator.
-		 */
-		tp = marker[markidx++] = mpi_alloc_limb_space(dsize);
-		mpihelp_lshift(tp, dp, dsize, normalization_steps);
-		dp = tp;
-
-		/* Shift up the numerator, possibly introducing a new most
-		 * significant word.  Move the shifted numerator in the remainder
-		 * meanwhile.
-		 */
-		nlimb = mpihelp_lshift(rp, np, nsize, normalization_steps);
-		if (nlimb) {
-			rp[nsize] = nlimb;
-			rsize = nsize + 1;
-		} else
-			rsize = nsize;
-	} else {
-		/* The denominator is already normalized, as required.	Copy it to
-		 * temporary space if it overlaps with the quotient or remainder.
-		 */
-		if (dp == rp || (quot && (dp == qp))) {
-			mpi_ptr_t tp;
-
-			tp = marker[markidx++] = mpi_alloc_limb_space(dsize);
-			MPN_COPY(tp, dp, dsize);
-			dp = tp;
-		}
-
-		/* Move the numerator to the remainder.  */
-		if (rp != np)
-			MPN_COPY(rp, np, nsize);
-
-		rsize = nsize;
-	}
-
-	q_limb = mpihelp_divrem(qp, 0, rp, rsize, dp, dsize);
-
-	if (quot) {
-		qsize = rsize - dsize;
-		if (q_limb) {
-			qp[qsize] = q_limb;
-			qsize += 1;
-		}
-
-		quot->nlimbs = qsize;
-		quot->sign = sign_quotient;
-	}
-
-	rsize = dsize;
-	MPN_NORMALIZE(rp, rsize);
-
-	if (normalization_steps && rsize) {
-		mpihelp_rshift(rp, rp, rsize, normalization_steps);
-		rsize -= rp[rsize - 1] == 0?1:0;
-	}
-
-	rem->nlimbs = rsize;
-	rem->sign	= sign_remainder;
-	while (markidx) {
-		markidx--;
-		mpi_free_limb_space(marker[markidx]);
-	}
-}
diff --git a/lib/crypto/mpi/mpi-internal.h b/lib/crypto/mpi/mpi-internal.h
index 554002182db1..91df5f0b70f2 100644
--- a/lib/crypto/mpi/mpi-internal.h
+++ b/lib/crypto/mpi/mpi-internal.h
@@ -52,12 +52,6 @@
 typedef mpi_limb_t *mpi_ptr_t;	/* pointer to a limb */
 typedef int mpi_size_t;		/* (must be a signed type) */
 
-#define RESIZE_IF_NEEDED(a, b)			\
-	do {					\
-		if ((a)->alloced < (b))		\
-			mpi_resize((a), (b));	\
-	} while (0)
-
 /* Copy N limbs from S to D.  */
 #define MPN_COPY(d, s, n) \
 	do {					\
@@ -66,14 +60,6 @@ typedef int mpi_size_t;		/* (must be a signed type) */
 			(d)[_i] = (s)[_i];	\
 	} while (0)
 
-#define MPN_COPY_INCR(d, s, n)		\
-	do {					\
-		mpi_size_t _i;			\
-		for (_i = 0; _i < (n); _i++)	\
-			(d)[_i] = (s)[_i];	\
-	} while (0)
-
-
 #define MPN_COPY_DECR(d, s, n) \
 	do {					\
 		mpi_size_t _i;			\
@@ -106,38 +92,6 @@ typedef int mpi_size_t;		/* (must be a signed type) */
 			mul_n(prodp, up, vp, size, tspace);	\
 	} while (0);
 
-/* Divide the two-limb number in (NH,,NL) by D, with DI being the largest
- * limb not larger than (2**(2*BITS_PER_MP_LIMB))/D - (2**BITS_PER_MP_LIMB).
- * If this would yield overflow, DI should be the largest possible number
- * (i.e., only ones).  For correct operation, the most significant bit of D
- * has to be set.  Put the quotient in Q and the remainder in R.
- */
-#define UDIV_QRNND_PREINV(q, r, nh, nl, d, di)				\
-	do {								\
-		mpi_limb_t _ql __maybe_unused;				\
-		mpi_limb_t _q, _r;					\
-		mpi_limb_t _xh, _xl;					\
-		umul_ppmm(_q, _ql, (nh), (di));				\
-		_q += (nh);	/* DI is 2**BITS_PER_MPI_LIMB too small */ \
-		umul_ppmm(_xh, _xl, _q, (d));				\
-		sub_ddmmss(_xh, _r, (nh), (nl), _xh, _xl);		\
-		if (_xh) {						\
-			sub_ddmmss(_xh, _r, _xh, _r, 0, (d));		\
-			_q++;						\
-			if (_xh) {					\
-				sub_ddmmss(_xh, _r, _xh, _r, 0, (d));	\
-				_q++;					\
-			}						\
-		}							\
-		if (_r >= (d)) {					\
-			_r -= (d);					\
-			_q++;						\
-		}							\
-		(r) = _r;						\
-		(q) = _q;						\
-	} while (0)
-
-
 /*-- mpiutil.c --*/
 mpi_ptr_t mpi_alloc_limb_space(unsigned nlimbs);
 void mpi_free_limb_space(mpi_ptr_t a);
@@ -181,8 +135,6 @@ int mpihelp_mul(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t usize,
 void mpih_sqr_n_basecase(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size);
 void mpih_sqr_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size,
 		mpi_ptr_t tspace);
-void mpihelp_mul_n(mpi_ptr_t prodp,
-		mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size);
 
 int mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
 			       mpi_ptr_t up, mpi_size_t usize,
@@ -194,14 +146,9 @@ mpi_limb_t mpihelp_mul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 
 /*-- mpih-div.c --*/
-mpi_limb_t mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-			 mpi_limb_t divisor_limb);
 mpi_limb_t mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limbs,
 			  mpi_ptr_t np, mpi_size_t nsize,
 			  mpi_ptr_t dp, mpi_size_t dsize);
-mpi_limb_t mpihelp_divmod_1(mpi_ptr_t quot_ptr,
-			    mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-			    mpi_limb_t divisor_limb);
 
 /*-- generic_mpih-[lr]shift.c --*/
 mpi_limb_t mpihelp_lshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
diff --git a/lib/crypto/mpi/mpi-inv.c b/lib/crypto/mpi/mpi-inv.c
deleted file mode 100644
index 61e37d18f793..000000000000
--- a/lib/crypto/mpi/mpi-inv.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/* mpi-inv.c  -  MPI functions
- *	Copyright (C) 1998, 2001, 2002, 2003 Free Software Foundation, Inc.
- *
- * This file is part of Libgcrypt.
- *
- * Libgcrypt is free software; you can redistribute it and/or modify
- * it under the terms of the GNU Lesser General Public License as
- * published by the Free Software Foundation; either version 2.1 of
- * the License, or (at your option) any later version.
- *
- * Libgcrypt is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "mpi-internal.h"
-
-/****************
- * Calculate the multiplicative inverse X of A mod N
- * That is: Find the solution x for
- *		1 = (a*x) mod n
- */
-int mpi_invm(MPI x, MPI a, MPI n)
-{
-	/* Extended Euclid's algorithm (See TAOCP Vol II, 4.5.2, Alg X)
-	 * modified according to Michael Penk's solution for Exercise 35
-	 * with further enhancement
-	 */
-	MPI u, v, u1, u2 = NULL, u3, v1, v2 = NULL, v3, t1, t2 = NULL, t3;
-	unsigned int k;
-	int sign;
-	int odd;
-
-	if (!mpi_cmp_ui(a, 0))
-		return 0; /* Inverse does not exists.  */
-	if (!mpi_cmp_ui(n, 1))
-		return 0; /* Inverse does not exists.  */
-
-	u = mpi_copy(a);
-	v = mpi_copy(n);
-
-	for (k = 0; !mpi_test_bit(u, 0) && !mpi_test_bit(v, 0); k++) {
-		mpi_rshift(u, u, 1);
-		mpi_rshift(v, v, 1);
-	}
-	odd = mpi_test_bit(v, 0);
-
-	u1 = mpi_alloc_set_ui(1);
-	if (!odd)
-		u2 = mpi_alloc_set_ui(0);
-	u3 = mpi_copy(u);
-	v1 = mpi_copy(v);
-	if (!odd) {
-		v2 = mpi_alloc(mpi_get_nlimbs(u));
-		mpi_sub(v2, u1, u); /* U is used as const 1 */
-	}
-	v3 = mpi_copy(v);
-	if (mpi_test_bit(u, 0)) { /* u is odd */
-		t1 = mpi_alloc_set_ui(0);
-		if (!odd) {
-			t2 = mpi_alloc_set_ui(1);
-			t2->sign = 1;
-		}
-		t3 = mpi_copy(v);
-		t3->sign = !t3->sign;
-		goto Y4;
-	} else {
-		t1 = mpi_alloc_set_ui(1);
-		if (!odd)
-			t2 = mpi_alloc_set_ui(0);
-		t3 = mpi_copy(u);
-	}
-
-	do {
-		do {
-			if (!odd) {
-				if (mpi_test_bit(t1, 0) || mpi_test_bit(t2, 0)) {
-					/* one is odd */
-					mpi_add(t1, t1, v);
-					mpi_sub(t2, t2, u);
-				}
-				mpi_rshift(t1, t1, 1);
-				mpi_rshift(t2, t2, 1);
-				mpi_rshift(t3, t3, 1);
-			} else {
-				if (mpi_test_bit(t1, 0))
-					mpi_add(t1, t1, v);
-				mpi_rshift(t1, t1, 1);
-				mpi_rshift(t3, t3, 1);
-			}
-Y4:
-			;
-		} while (!mpi_test_bit(t3, 0)); /* while t3 is even */
-
-		if (!t3->sign) {
-			mpi_set(u1, t1);
-			if (!odd)
-				mpi_set(u2, t2);
-			mpi_set(u3, t3);
-		} else {
-			mpi_sub(v1, v, t1);
-			sign = u->sign; u->sign = !u->sign;
-			if (!odd)
-				mpi_sub(v2, u, t2);
-			u->sign = sign;
-			sign = t3->sign; t3->sign = !t3->sign;
-			mpi_set(v3, t3);
-			t3->sign = sign;
-		}
-		mpi_sub(t1, u1, v1);
-		if (!odd)
-			mpi_sub(t2, u2, v2);
-		mpi_sub(t3, u3, v3);
-		if (t1->sign) {
-			mpi_add(t1, t1, v);
-			if (!odd)
-				mpi_sub(t2, t2, u);
-		}
-	} while (mpi_cmp_ui(t3, 0)); /* while t3 != 0 */
-	/* mpi_lshift( u3, k ); */
-	mpi_set(x, u1);
-
-	mpi_free(u1);
-	mpi_free(v1);
-	mpi_free(t1);
-	if (!odd) {
-		mpi_free(u2);
-		mpi_free(v2);
-		mpi_free(t2);
-	}
-	mpi_free(u3);
-	mpi_free(v3);
-	mpi_free(t3);
-
-	mpi_free(u);
-	mpi_free(v);
-	return 1;
-}
-EXPORT_SYMBOL_GPL(mpi_invm);
diff --git a/lib/crypto/mpi/mpi-mod.c b/lib/crypto/mpi/mpi-mod.c
deleted file mode 100644
index 54fcc01564d9..000000000000
--- a/lib/crypto/mpi/mpi-mod.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/* mpi-mod.c -  Modular reduction
- * Copyright (C) 1998, 1999, 2001, 2002, 2003,
- *               2007  Free Software Foundation, Inc.
- *
- * This file is part of Libgcrypt.
- */
-
-
-#include "mpi-internal.h"
-#include "longlong.h"
-
-/* Context used with Barrett reduction.  */
-struct barrett_ctx_s {
-	MPI m;   /* The modulus - may not be modified. */
-	int m_copied;   /* If true, M needs to be released.  */
-	int k;
-	MPI y;
-	MPI r1;  /* Helper MPI. */
-	MPI r2;  /* Helper MPI. */
-	MPI r3;  /* Helper MPI allocated on demand. */
-};
-
-
-
-void mpi_mod(MPI rem, MPI dividend, MPI divisor)
-{
-	mpi_fdiv_r(rem, dividend, divisor);
-}
-
-/* This function returns a new context for Barrett based operations on
- * the modulus M.  This context needs to be released using
- * _gcry_mpi_barrett_free.  If COPY is true M will be transferred to
- * the context and the user may change M.  If COPY is false, M may not
- * be changed until gcry_mpi_barrett_free has been called.
- */
-mpi_barrett_t mpi_barrett_init(MPI m, int copy)
-{
-	mpi_barrett_t ctx;
-	MPI tmp;
-
-	mpi_normalize(m);
-	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
-
-	if (copy) {
-		ctx->m = mpi_copy(m);
-		ctx->m_copied = 1;
-	} else
-		ctx->m = m;
-
-	ctx->k = mpi_get_nlimbs(m);
-	tmp = mpi_alloc(ctx->k + 1);
-
-	/* Barrett precalculation: y = floor(b^(2k) / m). */
-	mpi_set_ui(tmp, 1);
-	mpi_lshift_limbs(tmp, 2 * ctx->k);
-	mpi_fdiv_q(tmp, tmp, m);
-
-	ctx->y  = tmp;
-	ctx->r1 = mpi_alloc(2 * ctx->k + 1);
-	ctx->r2 = mpi_alloc(2 * ctx->k + 1);
-
-	return ctx;
-}
-
-void mpi_barrett_free(mpi_barrett_t ctx)
-{
-	if (ctx) {
-		mpi_free(ctx->y);
-		mpi_free(ctx->r1);
-		mpi_free(ctx->r2);
-		if (ctx->r3)
-			mpi_free(ctx->r3);
-		if (ctx->m_copied)
-			mpi_free(ctx->m);
-		kfree(ctx);
-	}
-}
-
-
-/* R = X mod M
- *
- * Using Barrett reduction.  Before using this function
- * _gcry_mpi_barrett_init must have been called to do the
- * precalculations.  CTX is the context created by this precalculation
- * and also conveys M.  If the Barret reduction could no be done a
- * straightforward reduction method is used.
- *
- * We assume that these conditions are met:
- * Input:  x =(x_2k-1 ...x_0)_b
- *     m =(m_k-1 ....m_0)_b	  with m_k-1 != 0
- * Output: r = x mod m
- */
-void mpi_mod_barrett(MPI r, MPI x, mpi_barrett_t ctx)
-{
-	MPI m = ctx->m;
-	int k = ctx->k;
-	MPI y = ctx->y;
-	MPI r1 = ctx->r1;
-	MPI r2 = ctx->r2;
-	int sign;
-
-	mpi_normalize(x);
-	if (mpi_get_nlimbs(x) > 2*k) {
-		mpi_mod(r, x, m);
-		return;
-	}
-
-	sign = x->sign;
-	x->sign = 0;
-
-	/* 1. q1 = floor( x / b^k-1)
-	 *    q2 = q1 * y
-	 *    q3 = floor( q2 / b^k+1 )
-	 * Actually, we don't need qx, we can work direct on r2
-	 */
-	mpi_set(r2, x);
-	mpi_rshift_limbs(r2, k-1);
-	mpi_mul(r2, r2, y);
-	mpi_rshift_limbs(r2, k+1);
-
-	/* 2. r1 = x mod b^k+1
-	 *	r2 = q3 * m mod b^k+1
-	 *	r  = r1 - r2
-	 * 3. if r < 0 then  r = r + b^k+1
-	 */
-	mpi_set(r1, x);
-	if (r1->nlimbs > k+1) /* Quick modulo operation.  */
-		r1->nlimbs = k+1;
-	mpi_mul(r2, r2, m);
-	if (r2->nlimbs > k+1) /* Quick modulo operation. */
-		r2->nlimbs = k+1;
-	mpi_sub(r, r1, r2);
-
-	if (mpi_has_sign(r)) {
-		if (!ctx->r3) {
-			ctx->r3 = mpi_alloc(k + 2);
-			mpi_set_ui(ctx->r3, 1);
-			mpi_lshift_limbs(ctx->r3, k + 1);
-		}
-		mpi_add(r, r, ctx->r3);
-	}
-
-	/* 4. while r >= m do r = r - m */
-	while (mpi_cmp(r, m) >= 0)
-		mpi_sub(r, r, m);
-
-	x->sign = sign;
-}
-
-
-void mpi_mul_barrett(MPI w, MPI u, MPI v, mpi_barrett_t ctx)
-{
-	mpi_mul(w, u, v);
-	mpi_mod_barrett(w, w, ctx);
-}
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index 3cb6bd148fa9..dde01030807d 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -25,7 +25,6 @@
 #include <linux/string.h>
 #include "mpi-internal.h"
 
-#define MAX_EXTERN_SCAN_BYTES (16*1024*1024)
 #define MAX_EXTERN_MPI_BITS 16384
 
 /**
@@ -110,112 +109,6 @@ MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
 }
 EXPORT_SYMBOL_GPL(mpi_read_from_buffer);
 
-/****************
- * Fill the mpi VAL from the hex string in STR.
- */
-int mpi_fromstr(MPI val, const char *str)
-{
-	int sign = 0;
-	int prepend_zero = 0;
-	int i, j, c, c1, c2;
-	unsigned int nbits, nbytes, nlimbs;
-	mpi_limb_t a;
-
-	if (*str == '-') {
-		sign = 1;
-		str++;
-	}
-
-	/* Skip optional hex prefix.  */
-	if (*str == '0' && str[1] == 'x')
-		str += 2;
-
-	nbits = strlen(str);
-	if (nbits > MAX_EXTERN_SCAN_BYTES) {
-		mpi_clear(val);
-		return -EINVAL;
-	}
-	nbits *= 4;
-	if ((nbits % 8))
-		prepend_zero = 1;
-
-	nbytes = (nbits+7) / 8;
-	nlimbs = (nbytes+BYTES_PER_MPI_LIMB-1) / BYTES_PER_MPI_LIMB;
-
-	if (val->alloced < nlimbs)
-		mpi_resize(val, nlimbs);
-
-	i = BYTES_PER_MPI_LIMB - (nbytes % BYTES_PER_MPI_LIMB);
-	i %= BYTES_PER_MPI_LIMB;
-	j = val->nlimbs = nlimbs;
-	val->sign = sign;
-	for (; j > 0; j--) {
-		a = 0;
-		for (; i < BYTES_PER_MPI_LIMB; i++) {
-			if (prepend_zero) {
-				c1 = '0';
-				prepend_zero = 0;
-			} else
-				c1 = *str++;
-
-			if (!c1) {
-				mpi_clear(val);
-				return -EINVAL;
-			}
-			c2 = *str++;
-			if (!c2) {
-				mpi_clear(val);
-				return -EINVAL;
-			}
-			if (c1 >= '0' && c1 <= '9')
-				c = c1 - '0';
-			else if (c1 >= 'a' && c1 <= 'f')
-				c = c1 - 'a' + 10;
-			else if (c1 >= 'A' && c1 <= 'F')
-				c = c1 - 'A' + 10;
-			else {
-				mpi_clear(val);
-				return -EINVAL;
-			}
-			c <<= 4;
-			if (c2 >= '0' && c2 <= '9')
-				c |= c2 - '0';
-			else if (c2 >= 'a' && c2 <= 'f')
-				c |= c2 - 'a' + 10;
-			else if (c2 >= 'A' && c2 <= 'F')
-				c |= c2 - 'A' + 10;
-			else {
-				mpi_clear(val);
-				return -EINVAL;
-			}
-			a <<= 8;
-			a |= c;
-		}
-		i = 0;
-		val->d[j-1] = a;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mpi_fromstr);
-
-MPI mpi_scanval(const char *string)
-{
-	MPI a;
-
-	a = mpi_alloc(0);
-	if (!a)
-		return NULL;
-
-	if (mpi_fromstr(a, string)) {
-		mpi_free(a);
-		return NULL;
-	}
-	mpi_normalize(a);
-	return a;
-}
-EXPORT_SYMBOL_GPL(mpi_scanval);
-
 static int count_lzeros(MPI a)
 {
 	mpi_limb_t alimb;
@@ -521,232 +414,3 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	return val;
 }
 EXPORT_SYMBOL_GPL(mpi_read_raw_from_sgl);
-
-/* Perform a two's complement operation on buffer P of size N bytes.  */
-static void twocompl(unsigned char *p, unsigned int n)
-{
-	int i;
-
-	for (i = n-1; i >= 0 && !p[i]; i--)
-		;
-	if (i >= 0) {
-		if ((p[i] & 0x01))
-			p[i] = (((p[i] ^ 0xfe) | 0x01) & 0xff);
-		else if ((p[i] & 0x02))
-			p[i] = (((p[i] ^ 0xfc) | 0x02) & 0xfe);
-		else if ((p[i] & 0x04))
-			p[i] = (((p[i] ^ 0xf8) | 0x04) & 0xfc);
-		else if ((p[i] & 0x08))
-			p[i] = (((p[i] ^ 0xf0) | 0x08) & 0xf8);
-		else if ((p[i] & 0x10))
-			p[i] = (((p[i] ^ 0xe0) | 0x10) & 0xf0);
-		else if ((p[i] & 0x20))
-			p[i] = (((p[i] ^ 0xc0) | 0x20) & 0xe0);
-		else if ((p[i] & 0x40))
-			p[i] = (((p[i] ^ 0x80) | 0x40) & 0xc0);
-		else
-			p[i] = 0x80;
-
-		for (i--; i >= 0; i--)
-			p[i] ^= 0xff;
-	}
-}
-
-int mpi_print(enum gcry_mpi_format format, unsigned char *buffer,
-			size_t buflen, size_t *nwritten, MPI a)
-{
-	unsigned int nbits = mpi_get_nbits(a);
-	size_t len;
-	size_t dummy_nwritten;
-	int negative;
-
-	if (!nwritten)
-		nwritten = &dummy_nwritten;
-
-	/* Libgcrypt does no always care to set clear the sign if the value
-	 * is 0.  For printing this is a bit of a surprise, in particular
-	 * because if some of the formats don't support negative numbers but
-	 * should be able to print a zero.  Thus we need this extra test
-	 * for a negative number.
-	 */
-	if (a->sign && mpi_cmp_ui(a, 0))
-		negative = 1;
-	else
-		negative = 0;
-
-	len = buflen;
-	*nwritten = 0;
-	if (format == GCRYMPI_FMT_STD) {
-		unsigned char *tmp;
-		int extra = 0;
-		unsigned int n;
-
-		tmp = mpi_get_buffer(a, &n, NULL);
-		if (!tmp)
-			return -EINVAL;
-
-		if (negative) {
-			twocompl(tmp, n);
-			if (!(*tmp & 0x80)) {
-				/* Need to extend the sign.  */
-				n++;
-				extra = 2;
-			}
-		} else if (n && (*tmp & 0x80)) {
-			/* Positive but the high bit of the returned buffer is set.
-			 * Thus we need to print an extra leading 0x00 so that the
-			 * output is interpreted as a positive number.
-			 */
-			n++;
-			extra = 1;
-		}
-
-		if (buffer && n > len) {
-			/* The provided buffer is too short. */
-			kfree(tmp);
-			return -E2BIG;
-		}
-		if (buffer) {
-			unsigned char *s = buffer;
-
-			if (extra == 1)
-				*s++ = 0;
-			else if (extra)
-				*s++ = 0xff;
-			memcpy(s, tmp, n-!!extra);
-		}
-		kfree(tmp);
-		*nwritten = n;
-		return 0;
-	} else if (format == GCRYMPI_FMT_USG) {
-		unsigned int n = (nbits + 7)/8;
-
-		/* Note:  We ignore the sign for this format.  */
-		/* FIXME: for performance reasons we should put this into
-		 * mpi_aprint because we can then use the buffer directly.
-		 */
-
-		if (buffer && n > len)
-			return -E2BIG;
-		if (buffer) {
-			unsigned char *tmp;
-
-			tmp = mpi_get_buffer(a, &n, NULL);
-			if (!tmp)
-				return -EINVAL;
-			memcpy(buffer, tmp, n);
-			kfree(tmp);
-		}
-		*nwritten = n;
-		return 0;
-	} else if (format == GCRYMPI_FMT_PGP) {
-		unsigned int n = (nbits + 7)/8;
-
-		/* The PGP format can only handle unsigned integers.  */
-		if (negative)
-			return -EINVAL;
-
-		if (buffer && n+2 > len)
-			return -E2BIG;
-
-		if (buffer) {
-			unsigned char *tmp;
-			unsigned char *s = buffer;
-
-			s[0] = nbits >> 8;
-			s[1] = nbits;
-
-			tmp = mpi_get_buffer(a, &n, NULL);
-			if (!tmp)
-				return -EINVAL;
-			memcpy(s+2, tmp, n);
-			kfree(tmp);
-		}
-		*nwritten = n+2;
-		return 0;
-	} else if (format == GCRYMPI_FMT_SSH) {
-		unsigned char *tmp;
-		int extra = 0;
-		unsigned int n;
-
-		tmp = mpi_get_buffer(a, &n, NULL);
-		if (!tmp)
-			return -EINVAL;
-
-		if (negative) {
-			twocompl(tmp, n);
-			if (!(*tmp & 0x80)) {
-				/* Need to extend the sign.  */
-				n++;
-				extra = 2;
-			}
-		} else if (n && (*tmp & 0x80)) {
-			n++;
-			extra = 1;
-		}
-
-		if (buffer && n+4 > len) {
-			kfree(tmp);
-			return -E2BIG;
-		}
-
-		if (buffer) {
-			unsigned char *s = buffer;
-
-			*s++ = n >> 24;
-			*s++ = n >> 16;
-			*s++ = n >> 8;
-			*s++ = n;
-			if (extra == 1)
-				*s++ = 0;
-			else if (extra)
-				*s++ = 0xff;
-			memcpy(s, tmp, n-!!extra);
-		}
-		kfree(tmp);
-		*nwritten = 4+n;
-		return 0;
-	} else if (format == GCRYMPI_FMT_HEX) {
-		unsigned char *tmp;
-		int i;
-		int extra = 0;
-		unsigned int n = 0;
-
-		tmp = mpi_get_buffer(a, &n, NULL);
-		if (!tmp)
-			return -EINVAL;
-		if (!n || (*tmp & 0x80))
-			extra = 2;
-
-		if (buffer && 2*n + extra + negative + 1 > len) {
-			kfree(tmp);
-			return -E2BIG;
-		}
-		if (buffer) {
-			unsigned char *s = buffer;
-
-			if (negative)
-				*s++ = '-';
-			if (extra) {
-				*s++ = '0';
-				*s++ = '0';
-			}
-
-			for (i = 0; i < n; i++) {
-				unsigned int c = tmp[i];
-
-				*s++ = (c >> 4) < 10 ? '0'+(c>>4) : 'A'+(c>>4)-10;
-				c &= 15;
-				*s++ = c < 10 ? '0'+c : 'A'+c-10;
-			}
-			*s++ = 0;
-			*nwritten = s - buffer;
-		} else {
-			*nwritten = 2*n + extra + negative + 1;
-		}
-		kfree(tmp);
-		return 0;
-	} else
-		return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(mpi_print);
diff --git a/lib/crypto/mpi/mpih-div.c b/lib/crypto/mpi/mpih-div.c
index be70ee2e42d3..913a519eb005 100644
--- a/lib/crypto/mpi/mpih-div.c
+++ b/lib/crypto/mpi/mpih-div.c
@@ -24,150 +24,6 @@
 #define UDIV_TIME UMUL_TIME
 #endif
 
-
-mpi_limb_t
-mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-			mpi_limb_t divisor_limb)
-{
-	mpi_size_t i;
-	mpi_limb_t n1, n0, r;
-	mpi_limb_t dummy __maybe_unused;
-
-	/* Botch: Should this be handled at all?  Rely on callers?	*/
-	if (!dividend_size)
-		return 0;
-
-	/* If multiplication is much faster than division, and the
-	 * dividend is large, pre-invert the divisor, and use
-	 * only multiplications in the inner loop.
-	 *
-	 * This test should be read:
-	 *	 Does it ever help to use udiv_qrnnd_preinv?
-	 *	   && Does what we save compensate for the inversion overhead?
-	 */
-	if (UDIV_TIME > (2 * UMUL_TIME + 6)
-			&& (UDIV_TIME - (2 * UMUL_TIME + 6)) * dividend_size > UDIV_TIME) {
-		int normalization_steps;
-
-		normalization_steps = count_leading_zeros(divisor_limb);
-		if (normalization_steps) {
-			mpi_limb_t divisor_limb_inverted;
-
-			divisor_limb <<= normalization_steps;
-
-			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
-			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
-			 * most significant bit (with weight 2**N) implicit.
-			 *
-			 * Special case for DIVISOR_LIMB == 100...000.
-			 */
-			if (!(divisor_limb << 1))
-				divisor_limb_inverted = ~(mpi_limb_t)0;
-			else
-				udiv_qrnnd(divisor_limb_inverted, dummy,
-						-divisor_limb, 0, divisor_limb);
-
-			n1 = dividend_ptr[dividend_size - 1];
-			r = n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
-
-			/* Possible optimization:
-			 * if (r == 0
-			 * && divisor_limb > ((n1 << normalization_steps)
-			 *		       | (dividend_ptr[dividend_size - 2] >> ...)))
-			 * ...one division less...
-			 */
-			for (i = dividend_size - 2; i >= 0; i--) {
-				n0 = dividend_ptr[i];
-				UDIV_QRNND_PREINV(dummy, r, r,
-						((n1 << normalization_steps)
-						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
-						divisor_limb, divisor_limb_inverted);
-				n1 = n0;
-			}
-			UDIV_QRNND_PREINV(dummy, r, r,
-					n1 << normalization_steps,
-					divisor_limb, divisor_limb_inverted);
-			return r >> normalization_steps;
-		} else {
-			mpi_limb_t divisor_limb_inverted;
-
-			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
-			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
-			 * most significant bit (with weight 2**N) implicit.
-			 *
-			 * Special case for DIVISOR_LIMB == 100...000.
-			 */
-			if (!(divisor_limb << 1))
-				divisor_limb_inverted = ~(mpi_limb_t)0;
-			else
-				udiv_qrnnd(divisor_limb_inverted, dummy,
-						-divisor_limb, 0, divisor_limb);
-
-			i = dividend_size - 1;
-			r = dividend_ptr[i];
-
-			if (r >= divisor_limb)
-				r = 0;
-			else
-				i--;
-
-			for ( ; i >= 0; i--) {
-				n0 = dividend_ptr[i];
-				UDIV_QRNND_PREINV(dummy, r, r,
-						n0, divisor_limb, divisor_limb_inverted);
-			}
-			return r;
-		}
-	} else {
-		if (UDIV_NEEDS_NORMALIZATION) {
-			int normalization_steps;
-
-			normalization_steps = count_leading_zeros(divisor_limb);
-			if (normalization_steps) {
-				divisor_limb <<= normalization_steps;
-
-				n1 = dividend_ptr[dividend_size - 1];
-				r = n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
-
-				/* Possible optimization:
-				 * if (r == 0
-				 * && divisor_limb > ((n1 << normalization_steps)
-				 *		   | (dividend_ptr[dividend_size - 2] >> ...)))
-				 * ...one division less...
-				 */
-				for (i = dividend_size - 2; i >= 0; i--) {
-					n0 = dividend_ptr[i];
-					udiv_qrnnd(dummy, r, r,
-						((n1 << normalization_steps)
-						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
-						divisor_limb);
-					n1 = n0;
-				}
-				udiv_qrnnd(dummy, r, r,
-						n1 << normalization_steps,
-						divisor_limb);
-				return r >> normalization_steps;
-			}
-		}
-		/* No normalization needed, either because udiv_qrnnd doesn't require
-		 * it, or because DIVISOR_LIMB is already normalized.
-		 */
-		i = dividend_size - 1;
-		r = dividend_ptr[i];
-
-		if (r >= divisor_limb)
-			r = 0;
-		else
-			i--;
-
-		for (; i >= 0; i--) {
-			n0 = dividend_ptr[i];
-			udiv_qrnnd(dummy, r, r, n0, divisor_limb);
-		}
-		return r;
-	}
-}
-
 /* Divide num (NP/NSIZE) by den (DP/DSIZE) and write
  * the NSIZE-DSIZE least significant quotient limbs at QP
  * and the DSIZE long remainder at NP.	If QEXTRA_LIMBS is
@@ -365,153 +221,3 @@ mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limbs,
 
 	return most_significant_q_limb;
 }
-
-/****************
- * Divide (DIVIDEND_PTR,,DIVIDEND_SIZE) by DIVISOR_LIMB.
- * Write DIVIDEND_SIZE limbs of quotient at QUOT_PTR.
- * Return the single-limb remainder.
- * There are no constraints on the value of the divisor.
- *
- * QUOT_PTR and DIVIDEND_PTR might point to the same limb.
- */
-
-mpi_limb_t
-mpihelp_divmod_1(mpi_ptr_t quot_ptr,
-		mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-		mpi_limb_t divisor_limb)
-{
-	mpi_size_t i;
-	mpi_limb_t n1, n0, r;
-	mpi_limb_t dummy __maybe_unused;
-
-	if (!dividend_size)
-		return 0;
-
-	/* If multiplication is much faster than division, and the
-	 * dividend is large, pre-invert the divisor, and use
-	 * only multiplications in the inner loop.
-	 *
-	 * This test should be read:
-	 * Does it ever help to use udiv_qrnnd_preinv?
-	 * && Does what we save compensate for the inversion overhead?
-	 */
-	if (UDIV_TIME > (2 * UMUL_TIME + 6)
-			&& (UDIV_TIME - (2 * UMUL_TIME + 6)) * dividend_size > UDIV_TIME) {
-		int normalization_steps;
-
-		normalization_steps = count_leading_zeros(divisor_limb);
-		if (normalization_steps) {
-			mpi_limb_t divisor_limb_inverted;
-
-			divisor_limb <<= normalization_steps;
-
-			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
-			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
-			 * most significant bit (with weight 2**N) implicit.
-			 */
-			/* Special case for DIVISOR_LIMB == 100...000.  */
-			if (!(divisor_limb << 1))
-				divisor_limb_inverted = ~(mpi_limb_t)0;
-			else
-				udiv_qrnnd(divisor_limb_inverted, dummy,
-						-divisor_limb, 0, divisor_limb);
-
-			n1 = dividend_ptr[dividend_size - 1];
-			r = n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
-
-			/* Possible optimization:
-			 * if (r == 0
-			 * && divisor_limb > ((n1 << normalization_steps)
-			 *		       | (dividend_ptr[dividend_size - 2] >> ...)))
-			 * ...one division less...
-			 */
-			for (i = dividend_size - 2; i >= 0; i--) {
-				n0 = dividend_ptr[i];
-				UDIV_QRNND_PREINV(quot_ptr[i + 1], r, r,
-						((n1 << normalization_steps)
-						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
-						divisor_limb, divisor_limb_inverted);
-				n1 = n0;
-			}
-			UDIV_QRNND_PREINV(quot_ptr[0], r, r,
-					n1 << normalization_steps,
-					divisor_limb, divisor_limb_inverted);
-			return r >> normalization_steps;
-		} else {
-			mpi_limb_t divisor_limb_inverted;
-
-			/* Compute (2**2N - 2**N * DIVISOR_LIMB) / DIVISOR_LIMB.  The
-			 * result is a (N+1)-bit approximation to 1/DIVISOR_LIMB, with the
-			 * most significant bit (with weight 2**N) implicit.
-			 */
-			/* Special case for DIVISOR_LIMB == 100...000.  */
-			if (!(divisor_limb << 1))
-				divisor_limb_inverted = ~(mpi_limb_t) 0;
-			else
-				udiv_qrnnd(divisor_limb_inverted, dummy,
-						-divisor_limb, 0, divisor_limb);
-
-			i = dividend_size - 1;
-			r = dividend_ptr[i];
-
-			if (r >= divisor_limb)
-				r = 0;
-			else
-				quot_ptr[i--] = 0;
-
-			for ( ; i >= 0; i--) {
-				n0 = dividend_ptr[i];
-				UDIV_QRNND_PREINV(quot_ptr[i], r, r,
-						n0, divisor_limb, divisor_limb_inverted);
-			}
-			return r;
-		}
-	} else {
-		if (UDIV_NEEDS_NORMALIZATION) {
-			int normalization_steps;
-
-			normalization_steps = count_leading_zeros(divisor_limb);
-			if (normalization_steps) {
-				divisor_limb <<= normalization_steps;
-
-				n1 = dividend_ptr[dividend_size - 1];
-				r = n1 >> (BITS_PER_MPI_LIMB - normalization_steps);
-
-				/* Possible optimization:
-				 * if (r == 0
-				 * && divisor_limb > ((n1 << normalization_steps)
-				 *		   | (dividend_ptr[dividend_size - 2] >> ...)))
-				 * ...one division less...
-				 */
-				for (i = dividend_size - 2; i >= 0; i--) {
-					n0 = dividend_ptr[i];
-					udiv_qrnnd(quot_ptr[i + 1], r, r,
-						((n1 << normalization_steps)
-						 | (n0 >> (BITS_PER_MPI_LIMB - normalization_steps))),
-						divisor_limb);
-					n1 = n0;
-				}
-				udiv_qrnnd(quot_ptr[0], r, r,
-						n1 << normalization_steps,
-						divisor_limb);
-				return r >> normalization_steps;
-			}
-		}
-		/* No normalization needed, either because udiv_qrnnd doesn't require
-		 * it, or because DIVISOR_LIMB is already normalized.
-		 */
-		i = dividend_size - 1;
-		r = dividend_ptr[i];
-
-		if (r >= divisor_limb)
-			r = 0;
-		else
-			quot_ptr[i--] = 0;
-
-		for (; i >= 0; i--) {
-			n0 = dividend_ptr[i];
-			udiv_qrnnd(quot_ptr[i], r, r, n0, divisor_limb);
-		}
-		return r;
-	}
-}
diff --git a/lib/crypto/mpi/mpih-mul.c b/lib/crypto/mpi/mpih-mul.c
index e5f1c84e3c48..a93647564054 100644
--- a/lib/crypto/mpi/mpih-mul.c
+++ b/lib/crypto/mpi/mpih-mul.c
@@ -317,31 +317,6 @@ mpih_sqr_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size, mpi_ptr_t tspace)
 	}
 }
 
-
-void mpihelp_mul_n(mpi_ptr_t prodp,
-		mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size)
-{
-	if (up == vp) {
-		if (size < KARATSUBA_THRESHOLD)
-			mpih_sqr_n_basecase(prodp, up, size);
-		else {
-			mpi_ptr_t tspace;
-			tspace = mpi_alloc_limb_space(2 * size);
-			mpih_sqr_n(prodp, up, size, tspace);
-			mpi_free_limb_space(tspace);
-		}
-	} else {
-		if (size < KARATSUBA_THRESHOLD)
-			mul_n_basecase(prodp, up, vp, size);
-		else {
-			mpi_ptr_t tspace;
-			tspace = mpi_alloc_limb_space(2 * size);
-			mul_n(prodp, up, vp, size, tspace);
-			mpi_free_limb_space(tspace);
-		}
-	}
-}
-
 int
 mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
 			   mpi_ptr_t up, mpi_size_t usize,
diff --git a/lib/crypto/mpi/mpiutil.c b/lib/crypto/mpi/mpiutil.c
index aa8c46544af8..34965a4bf182 100644
--- a/lib/crypto/mpi/mpiutil.c
+++ b/lib/crypto/mpi/mpiutil.c
@@ -20,63 +20,6 @@
 
 #include "mpi-internal.h"
 
-/* Constants allocated right away at startup.  */
-static MPI constants[MPI_NUMBER_OF_CONSTANTS];
-
-/* Initialize the MPI subsystem.  This is called early and allows to
- * do some initialization without taking care of threading issues.
- */
-static int __init mpi_init(void)
-{
-	int idx;
-	unsigned long value;
-
-	for (idx = 0; idx < MPI_NUMBER_OF_CONSTANTS; idx++) {
-		switch (idx) {
-		case MPI_C_ZERO:
-			value = 0;
-			break;
-		case MPI_C_ONE:
-			value = 1;
-			break;
-		case MPI_C_TWO:
-			value = 2;
-			break;
-		case MPI_C_THREE:
-			value = 3;
-			break;
-		case MPI_C_FOUR:
-			value = 4;
-			break;
-		case MPI_C_EIGHT:
-			value = 8;
-			break;
-		default:
-			pr_err("MPI: invalid mpi_const selector %d\n", idx);
-			return -EFAULT;
-		}
-		constants[idx] = mpi_alloc_set_ui(value);
-		constants[idx]->flags = (16|32);
-	}
-
-	return 0;
-}
-postcore_initcall(mpi_init);
-
-/* Return a constant MPI descripbed by NO which is one of the
- * MPI_C_xxx macros.  There is no need to copy this returned value; it
- * may be used directly.
- */
-MPI mpi_const(enum gcry_mpi_constants no)
-{
-	if ((int)no < 0 || no > MPI_NUMBER_OF_CONSTANTS)
-		pr_err("MPI: invalid mpi_const selector %d\n", no);
-	if (!constants[no])
-		pr_err("MPI: MPI subsystem not initialized\n");
-	return constants[no];
-}
-EXPORT_SYMBOL_GPL(mpi_const);
-
 /****************
  * Note:  It was a bad idea to use the number of limbs to allocate
  *	  because on a alpha the limbs are large but we normally need
@@ -163,15 +106,6 @@ int mpi_resize(MPI a, unsigned nlimbs)
 	return 0;
 }
 
-void mpi_clear(MPI a)
-{
-	if (!a)
-		return;
-	a->nlimbs = 0;
-	a->flags = 0;
-}
-EXPORT_SYMBOL_GPL(mpi_clear);
-
 void mpi_free(MPI a)
 {
 	if (!a)
@@ -188,143 +122,5 @@ void mpi_free(MPI a)
 }
 EXPORT_SYMBOL_GPL(mpi_free);
 
-/****************
- * Note: This copy function should not interpret the MPI
- *	 but copy it transparently.
- */
-MPI mpi_copy(MPI a)
-{
-	int i;
-	MPI b;
-
-	if (a) {
-		b = mpi_alloc(a->nlimbs);
-		b->nlimbs = a->nlimbs;
-		b->sign = a->sign;
-		b->flags = a->flags;
-		b->flags &= ~(16|32); /* Reset the immutable and constant flags. */
-		for (i = 0; i < b->nlimbs; i++)
-			b->d[i] = a->d[i];
-	} else
-		b = NULL;
-	return b;
-}
-
-/****************
- * This function allocates an MPI which is optimized to hold
- * a value as large as the one given in the argument and allocates it
- * with the same flags as A.
- */
-MPI mpi_alloc_like(MPI a)
-{
-	MPI b;
-
-	if (a) {
-		b = mpi_alloc(a->nlimbs);
-		b->nlimbs = 0;
-		b->sign = 0;
-		b->flags = a->flags;
-	} else
-		b = NULL;
-
-	return b;
-}
-
-
-/* Set U into W and release U.  If W is NULL only U will be released. */
-void mpi_snatch(MPI w, MPI u)
-{
-	if (w) {
-		mpi_assign_limb_space(w, u->d, u->alloced);
-		w->nlimbs = u->nlimbs;
-		w->sign   = u->sign;
-		w->flags  = u->flags;
-		u->alloced = 0;
-		u->nlimbs = 0;
-		u->d = NULL;
-	}
-	mpi_free(u);
-}
-
-
-MPI mpi_set(MPI w, MPI u)
-{
-	mpi_ptr_t wp, up;
-	mpi_size_t usize = u->nlimbs;
-	int usign = u->sign;
-
-	if (!w)
-		w = mpi_alloc(mpi_get_nlimbs(u));
-	RESIZE_IF_NEEDED(w, usize);
-	wp = w->d;
-	up = u->d;
-	MPN_COPY(wp, up, usize);
-	w->nlimbs = usize;
-	w->flags = u->flags;
-	w->flags &= ~(16|32); /* Reset the immutable and constant flags.  */
-	w->sign = usign;
-	return w;
-}
-EXPORT_SYMBOL_GPL(mpi_set);
-
-MPI mpi_set_ui(MPI w, unsigned long u)
-{
-	if (!w)
-		w = mpi_alloc(1);
-	/* FIXME: If U is 0 we have no need to resize and thus possible
-	 * allocating the limbs.
-	 */
-	RESIZE_IF_NEEDED(w, 1);
-	w->d[0] = u;
-	w->nlimbs = u ? 1 : 0;
-	w->sign = 0;
-	w->flags = 0;
-	return w;
-}
-EXPORT_SYMBOL_GPL(mpi_set_ui);
-
-MPI mpi_alloc_set_ui(unsigned long u)
-{
-	MPI w = mpi_alloc(1);
-	w->d[0] = u;
-	w->nlimbs = u ? 1 : 0;
-	w->sign = 0;
-	return w;
-}
-
-/****************
- * Swap the value of A and B, when SWAP is 1.
- * Leave the value when SWAP is 0.
- * This implementation should be constant-time regardless of SWAP.
- */
-void mpi_swap_cond(MPI a, MPI b, unsigned long swap)
-{
-	mpi_size_t i;
-	mpi_size_t nlimbs;
-	mpi_limb_t mask = ((mpi_limb_t)0) - swap;
-	mpi_limb_t x;
-
-	if (a->alloced > b->alloced)
-		nlimbs = b->alloced;
-	else
-		nlimbs = a->alloced;
-	if (a->nlimbs > nlimbs || b->nlimbs > nlimbs)
-		return;
-
-	for (i = 0; i < nlimbs; i++) {
-		x = mask & (a->d[i] ^ b->d[i]);
-		a->d[i] = a->d[i] ^ x;
-		b->d[i] = b->d[i] ^ x;
-	}
-
-	x = mask & (a->nlimbs ^ b->nlimbs);
-	a->nlimbs = a->nlimbs ^ x;
-	b->nlimbs = b->nlimbs ^ x;
-
-	x = mask & (a->sign ^ b->sign);
-	a->sign = a->sign ^ x;
-	b->sign = b->sign ^ x;
-}
-
 MODULE_DESCRIPTION("Multiprecision maths library");
 MODULE_LICENSE("GPL");
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

