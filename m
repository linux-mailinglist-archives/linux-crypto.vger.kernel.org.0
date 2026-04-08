Return-Path: <linux-crypto+bounces-22859-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JEZHdo81mlZBwgAu9opvQ
	(envelope-from <linux-crypto+bounces-22859-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 13:32:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9F3BB4B0
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296353015891
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Apr 2026 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF3381AE9;
	Wed,  8 Apr 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8S5WY6y"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6526CE2C;
	Wed,  8 Apr 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647888; cv=none; b=bOYgN6ETUDZNoogI2vUZY1cZjaFiTIrBfE01iPxHX9n50bFdTFfe28TVOmLhPGWmxQ1z8OgoiW0QHZqNMECpynGx38eLLWzLnKAobrsl2QZIe5MLY9cx93C2GVF88MoQXXg/5TzSHrGyOpbQsApWNsEX5YPSSFIy4tmiRrn6AJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647888; c=relaxed/simple;
	bh=wJZxeR0B3ql2+1STeAZH/CnHYWezmwi7ULni1Cydb14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qczDAcwDhoo+LjWIFjx1otsNGwzS4hq6y5glpQQW++WwQyy4ZBWpOSg4VB5N9PdQ8uIiXJaB2HREx5EkArslTgCY+Clq3z1pK6XYU7r4irw7evMz4CXeXZpFIyg9dHfDcYJVp72U1cY8B69g5RkRHDMDqGYWMMb3MOJhAbxvAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8S5WY6y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775647887; x=1807183887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJZxeR0B3ql2+1STeAZH/CnHYWezmwi7ULni1Cydb14=;
  b=A8S5WY6yrFibXFSqvNpV8BdhffjpX3msx7P/83FF+MFS+Mo2faE3snLr
   Pu8PS9bLbTyvfeSyierhw1uVJA2sJbuDbpkra90VpDzCaXQEFdvAnTybg
   whcRCGD6zA78HB8ib3ogeXxjGCRreGlW8+37k2SfDhdPa3cCT05KHeQZO
   dfVA3mpP2ND1SgiGIS5oSZGzrQfI8Ll69KqpehJxu/R+nSNb0Wk5DZ6VM
   XzsbA0p9/P+F62od9A+ywlghJlMZuqwzG7OrBtCY6Y3wBi98CA1Q1ROzl
   YCXwYQ72+Ha/FdQsxi5x8tWjEUV018gJWYPba8iHNY8hzZLwNOV9u733S
   Q==;
X-CSE-ConnectionGUID: o+G0h+rdR9exWJhqL7z15w==
X-CSE-MsgGUID: 3UPmo3KjRaadReKxmWVG0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86919403"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="86919403"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:31:27 -0700
X-CSE-ConnectionGUID: fI3MjRf0QuGOlxhZtkycbA==
X-CSE-MsgGUID: XM5jwQgxS5yRMJWovE2uQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="230114927"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:31:23 -0700
Date: Wed, 8 Apr 2026 14:31:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ignat Korchagin <ignat@linux.win>,
	Stefan Berger <stefanb@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] crypto: ecc - Unbreak the build on arm with
 CONFIG_KASAN_STACK=y
Message-ID: <adY8iUPrnoXDp_-g@ashevche-desk.local>
References: <abfaede9ab2e963d784fb70598ed74935f7f8d93.1775628469.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfaede9ab2e963d784fb70598ed74935f7f8d93.1775628469.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,linux-foundation.org,arndb.de,gmail.com,linux.win,linux.ibm.com,vger.kernel.org,googlegroups.com,google.com,arm.com];
	TAGGED_FROM(0.00)[bounces-22859-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: D0C9F3BB4B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:15:49AM +0200, Lukas Wunner wrote:
> Andrew reports the following build breakage of arm allmodconfig,
> reproducible with gcc 14.2.0 and 15.2.0:
> 
>   crypto/ecc.c: In function 'ecc_point_mult':
>   crypto/ecc.c:1380:1: error: the frame size of 1360 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> gcc excessively inlines functions called by ecc_point_mult() (without
> there being any explicit inline declarations) and doesn't seem smart
> enough to stay below CONFIG_FRAME_WARN.
> 
> clang does not exhibit the issue.
> 
> The issue only occurs with CONFIG_KASAN_STACK=y because it enlarges the
> frame size.  This has been a controversial topic a couple of times:
> 
> https://lore.kernel.org/r/CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com/
> 
> Prevent gcc from going overboard with inlining to unbreak the build.
> The maximum inline limit to avoid the error is 101.  Use 100 to get a
> nice round number per Andrew's preference.

I think this is not the best solution. We still can refactor the code and avoid
being dependant to the (useful) kernel options.

-- 
With Best Regards,
Andy Shevchenko



