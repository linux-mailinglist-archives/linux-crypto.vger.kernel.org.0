Return-Path: <linux-crypto+bounces-23611-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGlRDECA9WmRLwIAu9opvQ
	(envelope-from <linux-crypto+bounces-23611-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 06:40:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 244624B0EB4
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 06:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C13073008624
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2026 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A32D7DC4;
	Sat,  2 May 2026 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Si2dazyZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB928F948;
	Sat,  2 May 2026 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696823; cv=none; b=Q4O75HZ1sfi0gAxTZbBy/Ul1UnH9L0JlMupTfsLnCvrapdzpgz52cDgLDb3A4lRNhO0/Sx+rlKSvkMUpSnQCeNarAXfKer4487hT3zFY0AEoTbyfWD6c34te/bSpaqFWFxlr1B1L2LntQIxzz4ncOIagSr/ExvfHJAAD7h59DLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696823; c=relaxed/simple;
	bh=LVuHFarIY4Imyjv3maU2tyVYzHTBmSTg5vN8o9CUJLc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qsva+Fzex+5aOSbCXXWI3tGUayOyrqE1K2WUnYMmkV9NoYQW2/kZnSeBWS1WhdfjykA/gYmdGA78JrvEcERj7c1mDSmNSBq8pI271/4aGNBkiI5RH2kmni+hO3er9mXGmUl+z0rzv5cMukizimLBCkTZAvGJNO4l/MlzRHToUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Si2dazyZ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=9tuePheF+0fT9wxy0VYEQsuANzcspY6DJ7N3/VEvz7w=; b=Si2da
	zyZJJX6q9jvkUwRCoZ0N0EbQWQFmoHkXcOa6JZLmgWmbCtqjkZr+NhiTfJohcj9tTgIgCFzbP062Q
	zRBkcvExrQoswxI/uNOMGMuaalKWmpw4YKY2gDpml7LeHSE3Osoo+xsVKUtBdJzDiyb/jnhZ6tPez
	NbPcVMkQN7bWcfOgw++/DxxSsqMbE/ZiPBKKucuP6b4C5d7bu2h6Zic9CzY7R867s9Fy7pidtozaQ
	ZnDwCgMfozdZ3uilRVrB6zjE365Otk7m0DRJMmF35WRLAzTkKLKbquAAsnQu8NQMjaFg6mLcCm1IZ
	Ay9Q61ylu0/wicwud+B9xQj30lEMw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wJ297-00AatT-2L;
	Sat, 02 May 2026 12:40:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 May 2026 12:40:05 +0800
Date: Sat, 2 May 2026 12:40:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 7.1
Message-ID: <afWAJTyPunD79Bcd@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 244624B0EB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-23611-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]

Hi Linus:

The following changes since commit 3bfbf5f0a99c991769ec562721285df7ab69240b:

  crypto: krb5enc - fix async decrypt skipping hash verification (2026-04-20 16:18:58 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v7.1-p3

for you to fetch changes up to 5db6ef9847717329f12c5ea8aba7e9f588a980c0:

  crypto: authencesn - reject short ahash digests during instance creation (2026-04-23 13:44:06 +0800)

----------------------------------------------------------------
This push contains the following changes:

- Reject algorithms with authsizes that are too short in authencesn.
----------------------------------------------------------------

Yucheng Lu (1):
      crypto: authencesn - reject short ahash digests during instance creation

 crypto/authencesn.c | 5 +++++
 1 file changed, 5 insertions(+)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

