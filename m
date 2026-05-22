Return-Path: <linux-crypto+bounces-24445-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOprI1lOEGq5VwYAu9opvQ
	(envelope-from <linux-crypto+bounces-24445-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:38:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E38705B43F5
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A629030BB142
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF03380FE5;
	Fri, 22 May 2026 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="YS1SIZ8L"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEB371041
	for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452838; cv=none; b=EH7DJYoTHhogzoVOhvX6gHs0cJqcx8TnWO58Ki/zbGdBlx84gOiKY3UoZw5fmSrxu/w+kMp6LBXYTL4EOqPumMBOQtz1/vnGzSdMrSE5uRIBQ0rPQyoTlRYSg/uUtdqqSgN3ZImVlD5/Xh4p/DPDFH6sFchhHsx13rk+LzLeIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452838; c=relaxed/simple;
	bh=z/LZoHGGyQE5GS9bYIoSKy/kxVUsUzdP8vlt2lSI/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0aHlEfk3hXtO+ZCylqucUBr15Uc4wgNxwEBrEKXWpQ9kCkUFDPm5AMFcSaWLpsTo1pOGAQd8I8IntabM6KRq9yr3emQEGuQs9ZiW6VJDzIZmB6Knq7gqN8R/uCF93cOBR93cWGzM7f2V1RSqdvVHgtD+/o+8sMPEJY3G+iQXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=YS1SIZ8L; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=YvmLl9hVlDgMQmq513W/fwnyZfnALFloHm43Uh+AB3c=; 
	b=YS1SIZ8LlLXyB53qvWt7HHl+vSftNwX2/iuismfHvSylRVyViPwW6ba+Vs2j/HaYs64+Cdn9giW
	FQoHmHRxgxB8eSwoH+S69qDl9bBNsEheUzHHbWvJ7DpbMwMJUN9LYJ0KoO3PFjxmKtWpdNmqS+CPF
	jza3g4LTj++StRssngMQLOdwgBPFjP377xoVhKltuithKajCVQGPOYpinnQV86tdsxwaLQx3487Pg
	RdD+o9ODND9Dvy1lkLXYmE9HvHGo8eYP0VyiFcpbqJ2Atpy6UhUe2alIqGN+NLb6asP98T1qnmqYC
	pgnMdlgRYjllftoSDmUez/n0fB2NytX3J1QA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wQOy6-00GSJJ-26;
	Fri, 22 May 2026 20:27:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 May 2026 20:27:10 +0800
Date: Fri, 22 May 2026 20:27:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	wangzhi@stu.xidian.edu.cn, byu@xidian.edu.cn, w15303746062@163.com,
	vdronov@redhat.com
Subject: Re: [PATCH v3 0/2] crypto: qat - remove unused ioctl interface
Message-ID: <ahBLnsokkkw9Futh@gondor.apana.org.au>
References: <20260511100854.29474-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511100854.29474-1-giovanni.cabiddu@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,stu.xidian.edu.cn,xidian.edu.cn,163.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24445-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:mid,gondor.apana.org.au:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: E38705B43F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 11:04:07AM +0100, Giovanni Cabiddu wrote:
> The QAT driver exposes a character device (qat_adf_ctl) with IOCTLs for
> device configuration, start, stop, status query and enumeration. These
> IOCTLs are not part of any public uAPI header and have no known in-tree
> or out-of-tree users.
> 
> This ioctl interface increases the attack surface and is the subject of a
> number of bug reports. Remove it entirely.
> 
> Patch 1 removes the character device, the IOCTL definitions, the related
> data structures and headers. It strips adf_ctl_drv.c down to the
> minimal module_init/module_exit hooks. This is marked for stable.
> 
> Patch 2 renames the now-minimal adf_ctl_drv.c to adf_module.c and
> adjusts function names to match the new file name. This is not marked
> for stable as it is a pure rename.
> 
> Changes since v1:
> - Addressed comments from Sashiko: cleaned up leftover dead code
>   https://sashiko.dev/#/patchset/20260508091912.206913-1-giovanni.cabiddu%40intel.com
> 
> Changes since v2:
> - Removed additional dead code: adf_devmgr_get_dev_by_id(),
>   adf_get_vf_real_id() and a few ADF_CFG unused macros
> 
> Giovanni Cabiddu (2):
>   crypto: qat - remove unused character device and IOCTLs
>   crypto: qat - rename adf_ctl_drv.c to adf_module.c
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 -
>  drivers/crypto/intel/qat/qat_common/Makefile  |   2 +-
>  drivers/crypto/intel/qat/qat_common/adf_cfg.c |  10 -
>  drivers/crypto/intel/qat/qat_common/adf_cfg.h |   1 -
>  .../intel/qat/qat_common/adf_cfg_common.h     |  32 --
>  .../intel/qat/qat_common/adf_cfg_user.h       |  38 --
>  .../intel/qat/qat_common/adf_common_drv.h     |   3 -
>  .../crypto/intel/qat/qat_common/adf_ctl_drv.c | 466 ------------------
>  .../crypto/intel/qat/qat_common/adf_dev_mgr.c |  70 ---
>  .../crypto/intel/qat/qat_common/adf_module.c  |  64 +++
>  10 files changed, 65 insertions(+), 622 deletions(-)
>  delete mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_user.h
>  delete mode 100644 drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_module.c
> 
> 
> base-commit: f7dd32c5179d7755de18e21d5674b08f9e5cb180
> -- 
> 2.54.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

