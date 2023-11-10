Return-Path: <linux-crypto+bounces-72-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C604A7E7D0A
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Nov 2023 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D84B209A8
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Nov 2023 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493B1C2B2
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Nov 2023 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuB5IoKz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D811BDCB
	for <linux-crypto@vger.kernel.org>; Fri, 10 Nov 2023 14:28:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5D38EA9;
	Fri, 10 Nov 2023 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699626492; x=1731162492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2cWD40pnESfklx3IChr4sF09jcu/aufcX8F+y8XgNo=;
  b=EuB5IoKzgmRJh+mYdcNMhgPi8H2EoaGa7w9ytCpWPkjHwa8Wp9SC9yGb
   cHXx9biyONatMuCQBWuae6wKgDXuORvRqkTSIZ3leLzGZVzKJMb+9enhn
   Ogi/q7ITZTGCqiZCPmye9oVoX0vHWOSOBHESuPk25HHkJtFK4mKwFFCF6
   Z4vFO1q18+sv3LYGMZR6AqLb5hFNTKHfeRkBbjyhLAF49TbTi/0Bm5YJW
   QnSU6JA8Pg/jiuQFcI1bNC12knwMkfTwA+GGe1Fwgz1DNgvBhB8UFgp4i
   F+NGiJWKIOxS56DSFVcHQ6Qvez1jBnS5ToH4tQJtY5WFbPX7RLFBUtlX9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="370393012"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="370393012"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="5065666"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2023 06:28:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1SUO-0009e2-0h;
	Fri, 10 Nov 2023 14:28:04 +0000
Date: Fri, 10 Nov 2023 22:27:58 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, herbert@gondor.apana.org.au,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, seanjc@google.com, kim.phillips@amd.com,
	pbonzini@redhat.com, babu.moger@amd.com, jiaxi.chen@linux.intel.com,
	jmattson@google.com, pawan.kumar.gupta@linux.intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YunShen@zhaoxin.com, Leoliu@zhaoxin.com,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
Message-ID: <202311102217.ZDrXGyK9-lkp@intel.com>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master tip/x86/core linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/crypto-x86-sm2-add-Zhaoxin-SM2-algorithm-implementation/20231109-231229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20231109094744.545887-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231110/202311102217.ZDrXGyK9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311102217.ZDrXGyK9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311102217.ZDrXGyK9-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S: Assembler messages:
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:38: Error: bad register name `%r12'
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:39: Error: bad register name `%rbx'
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:41: Error: bad register name `%rsi'
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:42: Error: bad register name `%rdi'
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:43: Error: bad register name `%rdx'
   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:44: Error: bad register name `%rdx'
>> arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:45: Error: bad register name `%rcx'
   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:46: Error: bad register name `%r12'
   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:53: Error: bad register name `%rcx'
   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:55: Error: bad register name `%rbx'
   arch/x86/crypto/sm2-zhaoxin-gmi_asm.S:56: Error: bad register name `%r12'


vim +38 arch/x86/crypto/sm2-zhaoxin-gmi_asm.S

    26	
    27	.text
    28	.align 32
    29	###############################################################################
    30	# int zhaoxin_gmi_sm2_verify (
    31	#         unsigned char *key, /*key*/
    32	#         unsigned char *hash, /*hash*/
    33	#         unsigned char *sig, /*signature*/
    34	#         unsigned char *scratch /*8 kbytes scratch space*/
    35	#     );
    36	###############################################################################
    37	SYM_FUNC_START(zhaoxin_gmi_sm2_verify)
  > 38		push %r12
  > 39		push %rbx
    40	
  > 41		mov HASH_PTR, %rax
  > 42		mov KEY_PTR, %rbx
  > 43		mov SIG_PTR, %r12
    44		mov $8, %rdx
  > 45		mov SCRATCH_PTR, %rsi

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

