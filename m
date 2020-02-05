Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BF1525CC
	for <lists+linux-crypto@lfdr.de>; Wed,  5 Feb 2020 06:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgBEFTU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 5 Feb 2020 00:19:20 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:61343 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEFTU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 5 Feb 2020 00:19:20 -0500
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0155J7iR019895;
        Tue, 4 Feb 2020 21:19:08 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     manojmalviya@chelsio.com, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH crypto/chcr 0/2] Bug fixes for libkcapi's fail tests
Date:   Wed,  5 Feb 2020 10:48:40 +0530
Message-Id: <20200205051842.29324-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca87
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Patch1: This fixes the libkcapi's cbc(aes) aio fail case.
Patch2: This fixes the kernel panic which occurs during 
	aead asynchronous vmsplice multiple test.


Ayush Sawal (2):
  This fixes the libkcapi's cbc(aes) aio fail test cases
  This fixes the kernel panic which occurs during a libkcapi test

 drivers/crypto/chelsio/chcr_algo.c   | 25 ++++++++++++++++++++++---
 drivers/crypto/chelsio/chcr_crypto.h |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.25.0.114.g5b0ca87

