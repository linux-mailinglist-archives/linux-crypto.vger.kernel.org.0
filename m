Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6212C299222
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Oct 2020 17:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775316AbgJZQRZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Oct 2020 12:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1737072AbgJZQRZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Oct 2020 12:17:25 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3533D207F7
        for <linux-crypto@vger.kernel.org>; Mon, 26 Oct 2020 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603729045;
        bh=xV5Zqcht7LNtZR44htjLISewqjkESucpdCaz6BO+o6Y=;
        h=From:To:Subject:Date:From;
        b=Z0gZQ5oNtPutqwX9O/eKccwdxzklhQfF5CM2u2Mpk7BD6eccq1N0TpZKXZV5rZRBq
         ZtFU3en3AdEHilpngzxV+EwSpsRBVUB7v6EUFwPDioonilKnr08AuMc8LfqX08mj4s
         /2ZClito93gNEx6ipKDmYsGOJQDp7vLg1aXsNNhU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 0/4] crypto: testmgr - always print the actual driver name
Date:   Mon, 26 Oct 2020 09:16:58 -0700
Message-Id: <20201026161702.39201-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When alg_test() is called from tcrypt.ko rather than from the algorithm
registration code, "driver" is actually the algorithm name, not the
driver name.  So it shouldn't be used in places where a driver name is
wanted, e.g. when reporting a test failure or when checking whether the
driver is the generic driver or not.

See https://lkml.kernel.org/r/20200910122248.GA22506@Red for an example
where this caused a problem.  The self-tests reported "alg: ahash: md5
test failed", but it wasn't mentioned which md5 implementation it was.

Fix this by getting the driver name from the crypto tfm object that
actually got allocated.

Eric Biggers (4):
  crypto: aead - add crypto_aead_driver_name()
  crypto: testmgr - always print the actual hash driver name
  crypto: testmgr - always print the actual AEAD driver name
  crypto: testmgr - always print the actual skcipher driver name

 crypto/testmgr.c      | 121 +++++++++++++++++++-----------------------
 include/crypto/aead.h |   5 ++
 2 files changed, 59 insertions(+), 67 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.29.1

