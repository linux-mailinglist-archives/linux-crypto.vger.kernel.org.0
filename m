Return-Path: <linux-crypto+bounces-22135-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJttJC4zvGl3uwIAu9opvQ
	(envelope-from <linux-crypto+bounces-22135-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 18:32:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7822D00BD
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F3C83010B46
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E4385522;
	Thu, 19 Mar 2026 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Skg2l+yU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD93859C7;
	Thu, 19 Mar 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941544; cv=none; b=BlYO+CW4H3Ki3n3UjjXTB0hWB+UywlWPkOd2vcPunErOVkzPu7VNSG9xGVzH35vXx/aj5c8IUcrOClPTCe0cJg+qGZpHwEbpbdYH/IjxKpxWZ7mMayPQ7NFcKbXidKWebkyTw27mKU8WmMI33rfTSzdILwHbX1q2C1vKj5RDF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941544; c=relaxed/simple;
	bh=sZ1CFS4JRpgIq3ZpYmNJbtZIozTjOwSu47s80AoJ0KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNoD5Eoiyv7BEfBIB2L/CMFgIMHhl9v2yXixtVNJaOQCfqaIXKjNrwLHDau5rRjK42wFsk6eiGZN9KANsNPggW22a2CZQlrogP7UeKwxkaA5RwZVCSKdtY3AUq7l7J7m7XouIVwHhDAWd1ap0TyECaNFwGS9dNVQEjE4tkrhj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Skg2l+yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D76C19424;
	Thu, 19 Mar 2026 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941544;
	bh=sZ1CFS4JRpgIq3ZpYmNJbtZIozTjOwSu47s80AoJ0KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Skg2l+yU7GILoPBUa9poQPRsctN5AIUrHejk0O0Ahu36VjTWhX0tJO0LZdqCloHsO
	 3wIgplw+qHdj5UQSTnHydsxDbg2UcnkSyx2OnCio4HfI/01xnUbh4BB5UCS+nLVcPl
	 Jgu9KUHkTZk/ruc/mKDXBoVmyU/gUYcrr9EpCUv31TmUrAV0CZaVwQl2FYlE4MGQja
	 8N4Du5kNqY15URg/0u09BQySLd0yIBnfr7CP64q8hAUUK8skmJTZwC+XdOttn07i9j
	 B+PMXXlD7t0CPTzAXT74DO96MBYntIWUBFhpwuNaMHSLQQAJHKD/6h1Go6tlnC2a1J
	 +e5HHaXS5B+jg==
Date: Thu, 19 Mar 2026 10:32:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Cedric Xing <cedric.xing@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Li <zi.li@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Zhou Yuhang <zhouyuhang@kylinos.cn>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/tsm-mr: Use SHA-2 library APIs
Message-ID: <20260319173222.GA10208@quark>
References: <20260318164233.19800-1-ebiggers@kernel.org>
 <dc124ea8-05b8-42d2-93ad-d265e0ecf585@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc124ea8-05b8-42d2-93ad-d265e0ecf585@app.fastmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22135-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,intel.com,google.com,linux-foundation.org,linux.dev,kylinos.cn,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A7822D00BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 08:57:01PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 18, 2026, at 17:42, Eric Biggers wrote:
> > Given that tsm_mr_sample has a particular set of algorithms that it
> > wants, just use the library APIs for those algorithms rather than
> > crypto_shash.  This is more straightforward and a bit more efficient.
> >
> > This fixes an issue where this module failed to build due to the kconfig
> > options CRYPTO and CRYPTO_HASH not being selected.  Also, even if it
> > built, crypto_alloc_shash() could fail at runtime due to the needed
> > algorithms not being available.
> >
> > The library functions simply use direct linking.  So if it builds, which
> > it will due to the kconfig options being enabled, they are available.
> >
> > Fixes: f6953f1f9ec4 ("tsm-mr: Add tsm-mr sample code")
> > Fixes: 44a3873df811 ("coco/guest: Remove unneeded selection of CRYPTO")
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >
> > I'd like to take this via libcrypto-next, as that is where
> > "coco/guest: Remove unneeded selection of CRYPTO" is.
> 
> Thanks for fixing this! It is indeed nicer than the fix
> I sent earlier today.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.  Additional acks from the people owning this code (Dan, Cedric?)
would be appreciated.  But since this fixes a build error and is related
to the crypto library, I went ahead and applied this to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

I also found that the build error is pre-existing, as CRYPTO_HASH was
not being selected.  "coco/guest: Remove unneeded selection of CRYPTO"
just made it a bit easier to encounter, by not selecting CRYPTO either.

So I updated the second paragraph of the commit message to:

    This also fixes a bug where this module failed to build if it was
    enabled without CRYPTO_HASH happening to be set elsewhere in the
    kconfig.  (With the concurrent change to make TSM_MEASUREMENTS stop
    selecting CRYPTO, this existing build error would have become easier to
    encounter, as well.)  Also, even if it built, crypto_alloc_shash() could
    fail at runtime due to the needed algorithms not being available.

I also put this commit before "coco/guest: Remove unneeded selection of
CRYPTO" and dropped the Fixes reference to that.  So now it just has:

    Fixes: f6953f1f9ec4 ("tsm-mr: Add tsm-mr sample code")

- Eric

