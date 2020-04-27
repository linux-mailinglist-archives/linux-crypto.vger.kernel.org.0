Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09D1B96AD
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2020 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgD0FmA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Apr 2020 01:42:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgD0FmA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Apr 2020 01:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74EB31B;
        Sun, 26 Apr 2020 22:41:59 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (E111385.Arm.com [10.50.65.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADCE03F73D;
        Sun, 26 Apr 2020 22:41:56 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hadar Gat <hadar.gat@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>
Subject: [PATCH 0/3] hwrng: cctrng kconfig updates
Date:   Mon, 27 Apr 2020 08:41:36 +0300
Message-Id: <1587966099-28139-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Some fixes in Kconfig for cctrng:
 + add missing dependency on OF
 + change default to 'n'
 + improve inaccurate help description

Hadar Gat (3):
  hwrng: cctrng - Add dependency on OF
  hwrng: cctrng - change default to n
  hwrng: cctrng - update help description

 drivers/char/hw_random/Kconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.7.4

