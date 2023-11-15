Return-Path: <linux-crypto+bounces-32-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A196B7E4649
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13281C20B82
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71F328CD
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aop/kTpa"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A72328D4
	for <linux-crypto@vger.kernel.org>; Tue,  7 Nov 2023 16:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782883;
	Tue,  7 Nov 2023 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699374628; x=1730910628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m86TUzlYcXzvF7S9EMlG9uQF20EDoypndfxnW2VR2pM=;
  b=aop/kTpapKMowZosP/Xa8c305AeOVbQ380ewSvZwYdAulcoKlx+Pm+Hn
   Gao5OymMbxjIHGbBWjlVhADegqGe9bugWLrgCzEQ/fFnw0zmYrWIlls4J
   RaXS7DAbmbyqRGjZ7ibrzwusuZTvvFV0x62BXzro33QGIlw2C/0GIpEMZ
   g+STiLrEp4N5rtLWBsZyUyyMMLRD1CNbvEgx13QHolGC5Yq6JmuiFJu0i
   jdTQlwglsWVSbii7ImlTNamnpMxiD+c7Ywke5Sn2nQZgnhSrGNj1cHu61
   GN5yAyQqetZmTC75QWtHV+gxWieu7qHXE7Zgd9QCEoB1M/bHoJxCVhb0m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420657300"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="420657300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 08:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="879870032"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="879870032"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2023 08:30:25 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0Oy7-0007Dd-0A;
	Tue, 07 Nov 2023 16:30:23 +0000
Date: Wed, 8 Nov 2023 00:29:35 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
	herbert@gondor.apana.org.au, martin@kaiser.cx,
	jiajie.ho@starfivetech.com, jenny.zhang@starfivetech.com,
	mmyangfl@gmail.com, robh@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YunShen@zhaoxin.com,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <202311072324.klxSzojj-lkp@intel.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.6 next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-rng-driver-base-on-rep_xstore-instruction/20231107-152659
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231107070900.496827-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
config: i386-randconfig-003-20231107 (https://download.01.org/0day-ci/archive/20231107/202311072324.klxSzojj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311072324.klxSzojj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311072324.klxSzojj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/hw_random/zhaoxin-rng.c: Assembler messages:
>> drivers/char/hw_random/zhaoxin-rng.c:42: Error: bad register name `%rcx'
>> drivers/char/hw_random/zhaoxin-rng.c:43: Error: bad register name `%rdx'
>> drivers/char/hw_random/zhaoxin-rng.c:44: Error: bad register name `%rdi'


vim +42 drivers/char/hw_random/zhaoxin-rng.c

    39	
    40	static inline int rep_xstore(size_t size, size_t factor, void *result)
    41	{
  > 42		__asm__ __volatile__ (
  > 43		"movq %0, %%rcx\n"
  > 44		"movq %1, %%rdx\n"
    45		"movq %2, %%rdi\n"
    46		".byte 0xf3, 0x0f, 0xa7, 0xc0"
    47		:
    48		: "r"(size), "r"(factor), "r"(result)
    49		: "%rcx", "%rdx", "%rdi", "memory");
    50	
    51		return 0;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

