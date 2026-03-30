Return-Path: <linux-crypto+bounces-22612-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPN6D1fRymmsAQYAu9opvQ
	(envelope-from <linux-crypto+bounces-22612-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 21:39:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9A360838
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 162C6303778D
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB739A7FA;
	Mon, 30 Mar 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbd2Bix1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FE397686;
	Mon, 30 Mar 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899508; cv=none; b=ESpThvGROkwIgkZsi84brKxxsaFwGi5g6eJJeX3J9DM+BfyAhA59DrHyHJpM7r6wJydse7Tmva4Jf2E0vpJ3NfDpskttEhwm64wdEVFCMSpKBAETCVAjf2zhD8Go9OtwsPjc4NcRVsEY6llNy3J0xV1ugpoDdc75vYjibJixLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899508; c=relaxed/simple;
	bh=kHXM89WWXGaraKsUtolg0qgFqx3d1l1dFEp3lKbplYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9+JWxrneCiC/LWVcMxbLfd1Y+gQWCBzDywjeSLxJ9GtKbg2W+wQXEMLRTpSrG6E2Izy8lGNbTTsokylRhe/D7sIlv7rLQ1CWRswvJffiAuVloqroQqU+7zgfkXomJ+QeRz9AQiV7YygY281/cRbyqk4P7pEXji2bsdSz+iYx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbd2Bix1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E156C4CEF7;
	Mon, 30 Mar 2026 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774899507;
	bh=kHXM89WWXGaraKsUtolg0qgFqx3d1l1dFEp3lKbplYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nbd2Bix1SuPt0vpbuR67HPu6IZe+cOLFnb/PZpm+rYimYxhyURraAaioOu2g9V6NS
	 QAu/u3eSvkFdQ1BiYZ624rxZIQdAKBEUktw6X1IDnUMv42qDLM+Gykgb6hOpXWIm/b
	 W3v9+6aaIpMI4ICK0iPeSllm/i5rTyZSvMLdtKJ6KBpiMMb3jbbVP3ZLWwNLqZRj3v
	 zMkV0asfxRngXXQdUNbpe7+eJ8UWeZRXfT6GHZozgbX97jgmvbbEzRh1cWkcepdpgB
	 SQyn9Wflb3bCBsldcoJZlfU4j+5xulU7RQ+h+9gbBD/mj+ZfjuLltDeXcTyDn1TB4F
	 Y/G76b1u6aGjg==
Date: Mon, 30 Mar 2026 12:37:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: sparc: Drop optimized MD5 code
Message-ID: <20260330193718.GB4303@sol>
References: <20260326203341.60393-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326203341.60393-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22612-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAF9A360838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:33:41PM -0700, Eric Biggers wrote:
> MD5 is obsolete.  Continuing to maintain architecture-optimized
> implementations of MD5 is unnecessary and risky.  It diverts resources
> from the modern algorithms that are actually important.
> 
> While there was demand for continuing to maintain the PowerPC optimized
> MD5 code to accommodate userspace programs that are misusing AF_ALG
> (https://lore.kernel.org/linux-crypto/c4191597-341d-4fd7-bc3d-13daf7666c41@csgroup.eu/),
> no such demand has been seen for the SPARC optimized MD5 code.
> 
> Thus, let's drop it and focus effort on the more modern SHA algorithms,
> which already have optimized code for SPARC.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting libcrypto-next

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric

