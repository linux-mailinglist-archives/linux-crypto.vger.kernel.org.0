Return-Path: <linux-crypto+bounces-449-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1E980087A
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083CBB211C6
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84596210E8
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:37 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B17A8
	for <linux-crypto@vger.kernel.org>; Fri,  1 Dec 2023 02:12:32 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r90VY-005hlK-8c; Fri, 01 Dec 2023 18:12:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 18:12:37 +0800
Date: Fri, 1 Dec 2023 18:12:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Damian Muszynski <damian.muszynski@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH] crypto: qat - add sysfs_added flag for rate limiting
Message-ID: <ZWmxlTdDtEiQdLzi@gondor.apana.org.au>
References: <20231121170252.8263-1-damian.muszynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121170252.8263-1-damian.muszynski@intel.com>

On Tue, Nov 21, 2023 at 06:02:23PM +0100, Damian Muszynski wrote:
> The qat_rl sysfs attribute group is registered within the adf_dev_start()
> function, alongside other driver components.
> If any of the functions preceding the group registration fails,
> the adf_dev_start() function returns, and the caller, to undo the
> operation, invokes adf_dev_stop() followed by adf_dev_shutdown().
> However, the current flow lacks information about whether the
> registration of the qat_rl attribute group was successful or not.
> 
> In cases where this condition is encountered, an error similar to
> the following might be reported:
> 
>     4xxx 0000:6b:00.0: Starting device qat_dev0
>     4xxx 0000:6b:00.0: qat_dev0 started 9 acceleration engines
>     4xxx 0000:6b:00.0: Failed to send init message
>     4xxx 0000:6b:00.0: Failed to start device qat_dev0
>     sysfs group 'qat_rl' not found for kobject '0000:6b:00.0'
>     ...
>     sysfs_remove_groups+0x2d/0x50
>     adf_sysfs_rl_rm+0x44/0x70 [intel_qat]
>     adf_rl_stop+0x2d/0xb0 [intel_qat]
>     adf_dev_stop+0x33/0x1d0 [intel_qat]
>     adf_dev_down+0xf1/0x150 [intel_qat]
>     ...
>     4xxx 0000:6b:00.0: qat_dev0 stopped 9 acceleration engines
>     4xxx 0000:6b:00.0: Resetting device qat_dev0
> 
> To prevent attempting to remove attributes from a group that has not
> been added yet, a flag named 'sysfs_added' is introduced. This flag
> is set to true upon the successful registration of the attribute group.
> 
> Fixes: d9fb8408376e ("crypto: qat - add rate limiting feature to qat_4xxx")
> Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_rl.h       | 1 +
>  drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c | 8 ++++++++
>  2 files changed, 9 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

