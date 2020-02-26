Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47A16F6B0
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Feb 2020 06:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgBZFBA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Feb 2020 00:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgBZFBA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Feb 2020 00:01:00 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53B720658
        for <linux-crypto@vger.kernel.org>; Wed, 26 Feb 2020 05:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582693259;
        bh=Henn+sHuWVjQ9GkI2AA64J82QXOt7xA9/yA+pFP61VM=;
        h=From:To:Subject:Date:From;
        b=RBFf4RzKU0SVW/qPPlTzeT9CFEvP18N/FwOJIE3KckxZrgqau18Q4MxBkU6fa1tba
         N/cv1h2qlYVTEdJ1sAXZmXbplpZuflHq6AjgEGZersVbTatyUY/sw7f7cGU8kgZ1gZ
         40aTWOmp8E/tWUe/e/ssVVekzF3GpY3NYYF9FZ8M=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 00/12] crypto: more template instantiation cleanups
Date:   Tue, 25 Feb 2020 20:59:12 -0800
Message-Id: <20200226045924.97053-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series simplifies error handling in the remaining crypto templates,
taking advantage of the changes I made last release that made
crypto_grab_*() accept ERR_PTR() names and crypto_drop_*() accept
spawns that haven't been grabbed yet:
https://lore.kernel.org/r/20200103035908.12048-1-ebiggers@kernel.org

Many templates were already converted to the new style by that series.
This series just handles the remainder.

This series is an internal cleanup only; there are no changes for users
of the crypto API.  Net change is 124 lines of code removed.

Eric Biggers (12):
  crypto: authencesn - fix weird comma-terminated line
  crypto: ccm - simplify error handling in crypto_rfc4309_create()
  crypto: cryptd - simplify error handling in cryptd_create_*()
  crypto: ctr - simplify error handling in crypto_rfc3686_create()
  crypto: cts - simplify error handling in crypto_cts_create()
  crypto: gcm - simplify error handling in crypto_rfc4106_create()
  crypto: gcm - simplify error handling in crypto_rfc4543_create()
  crypto: geniv - simply error handling in aead_geniv_alloc()
  crypto: lrw - simplify error handling in create()
  crypto: pcrypt - simplify error handling in pcrypt_create_aead()
  crypto: rsa-pkcs1pad - simplify error handling in pkcs1pad_create()
  crypto: xts - simplify error handling in ->create()

 crypto/authencesn.c   |  2 +-
 crypto/ccm.c          | 29 ++++++-------------
 crypto/cryptd.c       | 37 ++++++++----------------
 crypto/ctr.c          | 29 ++++++-------------
 crypto/cts.c          | 27 ++++++------------
 crypto/gcm.c          | 66 ++++++++++++++-----------------------------
 crypto/geniv.c        | 17 ++++-------
 crypto/lrw.c          | 28 ++++++++----------
 crypto/pcrypt.c       | 33 ++++++----------------
 crypto/rsa-pkcs1pad.c | 59 +++++++++++++-------------------------
 crypto/xts.c          | 28 ++++++++----------
 kernel/padata.c       |  7 +++--
 12 files changed, 119 insertions(+), 243 deletions(-)

-- 
2.25.1

