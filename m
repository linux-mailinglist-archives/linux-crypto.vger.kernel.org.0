Return-Path: <linux-crypto+bounces-22057-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CER3MsmBuWmxHAIAu9opvQ
	(envelope-from <linux-crypto+bounces-22057-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:31:05 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DED2ADFFC
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EACAF3010788
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3237703A;
	Tue, 17 Mar 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK7WqClR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B737649B;
	Tue, 17 Mar 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765061; cv=none; b=JCJQwJ3TAh2lFTARs4re9qJVh2WZSP3oOU1jdbTawyf43xX79rkS9bP4HXBiukMZmOzwjGtyxZ9OjhYqDif0p0oVVDBaCAy7cSPi0MM9zid/ptoc55omGJJCVSJLA53Qq+dujPEWaLa2v0mAajHBA99jKYAbgp/JZ6m2MyvKAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765061; c=relaxed/simple;
	bh=f7M8YijdANJIM7TwtqYVn+G6KqOEWAFeN7/No3wmCcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRHHuMNM8qW0jSQUNyV3T1DwRzYWCt+54gHnuqg8/GTWHuSczlfQq8LIzkDTYKyzZJc9yHTUUgXULtuq+6e4uLOw/UANrW5hpRP751sW5eYIb+AtktCIjNwLZOMgTP3ZGSrils4Wru9u0nQ1bcDbBvseAeUK9ex4qJGYY/DfE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK7WqClR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB374C4CEF7;
	Tue, 17 Mar 2026 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765061;
	bh=f7M8YijdANJIM7TwtqYVn+G6KqOEWAFeN7/No3wmCcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FK7WqClRcXiprDvXkPmiUiykVRGnMEMt8Y7Q6gStvwlBrkBZZGlyFURDEoTuUfKlJ
	 hUzR5+SmO8qlZ5fwBy5w/hdV31tHra0yzVnbz6rqdbTC/3XNUVh/r59fCvMhrBCotG
	 nIbvGkwYxclPqKOTer4iYGtlfCDolv3Ns7qKXOhiecHCG4ntQj95HphjAAXQEjq7m5
	 TBC3ManZ6Cy6rvPmKg1SUf3T7bYvW162jrwGjuN3jSyqIMDhmedg+/uyglRyxhXKVN
	 8q+C0HIe0L2MLExAiJscPBtcJrr+6YjE8OXzJyssmSCxmo+TWd2YDHmbmgi2i7KDES
	 cBTI/CDYgmosw==
Date: Tue, 17 Mar 2026 09:30:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	kunit-dev@googlegroups.com,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: Re: [PATCH] kunit: configs: Enable all CRC tests in all_tests.config
Message-ID: <20260317163001.GB2931@sol>
References: <20260314172224.15152-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314172224.15152-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,googlegroups.com,linux.dev,davidgow.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-22057-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kunit.py:url]
X-Rspamd-Queue-Id: 83DED2ADFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:22:24AM -0700, Eric Biggers wrote:
> The new option CONFIG_CRC_ENABLE_ALL_FOR_KUNIT enables all the CRC code
> that has KUnit tests, causing CONFIG_KUNIT_ALL_TESTS to enable all these
> tests.  Add this option to all_tests.config so that kunit.py will run
> them when passed the --alltests option.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting crc-next
> (https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next)
> which has the commit adding CONFIG_CRC_ENABLE_ALL_FOR_KUNIT.
> 
> Note that patch also mirrors
> https://lore.kernel.org/linux-crypto/20260314035927.51351-3-ebiggers@kernel.org/
> which does the same for the crypto library tests.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

