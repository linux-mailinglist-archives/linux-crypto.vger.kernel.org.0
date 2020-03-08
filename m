Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB21717D48F
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Mar 2020 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHP5X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 Mar 2020 11:57:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHP5X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 Mar 2020 11:57:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1A51FB;
        Sun,  8 Mar 2020 08:57:21 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BB73F6CF;
        Sun,  8 Mar 2020 08:57:20 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] crypto: ccree - cleanups
Date:   Sun,  8 Mar 2020 17:57:03 +0200
Message-Id: <20200308155710.14546-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A bunch of code cleanups.
No fixes or new features here.

Gilad Ben-Yossef (4):
  crypto: ccree - remove ancient TODO remarks
  crypto: ccree - only check condition if needed
  crypto: ccree - use crypto_ipsec_check_assoclen()
  crypto: ccree - refactor AEAD IV in AAD handling

Hadar Gat (2):
  crypto: ccree - update register handling macros
  crypto: ccree - remove pointless comment

 drivers/crypto/ccree/cc_aead.c          | 113 +++++++-----------------
 drivers/crypto/ccree/cc_aead.h          |   3 +-
 drivers/crypto/ccree/cc_buffer_mgr.c    |  91 +++----------------
 drivers/crypto/ccree/cc_cipher.c        |   1 -
 drivers/crypto/ccree/cc_driver.h        |   5 +-
 drivers/crypto/ccree/cc_hash.c          |   3 -
 drivers/crypto/ccree/cc_hw_queue_defs.h |  77 ++++++++--------
 drivers/crypto/ccree/cc_request_mgr.c   |   1 -
 8 files changed, 80 insertions(+), 214 deletions(-)

-- 
2.25.1

