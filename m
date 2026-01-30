Return-Path: <linux-crypto+bounces-20480-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG2oM2+hfGlxOAIAu9opvQ
	(envelope-from <linux-crypto+bounces-20480-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 13:17:51 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254FBA6A0
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521203013683
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A4A36F407;
	Fri, 30 Jan 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUDcOTRv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520722E764D
	for <linux-crypto@vger.kernel.org>; Fri, 30 Jan 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775464; cv=none; b=CmOCmmrU/RrssUh/0KoBZz7v2bA5EAXDYOdRoGDLGe0zS8zBIE34HfBCtF1JKrWD2gj9E2iwQQ2GTMJwb+F5VJxeoHSVo72qP7x56UYNwtSHXXII/SUs8pYia9g8Z/oRAmZX99NdpNKEQSkgJOQIGQVkEqE2bc63kjsHIzrAgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775464; c=relaxed/simple;
	bh=pQYiXMP6QX8T/5xnW276lNpDzkeZ8aQu2QGXGKO1IKc=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Th0NdWJCB/mz3jmFjd644ZC1C5oBLmqEN+Jak4fZN9f7rbioG0JtxAOgDNO2n3grEHBMM5GfDSGd2Y2b5H2k2CQwKsJqL81fzW72tRg94kP4HNpuM5r20pSB8TTZNlyctRnIsmrD6oHMKC7GCVqDECfbnR17LhJyKZAbwDk+pXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUDcOTRv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769775462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=99yUStWJqFWqwChJ5d1IzxZNNe+wRHK4BzUn4qr9ia4=;
	b=jUDcOTRv4xHxv42XG6hBezq9YX6OJNylh/IgvvWEXqJM7eSZolm+2xmhtYL76iFyNy5ODC
	Rhv4iz887X5MI5lwpKf+JTbtGSz7KywMBrbmNgK99T1dykWrLDH4z2fuLoAW8NaZPoliDb
	w20XR5yKxxqvWSGDfMi90Fkz24LAIqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-BH22Tj7gOwGE_5fDIQPDvg-1; Fri,
 30 Jan 2026 07:17:37 -0500
X-MC-Unique: BH22Tj7gOwGE_5fDIQPDvg-1
X-Mimecast-MFC-AGG-ID: BH22Tj7gOwGE_5fDIQPDvg_1769775455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0628A1954B0B;
	Fri, 30 Jan 2026 12:17:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D09419560A7;
	Fri, 30 Jan 2026 12:17:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
    Mark Brown <broonie@kernel.org>
Cc: dhowells@redhat.com, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Pick up keys-next branch for linux-next?
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2261417.1769775448.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 12:17:28 +0000
Message-ID: <2261418.1769775448@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-20480-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7254FBA6A0
X-Rspamd-Action: no action

Hi Stephen, Mark,

Can you pick up my keys-next branch for linux-next please?  It can be foun=
d at:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/
	keys-next

Note that it's based on part of Eric Bigger's libcrypto/libcrypto-next bra=
nch
which I believe you already have in order to get ML-DSA support.

Thanks,
David


