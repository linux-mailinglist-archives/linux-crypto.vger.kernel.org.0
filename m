Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5311C13D7A3
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAPKO6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 05:14:58 -0500
Received: from foss.arm.com ([217.140.110.172]:47436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgAPKO6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 05:14:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E58CA31B;
        Thu, 16 Jan 2020 02:14:57 -0800 (PST)
Received: from e110176-lin.arm.com (unknown [10.50.4.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AC273F534;
        Thu, 16 Jan 2020 02:14:56 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] crypto: ccree - fixes and cleanups
Date:   Thu, 16 Jan 2020 12:14:35 +0200
Message-Id: <20200116101447.20374-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A bunch of fixes and code cleanups for the ccree driver

Gilad Ben-Yossef (8):
  crypto: ccree - fix AEAD decrypt auth fail
  crypto: ccree - turn errors to debug msgs
  crypto: ccree - fix pm wrongful error reporting
  crypto: ccree - cc_do_send_request() is void func
  crypto: ccree - fix PM race condition
  crypto: ccree - split overloaded usage of irq field
  crypto: ccree - make cc_pm_put_suspend() void
  crypto: ccree - erase unneeded inline funcs

Hadar Gat (2):
  crypto: ccree: fix typos in error msgs
  crypto: ccree: fix typo in comment

Ofir Drang (1):
  crypto: ccree - fix FDE descriptor sequence

 drivers/crypto/ccree/cc_aead.c        | 22 +++----
 drivers/crypto/ccree/cc_cipher.c      | 54 ++++++++++++++--
 drivers/crypto/ccree/cc_driver.c      | 16 ++---
 drivers/crypto/ccree/cc_driver.h      |  5 +-
 drivers/crypto/ccree/cc_pm.c          | 37 +++--------
 drivers/crypto/ccree/cc_pm.h          | 17 +----
 drivers/crypto/ccree/cc_request_mgr.c | 90 ++++-----------------------
 drivers/crypto/ccree/cc_request_mgr.h |  8 ---
 8 files changed, 93 insertions(+), 156 deletions(-)

-- 
2.23.0

