Return-Path: <linux-crypto+bounces-23026-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNoTCVTP32m4ZAAAu9opvQ
	(envelope-from <linux-crypto+bounces-23026-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 19:48:04 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A35406E5D
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12B623021097
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F237D139;
	Wed, 15 Apr 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZfr0SwT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAE41C71;
	Wed, 15 Apr 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275277; cv=none; b=jUCikfKJUgkuKXcu0OaLL6UQk16D3DGOSlqiNMq83KupQUqvLJCVg63C7p1zbF1uRnI8YHTcthz58go6i5k0H1QOPxPB9c+BG5SHO/x9lVyR+d470l4fgzYUECZndRDEfGYgcuC2TL1mhwAp6FGGeqhG36xX+fpjApcMZr0KVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275277; c=relaxed/simple;
	bh=9R8GIgkY9znoWD22HXqzJPBSmLSQpA3WKgY6KvOeBS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QMHIjjHF6PLoydIUOFJqFNW9poVJaMlG8G8MD5iP1l0Q70t1tasktJCmGFZpQl8syNzCKALoNFEf5nCLz++gp8QFGR0T9rqpR0fxUdQNs9MezBXKVavRL3S0hjZTASntqNDjdLd1ncbXhscQujuugC3/qjDUAERV/xAVHV+jX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZfr0SwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66DCC2BCB4;
	Wed, 15 Apr 2026 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776275277;
	bh=9R8GIgkY9znoWD22HXqzJPBSmLSQpA3WKgY6KvOeBS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PZfr0SwTG5RgSvn98QSiDA9r8eUy6qNR/sScVFsoqmcJwWtu8L+EKREFmTjj5ONAJ
	 rRjNkYas14MTfHJwXOilRQO0/OM7CO0/gGtdyAZea7YmMVJ9K/h/tCNnX4wuCiel2Z
	 CPmu9zSO0BDzBaZnWSpcH33fJ73w+3X5rZEONt6ngDD+5Sy9aeM73q6LAS0jpsJIpO
	 Acx5tq9O+Xnvtd6bvnwAH65AzKTNDeq2gpGKD8vO1746p73vaAw1kgeW725gfTA8md
	 CBh15zI6CZhL5412mq95kY+SNRrVYFllhcaEH5MK53F4VrZWcieFv5j+fkZWpTj9Zo
	 U3jxqgO6jQo8g==
Date: Wed, 15 Apr 2026 10:47:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [linus:master] [lib/crypto]  e5046823f8:
 stress-ng.urandom.ops_per_sec 4.3% regression
Message-ID: <20260415174755.GB3142@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202604151657.8e26ef70-lkp@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23026-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04A35406E5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[+Cc Jason and Ted]

On Wed, Apr 15, 2026 at 04:45:48PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 4.3% regression of stress-ng.urandom.ops_per_sec on:
> 
> 
> commit: e5046823f8fa3677341b541a25af2fcb99a5b1e0 ("lib/crypto: chacha: Zeroize permuted_state before it leaves scope")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This commit fixed the forward secrecy of the RNG, so it needed to go in.

For large RNG requests, we could get most of this performance back by
refactoring the chacha20_block() API to move the allocation of the
temporary state array into the caller.

We could also get much better performance than before by using the
architecture-optimized ChaCha20 code instead of the generic ChaCha20
code.

However, neither would be a simple change.

- Eric

