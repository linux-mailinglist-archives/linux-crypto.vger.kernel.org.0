Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFE20D999
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2020 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgF2TtI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 15:49:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:58002 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387747AbgF2Tki (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:38 -0400
IronPort-SDR: rF6p7/pJ+SfHKT6Rh88pjCgGYYQv2XZNoUpeXI0KPIZ67NTKbDNU0zP+umpqXQYhOPD7EysbXP
 qFL3dkI1qzPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211091656"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="211091656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:16:35 -0700
IronPort-SDR: mkDN67ghE1uwom6Stx0tCEEF90zgldmtpqx9Tv6d0G0wTlz5xEwJZQcMGOj1gf/jTEzcGeZO+L
 8F68PLZAmmFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="264891312"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2020 10:16:34 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v3 0/4] crypto: qat - fixes to aes xts
Date:   Mon, 29 Jun 2020 18:16:16 +0100
Message-Id: <20200629171620.2989-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series fixes a few issues with the xts(aes) implementation in the
QuickAssist driver:
 - Requests that are not multiple of the block size are rejected
 - Input key not validated
 - xts(aes) requests with key size 192 bits are rejected with -EINVAL

Changes from v2:
 - Patch #4 - removed CRYPTO_ALG_ASYNC flag from mask in the allocation
   of the fallback tfm to allow asynchronous implementations as fallback.
 - Patch #4 - added CRYPTO_ALG_NEED_FALLBACK flag as mask when allocating
   fallback tfm to avoid implementations that require fallback.
 - Reworked commit messages to have system logs in one line.

Changes from v1:
 - Removed extra pair of parenthesis around PTR_ERR in patch #4 (crypto:
   qat - allow xts requests not multiple of block)

Giovanni Cabiddu (4):
  crypto: qat - allow xts requests not multiple of block
  crypto: qat - validate xts key
  crypto: qat - remove unused field in skcipher ctx
  crypto: qat - fallback for xts with 192 bit keys

 drivers/crypto/qat/qat_common/qat_algs.c | 98 ++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 8 deletions(-)

-- 
2.26.2

