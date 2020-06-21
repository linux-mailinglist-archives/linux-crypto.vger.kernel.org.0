Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45FA2029BE
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2020 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgFUJH4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Jun 2020 05:07:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgFUJH4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Jun 2020 05:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0457CC0A;
        Sun, 21 Jun 2020 02:07:56 -0700 (PDT)
Received: from e110176-lin.arm.com (E113494.Arm.com [10.50.66.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C463F6CF;
        Sun, 21 Jun 2020 02:07:54 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fixes and update to essiv support
Date:   Sun, 21 Jun 2020 12:07:45 +0300
Message-Id: <20200621090748.18464-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Small fixes and adapt essiv support to the new template format

Gilad Ben-Yossef (3):
  crypto: ccree: fix resource leak on error path
  crypto: ccree: adapt ccree essiv supprot to kcapi
  crypto: ccree: remove unused field

 drivers/crypto/ccree/cc_cipher.c | 149 ++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 41 deletions(-)

-- 
2.27.0

