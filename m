Return-Path: <linux-crypto+bounces-126-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F57ECAAD
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 19:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131AC1F217B3
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADC364C7
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyOFReVK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F935EFB
	for <linux-crypto@vger.kernel.org>; Wed, 15 Nov 2023 16:59:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805EC19D;
	Wed, 15 Nov 2023 08:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700067578; x=1731603578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKen/SAx4UEsgZztdlCyc7GUsdmkySPk3GnM9twjEo8=;
  b=IyOFReVKir3mTxXEnE1cw53jgXoVLglW4ggMottEXhILVwWbuVShJzZP
   kbzVa/NyyA8+IHI1g79LF5qE6ml966Wy0AX5Q+U0fdCutrxH+0VtbZZTV
   t/46ARqWysP8svn1DsbvQMnVA+w1o/NKr2WZqJ6JMVB/Jy/SPB7tWo+pw
   zvxjVpw1r+5qRd9Jq/Nsm79seUGksY21jgOGp+8AkLSgeHeNANra9CaoF
   iZtXEYe3wwrYF+7zs1n5AqBA7qO0fXiNqLzMU0MCkIL/rOZ8eYp5dfE6J
   ni3cSJtHizTzpKgOC4YDqGAo5vcTmrhJWXVdFZ/Qw9ASU3+8XbifIDTpT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="3992077"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="3992077"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="799901038"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="799901038"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2023 08:59:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3JEe-0000c0-0U;
	Wed, 15 Nov 2023 16:59:28 +0000
Date: Thu, 16 Nov 2023 00:58:36 +0800
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
Subject: Re: [PATCH v2] crypto: x86/sm2 -add Zhaoxin SM2 algorithm
 implementation
Message-ID: <202311160022.csCILGmA-lkp@intel.com>
References: <20231115071724.575356-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115071724.575356-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master tip/x86/core linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/crypto-x86-sm2-add-Zhaoxin-SM2-algorithm-implementation/20231115-163848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20231115071724.575356-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v2] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231116/202311160022.csCILGmA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160022.csCILGmA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160022.csCILGmA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In function 'zhaoxin_gmi_sm2_verify',
       inlined from '_zhaoxin_sm2_verify' at arch/x86/crypto/sm2-zhaoxin-gmi_glue.c:56:9,
       inlined from 'zhaoxin_sm2_verify' at arch/x86/crypto/sm2-zhaoxin-gmi_glue.c:79:8:
>> arch/x86/crypto/sm2-zhaoxin-gmi_glue.c:43:9: error: inconsistent operand constraints in an 'asm'
      43 |         asm(".byte 0xf2, 0x0f, 0xa6, 0xc0"
         |         ^~~


vim +/asm +43 arch/x86/crypto/sm2-zhaoxin-gmi_glue.c

    35	
    36	/* Zhaoxin sm2 verify function */
    37	static inline int zhaoxin_gmi_sm2_verify(unsigned char *key, unsigned char *hash, unsigned char *sig,
    38					unsigned char *scratch)
    39	{
    40		uint64_t cword, f_ok;
    41		cword = (uint64_t)0x8;
    42	
  > 43		asm(".byte 0xf2, 0x0f, 0xa6, 0xc0"
    44			:"=c"(f_ok), "+a"(hash), "+b"(key), "+d"(cword), "+S"(scratch), "+D"(sig));
    45	
    46		return f_ok;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

