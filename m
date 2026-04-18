Return-Path: <linux-crypto+bounces-23166-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPZgHi0C5GnJOgEAu9opvQ
	(envelope-from <linux-crypto+bounces-23166-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 19 Apr 2026 00:14:05 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A54225D2
	for <lists+linux-crypto@lfdr.de>; Sun, 19 Apr 2026 00:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B8E3014941
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Apr 2026 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6302346E60;
	Sat, 18 Apr 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUO/T1oe"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B4255F28;
	Sat, 18 Apr 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776550417; cv=none; b=f/+h0JDBsMZwT6mp+dknw0Uew7nsCJ3CcfAvcQ4juhzNNJiQW2cCWkC5egZSxsAJpyjjd65mIpi+4j/AKq7uut0JUVwPbE4jMNQIta6KHOUELTaZjYA2prXDOPKz/ZJ1RLZh9A1NCbABIdx88kjEui1819N1dx5BUi5jqW5NNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776550417; c=relaxed/simple;
	bh=eOe3+zCYbTsR+dZksbeU88CmBAwOeZfSa3rrrUtEl7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8muq+hMXQPPSx5Y7d48CD9vy6wD+dQ7mzscIS3soV3R6l/dNPl/TMXwycepmQhXvBnQVHFhXWrmPcebm02otkL8jE32dlNkWg6mfGq1Yaqr4UsEvi0RRr/sAEvJHp40TDIAQ0Lh9bcVRrTvj2XMfMFOfGxwipqgOHZ2mSwvVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUO/T1oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB526C19424;
	Sat, 18 Apr 2026 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776550417;
	bh=eOe3+zCYbTsR+dZksbeU88CmBAwOeZfSa3rrrUtEl7s=;
	h=From:To:Cc:Subject:Date:From;
	b=pUO/T1oe9VeVzZ89+1zS6jMbpL2AaS3HxjNVK5deRe+4QwfwfiYXbVpXGkM/+M7Mu
	 SQd7/7E6dbwYn3no/Kw/2YIiRqvULxE22ijiZvfmURRbfcAsSDNDbGcgkXOwmgu1Ul
	 0kBM1IMAAIUqc7iPeo8wp53YbSTK0Xw+BN7pz9p19jFUM4iz3RoYe8VD76v8cX2+td
	 L3+SIH7qq/f6zeyxmvY7ELLLJFh7++SQm9G2P7Od8rCm+oDnLUzBpbRica8T20Jfvb
	 7iSlHJKQ5B70ZFbdA2t8plAptYLsFq5lH1ZFl/dVPs97djR0Wavcw5AjS2ttVi4kFG
	 K1tdPyyVxU5+A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-cifs@vger.kernel.org,
	Steve French <sfrench@samba.org>
Cc: linux-crypto@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/4] smb: client: Use AES-CMAC library
Date: Sat, 18 Apr 2026 15:13:07 -0700
Message-ID: <20260418221311.67583-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23166-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 237A54225D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series updates the SMB client to use the AES-CMAC library functions
that were recently added, instead of a "cmac(aes)" crypto_shash.  As
usual, this simplifies the code considerably and is much more efficient.

These patches were originally sent as patches 8-11 of the series
https://lore.kernel.org/r/20260218213501.136844-1-ebiggers@kernel.org/
The only change from that version was adding tags and rebasing.
I also added some microbenchmark results below.

This is intended to be taken through the smb tree, either 7.1 or 7.2
depending on maintainer preference.

A few microbenchmarks that demonstrate improved performance:

 - Total cycles spent in generate_key() during SMB3 mount
   decreased from 20640 to 10780 (3 calls total).

 - Total cycles spent in smb3_calc_signature() during SMB3 mount
   decreased from 177620 to 73180 (32 calls & 4255 bytes total).

 - Total cycles spent in smb3_calc_signature() while writing 10MB file
   decreased from 27551180 to 26628360 (10 calls & 10001392 bytes total)

 - Total cycles spent in smb3_calc_signature() while reading 10MB file
   decreased from 28390900 to 27879340 (14 calls & 10001781 bytes total)

Note that my "before" numbers were taken from current mainline which has
my changes that made the "cmac(aes)" crypto_shash a bit faster as well.
So the speedup vs v7.0 is actually even greater.

Eric Biggers (4):
  smb: client: Use AES-CMAC library for SMB3 signature calculation
  smb: client: Remove obsolete cmac(aes) allocation
  smb: client: Make generate_key() return void
  smb: client: Drop 'allocate_crypto' arg from smb*_calc_signature()

 fs/smb/client/Kconfig         |   2 +-
 fs/smb/client/cifs_unicode.c  |   1 +
 fs/smb/client/cifsencrypt.c   |  62 ++++++-------------
 fs/smb/client/cifsfs.c        |   1 -
 fs/smb/client/cifsglob.h      |   7 +--
 fs/smb/client/cifsproto.h     |   3 -
 fs/smb/client/misc.c          |  57 -----------------
 fs/smb/client/sess.c          |  11 ----
 fs/smb/client/smb2proto.h     |   1 -
 fs/smb/client/smb2transport.c | 113 +++++++++-------------------------
 10 files changed, 53 insertions(+), 205 deletions(-)


base-commit: 8541d8f725c673db3bd741947f27974358b2e163
-- 
2.53.0


