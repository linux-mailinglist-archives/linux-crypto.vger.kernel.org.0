Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B688DAD8AC
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Sep 2019 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbfIIMP7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 08:15:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35580 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbfIIMP6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 08:15:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id t50so12756428edd.2
        for <linux-crypto@vger.kernel.org>; Mon, 09 Sep 2019 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyPj2vBs2t7A4yBZTnFeRCe0Q/FasNzSKBUIKJqgOio=;
        b=Xo5eu+7mSYNyWlk+KietBcX0aqFX5diSobu+/qydPJusbjQi3gJek8DnSDwJtBmwV7
         Z176ui790EyWgnl+kAsqDxvCzTWQx43v0oTOzq2j3J1iewtSxcyLluoS7MYB381lKxL7
         nlYOi6N+5uTQ0/Ooii2+rWm4hcuE9Xyvb2+SP6QOiCDvRJc3OQRv44qUfuVdVk7301FA
         Z+abEzhPLp9ObOohhZyWdn/XgwX5SSRkjCrIBjoEXaDF1MNqzh/HyygQFZlndU8hihS9
         fcrhqwz+8F6d1/xIEx3TxN4JeAFfIInEMT0hbETpoDwhrV2bU68xNqFCK0phpjXfGj2w
         N5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyPj2vBs2t7A4yBZTnFeRCe0Q/FasNzSKBUIKJqgOio=;
        b=j8TcUKKa6RlggAh5i+dfPDS96LRCvq7Bo1QlkZPs6ifnFGm6823io4orH4bNsKEeNH
         FgU/6tyFEXCbbxnlUrzivMVK7HmG7zAIbGqWyaJEv5+q/LedBhgvQ3VM7KzcEcMNC3P5
         5VntrnZ6WHics8FeqWaqdo/jabtwdVcwWgAE8+ZAf+mGvni+Gu1zT2ETWXdW17fmZ1f4
         rON3depsp7KNSgewFFf3adRoSBcId7rbjFlsUHAJ0rXBOZWaUzmWKTsG4vFIhw1VsCsU
         Wj/9sTiJ0fCAs1uSHR8lU+mGXBKG8P37LQvR1kbDZHAgmZDcRLJkKwPlhquLr3AOsmZD
         FSbQ==
X-Gm-Message-State: APjAAAX2E7qIpnLBvfuHBT/Phh1gM0GemChEdsfwejQBjzwIVlHImwuY
        TOwulp+9QuPnyVSLihEtzOdnnWUo
X-Google-Smtp-Source: APXvYqxra3wT9q1oxwMQW3bw74l8CAtFUi2miGsMz919rPzYsnJM/a0TQN0vi0OLggDsHYVQgqtjWw==
X-Received: by 2002:aa7:d6d8:: with SMTP id x24mr5021460edr.178.1568031357367;
        Mon, 09 Sep 2019 05:15:57 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id d24sm3001208edp.88.2019.09.09.05.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 05:15:56 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 0/3] crypto: inside-secure - Add support for the CBCMAC
Date:   Mon,  9 Sep 2019 13:13:05 +0200
Message-Id: <1568027588-31997-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset adds support for the (AES) CBCMAC family of authentication
algorithms: AES-CBCMAC, AES-XCBCMAC and AES-MAC
It has been verified with a Xilinx PCIE FPGA board as well as the Marvell
Armada A8K based Macchiatobin development board.

Pascal van Leeuwen (3):
  crypto: inside-secure - Added support for the AES CBCMAC ahash
  crypto: inside-secure - Added support for the AES XCBC ahash
  crypto: inside-secure - Added support for the AES-CMAC ahash

 drivers/crypto/inside-secure/safexcel.c      |   3 +
 drivers/crypto/inside-secure/safexcel.h      |   3 +
 drivers/crypto/inside-secure/safexcel_hash.c | 462 ++++++++++++++++++++++++---
 3 files changed, 427 insertions(+), 41 deletions(-)

-- 
1.8.3.1

