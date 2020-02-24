Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C7169CB4
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Feb 2020 04:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBXDnJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 23 Feb 2020 22:43:09 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:52746 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXDnJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 23 Feb 2020 22:43:09 -0500
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01O3gx6Y015521;
        Sun, 23 Feb 2020 19:43:00 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     vinay.yadav@chelsio.com, manojmalviya@chelsio.com,
        Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH Crypto 0/2] Improving the performance of chelsio crypto operations
Date:   Mon, 24 Feb 2020 09:12:31 +0530
Message-Id: <20200224034233.12476-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca87
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

patch 1: Recalculate iv only if it is needed for aes-xts.
patch 2: Use multiple txq/rxq per tfm to process the requests.

Ayush Sawal (2):
  chcr: Recalculate iv only if it is needed
  chcr: Use multiple txq/rxq per tfm to process the requests

 drivers/crypto/chelsio/chcr_algo.c   | 337 +++++++++++++++++----------
 drivers/crypto/chelsio/chcr_core.h   |   1 -
 drivers/crypto/chelsio/chcr_crypto.h |  15 +-
 3 files changed, 227 insertions(+), 126 deletions(-)

-- 
2.25.0.114.g5b0ca87

