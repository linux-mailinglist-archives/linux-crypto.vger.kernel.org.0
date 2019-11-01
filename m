Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1103BEBF2B
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfKAIYS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 04:24:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:38372 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfKAIYS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 Nov 2019 04:24:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 01:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="402158208"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2019 01:24:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQSEC-000Hou-DM; Fri, 01 Nov 2019 16:24:16 +0800
Date:   Fri, 1 Nov 2019 16:24:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [cryptodev:master 150/163]
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c:558:52-53: Unneeded
 semicolon
Message-ID: <201911011602.zkLvFEQE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
head:   298b4c604008025b134bc6fccbc4018449945d60
commit: 06f751b613296cc34b86fc83fccaf30d646eb8bc [150/163] crypto: allwinner - Add sun8i-ce Crypto Engine

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c:558:52-53: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
