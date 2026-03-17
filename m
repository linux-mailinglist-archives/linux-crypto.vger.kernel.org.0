Return-Path: <linux-crypto+bounces-22060-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHioKiqDuWlyIgIAu9opvQ
	(envelope-from <linux-crypto+bounces-22060-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:36:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3871F2AE1CB
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723F4315A389
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D9376467;
	Tue, 17 Mar 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3j6f/kn"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84C376BCA;
	Tue, 17 Mar 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765138; cv=none; b=AK7+sjIEVrlIAHnrKxrQwbeN6QJlBHYcPqaFuJVpaUvCZ5bzlaOxnLu4/u+JIJ4CMdbXwgQFmicFW/kmhwglDC09aBCMsnYcFpfr4beI+TMfxHd19FTboADlaRz4M1iWZ2W5uBM07UZgad4AQJOnl+YXz+4NfVG8SN664G5MptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765138; c=relaxed/simple;
	bh=cYheTIqpcFI6XBmZlpJGrVLvA9SafZRNORIoUZKVj0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYmlCjWw2B3r0/p6mHODJr+dhCjZTqAlFP0i+ofR/gUvkw3lqMKLePebvfdG0ZvAeDVCA2NeJFiRRIEZhM3sZYh/OeggBbQdMO5WkI3crwnEREK7sa+vnoCdFGnHn+mOzSAFz/VpOzrA8LB0Tp6Kk9O2D87uRZcB58O2cIsI2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3j6f/kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115FEC2BC86;
	Tue, 17 Mar 2026 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765138;
	bh=cYheTIqpcFI6XBmZlpJGrVLvA9SafZRNORIoUZKVj0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3j6f/knD5CMzTIaf/nN32w38r/tE2Cp4mNGqfpdE4XKhOoHmi5e8bOcFVaFgqUZv
	 5h0IMDqVLRkw38w0xVQ5wu5e/9gFnhsu1i69TafzMnRIZ8px3RIfjphqVyUnnid09k
	 v3ohZkCtmz4XwKLrdJu8mNX2UcOtkZJ6Xz5WkD6xocS6EJ0FsN9WFkqWS/3ItQIMA1
	 HKEx1va87UjkYRERVjpF8LC1A6KXgq3AorrG3C051YkUuicCpYAMHCDxcMvjwHhpa4
	 ElY8EsMJkTgl/H/G4gFLTiyoZ5D2cXSW6mVigVY6uoxRBEep/N5+46lkdzQM533GTi
	 qNmTo5kCgzsDQ==
Date: Tue, 17 Mar 2026 09:31:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lib/crc: arm64: Drop check for CONFIG_KERNEL_MODE_NEON
Message-ID: <20260317163118.GE2931@sol>
References: <20260314175744.30620-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314175744.30620-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22060-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3871F2AE1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:57:44AM -0700, Eric Biggers wrote:
> CONFIG_KERNEL_MODE_NEON is always enabled on arm64, and it always has
> been since its introduction in 2013.  Given that and the fact that the
> usefulness of kernel-mode NEON has only been increasing over time,
> checking for this option in arm64-specific code is unnecessary.  Remove
> this check from lib/crc/ to simplify the code and prevent any future
> bugs where e.g. code gets disabled due to a typo in this logic.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting crc-next
> (https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

