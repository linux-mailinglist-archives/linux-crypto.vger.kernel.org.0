Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11F7A617
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfG3Kdt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 06:33:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49696 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbfG3Kdt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 06:33:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECBD41A066C;
        Tue, 30 Jul 2019 12:33:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E07041A066B;
        Tue, 30 Jul 2019 12:33:47 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 80D52204D6;
        Tue, 30 Jul 2019 12:33:47 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 0/2] crypto: validate inputs for gcm and aes
Date:   Tue, 30 Jul 2019 13:33:42 +0300
Message-Id: <1564482824-26581-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Added inline helper functions to check authsize and assoclen for
gcm, rfc4106 and rfc4543.  
Added, also, inline helper function to check key length for AES algorithms.
These are used in the generic implementation of gcm/rfc4106/rfc4543
and aes.

Changes since v1:
- rename helper functions with crypto_ prefix;
- update aes after it was moved to lib/crypto.

Iuliana Prodan (2):
  crypto: gcm - helper functions for assoclen/authsize check
  crypto: aes - helper function to validate key length for AES
    algorithms

 crypto/gcm.c         | 41 ++++++++++++++-------------------------
 include/crypto/aes.h | 17 ++++++++++++++++
 include/crypto/gcm.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/crypto/aes.c     |  8 ++++----
 4 files changed, 91 insertions(+), 30 deletions(-)

-- 
2.1.0

