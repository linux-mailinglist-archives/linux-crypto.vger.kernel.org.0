Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08406192A7C
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCYNz1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 09:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:48796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgCYNz1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 09:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8921FB;
        Wed, 25 Mar 2020 06:55:27 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941983F71E;
        Wed, 25 Mar 2020 06:55:26 -0700 (PDT)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64: Make extension enablement consistent
Date:   Wed, 25 Mar 2020 13:55:20 +0000
Message-Id: <20200325135522.7782-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently we use a mix of .arch and .cpu to enable architecture
extensions, make things consistent by converting the two instances of
.cpu to .arch which is more common and a bit more idiomatic for our
goal.

Mark Brown (2):
  arm64: crypto: Consistently enable extension
  arm64: lib: Consistently enable crc32 extension

 arch/arm64/crypto/crct10dif-ce-core.S | 2 +-
 arch/arm64/lib/crc32.S                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

