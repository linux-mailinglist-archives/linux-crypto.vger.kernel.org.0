Return-Path: <linux-crypto+bounces-1537-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB26837DCF
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 02:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47E61F28035
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D4137C3C;
	Tue, 23 Jan 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRT0qu1b"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EB5FF0B
	for <linux-crypto@vger.kernel.org>; Tue, 23 Jan 2024 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970168; cv=none; b=YnxYNcVsYZY3K/3Eizw/R/Oo5sM2pzWQQTcEH4qVvjaaINPVfbYMRLIRtAJ+1BDL0ZAxXDCWTj3e5hyXHFKL9xIj9yrnvdRdVlF7LhSERrCRehT1M89bmlsckdx3BEQEzSziGvc0vxP3qjdridKXQUZm/gGKk1SsFq/Vip/XnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970168; c=relaxed/simple;
	bh=08gzPVNqKaIThrka0PRUXmbx8gcHwrKCAMm1CuCF8P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9s5P26sa9O9POCmeqBQWflJzqGM7AAQ8y8FiWOkANmCML+90dlMytDjFJsEQLvlOs4i+5Qfg2/2edySYEykVTHUk/0Wef5cMofTxY3Vbj06u7Cdv854xQpnYibvYZC0WlPgRb1abtDsU1jhNh8jXmtW9LVtuts2ndnXwGEuVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fRT0qu1b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d751bc0c15so13286615ad.2
        for <linux-crypto@vger.kernel.org>; Mon, 22 Jan 2024 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970166; x=1706574966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0IWBalbPa7nBe+7qRPGByHWNgNICkmEQCfSed9PR50=;
        b=fRT0qu1bXS9ZtGZoXpSXONIkIFh7UtLb2IsyepAXfL2Ah8wh6fmE1Rw/ORb449ACUy
         l+r4Qk61/jFFe+d7sn6aEOzHuwc1rlvgXkxYKqu0ue9qh1HG3yPOQbdHILED/U1EvK8a
         eVemySHgabNAisfyG01oG9nwc9qNLUogv+eAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970166; x=1706574966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0IWBalbPa7nBe+7qRPGByHWNgNICkmEQCfSed9PR50=;
        b=J/WVv2mw2EoXaN9gSg2V3QwwezQKRBwdjuc8jQcC90+nCA38me5fKQOny8hzpnn/KD
         pkQ+WZxkMXVSh6ESvqFofN181QIeNXhFs5/VVirefZCUskfRl1Bp+/UW61cpf72gUmGn
         w758GP+P8VzLRVc842SiSI8mhx5XXtfE7g4Q5YVF5HWIUbBB6xrwLyYR+MR2hpEOyijS
         WO+hm63bX/StQa6JBV99nMP1Ke0q6w8zH/7hBkj86J5k7wQPQaBmwFzdTVWAX6jcLjw4
         O1YmS7rA2fQncliGihMEHHG7xGtp4BR6AUmnOP28eKBhQEDpUl5GjEJxe0aaPxk47fAX
         fQZQ==
X-Gm-Message-State: AOJu0YwYV39QCbdOmrMFu0b9pjkyXUrE8FFKROqIz7QiGETh4wOgu3Y2
	rFdZF//VR1rUq/G/bDpwBxnGZnGmLIyeddLjcj6xqOUuyWwlGch+2u+767+ARQ==
X-Google-Smtp-Source: AGHT+IFAeQqI3FFXQ9+1Lb9KSwrHLPJKfBRcl5zF9RvXxq3cLLHLHaogLpM0B8iNqUxW5Y7pLSv+tw==
X-Received: by 2002:a17:903:482:b0:1d4:79b6:101a with SMTP id jj2-20020a170903048200b001d479b6101amr4643124plb.41.1705970166511;
        Mon, 22 Jan 2024 16:36:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902f29100b001d707a14316sm7490995plc.75.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@axis.com,
	linux-crypto@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 39/82] crypto: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:14 -0800
Message-Id: <20240123002814.1396804-39-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=keescook@chromium.org;
 h=from:subject; bh=08gzPVNqKaIThrka0PRUXmbx8gcHwrKCAMm1CuCF8P8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIRQrU4z+xZKgZEZXKAJfo17xdTxqMyiWe6
 GGw7oiVmY2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JtNlD/0d9ZXpSr+O/WY+Z8RnA0WFcmb8q8dHDR+pV9DASBchjSH3T7j/DJE7/4sN+voKM6jipuP
 +b4X/XvukaDPGcJID6ZCEETKBPkMpdxZthLJ9z3AD+pID8v8vvqxW+pRFzY4po/kjeOset6zPFO
 7YxbAUWVwSXk7QDgV3gYX/lK9QILRqXGRAhvOcubjgDREfAc2MbuJk4ItNqk2WcMnk53cEFtYji
 lJKFR1cHbwVPaSk2x/UmWTY9FIg9orR7rjJtFSCaZPayWmA4lNONN5MKTyl9QbNbB6LkGju5DJM
 Hd0T890SCjvldjd2bfSaiG9wW3fOFHydZMzdTnzla2TMofjeNAsC6odLW9rM59EO6ovdpQJ1M0y
 4TeZl+acwIvrGJuRvXNx0Nokuls+m/qhpft8nMxOcVOmd3BVu+jgvguImnYNwmX/2gdr1tHBEEq
 uBNgF0pN3/zlUJqLU6Jaa55akZsk3vMrVRP+A2Tr00GdajqCWKlEYuwX7N2mQ+PojwYVoKRfsnA
 wgQYhoKfgkZAFdaSlsNJcKY6N951w+i8ooSo5xvTH/8LATZEBNEZ30239h/apCk/ho5GUZ/fXJM
 RLglccDfc4V+1WVhsOdPVy53he2MDI39X+mro/t056xBMjwT3L1D9ZvHF5GnpW4GVJs19uUshk+ ZHeju5Fy9h8Zijw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@axis.com
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index dbc1d483f2af..cbec539f0e20 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1190,7 +1190,7 @@ artpec6_crypto_ctr_crypt(struct skcipher_request *req, bool encrypt)
 	 * the whole IV is a counter.  So fallback if the counter is going to
 	 * overlow.
 	 */
-	if (counter + nblks < counter) {
+	if (add_would_overflow(counter, nblks)) {
 		int ret;
 
 		pr_debug("counter %x will overflow (nblks %u), falling back\n",
-- 
2.34.1


