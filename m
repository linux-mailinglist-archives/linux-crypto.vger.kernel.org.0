Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AD202FA0
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2020 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgFVGPR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 22 Jun 2020 02:15:17 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48805 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731167AbgFVGPQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 22 Jun 2020 02:15:16 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jun 2020 23:15:16 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 21 Jun 2020 23:15:13 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id BA113218BA; Mon, 22 Jun 2020 11:45:11 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        stanimir.varbanov@linaro.org, ardb@kernel.org,
        sivaprak@codeaurora.org, cotequeiroz@gmail.com,
        ebiggers@google.com, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] qce crypto fixes for tcrypto failures
Date:   Mon, 22 Jun 2020 11:45:03 +0530
Message-Id: <1592806506-23978-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

while running tcrypto test cases on qce crypto engine few failures are
noticed, this is mainly because of the updates on tcrypto driver and
not testing qce reqgularly with mainline tcrypto driver.

This series tries to address few of the errors while running tcrypto on
qce.

Sivaprakash Murugesan (3):
  crypto: qce: support zero length test vectors
  crypto: qce: re-initialize context on import
  crypto: qce: sha: Do not modify scatterlist passed along with request

 drivers/crypto/Kconfig      |  2 ++
 drivers/crypto/qce/common.h |  2 ++
 drivers/crypto/qce/sha.c    | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.7.4

