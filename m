Return-Path: <linux-crypto+bounces-21186-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePjjLVGsn2m1dAQAu9opvQ
	(envelope-from <linux-crypto+bounces-21186-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 03:13:37 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375C1A00C4
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 03:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5FC30086E2
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 02:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25680376462;
	Thu, 26 Feb 2026 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWRtr7JY"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97737419F
	for <linux-crypto@vger.kernel.org>; Thu, 26 Feb 2026 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072013; cv=none; b=mG9ruVHEDCZXXCAv9ZYHqEHTf5PQEdx+CeQ9Xi8hbhTFSTi8WMMHL85d2RghSlWM/T61EXzaf6oykiO/HUHVm1KC3dStDqvR2Yb8y/Otb24DQKsmgOo3tciJQkofV1jIuxlqW2Q6PlNncqUPicIFmBLLb+8T0cpvqfNcoweFv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072013; c=relaxed/simple;
	bh=XOfrE5iqPV4wzmg0ThnsmiXcvX5j7MpZO/hDp6lwsPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKfDS2mPqw3TsurU7BMTeQWt02ySwmFmfM36hlWHa+VRlbCUFk6R0hfqiI/5gKTabEkWJRjLMtUHXkDqc+sf6yQGPuClNy/0LWjXSx2QDtOhxs0d9s/lqvD3PwsotMSMfob6GGI9vgudPUb48Nvm1eFKfV7Ew9Zte96xtfQ4iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWRtr7JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A859C116D0;
	Thu, 26 Feb 2026 02:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772072013;
	bh=XOfrE5iqPV4wzmg0ThnsmiXcvX5j7MpZO/hDp6lwsPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWRtr7JY1RrWa/WaFPi1SRhZN1v83jk6rX/D4YC38pNkdRqjWhuFbyBXvCCLxp27G
	 /Y4oFgmAiXXW9Jpnke1qvmOwccdEO2OLYuzESOXeKlYp9ZnDk7cKZDFJc3llg62wBl
	 qf6Q+soQDJH1T9Ai5im5eQBVV5Z7xElfTB0U3fpJhaKqkVCSHnKB5hgQOiAOa92bI6
	 I1hlEik0D50oi3dghvI/D2KaiiRoYCnuVWPCzEKYtEIGO0XZVqyTZm9siBetuz0QKP
	 7QgBvqot7TECBNp0iH8fAxFOV+OIDawOtuZtpy9UVC/d9AbyezcNu4asx/N3hdcthP
	 66bFxM8zNxBCg==
Date: Wed, 25 Feb 2026 18:13:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 0/5] pkcs7: better handling of signed attributes
Message-ID: <20260226021331.GA55502@quark>
References: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21186-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2375C1A00C4
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:19:02PM -0500, James Bottomley wrote:
> Although the biggest use of signed attributes is PKCS#7 and X509
> specific data, they can be added to a signature to support arbitrary
> and verifiable objects.  This makes them particularly useful when you
> want to take an existing signature scheme and extend it with
> additional (but always verified) data in such a way that it still
> looks valid to both the old and new schemes.

What kernel subsystem is going to use this, and how?  As-is the only
caller of pkcs7_get_authattr() that you've proposed is in test code.

If this is for some out-of-tree module, we don't do that.

I'll also note that we should generally be aiming to simplify the PKCS#7
signature verification code, not making it even more complex.

- Eric

