Return-Path: <linux-crypto+bounces-23022-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJC4Jxaf32kEWwAAu9opvQ
	(envelope-from <linux-crypto+bounces-23022-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 16:22:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B340538B
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84C02300BB8E
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0C3D3491;
	Wed, 15 Apr 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JMnxKnun"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226D271456;
	Wed, 15 Apr 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262930; cv=none; b=uVjA1/+41HYSgz/OVlVIwENfZC5K5xZCUXouJJGTti/0r3OLcVnvJc2O8aOIgpZTX2CHzMeyQK/75Buh8pYDUUs/cwgaIhb24YCNe92N1Lw1BxB4Pb/KgP6Tekuzmnst5C2kOf+pdpLmkp5zSj3BXSF+63lY8ml34P4W4DSbzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262930; c=relaxed/simple;
	bh=UJuuESz1HI93uGPmtqfkdn4doXvRoGkvMDou1Zc+ezg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Vgmu//4nyUetOidU5lA/Xcjn0Q06rbqiUluoA2ikvYmzuIP7tDhzAgUDLM/+X4R6QXfEyg4iclI/2Rx+wiBMpcnsfvxnBFys74keXWajOcZ5OIXS3c7S1AV8w2Vg3qsgwyjJ8UFeCWMueMFfU/uJGHk/Frz88wzI4oT/h5WM/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=JMnxKnun; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1776262919; x=1776522119;
	bh=2XvRJ3CZCKOhB+TRCzJBYLjCjHc2nMx7NAxdDM9jjIo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JMnxKnunezJavfI1ilbbtlTsgx6vDVpEHpL1Oe1ECk7n8iSMkXxMPV8VsUP4+tYhH
	 Z9588XGrJPUFpAEAZmr5YyLhajBA21AHNNzvpotiURjntfaoLRalyuy/AHLQbuunho
	 D3e5iDyUQ1JV5eNFZO8fhIH0woFFCP53+niCmJCBDFhNmPbOCA1Mv0SQdVN1QJkFTa
	 RuYKvF4Pz/iW8znZfGjVbWHgKZ8FRDQG/wKuKhP+HLqg4K7dYuQOdup3dgW/r/ZwAD
	 Snyvv9B4bDTKBPpNMoWsvOdNB6DTZdJ/TI9nHijQJ2ySx6VKHVf5h+Kf2rDCoE+tuD
	 a3Cc6cODlb01Q==
Date: Wed, 15 Apr 2026 14:21:52 +0000
To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Announce loop-AES-v3.8i file/swap crypto package
Message-ID: <Ba4LL221pRJxzM43znuugKG1DEzUGcvQOp7H88lZfTmAJ6TJzL1YboVtfJ8p7wkVz-K9VAaN08vSDMpL79p4u45hk3N0lPYuD2Dc8LptKBc=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 354543d799285ce687ac91fd2168e6ac968882ce
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23022-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jariruusu@protonmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	FREEMAIL_FROM(0.00)[protonmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348B340538B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

loop-AES changes since previous release:
- CVE-2026-27456 fix for libmount enabled util-linux versions.
- Fixed external-module-version build for 7.0 kernels.
- Some #ifdef spaghetti removed for 7.x kernels.
=20
bzip2 compressed tarball is here:
=20
    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8i.tar.bz2
    md5sum 369270c0952819b59f3cf2e75540afb8
=20
    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8i.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


