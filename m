Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7137BF2AA
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Oct 2023 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442209AbjJJGAS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Oct 2023 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442193AbjJJGAQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Oct 2023 02:00:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A0B7
        for <linux-crypto@vger.kernel.org>; Mon,  9 Oct 2023 23:00:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A482CC433C7
        for <linux-crypto@vger.kernel.org>; Tue, 10 Oct 2023 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696917612;
        bh=U5XBDfkjSw/O9iv4sbY1NYsX1xjdr3f6uRGEJ6jVfTU=;
        h=From:To:Subject:Date:From;
        b=RZlZDvdlYXrqCJ+ukHIWTSdr6rQKwJnMlIat5HaCcBpKUzOUYYbyLcKN5e5YLo/hb
         ABvi+nILz4sMOgrWcxqb54Oss6ssbC6HYgmLUBiQT36JEWvNdZHTsskWBmCqDdXEFH
         tWRejc7wrduFnVE9DmUc4jigOBjDecUJqaMbNFSZHwBoN+TX0IC5irKcuE51hIaMPT
         9lhecEk6qYoAiNZmDKj8nUsVUlwm+pFcjWWfgy94wQXDVTNEc9nj445XIYxwmwAhup
         x5AZAKuAkaVB2B0wC+IoC7NfvhpNut0Q1MQwhSmvTG3scVSvvJZDPNupvRzScZcJuW
         EY2lmSPFwNVhg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 0/4] crypto: adiantum optimizations
Date:   Mon,  9 Oct 2023 22:59:42 -0700
Message-ID: <20231010055946.263981-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series slightly improves the performance of adiantum encryption and
decryption on single-page messages.

Eric Biggers (4):
  crypto: adiantum - add fast path for single-page messages
  crypto: arm/nhpoly1305 - implement ->digest
  crypto: arm64/nhpoly1305 - implement ->digest
  crypto: x86/nhpoly1305 - implement ->digest

 arch/arm/crypto/nhpoly1305-neon-glue.c   |  9 ++++
 arch/arm64/crypto/nhpoly1305-neon-glue.c |  9 ++++
 arch/x86/crypto/nhpoly1305-avx2-glue.c   |  9 ++++
 arch/x86/crypto/nhpoly1305-sse2-glue.c   |  9 ++++
 crypto/adiantum.c                        | 65 +++++++++++++++++-------
 5 files changed, 83 insertions(+), 18 deletions(-)

base-commit: 8468516f9f93a41dc65158b6428a1a1039c68f20
-- 
2.42.0

