Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8B3C3AD9
	for <lists+linux-crypto@lfdr.de>; Sun, 11 Jul 2021 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGKGP4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 11 Jul 2021 02:15:56 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:51148 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKGPz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 11 Jul 2021 02:15:55 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d42 with ME
        id TiCz2500L21Fzsu03iD0j0; Sun, 11 Jul 2021 08:13:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Jul 2021 08:13:07 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, tomaszx.kowalik@intel.com,
        marco.chiappero@intel.com, andriy.shevchenko@linux.intel.com,
        fiona.trahe@intel.com, wojciech.ziemba@intel.com,
        ztong0001@gmail.com, qat-linux@intel.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] crypto: qat - Fixes and clean-ups
Date:   Sun, 11 Jul 2021 08:12:57 +0200
Message-Id: <cover.1625983602.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The only link between these 3 patches are that they are all related to
'drivers/crypto/qat'.


Christophe JAILLET (3):
  crypto: qat - Simplify code and axe the use of a deprecated API
  crypto: qat - Disable AER if an error occurs in probe functions
  crypto: qat - Fix a typo in a comment

 drivers/crypto/qat/qat_4xxx/adf_drv.c       |  8 ++------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c      | 15 ++++++---------
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    |  9 ++-------
 drivers/crypto/qat/qat_c62x/adf_drv.c       | 15 ++++++---------
 drivers/crypto/qat/qat_c62xvf/adf_drv.c     |  9 ++-------
 drivers/crypto/qat/qat_common/adf_aer.c     |  2 +-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c   | 15 ++++++---------
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c |  9 ++-------
 8 files changed, 27 insertions(+), 55 deletions(-)

-- 
2.30.2

