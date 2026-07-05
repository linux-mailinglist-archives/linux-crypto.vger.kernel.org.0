Return-Path: <linux-crypto+bounces-25600-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4nqM4gWSmrX+AAAu9opvQ
	(envelope-from <linux-crypto+bounces-25600-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:32:08 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB4709753
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 10:32:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=lQubVYDn;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25600-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25600-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DC82300A502
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57485318146;
	Sun,  5 Jul 2026 08:32:06 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E78F2B;
	Sun,  5 Jul 2026 08:32:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240326; cv=none; b=QTix35cII+0QUJCBMYkzf08ky72j2ndPNOL8ei/mK4mAEqk2F5RKp+bD8CyXu0IB3G0aRtDqHNuf6xjm4IJlRDEtKfDKpuxgFXSPelpt15YqxoIXch0eFfMg90oa2/RLhRrGrZ2r1k/5eqYWN4HYBsilSTndcebgFlros95vLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240326; c=relaxed/simple;
	bh=F4HRd61PC5wC5hTGf1MMPk7ErqLFD9JIa7HW4/L/CHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw91VrQewIHoPDUp2qsowX2jp+LTa7BZ9AGjtHYLDAGiSCvYXTNAeROvrL1NoipU/E7NF5VTS2LlkQxjgkfIfNkizpe1D8MVW31fsBM1c9cmiB4TJBTDvR1ZB/z9NdSUVwpNRs1bhdvrIcWxWKd7wJeQ2LyEab3+1F/auiltISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lQubVYDn; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=u1ThbLSodWf0lwDI+25VPVsvqW22OFSxSVxWmvJ+Npk=; 
	b=lQubVYDn497QS3k0Wz9CUOXt8E+COGfrd7XEIMYKtGqVQShROdgGC7t8ms7D9jbB6mfEroaDvKu
	F+oR+3rqbj5Bo89D8ljNwHRucOADnScPZ3hHuCiBYxy3S9sJ7+ORhbOHTp4e4js+iGtbi4HX21U7e
	phaaiLpWWHqgF6PqTYGzjO8Bbm1FbRuY+7P69FY2BMkkunUxbbpCbD930S2byS9h1By+5Dnu70ZDJ
	qKhm6XDtkNgw1VSCp8oI5ktyvUT2hys9XxAUaoDPl9CF6/Fha0XKLdGXi+D124UGvhTbQTYPvIxs0
	KdKWc47W04prIMddTFv33ovzd6NySIj9AUiA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wgIGf-0000000Al0u-1EhV;
	Sun, 05 Jul 2026 16:32:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Jul 2026 16:32:01 +0800
Date: Sun, 5 Jul 2026 16:32:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: ashish.kalra@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, tycho@kernel.org,
	nikunj@amd.com, michael.roth@amd.com
Subject: Re: [PATCH v5] crypto/ccp: Introduce SNP_VERIFY_MITIGATION command
Message-ID: <akoWgZuz356fAiQS@gondor.apana.org.au>
References: <682e46e778b7394fb679591c9b6e4d9aeafa9462.1781533471.git.prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682e46e778b7394fb679591c9b6e4d9aeafa9462.1781533471.git.prsampat@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25600-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:prsampat@amd.com,m:ashish.kalra@amd.com,m:thomas.lendacky@amd.com,m:john.allen@amd.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aik@amd.com,m:tycho@kernel.org,m:nikunj@amd.com,m:michael.roth@amd.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:url,apana.org.au:email,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39BB4709753

On Mon, Jun 15, 2026 at 03:23:15PM +0000, Pratik R. Sampat wrote:
> The SEV-SNP firmware provides the SNP_VERIFY_MITIGATION command, which
> can be used to query the status of currently supported vulnerability
> mitigations and to initiate mitigations within the firmware.
> 
> This command is an explicit mechanism to ascertain if a firmware
> mitigation is applied without needing a full RMP re-build, which is most
> useful in a live firmware update scenario.
> 
> The firmware supports two subcommands: STATUS and VERIFY. The STATUS
> subcommand is used to query the supported and verified mitigation bits.
> The VERIFY subcommand initiates the mitigation process within the FW for
> the specified vulnerability. Expose a userspace interface under:
> /sys/firmware/sev/vulnerabilities/
>   - supported_mitigations (read-only): supported mitigation vector mask
>   - verified_mitigations (read/write): current verified mask; write a
>     vector to request VERIFY for that bit
> 
> The behavior of SNP_VERIFY_MITIGATION and the pre-requisites for using
> it are bug-specific. Information about supported mitigations and its
> corresponding vector is to be published as part of the AMD Security
> Bulletin.
> 
> See SEV-SNP Firmware ABI specifications 1.58, SNP_VERIFY_MITIGATION for
> more details.
> 
> Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
> v5:
>  * Collect Reviewed-by Tags
>  * Check for multiple bits set in the mitigation vector - Tom
>  * Add CONFG_SYSFS option to #else and #endif - Tom
>  * Minor whitespace and grammer fixes - Tom
>  * Return -EINVAL instead of -EIO for mitigation failure bit set
>    reporting - Tycho
> 
> v4: https://lore.kernel.org/linux-crypto/4957b07dbb4029a4c59bb3cf35f068c36284aa48.1780693665.git.prsampat@amd.com/
>  * Split interface definitions in documentation - Kernel Test Bot
>  * Wrap snp_verify_mitigation() under #ifdef CONFIG_SYSFS - Tom
>  * Remove check for snp initialized and feature info active for
>    registering mitigigation interface - Tom
>  * Since init vs init races should not be possible anymore[1], remove the
>    sysfs mutex guard as sysfs' own synchornization suffices - Tom, Tycho
>  * Dropping the reviewed-by since the patch has changed in a meaningful
>    way
> 
> v3: https://lore.kernel.org/linux-crypto/a043a82c-f3dd-4f29-86fb-60638eaddc9b@amd.com/
>   * Remove failed_status interface and report failure via dev_err - Tycho
>   * Make vulnerability interfaces root only accessible - Sashiko
>   * Move /sys/firmware/vulnerabilities/ to
>     /sys/firmware/sev/vulnerabilities/ to be platform specific - Sashiko
>   * Guard sysfs creation under a new mutex to avoid racing during
>     creation and using the sev_cmd_mutex which would race with
>     vulnerability operations - Sashiko
> 
> [1]: https://lore.kernel.org/all/20260504165147.1615643-5-tycho@kernel.org/
> 
> Patch based on cryptodev-2.6
> ---
>  .../sysfs-firmware-sev-vulnerabilities        |  19 ++
>  drivers/crypto/ccp/sev-dev.c                  | 177 ++++++++++++++++++
>  drivers/crypto/ccp/sev-dev.h                  |   3 +
>  include/linux/psp-sev.h                       |  51 +++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-sev-vulnerabilities

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

