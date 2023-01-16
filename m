Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA366CFFB
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Jan 2023 21:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjAPUPQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Jan 2023 15:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjAPUPN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Jan 2023 15:15:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDB24490
        for <linux-crypto@vger.kernel.org>; Mon, 16 Jan 2023 12:15:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so3661247wms.3
        for <linux-crypto@vger.kernel.org>; Mon, 16 Jan 2023 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMLRObJikupEwzTrRnh2PGmgjZ9Cqtc3WwiwTSH8KzM=;
        b=XmCdZzRtTuZuHhp81pkE69P4loy4VR6MnN9p5Ug0b9VeBBJyFAJNXMMCCPXI2Xww4+
         +WmiN3JAbNz9M0cQ2HbFFj86PlJHgnfX3V6lXt1sgEDdZNmnFPeDjSwKbJNvBY++u8WY
         tdBzDidtFDPRiHUykbwhSWvFSRYwmt5pon5+6DRZWcD526dyXxLcUW239Ttv5O67N6Fc
         cLdz5fdlYzw74C1vGu/ANNxqRb1YmE4B2jUnANSP5aRhHLum8XP0XS+AsugX2ORfUlg1
         KfwnBp6EI/3oYPR0eLQU2Nndym4TVpl856OKzZww7FcENqKPQxmU/O1C2fKPcezVGXGS
         EACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMLRObJikupEwzTrRnh2PGmgjZ9Cqtc3WwiwTSH8KzM=;
        b=Br3v/SUeqwi9uRDUvpW/VMkKQniYXtcOOi1o98GIH0kiaWhM1kp82o5QTVrEKz0hrv
         nK/ztxJczGEOsZXuiWFUSdvxFt7p3BbLLEUll5JC7nc/3L2DUIod9ow0lziiTm7PL107
         gfV27qqTQ3QEkIbSX2hXJvL8KUpVWHoNAxy1Jiw6n1hZ3X+FfmMPyxPLBgDhATlMukQc
         BWV8LkKdV5yqMost+L1aEtOfPjNZ5QuI+CGncshbQExusrVB9Ack2+JESVQZHpX8pBD1
         osj7ml7E/6zBwBDmtwN6miND2xUxreMfNt0yVGWmWzv+gZPPqMEoEIt5MWypWultcNjM
         YwlQ==
X-Gm-Message-State: AFqh2kqOalb0i0jk9DwcBK/X9yZ75ZGwCja64hFt5hs+SJ13ejUEOH8G
        GipisbWU0FxaAynhhJwk5tc26Q==
X-Google-Smtp-Source: AMrXdXv6vt0oUJQj3sllPk++1BCsUEFdkO/Gf79SgLX//tfJ5iVqBNK7A6tl8lhtKabc2OX2F1UAyA==
X-Received: by 2002:a05:600c:b8d:b0:3cf:7c8b:a7c7 with SMTP id fl13-20020a05600c0b8d00b003cf7c8ba7c7mr622696wmb.39.1673900111548;
        Mon, 16 Jan 2023 12:15:11 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm34549829wmb.47.2023.01.16.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:15:11 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bob Gilligan <gilligan@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH v3 4/4] crypto/Documentation: Add crypto_pool kernel API
Date:   Mon, 16 Jan 2023 20:14:58 +0000
Message-Id: <20230116201458.104260-5-dima@arista.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116201458.104260-1-dima@arista.com>
References: <20230116201458.104260-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/crypto/crypto_pool.rst | 36 ++++++++++++++++++++++++++++
 Documentation/crypto/index.rst       |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/crypto/crypto_pool.rst

diff --git a/Documentation/crypto/crypto_pool.rst b/Documentation/crypto/crypto_pool.rst
new file mode 100644
index 000000000000..84abd1f2ee80
--- /dev/null
+++ b/Documentation/crypto/crypto_pool.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Per-CPU pool of crypto requests
+===============================
+
+Overview
+--------
+The crypto pool API manages pre-allocated per-CPU pool of crypto requests,
+providing ability to use crypto requests on fast paths, potentially in atomic
+contexts. The allocation and initialization of the requests should be done
+before their usage as it's slow-path and may sleep.
+
+Order of operations
+-------------------
+You are required to allocate a new pool prior using it and manage its lifetime.
+You can allocate a per-CPU pool of ahash requests by crypto_pool_alloc_ahash().
+It will give you a pool id that you can use further on fast-path for hashing.
+You can increase the reference counter for an allocated pool via
+crypto_pool_get(). Decrease the reference counter by crypto_pool_release().
+When the refcounter hits zero, the pool is scheduled for destruction and you
+can't use the corresponding crypto pool id anymore.
+Note that crypto_pool_get() and crypto_pool_release() must be called
+only for an already existing pool and can be called in atomic contexts.
+
+crypto_pool_start() disables bh and returns you back ``struct crypto_pool *``,
+which is a generic type for different crypto requests and has ``scratch`` area
+that can be used as a temporary buffer for your operation.
+
+crypto_pool_end() enables bh back once you've done with your crypto
+operation.
+
+.. kernel-doc:: include/crypto/pool.h
+   :identifiers:
+
+.. kernel-doc:: crypto/crypto_pool.c
+   :identifiers:
diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index 21338fa92642..3eaf4e964e5b 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -25,6 +25,7 @@ for cryptographic use cases, as well as programming examples.
    devel-algos
    userspace-if
    crypto_engine
+   crypto_pool
    api
    api-samples
    descore-readme
-- 
2.39.0

