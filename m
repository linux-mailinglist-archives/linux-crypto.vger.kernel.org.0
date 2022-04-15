Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1D5025C4
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Apr 2022 08:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349607AbiDOGro (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Apr 2022 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350733AbiDOGrm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Apr 2022 02:47:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB2B0A51
        for <linux-crypto@vger.kernel.org>; Thu, 14 Apr 2022 23:45:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t12so6477092pll.7
        for <linux-crypto@vger.kernel.org>; Thu, 14 Apr 2022 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldV1uCjsScyMqnX29S2Mnzm56eDt6Wx9wkmuB11hEfM=;
        b=rDb8Gh4XiSJ5bCNnQ/GtnJIzx5ChDSHZ4lV22jBcV+F9GyJoIkOE+UWgey1kEpy0gI
         MTKaFOriP4KbyNke3RHlowF7AzZ8vUNcqA+TwvlHlayovLLg57TbgJXaNYd9fpE64GSZ
         ABXn/A0Tx029H5JDtT1XMYUFDzq0jEaK9jWxYNCherEopNOslLePPx/F+lrjS9pBVK/A
         9dpWjF77ljcGRCaQK7cvGyxJE/KLO5/lQq2+8MwZm4Q9PnjS1vEyAdD7UlP5UuCfx7RW
         f+X1YiQzmVoG1vIaEQcymb5C98hqfNYIoFZUyzS8Jq2XoPr8jS+wGPmsTLuYAXyggK+m
         Ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldV1uCjsScyMqnX29S2Mnzm56eDt6Wx9wkmuB11hEfM=;
        b=Q9OK7G6mCScZvaXruwTabAUo6zU9JBI3KbUG/9h+SrmQFByq53H7GwDCmUvTGhqB8S
         lYFRc6gss70IJrN/cZNgrlqThS7jDNoj+pm6c+xubKjFNoYPwoNAoDJ02eKvPAwJDq9c
         JP4Zlii7uGZHnuGHjDJxbw2E8Pzf0G8PGndwIqEkOUYIc3s2rYEi0AyaFXM+vFESj7RN
         2qlglKj4+JRP84u52+ohJSnSDfpgCl1D8JM4q12UKE/666bFamgmksx5oqE5jdcHZb9n
         ZE5kufd1JdTU01v6243Vm/Q741uwgMgxAJ3x+dBn6krz3V910GDmlSv7mVasduZB4jiP
         cOLg==
X-Gm-Message-State: AOAM531LYeh2n3h4H17X59W3sHzF9IU0qHRli2wt3MHAJFT/hS6BlvYV
        hYAGD+v0mgyEurRBKMVM889f/g==
X-Google-Smtp-Source: ABdhPJyBEsq9NBxcUGHmvrk5wwfGZRmZAh1nf0tDGbK7Ic0lp5x83dUfzjLylmDxDhgTYThkApUAEw==
X-Received: by 2002:a17:902:9309:b0:156:983d:2193 with SMTP id bc9-20020a170902930900b00156983d2193mr49846482plb.158.1650005113570;
        Thu, 14 Apr 2022 23:45:13 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:45:12 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/4] virtio-crypto: Improve performance
Date:   Fri, 15 Apr 2022 14:41:32 +0800
Message-Id: <20220415064136.304661-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

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

zhenwei pi (2):
  virtio-crypto: wait ctrl queue instead of busy polling
  virtio-crypto: move helpers into virtio_crypto_common.c

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  92 ++++++------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  25 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 134 ++++++++----------
 6 files changed, 222 insertions(+), 159 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

