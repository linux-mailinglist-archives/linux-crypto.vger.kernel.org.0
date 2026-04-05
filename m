Return-Path: <linux-crypto+bounces-22794-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /bB/MnNq0mmPXgcAu9opvQ
	(envelope-from <linux-crypto+bounces-22794-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Apr 2026 15:58:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7539E9A8
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Apr 2026 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F86C3006B4B
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Apr 2026 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446821A447;
	Sun,  5 Apr 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RsnIcc9d"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D415B971
	for <linux-crypto@vger.kernel.org>; Sun,  5 Apr 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775397487; cv=none; b=ZRXzkk3chy5pbQ7/9H7n5WMwmSA38oJvmGd9eRscZphMjBx+rNe1vpWTzZGVEOqbwVKJW2idBF/F+Q/QVNVvY6APxQatfvgXkx6CD1AJ2MKdoYNRJMvE7iABA3dmiiwZiT8sNvyCvctGxFk1YJxBeO3TaDz5Kpe+eZbtjx48tLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775397487; c=relaxed/simple;
	bh=oIoWcIY00KuQ4hBvB3K/oNpr8SuD/HLem1NS60+K2Os=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=nxhWM0BtVT6EL6gQk+Gbje3Nmc9J+gSjBboZkYYl6JM0JE1dzvVhqTJRvzxw0lpdBtdnvtqiKtmHAD3txJ1OUhwaHRyWZIPgHOf4Ck+OmYnHqY8+QZARY2csepNd8POwBqtNjoc0xJ9Mb1ar0syWMZ4Q41IuVI4vCRkrPPjHeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RsnIcc9d; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1775397469; x=1775656669;
	bh=3ysJ8+XmLONe9hREipfzbp1twL8tDmHUYsXRdbi2tgE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RsnIcc9dw9+HQbYw3XK5YPbAKw27WjaYFJUq4BPgnhFMy5EY6AOkv2cVIohjmR9AG
	 Vyj1aEXtqr+BU25xq46PGYUFqVkHcL8K3vQgyUr/7vwyGwbCwdQ31jOcrQjOuzhUWo
	 LOCYK7j04KNKfF+sHbQQP/ioBXm8nfQlIQb0E8M9a1GYuK41ybwHpklmfyKs82Hc7V
	 uWf4EpcsuG3p/XKYGcccOTf7UAbNsuuV3pAYSWcQ0QR5VflaYqADwCe8KQDwHnN8I/
	 l04BduH0cClaBfAAONmy02aLZskTnFeCOOhRxVh6SrtVotRtTO9iZXTDts4EUDeOrH
	 XulUQpE1M1WUQ==
Date: Sun, 05 Apr 2026 13:57:44 +0000
To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Subject: CVE-2026-27456 fix for loop-AES util-linux versions
Message-ID: <YnZ057FFu3uAo2lL-wB1m_ZvdW9I_4awEj_-X_X_gCsVt7kDQTyRKf_u_ak1i7bdMzTgtG7JYLxUZpLMFIMbTexueflIlpgqmUJ6S_25Cao=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 7f495b4615b497f873a2a035e14ce6542b7a231d
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22794-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jariruusu@protonmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBE7539E9A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CVE-2026-27456 fix for loop-AES util-linux versions need=20
small one-line patch applied. Below are versions that have  =20
that one-line fix applied.
 =20
  https://loop-aes.sourceforge.net/updates/util-linux-2.38.1.diff.bz2
  https://loop-aes.sourceforge.net/updates/util-linux-2.38.1.diff.bz2.sign
 =20
  https://loop-aes.sourceforge.net/updates/util-linux-2.41.4.diff.bz2
  https://loop-aes.sourceforge.net/updates/util-linux-2.41.4.diff.bz2.sign
=20
  https://loop-aes.sourceforge.net/updates/util-linux-2.42.diff.bz2
  https://loop-aes.sourceforge.net/updates/util-linux-2.42.diff.bz2.sign
=20
Below is that one-line patch. This patch can be applied to other
versions of loop-AES util-linux.       =20
=20
  https://loop-aes.sourceforge.net/updates/CVE-2026-27456-fix.diff
  https://loop-aes.sourceforge.net/updates/CVE-2026-27456-fix.diff.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


