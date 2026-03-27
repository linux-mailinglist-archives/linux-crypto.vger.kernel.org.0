Return-Path: <linux-crypto+bounces-22488-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KITZKVRXxmmMIwUAu9opvQ
	(envelope-from <linux-crypto+bounces-22488-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:09:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8906342349
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A8C930435EA
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA13A9D8B;
	Fri, 27 Mar 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="a0ZUXc74"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BF28D8D1;
	Fri, 27 Mar 2026 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606011; cv=none; b=DUUkv23Hy/9P5rON9vz0njZcntQzidgbBy46nYYbkFB4m5lZIwtk1uCR6cOrd98SzXcLKd+5r5P3/aHnNNJ+Ljqo02mUyK4oPEqOC+cDMeN7n8YvKMdHFpb5BH0VNkntpJc03phyfxAUkncJq+W9HCz3VzQqtewmQh6EJrwUaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606011; c=relaxed/simple;
	bh=RQ6IHNBx01dBJbWQ6PcCmxvviJY8Ftqwgxc8xMjoN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDoKuK5jFjif690SJEBrDskXDcV3qcU43Ja2tOcbC3/l83wWymbpIl2dr/aq2gRsrq8oWjjDomkLU++6PBTYlLjgUKyHei1bR+0YHx4Bn5u8wqq+9I9/w437n4OcRVx/VRUmQSFVBmFeYOU3bsP07sdldLzjrZiJXR2PlVjh2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=a0ZUXc74; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=4QzfYaLe/rXOHs+mVzfwGVshXWnq3+lcNx4XDowLmVY=; 
	b=a0ZUXc74/1e6kzIhdvVuxxUMrsvKdlw6sre0AwUe7RMDlU42cTHobkKWmwFjMIdZKdhFySCK5Lu
	6O5QBrh13CvDfIe7CkDax5OA884h//hU10X0UtlyRgn8eBd6NImAonJOna5naVY8Yhlp1CXAHfVyk
	HM/rGBhpk0en4bUjSfuu4Zz4p0VbnAEInBJ2LltuPJ0bSICwDTSjL3DBYqQ1FiXOAtwlI/buXtZB/
	12UEe59s3U668P1RMc8BsWYl749mNTmW23d2ZpwW/WazmaXMrB8+klHwTAjAF45yacdIrSBSiZKVC
	aBaQ6lvpR5K7BbUv1uHCBcMGWOSEGo/2BKvg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63fn-001bmP-2t;
	Fri, 27 Mar 2026 18:06:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:06:30 +0900
Date: Fri, 27 Mar 2026 19:06:30 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: nx - annotate struct nx842_crypto_header with
 __counted_by
Message-ID: <acZWps0gefzjyktn@gondor.apana.org.au>
References: <20260317201804.1393389-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317201804.1393389-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[us.ibm.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,davemloft.net,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22488-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,linux.dev:email]
X-Rspamd-Queue-Id: B8906342349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:18:06PM +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/nx/nx-842.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

