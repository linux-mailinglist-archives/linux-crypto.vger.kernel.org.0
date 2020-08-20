Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F024C12B
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHTPEb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 11:04:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:21215 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgHTPEb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 11:04:31 -0400
IronPort-SDR: I2rWdaiOTiP5mC2wFP2K5t/+8YwdIUqNb1D070nmoeg/8qRQGACV1fOUhLpfe8jwMtQjZHmvhV
 Hl24+Y/TKLJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="135377345"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="135377345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 08:04:13 -0700
IronPort-SDR: +p13r29WI39FhNCUwJHziQkiDYnYaId+PnQ9px8kandaaiCGQrNAFN5RcloADHxi9/Re6SYuzm
 2B8/xw0GRijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="327456945"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2020 08:04:11 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8m6s-00007r-9T; Thu, 20 Aug 2020 15:04:10 +0000
Date:   Thu, 20 Aug 2020 23:03:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atte Tommiska <atte.tommiska@xiphera.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Atte Tommiska <atte.tommiska@xiphera.com>
Subject: [PATCH] hwrng: xiphera-trng: fix platform_no_drv_owner.cocci warnings
Message-ID: <20200820150319.GA61081@b50bd4e4e446>
References: <fdfe7889bf59f7b2b866ce25cd72ef323f508a3c.1597914503.git.atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfe7889bf59f7b2b866ce25cd72ef323f508a3c.1597914503.git.atte.tommiska@xiphera.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: kernel test robot <lkp@intel.com>

drivers/char/hw_random/xiphera-trng.c:141:3-8: No need to set .owner here. The core will do it.

 Remove .owner field if calls are used which set it automatically

Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

CC: Atte Tommiska <atte.tommiska@xiphera.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

url:    https://github.com/0day-ci/linux/commits/Atte-Tommiska/hwrng-add-support-for-Xiphera-XIP8001B/20200820-190349
base:    bc752d2f345bf55d71b3422a6a24890ea03168dc

 xiphera-trng.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/char/hw_random/xiphera-trng.c
+++ b/drivers/char/hw_random/xiphera-trng.c
@@ -138,7 +138,6 @@ MODULE_DEVICE_TABLE(of, xiphera_trng_of_
 static struct platform_driver xiphera_trng_driver = {
 	.driver = {
 		.name = "xiphera-trng",
-		.owner = THIS_MODULE,
 		.of_match_table	= xiphera_trng_of_match,
 	},
 	.probe = xiphera_trng_probe,
