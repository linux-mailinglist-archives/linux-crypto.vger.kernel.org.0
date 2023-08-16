Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4011077DC80
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Aug 2023 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbjHPIiE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Aug 2023 04:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbjHPIhR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Aug 2023 04:37:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121C272B
        for <linux-crypto@vger.kernel.org>; Wed, 16 Aug 2023 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692174975; x=1723710975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Djlc4kLZrpV7+3Mk9bfWd0tzJ8Qx90rkJ8yaGNVQOds=;
  b=dAUGTsF7e2h4/PhM2hO/6sYvwzXb2iGKhiORExhxc0dEoI+bTnjk6xUb
   rxuYWzoFjTSNtzpYH/mxt6w4llaJbmucbgf+Ux/MFi7IOgJT+k2Pqk0vk
   2a3H+RLvWyce130UdOT95NtM09vxKjqylizQLp59rbkU/0LkeE1HgRMUz
   Wm/or1S/yUc0V0l1u9gbJQuWi5vtrdE4lGw191w/X1ppnsiVsq47r14Un
   oXdnngBXt0UkAUnFsxLsG5kqGLUCf/gmJ39RMUqgviqT2IywDaokiVr5t
   u99OH/85pAy9BFg6XsFu3AZ4vQXQSD3yv8JHZ7twykGr3GEHgASvC+UCV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362630554"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="362630554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763567489"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="763567489"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 01:36:04 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWC0Z-00009C-11;
        Wed, 16 Aug 2023 08:36:03 +0000
Date:   Wed, 16 Aug 2023 16:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Pandit <ppandit@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     oe-kbuild-all@lists.linux.dev, linux-crypto@vger.kernel.org,
        P J P <pjp@fedoraproject.org>
Subject: Re: [PATCH] crypto: use SRCARCH to source arch Kconfigs
Message-ID: <202308161641.v6maXREx-lkp@intel.com>
References: <20230816063107.11215-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816063107.11215-1-ppandit@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Prasad,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linus/master v6.5-rc6 next-20230815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prasad-Pandit/crypto-use-SRCARCH-to-source-arch-Kconfigs/20230816-143209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20230816063107.11215-1-ppandit%40redhat.com
patch subject: [PATCH] crypto: use SRCARCH to source arch Kconfigs
config: xtensa-randconfig-r015-20230816 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161641.v6maXREx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161641.v6maXREx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> crypto/Kconfig:1424: can't open file "arch/xtensa/crypto/Kconfig"
   make[3]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1 shuffle=2313028485
   make[2]: *** [Makefile:693: oldconfig] Error 2 shuffle=2313028485
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=2313028485
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=2313028485
   make: Target 'oldconfig' not remade because of errors.
--
>> crypto/Kconfig:1424: can't open file "arch/xtensa/crypto/Kconfig"
   make[3]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1 shuffle=2313028485
   make[2]: *** [Makefile:693: olddefconfig] Error 2 shuffle=2313028485
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=2313028485
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=2313028485
   make: Target 'olddefconfig' not remade because of errors.


vim +1424 crypto/Kconfig

  1419	
  1420	config CRYPTO_HASH_INFO
  1421		bool
  1422	
  1423	if !KMSAN # avoid false positives from assembly
> 1424	source "arch/$(SRCARCH)/crypto/Kconfig"
  1425	endif
  1426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
