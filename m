Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE8229802
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgGVMPM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 08:15:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55394 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMPL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B6271A17A3;
        Wed, 22 Jul 2020 14:15:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D6061A1797;
        Wed, 22 Jul 2020 14:15:10 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D17B202AD;
        Wed, 22 Jul 2020 14:15:10 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/7] crypto: caam - updates for 5.9
Date:   Wed, 22 Jul 2020 15:14:51 +0300
Message-Id: <20200722121458.8478-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Herbert,

This patch set contains a few caam driver updates.
The fixes are minor and thus ok to go through the cryptodev tree.

Dan Douglass (1):
  crypto: caam/jr - remove incorrect reference to caam_jr_register()

Franck LENORMAND (1):
  crypto: caam - remove deadcode on 32-bit platforms

Horia Geantă (5):
  crypto: caam/qi2 - fix error reporting for caam_hash_alloc
  crypto: caam/qi2 - create ahash shared descriptors only once
  crypto: caam - silence .setkey in case of bad key length
  crypto: caam - add more RNG hw error codes
  crypto: caam/qi2 - add module alias

 drivers/crypto/caam/caamalg.c     |  2 +-
 drivers/crypto/caam/caamalg_qi.c  |  2 +-
 drivers/crypto/caam/caamalg_qi2.c | 11 ++++++++---
 drivers/crypto/caam/error.c       |  3 +++
 drivers/crypto/caam/jr.c          |  3 +--
 drivers/crypto/caam/regs.h        | 11 ++++++++---
 6 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.17.1

