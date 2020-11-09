Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E372AB26C
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Nov 2020 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgKIIc6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Nov 2020 03:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIIc6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Nov 2020 03:32:58 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD8F206ED;
        Mon,  9 Nov 2020 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604910778;
        bh=gevEFAL9at2tNPhrsj7B6CkAl+nAQAei2cauoSzXsR8=;
        h=From:To:Cc:Subject:Date:From;
        b=hcy16/uZTutlK++0Tln87hZTIciuuBxSZTQP4+ZVdU94rkqi/YMDRKyZaRS/GxCTf
         decDw4i83KXh/rwA4FA7WWwVDMovHQcVrLvf5ZsxoEm2NwQOXJnZGJYEE0mStY00S9
         1mpmL/uOyZ/On07WD1WhyVzdHMiYhVR5T2okGXa4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] crypto: tcrypt enhancements
Date:   Mon,  9 Nov 2020 09:31:40 +0100
Message-Id: <20201109083143.2884-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Some tcrypt enhancements that I have been using locally to test and
benchmark crypto algorithms on the command line using KVM:
- allow tcrypt.ko to be builtin and defer its initialization to late_initcall
- add 1420 byte blocks to the list of benchmarked block sizes for AEADs and
  skciphers, to get an estimate of the performance in the context of a VPN

Ard Biesheuvel (3):
  crypto: tcrypt - don't initialize at subsys_initcall time
  crypto: tcrypt - permit tcrypt.ko to be builtin
  crypto: tcrypt - include 1420 byte blocks in aead and skcipher
    benchmarks

 crypto/Kconfig  |  2 +-
 crypto/tcrypt.c | 83 +++++++++++---------
 2 files changed, 46 insertions(+), 39 deletions(-)

-- 
2.17.1

