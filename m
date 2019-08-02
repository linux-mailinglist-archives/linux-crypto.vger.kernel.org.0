Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6680324
	for <lists+linux-crypto@lfdr.de>; Sat,  3 Aug 2019 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbfHBXUd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 19:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387495AbfHBXUd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38422087E;
        Fri,  2 Aug 2019 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788032;
        bh=5MDWMZ+Bb+H1JLI7zlax6RlbYeorlnYGQAZD3xSaKLo=;
        h=From:To:Cc:Subject:Date:From;
        b=CtHrXPeQaqIFT1kGAnW5DOoL8nsvXXEeu7tkt5g7Mxl5bfl8RedIJaHQArwrWFdyE
         L6JPaV9JlfPhnE00BtjeQHNIQxZJVil3TZyX3zyNKIgyRLxJhVb4OkCNmO4/AZdcIn
         J1SflbREfyPuEfw1L3nbDzBH3pDvS3rV2LZ8uIN8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] crypto: ccp - Remove unnecessary includes
Date:   Fri,  2 Aug 2019 18:20:10 -0500
Message-Id: <20190802232013.15957-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

CCP includes <linux/pci.h> many times unnecessarily.  Add a couple
DMA-related includes for dma_direction and dma_get_mask(), which were
previously included indirectly via <linux/pci.h>.  Then remove the
unnecessary includes of <linux/pci.h>.

Bjorn Helgaas (2):
  crypto: ccp - Include DMA declarations explicitly
  crypto: ccp - Remove unnecessary linux/pci.h include

 drivers/crypto/ccp/ccp-crypto.h    | 1 -
 drivers/crypto/ccp/ccp-dev-v3.c    | 1 -
 drivers/crypto/ccp/ccp-dev-v5.c    | 1 -
 drivers/crypto/ccp/ccp-dev.h       | 2 +-
 drivers/crypto/ccp/ccp-dmaengine.c | 1 +
 drivers/crypto/ccp/ccp-ops.c       | 1 -
 drivers/crypto/ccp/psp-dev.h       | 1 -
 drivers/crypto/ccp/sp-dev.h        | 1 -
 8 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

