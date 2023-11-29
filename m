Return-Path: <linux-crypto+bounces-383-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C435B7FD99A
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D2B20E05
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81F20B0E
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOLmr3y0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9552114;
	Wed, 29 Nov 2023 13:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FCAC433C8;
	Wed, 29 Nov 2023 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701264242;
	bh=1NbDZfh8R1r80cG2RxeClfnngCV9fEBcQY0EYYXzdXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOLmr3y0gmg9UK2nge9FwAY4v4u0n/qscw6QMpBPSYu7oAoWC6DyLDg1O5HJVk2w2
	 iCkDburLZyxf3ZWWyB96VX4SdKBpmRnw/d8E0k6GQFjY5tj2aYROnVDZP5XuRj4fJM
	 JdSzXA57JzFAxMviX6WiPtAbHkCCD3tOH7S8YoWCOXheww2wmDXYx4P+vJ1TDDXHiS
	 mRFQyyAWR4EO1JSx/FGWkwL1rNq81Nlk6Ep0BRU0nFjPwYOuzVHfizSq8vC5Cooy90
	 18A4AdHN4ndYCogaNOM1MwNZro37homwTu2F3iNC4N8YrJ9UVu2RCEYqCUl2lpep+R
	 udDUorHEPj6Hw==
Date: Wed, 29 Nov 2023 18:53:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, fenghua.yu@intel.com,
	dave.jiang@intel.com, tony.luck@intel.com,
	wajdi.k.feghali@intel.com, james.guilford@intel.com,
	kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com, pavel@ucw.cz,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 02/14] dmaengine: idxd: Rename drv_enable/disable_wq
 to idxd_drv_enable/disable_wq, and export
Message-ID: <ZWc7bRoRuqQ+hPt4@matsya>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
 <20231127202704.1263376-3-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127202704.1263376-3-tom.zanussi@linux.intel.com>

On 27-11-23, 14:26, Tom Zanussi wrote:
> Rename drv_enable_wq and drv_disable_wq to idxd_drv_enable_wq and
> idxd_drv_disable_wq respectively, so that they're no longer too
> generic to be exported.  This also matches existing naming within the
> idxd driver.
> 
> And to allow idxd sub-drivers to enable and disable wqs, export them.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

