Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046721AE6DC
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2020 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDQUjB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Apr 2020 16:39:01 -0400
Received: from foss.arm.com ([217.140.110.172]:55950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDQUjB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Apr 2020 16:39:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30DFC14;
        Fri, 17 Apr 2020 13:39:00 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (unknown [10.57.26.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33B93F237;
        Fri, 17 Apr 2020 13:38:58 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Hadar Gat <hadar.gat@arm.com>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: cctrng - add missing include to linux/fips.h
Date:   Fri, 17 Apr 2020 23:38:45 +0300
Message-Id: <1587155926-32663-1-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This fixes build failure when CONFIG_CRYPTO_FIPS is defined.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 drivers/char/hw_random/cctrng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index bdcd562..e82716c 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -15,6 +15,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/fips.h>
 
 #include "cctrng.h"
 
-- 
2.7.4

