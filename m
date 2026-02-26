Return-Path: <linux-crypto+bounces-21184-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MvmOFIGen2nucwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21184-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 02:14:41 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F719FC14
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 02:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11FC302FB1F
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 01:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABEB2E7F08;
	Thu, 26 Feb 2026 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zong3RjQ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD706286D70
	for <linux-crypto@vger.kernel.org>; Thu, 26 Feb 2026 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068476; cv=none; b=U3FMEQUTGLut2dSTir+f4rPMouSipNFOZRxOLKWfbizI9fLdieUSjc5+6PoM6/HD1p9rNJhdsX5dgVUL1/YkVx2rczwYPhrMXkEyObGAvEZFKMrgSVLadCXmtXTag1MV/keGGdoBmChULjiy53SpdIy7f+lpLwnqEjok9zhz9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068476; c=relaxed/simple;
	bh=EcPFw3fwdHKBUa9LIKaZnc+0flJAKUAS/QgR7EiNEGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUVjJN963h9AeKg1Rd3fOMeCFxY+wy4jcSE20kPEQUPtFOwiPzLPdFfV7uTllJu6DOX08ZuN1FHPPKtcSHSeykPOXaku2RSaJYW+gWCM+j0bSXILcCe0esbfrpwmsbf1NjnR/uJi5hyz9YSkU/1eK4LiHNyg6rEFTUkjzvXvgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zong3RjQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772068475; x=1803604475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcPFw3fwdHKBUa9LIKaZnc+0flJAKUAS/QgR7EiNEGs=;
  b=Zong3RjQy0gu2Btw4zmDUmKMStLgGCFXmAq6DGSZn1tAaMz06M1DBVe/
   qi24aj3IpJE6vC4LO+L9vvA+3jdS+wSjGYmdkWZ1OTD3W6u3RTIKPEN/0
   NLUbzizWl8vRqGr2D+rNECR+/YpQRA2V2i3ovBzIXMDkE8wuWRul/opVH
   EEJ3t1bCOBgVn9enjtaDerfhNUX09QtWnaCHlAABOal58uO1sWp1M6VI5
   M3EkdR8ldxsB/a7A6r7jv+y206K8uMFievwl3XJ9tXygH1+PPhDCxqpsE
   TgfL9upHt8YT8JaWnFD8wiwM0o9Ag2spxxy6fzNNoqGlv+mrrPU5I6ut7
   Q==;
X-CSE-ConnectionGUID: 3l9JHzyAT3+gN1UEUCKTCw==
X-CSE-MsgGUID: NZ7qUciBTLK856RCeM/e/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75726520"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="75726520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 17:14:34 -0800
X-CSE-ConnectionGUID: ZDR4v/W6Rt2COLyzL1ABgg==
X-CSE-MsgGUID: NFxp3jjOTeSap7c3rCMNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="219780931"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 25 Feb 2026 17:14:32 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvPwY-000000007lJ-2etx;
	Thu, 26 Feb 2026 01:13:55 +0000
Date: Thu, 26 Feb 2026 09:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 5/5] crypto: pkcs7: add tests for pkcs7_get_authattr
Message-ID: <202602260949.uDrsr8hd-lkp@intel.com>
References: <20260225211907.7368-6-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225211907.7368-6-James.Bottomley@HansenPartnership.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21184-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C90F719FC14
X-Rspamd-Action: no action

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc1 next-20260225]
[cannot apply to herbert-cryptodev-2.6/master herbert-crypto-2.6/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/certs-break-out-pkcs7-check-into-its-own-function/20260226-052454
base:   linus/master
patch link:    https://lore.kernel.org/r/20260225211907.7368-6-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v3 5/5] crypto: pkcs7: add tests for pkcs7_get_authattr
config: i386-buildonly-randconfig-002-20260226 (https://download.01.org/0day-ci/archive/20260226/202602260949.uDrsr8hd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260949.uDrsr8hd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260949.uDrsr8hd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> crypto/asymmetric_keys/pkcs7_key_type.c:99:52: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
      99 |         pr_info("Correctly Got message hash, size=%ld\n", len);
         |                                                   ~~~     ^~~
         |                                                   %zu
   include/linux/printk.h:584:34: note: expanded from macro 'pr_info'
     584 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:511:60: note: expanded from macro 'printk'
     511 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:483:19: note: expanded from macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +99 crypto/asymmetric_keys/pkcs7_key_type.c

    48	
    49	/*
    50	 * Preparse a PKCS#7 wrapped and validated data blob.
    51	 */
    52	static int pkcs7_preparse(struct key_preparsed_payload *prep)
    53	{
    54		enum key_being_used_for usage = pkcs7_usage;
    55		int ret;
    56		struct pkcs7_message *pkcs7;
    57		const void *data;
    58		size_t len;
    59	
    60		if (usage >= NR__KEY_BEING_USED_FOR) {
    61			pr_err("Invalid usage type %d\n", usage);
    62			return -EINVAL;
    63		}
    64	
    65		ret = verify_pkcs7_signature(NULL, 0,
    66					      prep->data, prep->datalen,
    67					      VERIFY_USE_SECONDARY_KEYRING, usage,
    68					      pkcs7_view_content, prep);
    69		if (ret)
    70			return ret;
    71	
    72		pkcs7 = pkcs7_parse_message(prep->data, prep->datalen);
    73		if (IS_ERR(pkcs7)) {
    74			pr_err("pkcs7 parse error\n");
    75			return PTR_ERR(pkcs7);
    76		}
    77	
    78		/*
    79		 * the parsed message has no trusted signer, so nothing should
    80		 * be returned here
    81		 */
    82		ret = pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
    83		if (ret == 0) {
    84			pr_err("OID returned when no trust in signer\n");
    85			goto out;
    86		}
    87		/* add trust and check again */
    88		ret = validate_pkcs7_trust(pkcs7, VERIFY_USE_SECONDARY_KEYRING);
    89		if (ret) {
    90			pr_err("validate_pkcs7_trust failed!!\n");
    91			goto out;
    92		}
    93		/* now we should find the OID */
    94		ret = pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
    95		if (ret) {
    96			pr_err("Failed to get message digest\n");
    97			goto out;
    98		}
  > 99		pr_info("Correctly Got message hash, size=%ld\n", len);
   100	
   101	 out:
   102		pkcs7_free_message(pkcs7);
   103		return 0;
   104	}
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

