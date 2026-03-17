Return-Path: <linux-crypto+bounces-22040-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLLNGeJiuWlsCwIAu9opvQ
	(envelope-from <linux-crypto+bounces-22040-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 15:19:14 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A25462ABA95
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA82318700D
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A03ACA43;
	Tue, 17 Mar 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="S+32WFiW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EA346FD0
	for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756502; cv=none; b=mfSxA9EH0FVbebG6qKzQcS1oWq6KFJmXi6KyhqvecPENNlgfmpfkgBEbHQrkmeUXL701CbkaUXlnD5MQ6erBcbJIXEzt/aqWetNpCJPXXSRYSZL3KW52BuonFY3CnvjTHkC6jk/IdNKPyTlgAOxwMKAzE7Tpqre1UC/gtMepuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756502; c=relaxed/simple;
	bh=IPDlJqLvpsXv3EasK6bhn2TOL92nzbN0lg1b5fh6744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjpWGXj96TgQEU2Tibs4KyeCGNh5WIVHy4RpPB0C0QdP5MC6TUKTRsn2fyC3oh62ec6Xw+DpFTHxDKmUw56D2loa99EMw/G21cWqZU5cdcTnJCz9YSHsAolv8NVK0aWD2y6bGQ6z9SbqKz4PLUAmFV9WlSzMtMIM7HRVJIvUTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=S+32WFiW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-106.bstnma.fios.verizon.net [173.48.82.106])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62HE7lf1019762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1773756471; bh=h3kdXNckozj83znWGEpKIeRclysDZPjs3MuyF64Babc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=S+32WFiWjdnaQ5sU0ugPXfHS/NQdL38ccDYyRJEGKg063fulOP5szMY/cUxo79pvd
	 KbpxB0M/AnYaTPDBpe3BlCljyMNevDSoscU8eaapYnUhaeNBr2fuJTGBTtF0ByvPmF
	 qOBoSNx5TD8cFdJKiq7wOTQXiOSjKh+mkLJvyeETB+H6JTaDmgFXr/7t5h7Tm/Ak6y
	 3IvEs9DaWnzVrKOLc/4ZN1KQIOeJsDZPzaMjwX9nGt65xXYw/3GEUBX8Z0L0Gd8638
	 9iMkHOu0zDr/fW9qiQad0x+d9xamx6bwcGydFX64zq64EknMP5edzXxhKLT8Xs//+N
	 5KPxp4vgihSUA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 955075DF96C6; Tue, 17 Mar 2026 10:06:46 -0400 (EDT)
Date: Tue, 17 Mar 2026 10:06:46 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Nathaniel Roach <nroach44@nroach44.id.au>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: Does the SPARC optimized crypto and CRC code actually work?
Message-ID: <20260317140646.GC53921@macsyma-wired.lan>
References: <20260316204211.GA2661@quark>
 <ca9ba2ec-849c-4f86-8ac9-274ac4b5f885@nroach44.id.au>
 <20260317034539.GA2705965@google.com>
 <76ed4ac4c86341c5c9168aeee8cd53566e018001.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ed4ac4c86341c5c9168aeee8cd53566e018001.camel@physik.fu-berlin.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	TAGGED_FROM(0.00)[bounces-22040-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A25462ABA95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

How hard would it be to add support for the Sparc crypto accleration
opcodes to QEMU?  Is that something that could be, say, an GSOC or
Outreachy project?

Just a thought,

						- Ted

