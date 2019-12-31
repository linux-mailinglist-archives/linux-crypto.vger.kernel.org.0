Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7612D5F3
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Dec 2019 04:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLaDUz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Dec 2019 22:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfLaDUz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Dec 2019 22:20:55 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F7420722
        for <linux-crypto@vger.kernel.org>; Tue, 31 Dec 2019 03:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577762455;
        bh=2dfafHG1HqArpKbeVPAVpRbxhH10O3ZEkC64crc91Kg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AG4cTlh0EvEpEHVCxAX84OHpfBX+7h0brqw/l5P8W0YghBbV3NoB1zs7g5Q3eMBsH
         +hsaYwyTHyxO4Be4izGHeY7V6bFJOD3Z+/kfR4N2ydxfreAuYqwLqsjMnv8fv/1Kp9
         0fCSbzGIIWdbHr3DNhtuj+oWZJrtjiH9L5Ey2c94=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 4/8] crypto: remove unused tfm result flags
Date:   Mon, 30 Dec 2019 21:19:34 -0600
Message-Id: <20191231031938.241705-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231031938.241705-1-ebiggers@kernel.org>
References: <20191231031938.241705-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The tfm result flags CRYPTO_TFM_RES_BAD_KEY_SCHED and
CRYPTO_TFM_RES_BAD_FLAGS are never used, so remove them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/crypto.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 8729f957f83c..950b592947b2 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -114,9 +114,7 @@
 #define CRYPTO_TFM_REQ_MAY_BACKLOG	0x00000400
 #define CRYPTO_TFM_RES_WEAK_KEY		0x00100000
 #define CRYPTO_TFM_RES_BAD_KEY_LEN   	0x00200000
-#define CRYPTO_TFM_RES_BAD_KEY_SCHED 	0x00400000
 #define CRYPTO_TFM_RES_BAD_BLOCK_LEN 	0x00800000
-#define CRYPTO_TFM_RES_BAD_FLAGS 	0x01000000
 
 /*
  * Miscellaneous stuff.
-- 
2.24.1

