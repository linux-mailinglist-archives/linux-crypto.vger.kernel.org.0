Return-Path: <linux-crypto+bounces-22217-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SQk2De5Lv2l/1gMAu9opvQ
	(envelope-from <linux-crypto+bounces-22217-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Mar 2026 02:54:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B96AC2E7EDF
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Mar 2026 02:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B71F83019FE4
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Mar 2026 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D85375ADE;
	Sun, 22 Mar 2026 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEp8nBlW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BD366079;
	Sun, 22 Mar 2026 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144487; cv=none; b=GFEis2duN9rbZgVTyDuyH+IVH1O9/eAmvNUyyTEbEZ3+W+46jYaZlEYk1Gs25+wQlTQY3E/ghSXBNr0PL+r+O0yH3IOzclPFLJ3lpL92twbAL3qGgSLKU6KXpx0NqzpqgB9pvrWNAxq/ccxc2acM0Yq1k6FzbmDhDSJ4oDiEm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144487; c=relaxed/simple;
	bh=aFD2Ff7LoG8iL5dcDbus7svfU2kU8WOLZeuTS3uXKhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sczo6HQoBSlCgAl0/VnfEN9S5jfwmh9xeZqbu4AeJTye0wkFM+mdhNOO/BisFfKP3BMWhIWtOE2i4YIGRizQY1bCafAyLrUJZaze6aHmVy37c+EgkpwQBaFfuJD/fz7NHkDFUEPTv71mVEhAY8pY9rVe9Bh7WC46mwFpMAo5Tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEp8nBlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495C6C19421;
	Sun, 22 Mar 2026 01:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774144487;
	bh=aFD2Ff7LoG8iL5dcDbus7svfU2kU8WOLZeuTS3uXKhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEp8nBlWl4emj19OyMFc94OWo3b3qMR8qgj78lSNO9PkFDjKPWXcDBmd4U7OBrqLK
	 WW4wq3R6Gi8Mm1iXa1nXos2RwBVBC2cSDmU5xzUb/ihw1Z7RLZZB/ndp1LeNL2eFDq
	 zN0d1DtlHZdtugLAex43wq4toV26MRE8fnZPHk+cYMLCCoUsyUKeCLxjXpFbvr36Oa
	 Ipfcls+dvVi3kwuD1Fcr9jCelCJM0Dv/gshMF1oh3Tfm8cA61IP5Y2E1rukohE8IHJ
	 cFSk380iIwXlQ0ePgvGws2oMYAHT9zPAx+w8FC2z/cYSaKeBRp2RzpLlaCDSN87z0f
	 OAyB0hzWfNUXQ==
Date: Sat, 21 Mar 2026 18:54:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cryptomgr - Select algorithm types only when
 CRYPTO_SELFTESTS
Message-ID: <20260322015445.GA2121@quark>
References: <20260321232932.98102-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321232932.98102-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22217-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B96AC2E7EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 04:29:32PM -0700, Eric Biggers wrote:
> Enabling any template selects CRYPTO_MANAGER, which causes
> CRYPTO_MANAGER2 to enable itself, which selects every algorithm type
> option.  However, pulling in all algorithm types is needed only when the
> self-tests are enabled.  So condition the selections accordingly.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

This will need a v2.  It turns out other symbols are relying on
transitive selections of these.

- Eric

