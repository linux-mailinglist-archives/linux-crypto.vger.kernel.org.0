Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5127D47D75
	for <lists+linux-crypto@lfdr.de>; Mon, 17 Jun 2019 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFQIqi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 17 Jun 2019 04:46:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfFQIqi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 17 Jun 2019 04:46:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68AD28;
        Mon, 17 Jun 2019 01:46:37 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994AD3F246;
        Mon, 17 Jun 2019 01:46:36 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: ccree: minor fixes
Date:   Mon, 17 Jun 2019 11:46:26 +0300
Message-Id: <20190617084631.23551-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A bunch of minor fixes and sanity checks

Gilad Ben-Yossef (1):
  crypto: ccree: add HW engine config check

Ofir Drang (3):
  crypto: ccree: Relocate driver irq registration after clk init
  crypto: ccree: check that cryptocell reset completed
  crypto: ccree: prevent isr handling in case driver is suspended

 drivers/crypto/ccree/cc_driver.c    | 70 +++++++++++++++++++++++++----
 drivers/crypto/ccree/cc_driver.h    |  6 +++
 drivers/crypto/ccree/cc_host_regs.h | 20 +++++++++
 drivers/crypto/ccree/cc_pm.c        | 11 +++++
 drivers/crypto/ccree/cc_pm.h        |  7 +++
 5 files changed, 105 insertions(+), 9 deletions(-)

-- 
2.21.0

