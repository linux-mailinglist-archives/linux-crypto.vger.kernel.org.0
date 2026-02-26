Return-Path: <linux-crypto+bounces-21262-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEhYD92toGnDlgQAu9opvQ
	(envelope-from <linux-crypto+bounces-21262-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 21:32:29 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90531AF2BF
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 21:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22257301F7BF
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0742885D;
	Thu, 26 Feb 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXlAip6f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8B320CCC
	for <linux-crypto@vger.kernel.org>; Thu, 26 Feb 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137944; cv=none; b=W+bM6D+HESnVsZz4AcBv+YMhAiZt8+GqzGhig1kGgm7inc/WjVKk4cbx2Qbvj9X7lMZhCWN16ed2/bZp9xYTtNCZCazx/Dy3ZxOxL3f8Ifsed5muVOa2D4/43yp4V8374vu+Lf6QT/+lQdUrDARR4AYfOpRfk//pa1gBdHqBC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137944; c=relaxed/simple;
	bh=C+iTffCLjsqI4qo0b9qTkR5RJDv1+JxWY9RpgdkZiX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfbcUb7anABOGsBzr+NUA245NuwfdwBvZUVxfIu1fXkn6M0ZG5cKMtc6yNu1MFrtPMIVbf1d2I/lLckeAx2tvaVbctIyBRqnfLIQOEk9h34EapxS4A0I3KxCzAfsI9Q0XFA/8/U2FBbrpOjlMrUR72BP0PBWp2/LNPxqM8LqtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXlAip6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30193C116C6;
	Thu, 26 Feb 2026 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772137944;
	bh=C+iTffCLjsqI4qo0b9qTkR5RJDv1+JxWY9RpgdkZiX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXlAip6fEExCl1C0fzFtHFOrz+mm7xB/NUz1LDK9qscetMDQ9ds8LtPUb/gAdagWr
	 kPjGhG+6LKh6vIHmkLoNuVf1ZDO00l+09V2uMSAohIzX1MbBkmimZLAmKKEY9UJDPG
	 x3HPiXhyrNnH2eZAqQ7PZTcx+ZvhpuLTsfUV4d9Hd+07U4XSDU6Io11Y4AVh4Ag2jI
	 4qJtWJztMIwDi8ebRnDPGxM96bGa1Btm35VAzE5Ykbuu+Qpa901zxD8fW7llh7BtWr
	 yCSLc0lV/5WZ04zwAFP84AAchAiFfTsTQMQiKH+43xbCUVyHy+DcCPgXXHNSrw7vFb
	 uY2nFvWg8rUIQ==
Date: Thu, 26 Feb 2026 12:31:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 3/5] crypto: pkcs7: allow pkcs7_digest() to be called
 from pkcs7_trust
Message-ID: <20260226203133.GB2273@sol>
References: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
 <20260225211907.7368-4-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225211907.7368-4-James.Bottomley@HansenPartnership.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21262-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A90531AF2BF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:19:05PM -0500, James Bottomley wrote:
> +	/*
> +	 * if we're being called immediately after parse, the
> +	 * signature won't have a calculated digest yet, so calculate
> +	 * one.  This function returns immediately if a digest has
> +	 * already been calculated
> +	 */
> +	pkcs7_digest(pkcs7, sinfo);

pkcs7_digest() can fail, returning an error code and leaving sig->m ==
NULL && sig->m_size == 0.  Here, the error is just being ignored.
Doesn't that then cause the signature verification to proceed against an
empty message, rather than anything related to the data provided?

- Eric

