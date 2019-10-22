Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D950E0764
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Oct 2019 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfJVPaZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 11:30:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35694 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfJVPaZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 11:30:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so10875249pfw.2;
        Tue, 22 Oct 2019 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=747DEOWz3b+mHu1ia2E5gpqgJdPAuuN1mTUboz1aRUg=;
        b=YMlrfWcRw5wecqEw03E3kH/r/+FWl29IHRv3e6WmXVU+Yrsi87bWEPzXp/nErc69HQ
         98Ye8AU7w6t6Qu4DyN6P/PTBaAWfonM/cZUYM5VJXq0rIcligZBOc3HQZQHpZ/Nx5W2h
         bTvh/S1Fr+5cOnaSTiv41nvnvU6a/YTIfsv5UvOEwp2qSbzmBZJuww3pqgbkLtruNgt1
         qY1zDXaUjxefU272AnYaOJx7cPiopNNNcH38Nq3YZQvRJ4Yn5B8NBzFG2qNGRZrOb2go
         k9KylWQdDdb1v8kQZOuv6dOjtmgELgi4RbdSSZPb9WyeSMUMhxmzAz6fBf2Ehkt8s1si
         xB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=747DEOWz3b+mHu1ia2E5gpqgJdPAuuN1mTUboz1aRUg=;
        b=VPb5FxuEP8KmUCSjXxaqvXiTD7mWa0VSk0kIwxSWouimUso89jErEHsHxbkorC07zT
         4kEx2PVlxtrpVCWubO0de27NLHTYGTooY5Ou+q07Tc1B9ABxNYoqqlqDa16R57j/W0Oq
         fO1t0O5qRmXxRnWCR9rKtRY1ZEzgK6St/a6rgAw4i5aqUs7pQXiIYqGZeIJcbrqRqDaX
         kx3XNEfPAPGV5j/SaaI0L+mt1z4FpfkfmJbEPMTN75VnXNwuPijjz4lEoZAsdxW8Jksu
         7IbetRqyXVfZBdv/HisG1Mt5jpDh5XxNtSrFa1SQ6ItUEPLRPkYyDvVuPWJjRJ/LfCz6
         URqQ==
X-Gm-Message-State: APjAAAXpvmrXb+HXp3POW925UvcYuAbcOKhk5lJxYI/IuuUGHT4oJbDM
        YLg2Ivg+crGlHYG1yThMkTbgOi4o
X-Google-Smtp-Source: APXvYqw2BDTLx0JXQesMSd8sTbfxdGhSvtMmGa12c8y0LswD/Jct4D5mCKo7rwZlWL865bpVLFHq6g==
X-Received: by 2002:a63:a849:: with SMTP id i9mr4198021pgp.237.1571758223865;
        Tue, 22 Oct 2019 08:30:23 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z63sm6066128pgb.75.2019.10.22.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:30:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] CAAM bugfixes, small improvements
Date:   Tue, 22 Oct 2019 08:30:07 -0700
Message-Id: <20191022153013.3692-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Everyone:

This series contains bugfixes and small improvement I made while doing
more testing of CAAM code.

Changes since [v1]:

    - Rebased on latest cryptodev/master, series limited to just
      devres changes

    - Minor code style changes as per feedback

[v1] lore.kernel.org/lkml/20190904023515.7107-1-andrew.smirnov@gmail.com

Andrey Smirnov (6):
  crypto: caam - use devres to unmap memory
  crypto: caam - use devres to remove debugfs
  crypto: caam - use devres to de-initialize the RNG
  crypto: caam - use devres to de-initialize QI
  crypto: caam - use devres to populate platform devices
  crypto: caam - populate platform devices last

 drivers/crypto/caam/ctrl.c   | 222 ++++++++++++++++-------------------
 drivers/crypto/caam/intern.h |   4 -
 drivers/crypto/caam/qi.c     |   8 +-
 drivers/crypto/caam/qi.h     |   1 -
 4 files changed, 104 insertions(+), 131 deletions(-)

-- 
2.21.0

