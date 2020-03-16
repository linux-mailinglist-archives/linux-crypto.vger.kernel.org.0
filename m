Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252CC1864E8
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Mar 2020 07:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgCPGDt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Mar 2020 02:03:49 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:3860 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgCPGDs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Mar 2020 02:03:48 -0400
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02G63bvJ002765;
        Sun, 15 Mar 2020 23:03:38 -0700
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     manojmalviya@chelsio.com, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH Crypto 0/2] Fixes issues during driver registration
Date:   Mon, 16 Mar 2020 11:33:16 +0530
Message-Id: <20200316060318.20896-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Patch 1: Avoid the accessing of wrong u_ctx pointer.
Patch 2: Fixes a deadlock between rtnl_lock and uld_mutex.

Ayush Sawal (2):
  chcr: Fixes a hang issue during driver registration
  chcr: Fixes a deadlock between rtnl_lock and uld_mutex

 drivers/crypto/chelsio/chcr_core.c  | 34 +++++++++++++++++++++++------
 drivers/crypto/chelsio/chcr_ipsec.c |  2 --
 2 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.26.0.rc1.11.g30e9940

