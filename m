Return-Path: <linux-crypto+bounces-24924-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sokZNPW1ImoLcgEAu9opvQ
	(envelope-from <linux-crypto+bounces-24924-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:41:41 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AED647CDD
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=LMjV4yMt;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24924-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24924-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3381B3006780
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D34C043E;
	Fri,  5 Jun 2026 11:41:29 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19034C9560
	for <linux-crypto@vger.kernel.org>; Fri,  5 Jun 2026 11:41:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659689; cv=none; b=d/xIXu30gXp+zFBNqDy3/DC0jSN6SxBIKSRNqGxWNghvO3q1NoUQ+iTzmBdJWo/V8L5HSHot/5iSdJ9TUSMX0bucHCLtg6PgSwMGkaYGaMit/jmcaa3MZIMa/aNpFZUCKR1jVzslxtfvCbbTBsDv8b5ANrr4DIy5CGND6f/bRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659689; c=relaxed/simple;
	bh=XTtRpkPqefyFjRlDnUJg47EbwcbO55yMLGphUyX0iIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUwyWh0PK5R4Z2Hs5doTxeYCY/lIoZD+6M5V5zOEk1NNPMiqi8kNdOE0aHAaBqyl8K4pUnUU3Ve1WiAKXl3WQZj2luTvuzrwxZ8l5Go0KlLVA4bIkdDSdIr741Q0X/dNL/xr9QDuVgRsf8uv4arP7kWRvpkbJrUKTcBkr2fTJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=LMjV4yMt; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=XchOpw9KsKkHaelfjYETSyFqMY8Ddr9vk9QK/BEVTDc=; 
	b=LMjV4yMte8DCUayM8dUT7aX7aRCbW3J5pVVVA70ijP5d4uNka89xBd8EsIcIkd4j2pdiftfxW1p
	mLgs7+nQjdnS+kvgKzmKHvfQuZiJMWtchvnplLW8LU/yizK64nSI0VKjtXdQADoXl1bHXE8gwS47J
	MLu49l6i8Kq55ETCG1437uG8+Qs10yelr70bhjFxU4TOPGQk/Z2cdyz0+YC34K0iMZJwfYLxY1EOV
	x0cgI0zBXbVQgoWHfUKRJ9YJZO2tcfrGgtgoIOXozxYnROtpHSeVcJinS4TLozNB1Nm4qc4Nwy/zg
	4oaBQ/z/9RBZG8Pxnbn0og7R3XUK1NSnDe8g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSvU-002omw-0W;
	Fri, 05 Jun 2026 19:41:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:41:24 +0800
Date: Fri, 5 Jun 2026 19:41:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nitesh.venkatesh@intel.com
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Junyuan Wang <junyuan.wang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH] crypto: qat - add KPT support for GEN6 devices
Message-ID: <aiK15ETsRjhmnJn4@gondor.apana.org.au>
References: <20260526092839.432243-1-nitesh.venkatesh@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526092839.432243-1-nitesh.venkatesh@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24924-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nitesh.venkatesh@intel.com,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:junyuan.wang@intel.com,m:giovanni.cabiddu@intel.com,m:ahsan.atta@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9AED647CDD

On Tue, May 26, 2026 at 09:28:39AM +0000, nitesh.venkatesh@intel.com wrote:
> From: Junyuan Wang <junyuan.wang@intel.com>
> 
> Add support for Intel Key Protection Technology (KPT) on QAT GEN6
> devices.
> 
> KPT protects private keys from exposure by keeping them wrapped
> (encrypted) while in use, in-flight, and at rest. Keys remain in wrapped
> form and are not exposed in plaintext in host memory. This feature
> operates outside of the Linux crypto framework and kernel keyring.
> 
> Extend the firmware admin interface to enable and configure KPT. During
> device initialisation, if KPT is enabled, the driver sends an admin
> message to firmware to enable KPT mode and configure parameters such as
> the maximum number of SWK (Symmetric Wrapping Key) slots and the SWK
> time-to-live (TTL).
> 
> Expose KPT configuration via a new sysfs attribute group, "qat_kpt", and
> add ABI documentation.
> 
> Co-developed-by: Nitesh Venkatesh <nitesh.venkatesh@intel.com>
> Signed-off-by: Nitesh Venkatesh <nitesh.venkatesh@intel.com>
> Signed-off-by: Junyuan Wang <junyuan.wang@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> ---
>  .../ABI/testing/sysfs-driver-qat_kpt          |  97 ++++++
>  .../intel/qat/qat_6xxx/adf_6xxx_hw_data.c     |  21 +-
>  .../intel/qat/qat_6xxx/adf_6xxx_hw_data.h     |   9 +
>  drivers/crypto/intel/qat/qat_6xxx/adf_drv.c   |   6 +
>  drivers/crypto/intel/qat/qat_common/Makefile  |   2 +
>  .../intel/qat/qat_common/adf_accel_devices.h  |   2 +
>  .../crypto/intel/qat/qat_common/adf_admin.c   |  39 +++
>  .../crypto/intel/qat/qat_common/adf_admin.h   |   2 +
>  .../crypto/intel/qat/qat_common/adf_init.c    |   8 +
>  drivers/crypto/intel/qat/qat_common/adf_kpt.c |  56 ++++
>  drivers/crypto/intel/qat/qat_common/adf_kpt.h |  29 ++
>  .../intel/qat/qat_common/adf_sysfs_kpt.c      | 296 ++++++++++++++++++
>  .../intel/qat/qat_common/adf_sysfs_kpt.h      |  10 +
>  .../qat/qat_common/icp_qat_fw_init_admin.h    |   8 +
>  .../crypto/intel/qat/qat_common/icp_qat_hw.h  |   3 +-
>  15 files changed, 586 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-qat_kpt
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_kpt.c
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_kpt.h
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_kpt.c
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_sysfs_kpt.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

