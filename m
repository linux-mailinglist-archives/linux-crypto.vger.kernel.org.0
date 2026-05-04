Return-Path: <linux-crypto+bounces-23659-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO4FC66m+GkExgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23659-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 16:01:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45484BE570
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB80303BB9B
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F43DC4AB;
	Mon,  4 May 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mnble04x"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92D20DD51;
	Mon,  4 May 2026 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903002; cv=none; b=P3QQ3+drHrdudV7crOOxc8aFzKnRRwp1D4gQQ0KKeqqC9zhYWP11+x9H3DniWV53TYc2LyZEHD0JDUyQJRVwPUb89PtOSxuDcxEj0MaEeSNaxB1Fa1zILBngggr5MicaY8Tz2F08ci2R5AzAYQN+VvI12jrnMJGwicgqZOHNOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903002; c=relaxed/simple;
	bh=nHyGMukKa/aeCIQK+8Djjqek/gwXo0Hm9P2kwKVLVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNHAEhCtuoYvm/SltKlzKfXMBH52R0D1B4/up8SNQqaLhu0rt5g206U0Fo7iJdOOjfsoH3RSrNOBUdEzRkmqvJrf2MnQmHv1My8Iwqpsane9IUQLdigakfNIRPpf8PCzapQp+MtpdY1r33/aspg1pMwDPA/eNLRaVG9LPbV4D7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mnble04x; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777903001; x=1809439001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHyGMukKa/aeCIQK+8Djjqek/gwXo0Hm9P2kwKVLVcA=;
  b=Mnble04xEK+j4zvEspObuxiKDXpauRuVKuWss7h5ymBPTCkHR5lfOhLc
   xar0iKBLNu9bwJd2iVoP2gxe/mOyvzx/ur7iLp0B5UjX/3w+0/QYLqqZ5
   CYL4+aVX9+ZltIriOGFOmxwep/6ubUiYJfNItNRekWskN+zpBx5eWOYwX
   YehUfbOxrYO+pTTmLJjqhTJnnnx875z9Shy+QkGXueMFTZo7qmbBYfnTj
   HZbMZHDBHnusO+is6v6SGhp+j17RY/cZFtPHTL/5rHo46F+KTlYb0Mheb
   VpU/Nkgb196F8BVkpJ34U7mZ5hOawQgsvh1oNFl0guwJnuNxLdyeocING
   A==;
X-CSE-ConnectionGUID: bMCgukcWSHuFytnnfKS56A==
X-CSE-MsgGUID: sJBkSUz2SdqlPublUAeBnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90216768"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="90216768"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:56:41 -0700
X-CSE-ConnectionGUID: /Ya7LkBfSl2CfdHF1899Xw==
X-CSE-MsgGUID: AuR+nXGDSJ+u4VDQY8w3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232369344"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 04 May 2026 06:56:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2DF4D98; Mon, 04 May 2026 15:56:38 +0200 (CEST)
Date: Mon, 4 May 2026 15:56:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] hwrng: core - use MAX to simplify RNG_BUFFER_SIZE
Message-ID: <afillkDh49TLjSar@black.igk.intel.com>
References: <20260430110047.248825-5-thorsten.blum@linux.dev>
 <20260430110047.248825-7-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110047.248825-7-thorsten.blum@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Rspamd-Queue-Id: D45484BE570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23659-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]

On Thu, Apr 30, 2026 at 01:00:50PM +0200, Thorsten Blum wrote:
> Replace the open-coded variant with MAX().

Hmm... While this patch is correct the very similar is being used
outside of hwrng. Can we perhaps have a common definition somewhere
near to SMP_CACHE_BYTES?

-- 
With Best Regards,
Andy Shevchenko



