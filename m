Return-Path: <linux-crypto+bounces-23635-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK3sHMct+GnsrAIAu9opvQ
	(envelope-from <linux-crypto+bounces-23635-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 07:25:27 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C723F4B87EE
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 07:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 537F5300C92C
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668826D4DD;
	Mon,  4 May 2026 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joxUbXZC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880E194C95;
	Mon,  4 May 2026 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777872319; cv=none; b=PipDsrwI7Wc+Mw3UgOnMiyVsETzQJgWyijDzk079P/LF2gHFos/qGXAzNGR4NOG+a575usllwocrG/ZFQl23udj4Iq1Pip2PSCMa+ERAIo4E36FHB9mKHBsorCezIbTl3sdZu4d71TZjLw8sHAHVdJzNCB1netUtVJ24oUAnIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777872319; c=relaxed/simple;
	bh=cWsY04NwTyuRryFb593w+Gq66PE1c9915vbtt/EVhIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ifoY0zIanwjNk8jLmXUL6hpNN2HzkgiQtC/Y/ch9swBDi8XlHBGqQ9UyDFe5Txubm/4i0IXkUrD0f1kd5ahu4l9fR0qaEoIGB3ZqaCtedXxUScFjJai1NFCJgzYIXzKqzHewoquCLykBn7SGkuUoHH5uZUIaRQS2xaRinHvq1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joxUbXZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29701C2BCB8;
	Mon,  4 May 2026 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777872319;
	bh=cWsY04NwTyuRryFb593w+Gq66PE1c9915vbtt/EVhIk=;
	h=Date:From:To:Cc:Subject:From;
	b=joxUbXZCAe5V9caMTmTkqUjPaK1xnAC7R7izG1FMcEbOaIqIfcW8swiS7YU1VD30n
	 FGJpl6wcIB18FxYxQWvEykxj7Aw7EY3T39iELpWBelP1ioLQyRW3lav0qzbVBgGL3B
	 i/B6xwCpkNvaF1lYvVJ9K1eO4gV6pEh8RFTkJnZfcoSSVUK+NIAlU3mkHQF4411SJd
	 Y7MCeoC+MZ3awvlTPduw52oKslVE5hiwYot5j6u87COz38npdfVCgglldYxjjozqTK
	 78NV459ubHfLbFtvIOwPremK/wVDZc6rxNE8xVJ9zfq1+iT9OFJf9IgH71to9/aos2
	 8NxN32puMXWOA==
Date: Sun, 3 May 2026 22:24:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Milan Broz <gmazyland@gmail.com>,
	cryptsetup development <cryptsetup@lists.linux.dev>
Cc: linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: AF_ALG algorithms required by cryptsetup
Message-ID: <20260504052400.GB2289@sol>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: C723F4B87EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23635-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Milan,

AF_ALG is going to have to go away eventually, due to its frequent
vulnerabilities which vastly outweigh its benefits.  Userspace crypto
code can be, should be, and generally already is used instead.

In the meantime, AF_ALG will need to be hardened by reducing its attack
surface, for example by removing unneeded algorithms and/or adding a
privilege check.

I understand cryptsetup actually already links to a userspace crypto
library such as libcrypto or libgcrypt by default (more than one is
supported).  However, it sometimes falls back to AF_ALG for certain
algorithms for password hashing or keyslot encryption.  The default
settings don't seem to use it (indeed, I use LUKS on one of my systems
and AF_ALG isn't enabled in my kernel), but some non-default settings
seem to use it.

Is a reasonably definitive list of the algorithms cryptsetup needs from
AF_ALG available anywhere, so that an allowlist can be implemented on
the kernel side?

(It would need to be unioned with what iwd uses as well.)

Also, what are the biggest blockers to removing the AF_ALG dependency
from cryptsetup, in your view?

Finally, how well would a CAP_SYS_ADMIN or CAP_NET_ADMIN restriction
work for cryptsetup?  IIUC, volume formatting and opening require root
anyway, and all the device-mapper ioctls already require CAP_SYS_ADMIN.
I know 'cryptsetup benchmark' would be affected, but that tends to be a
one-off manually-run thing, which people could add 'sudo' to.

- Eric

