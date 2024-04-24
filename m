Return-Path: <linux-crypto+bounces-3827-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1041D8B1274
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Apr 2024 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416651C2138F
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Apr 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB115E9B;
	Wed, 24 Apr 2024 18:35:39 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF2256A
	for <linux-crypto@vger.kernel.org>; Wed, 24 Apr 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983739; cv=none; b=PrwyFOPYe7gES13Y82SiH7OFMC+Z8QNQ7b6pPFhHv3+fihFW6k0MyVHMM5yFxt+StiKIBHpo6Y+6CzvJPOzXvdlEhPFrFCr9ht1Z8F0Gs2lhv4+mDmzod8dfr66paJduXZ08+tQ7Hd6xlBaKmtJGz/uDm0b13TaLN0eIJqCzE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983739; c=relaxed/simple;
	bh=oDZwQgImVeCUBxSbmPb2CBIkIdZOlgHbROb7BGHgqwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unw4lZZbTd+oKr/BJqIcQCYMach7VOkJoxzW+Kh3TuFl0mt3AGpx9FHCE/A7vTm0ivJO9/g6F2GVrBo+JV4X271ry8asUky/bBUKhWZslxVW9iU+XosPXPfi4ol6HfaVZKHyEI1jBcTUpckn0wOsFggZEl/28sBxtRg/C9Hj41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: dgM5GxlxSIG7Cbs7QhbJNw==
X-CSE-MsgGUID: vg6EnTS1S+GAsiORfMPzvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9796655"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9796655"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:35:38 -0700
X-CSE-ConnectionGUID: PL6o4XGlQHu3UA7PuDzwZQ==
X-CSE-MsgGUID: yLUAZd31TGylQKKUnt41cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29436829"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:35:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzhSt-00000000kZV-3POF;
	Wed, 24 Apr 2024 21:35:31 +0300
Date: Wed, 24 Apr 2024 21:35:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, arm@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 6/9] platform: cznic: turris-omnia-mcu: Add support
 for MCU provided TRNG
Message-ID: <ZilQ8948PV8MuLiZ@smile.fi.intel.com>
References: <20240424173809.7214-1-kabel@kernel.org>
 <20240424173809.7214-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424173809.7214-7-kabel@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 07:38:05PM +0200, Marek Beh�n wrote:
> Add support for true random number generator provided by the MCU.
> New Omnia boards come without the Atmel SHA204-A chip. Instead the
> crypto functionality is provided by new microcontroller, which has
> a TRNG peripheral.

...

> +	/* If someone else cleared the TRNG interrupt but did not read the
> +	 * entropy, a new interrupt won't be generated, and entropy collection
> +	 * will be stuck. Ensure an interrupt will be generated by executing
> +	 * the collect entropy command (and discarding the result).
> +	 */

/*
 * Note, the above style is solely for net subsystem. The
 * others should use the usual one, like in this example.
 */

-- 
With Best Regards,
Andy Shevchenko



