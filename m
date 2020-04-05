Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED1419EAF3
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Apr 2020 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDELug (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Apr 2020 07:50:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38528 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgDELug (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Apr 2020 07:50:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74BDE2008FB;
        Sun,  5 Apr 2020 13:50:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68B972008F5;
        Sun,  5 Apr 2020 13:50:34 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ED63C20466;
        Sun,  5 Apr 2020 13:50:33 +0200 (CEST)
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
Subject: [PATCH 0/4] crypto: caam - fix use-after-free KASAN issue
Date:   Sun,  5 Apr 2020 14:50:07 +0300
Message-Id: <1586087411-8505-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series fixes a use-after-free KASAN issue that was introduce by CAAM backlogging support[1].
This is fixed for SKCIPHER, HASH, RSA and AEAD algorithms.

[1] https://patchwork.kernel.org/cover/11378941/

Iuliana Prodan (4):
  crypto: caam - fix use-after-free KASAN issue for SKCIPHER algorithms
  crypto: caam - fix use-after-free KASAN issue for AEAD algorithms
  crypto: caam - fix use-after-free KASAN issue for HASH algorithms
  crypto: caam - fix use-after-free KASAN issue for RSA algorithms

 drivers/crypto/caam/caamalg.c  | 8 ++++----
 drivers/crypto/caam/caamhash.c | 5 +++--
 drivers/crypto/caam/caampkc.c  | 6 ++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.1.0

