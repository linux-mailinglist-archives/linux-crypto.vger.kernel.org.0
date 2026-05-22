Return-Path: <linux-crypto+bounces-24452-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB3aCFZQEGq5VwYAu9opvQ
	(envelope-from <linux-crypto+bounces-24452-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:47:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9054A5B4653
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 14:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC127310D9FE
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216553B2D00;
	Fri, 22 May 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="oGqB0mbZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799563B27EE
	for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453015; cv=none; b=aj7A05HYaVoR6DxxGcFo+1nQhONe0ruCtqIjUUgy5kHsiOOHKC/8baADAFsFRQlPM/6+RmL1Ut5W/YJJiVkmyGSXNdBX343nGmaIcs9g7CHzn1r+8ty7MTp4N950ukeDjj6p3sGqzVGPVOc1OraqMbr004OlJnyiuKvp7kACdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453015; c=relaxed/simple;
	bh=61uIYwL9erfqoN/v8gMuS+5PK2che/nRNBcaunuI4V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoJdvHpN3ovrytQY8l1PHcKH8/G0DyDzChovgxPV6WYMrM7UZVuFCP5Z/6dEDd5BejAOkc45IyLGfvlPoHdlyr6OUT/nRfJIo42Jt8n08hzEcNWnAzpK9Gd53nxHSPRDQa5Hn6W3xFdrJgaZ4evIdvhq60hyNT78qc5ByYCHgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=oGqB0mbZ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=bURVAgw31j7D8j7kANyqBjSVae9Oto1QDOcNNNUJq44=; 
	b=oGqB0mbZ1SfKjhCwKhNKbfcb0bMoIkzf58AQFTY9oX0DCrImaa7sDI+fampbSEdrWSSV+zgPyuV
	V3lUyVZeI4KwVNoQuOv3vvo2VXWNwpAVlQhbsl6EpUEOevIke3PDkmp/0+VW2TxmPCFaza6pzjEN7
	EVztwNeelBym5c3I3gs9QCqzZhlk5oY5WzDO9SrRFlIVxZT0aiHI++6abFospl3ZY9uXp5uHQg7UL
	QoWn6lVmrNh2cPA6FTRllJENpOH+6843uZViTawIPCNF8erH6jkGJAh2GeBFS4JbbyNxGc5siP1yP
	AaJhwO8zwkMjSMcdFK8S+IXwTdrevuFsKUmw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wQP11-00GSNn-0R;
	Fri, 22 May 2026 20:30:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 May 2026 20:30:11 +0800
Date: Fri, 22 May 2026 20:30:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Fiona Trahe <fiona.trahe@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH] Documentation: qat_rl: make rate limiting wording clearer
Message-ID: <ahBMU0iUaKv3zqtP@gondor.apana.org.au>
References: <20260513153317.32355-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513153317.32355-1-giovanni.cabiddu@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24452-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Queue-Id: 9054A5B4653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 13, 2026 at 04:33:08PM +0100, Giovanni Cabiddu wrote:
> From: Fiona Trahe <fiona.trahe@intel.com>
> 
> The term "capability" typically refers to an ability to perform an
> action, whereas "capacity" denotes a measurable amount of resources.
> 
> Since the sysfs-driver-qat_rl document describes remaining resources
> available to perform work, "capacity" is the more accurate term.
> 
> Replace "capability" with "capacity" in the document.
> 
> Signed-off-by: Fiona Trahe <fiona.trahe@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat_rl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

