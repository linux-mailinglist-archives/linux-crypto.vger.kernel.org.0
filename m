Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2404E16EA72
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Feb 2020 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgBYPsq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Feb 2020 10:48:46 -0500
Received: from foss.arm.com ([217.140.110.172]:52364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730019AbgBYPsp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Feb 2020 10:48:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E6E1FB;
        Tue, 25 Feb 2020 07:48:44 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2A4A3F703;
        Tue, 25 Feb 2020 07:48:42 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: testmgr - AEAD extra tests fixes
Date:   Tue, 25 Feb 2020 17:48:32 +0200
Message-Id: <20200225154834.25108-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix issues found while debugging ccree driver failures with the new
AEAD extra tests code.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Gilad Ben-Yossef (2):
  crypto: testmgr - use generic algs making test vecs
  crypto: testmgr - sync both RFC4106 IV copies

 crypto/testmgr.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

-- 
2.25.0

