Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE95F1795
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfKFNsh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Nov 2019 08:48:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:32806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfKFNsh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Nov 2019 08:48:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C665CB389;
        Wed,  6 Nov 2019 13:48:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82969DA79A; Wed,  6 Nov 2019 14:48:42 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ebiggers@kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] BLAKE2b cleanups
Date:   Wed,  6 Nov 2019 14:48:24 +0100
Message-Id: <cover.1573047517.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

the patchset implements cleanups suggested by Eric in
https://lore.kernel.org/linux-crypto/20191025051550.GA103313@sol.localdomain/

The diff is the same, split into pieces with some additional comments
where it would help understand the simplifications. This is based on v7
of the BLAKE2b patchset.

The self-tests have been run for each patch on x86_64.

David Sterba (7):
  crypto: blake2b: merge _final implementation to callback
  crypto: blake2b: merge blake2 init to api callback
  crypto: blake2b: simplify key init
  crypto: blake2b: delete unused structs or members
  crypto: blake2b: open code set last block helper
  crypto: blake2b: merge _update to api callback
  crypto: blake2b: rename tfm context

 crypto/blake2b_generic.c | 267 +++++++++++----------------------------
 1 file changed, 76 insertions(+), 191 deletions(-)

-- 
2.23.0

