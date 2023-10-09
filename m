Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF387BD45F
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Oct 2023 09:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjJIHc6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Oct 2023 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbjJIHc5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Oct 2023 03:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE000BA
        for <linux-crypto@vger.kernel.org>; Mon,  9 Oct 2023 00:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7DFC433C8
        for <linux-crypto@vger.kernel.org>; Mon,  9 Oct 2023 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696836776;
        bh=0xKzBikM1wK5FDdwocKHcg570ZOv+dVn0XXLWlI64pc=;
        h=From:To:Subject:Date:From;
        b=QwF09fx4cYTzvAzWw3hH+N9CKtz+dUGQWoR541ajkKOc+lOEOLAkpz4yaxPKnz/UD
         8ISjswY2Jhmvj2qs8Km3FTciAQYr5/zTp/RvTQgBXdMfS3P6q1AdUgwZ7TVxlIQ8Ra
         /WECuG8f4JOqjs0o6NAmhmpQDDCwSGOlWfANOhno5I/Bu5UDgXiyErRQRRo4JFsIN3
         j1KacfthPGOZGatSIIpFXiBQrWP2E5Y9uCv8XuClGsMhqyuk9VfLRfftZO6Sw3pJ82
         R/qFlwndyJCxNRw79ZcA89WNpAH/o2/eG++hTw2gP7GfwRGhXC8uVdWSFLIO6nvqli
         6HMHkszZjCglw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] crypto: shash optimizations
Date:   Mon,  9 Oct 2023 00:32:12 -0700
Message-ID: <20231009073214.423279-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series fixes some inefficiencies in crypto_shash_digest() and
crypto_shash_finup(), particularly in cases where the algorithm doesn't
implement ->digest or ->finup respectively.

Eric Biggers (2):
  crypto: shash - optimize the default digest and finup
  crypto: shash - fold shash_digest_unaligned() into
    crypto_shash_digest()

 crypto/shash.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)


base-commit: 8468516f9f93a41dc65158b6428a1a1039c68f20
-- 
2.42.0

