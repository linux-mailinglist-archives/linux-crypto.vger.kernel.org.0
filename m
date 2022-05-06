Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23051D8CF
	for <lists+linux-crypto@lfdr.de>; Fri,  6 May 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiEFNYi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 May 2022 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347404AbiEFNYi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 May 2022 09:24:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DD5C64F
        for <linux-crypto@vger.kernel.org>; Fri,  6 May 2022 06:20:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q4so4522146plr.11
        for <linux-crypto@vger.kernel.org>; Fri, 06 May 2022 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQA7sO3Gs0+tp7sDV+25Y43XXMTJ/XsoGGLuKCP2Q5c=;
        b=QHX7BY4TwwXgGIri826+34OIoQnZyonU2K5KsCwFi4WtwRftvSjGjx4ptoaBX5dy5m
         EqUGIltWJH7jod06iVUUbfe07wHTN/gRZnt0YC11dr8IoLeuk2Jv6tN7yztcRSBt9rrF
         MR2HdlRMV78qjg2Z3wPMIme7/3AFqLElpIYyDmBCi+Wozg1j8Z+RMdgCCLgfKbSzhOyu
         b33ktXG0LJlFRLt6rVj0FgHig2tSxgw6w1OJmRWt3LHkoGh/XhsHfRf1bwRobMSHUk3e
         3CPwKIg4+c1oYIaE6YiTNhN48/9bvFPqFde/QJChE6/BaMB8MkULCec9tlY+QKXXZoXQ
         P/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQA7sO3Gs0+tp7sDV+25Y43XXMTJ/XsoGGLuKCP2Q5c=;
        b=cWyePzuoZzTvqp69AsgBObpa+7xdq7LACCNzTexEppvSZLl3+oUYbHVYKbISGc7ABc
         DzCL0h/dlt8H3KiMjxF3pRHG4vxlXPKdzu6ja7bjN2OaXjBXBSabyht/15VcrrC9r5D1
         BLrqXWp/SpBA2UQa1RmmBj9XdH5mVQBzDiUusq+mfdNLAu2x0ZVXM07CQx6UuO7E+xHQ
         P90ln+kmJlHVuPtpfaZ3lpQb6nXFluAmHuL7C1JitZoQsrggytSuMWqshktErB53xG9l
         h6AtV+o+XmFsLTAYBlPpN6sv0ujh2OsHPKa3QFNf+hvih6oQkuULkEBFiJpfxaiYxIaf
         TKmw==
X-Gm-Message-State: AOAM533zErQyfhM1/ejVZvgE5EVn1RABhKix4tE1D3AVF0Sboiy4dYHl
        /GIX4/z5h8wZCpVnn6LgqQmuew==
X-Google-Smtp-Source: ABdhPJwf9r5jic9L4RMxeLZWJ+xLefhk6TerHNfuXcQyEP1lOV6uhftuuhlJRdWizxpFwGezbysJxA==
X-Received: by 2002:a17:903:2091:b0:15c:b49b:664d with SMTP id d17-20020a170903209100b0015cb49b664dmr3628597plc.151.1651843254280;
        Fri, 06 May 2022 06:20:54 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:20:53 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v6 0/5] virtio-crypto: Improve performance
Date:   Fri,  6 May 2022 21:16:22 +0800
Message-Id: <20220506131627.180784-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

v5 -> v6:
 - Minor fix for crypto_engine_alloc_init_and_set().
 - All the patches have been reviewed by Gonglei, add this in patch.
 Thanks to Gonglei.

v4 -> v5:
 - Fix potentially dereferencing uninitialized variables in
   'virtio-crypto: use private buffer for control request'.
   Thanks to Dan Carpenter!

v3 -> v4:
 - Don't create new file virtio_common.c, the new functions are added
   into virtio_crypto_core.c
 - Split the first patch into two parts:
     1, change code style,
     2, use private buffer instead of shared buffer
 - Remove relevant change.
 - Other minor changes.

v2 -> v3:
 - Jason suggested that spliting the first patch into two part:
     1, using private buffer
     2, remove the busy polling
   Rework as Jason's suggestion, this makes the smaller change in
   each one and clear.

v1 -> v2:
 - Use kfree instead of kfree_sensitive for insensitive buffer.
 - Several coding style fix.
 - Use memory from current node, instead of memory close to device
 - Add more message in commit, also explain why removing per-device
   request buffer.
 - Add necessary comment in code to explain why using kzalloc to
   allocate struct virtio_crypto_ctrl_request.

v1:
The main point of this series is to improve the performance for
virtio crypto:
- Use wait mechanism instead of busy polling for ctrl queue, this
  reduces CPU and lock racing, it's possiable to create/destroy session
  parallelly, QPS increases from ~40K/s to ~200K/s.
- Enable retry on crypto engine to improve performance for data queue,
  this allows the larger depth instead of 1.
- Fix dst data length in akcipher service.
- Other style fix.

lei he (2):
  virtio-crypto: adjust dst_len at ops callback
  virtio-crypto: enable retry for virtio-crypto-dev

zhenwei pi (3):
  virtio-crypto: change code style
  virtio-crypto: use private buffer for control request
  virtio-crypto: wait ctrl queue instead of busy polling

 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++------
 drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
 4 files changed, 182 insertions(+), 129 deletions(-)

-- 
2.20.1

