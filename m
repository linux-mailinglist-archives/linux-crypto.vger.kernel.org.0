Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF93C1A013B
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Apr 2020 00:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFWrh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Apr 2020 18:47:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60976 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFWrh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Apr 2020 18:47:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6B520073C;
        Tue,  7 Apr 2020 00:47:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF251200220;
        Tue,  7 Apr 2020 00:47:35 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F049205A5;
        Tue,  7 Apr 2020 00:47:35 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2 0/4] crypto: caam - fix use-after-free KASAN issue
Date:   Tue,  7 Apr 2020 01:47:24 +0300
Message-Id: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series fixes a use-after-free KASAN issue that was introduce
by CAAM backlogging support[1].
This is fixed for SKCIPHER, HASH, RSA and AEAD algorithms.

[1] https://patchwork.kernel.org/cover/11378941/

---
Changes since V1:
- update commit messages by adding the complete KASAN report;
- keep resource freeing before request completion callback;
- added stable tag.

Iuliana Prodan (4):
  crypto: caam - fix use-after-free KASAN issue for SKCIPHER algorithms
  crypto: caam - fix use-after-free KASAN issue for AEAD algorithms
  crypto: caam - fix use-after-free KASAN issue for HASH algorithms
  crypto: caam - fix use-after-free KASAN issue for RSA algorithms

 drivers/crypto/caam/caamalg.c  | 8 ++++++--
 drivers/crypto/caam/caamhash.c | 8 ++++++--
 drivers/crypto/caam/caampkc.c  | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.1.0

