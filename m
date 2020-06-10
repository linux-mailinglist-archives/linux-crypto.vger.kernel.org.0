Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEB1F4E53
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2020 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFJGlh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Jun 2020 02:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgFJGlh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Jun 2020 02:41:37 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F802074B;
        Wed, 10 Jun 2020 06:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591771297;
        bh=BuAi8lTm66aXNBirKwiAWHgcpw2pfk0uDXOzJ3Yqu0U=;
        h=From:To:Cc:Subject:Date:From;
        b=wjm1i6S+j8qLKjbAmm9YuWSkBdndvOOz2Lxrp74w34vc+U0tIlNHvnaYZKKErA7oE
         EMByYIngBveZn+bGMtTnCi26zfLNmrkvrIa0WDhiAUA6DJiP8V3g5HlN7GpYyTvmcC
         tAa8b2u1wi6iXldlNS4fcBpNCb0sHETqaka6fkSI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 0/2] crc-t10dif library improvements
Date:   Tue,  9 Jun 2020 23:39:41 -0700
Message-Id: <20200610063943.378796-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series makes some more improvements to lib/crc-t10dif.c, as discussed at
https://lkml.kernel.org/linux-crypto/20200604063324.GA28813@gondor.apana.org.au/T/#u

This applies on top of Herbert's
"[v2 PATCH] crc-t10dif: Fix potential crypto notify dead-lock".

Eric Biggers (2):
  crc-t10dif: use fallback in initial state
  crc-t10dif: clean up some more things

 lib/crc-t10dif.c | 61 +++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

-- 
2.26.2

