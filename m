Return-Path: <linux-crypto+bounces-21174-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ/yNVxnn2lRagQAu9opvQ
	(envelope-from <linux-crypto+bounces-21174-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 22:19:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2819DC3F
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53D4230216FE
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Feb 2026 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B42FD1B6;
	Wed, 25 Feb 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Q7K63SlU"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC1239099
	for <linux-crypto@vger.kernel.org>; Wed, 25 Feb 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054359; cv=none; b=SiASsyIankJm/wSzSdAlD1mmtOxLRcHKm8N9FsQoridnoZS8thShcsVJK0dfch1ccRj4miB2Qz7QGihwUw3JnvQfySaVUMJC1OxVjMvJ6USJCUIoRGEgghqQiB3RHzVR5K3UBzaVGYfkt4bhbTDAW8dYid2H4OceJRu30PhWvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054359; c=relaxed/simple;
	bh=1HA4ywL7XBrJAafSssnyb4SgIYcFrRjOv1N7k4X7vd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s96tjsdT+Asmyhe14d7mrDuGfNI0Wb+a57i0m3Ck/47DTBbRLqOWjyby4yatdnphb3llbS1uvUL5tBvFUphZ/36ERHIDpyEBSVj0/QCY0xMbpa1c4L9HfG6LkSxzLYFm8Sb8zLslTLxVahM/lat+UQzaq7Kv44UbOfO26/oW01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Q7K63SlU; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1772054356;
	bh=1HA4ywL7XBrJAafSssnyb4SgIYcFrRjOv1N7k4X7vd8=;
	h=From:To:Subject:Date:Message-ID:From;
	b=Q7K63SlUTKYUzpHRIJ5MxvR/k+74HPnIsJ0paIkV7D9d0q2VmpwwVZd1odQSkMWHW
	 yxFtcs32anGmYGqW5mITOgrRMUg9FXA73M8hT3IL+RPGZkhgERMUaVh9v8MjBuWh71
	 X6p62ZtSX2xVx06IiU12BMvIdztF8TIcjszhuoB4=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 161861C02CA;
	Wed, 25 Feb 2026 16:19:16 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: [PATCH v3 0/5] pkcs7: better handling of signed attributes
Date: Wed, 25 Feb 2026 16:19:02 -0500
Message-ID: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hansenpartnership.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hansenpartnership.com:s=20151216];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21174-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hansenpartnership.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[James.Bottomley@HansenPartnership.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09D2819DC3F
X-Rspamd-Action: no action

v3 updates for the now-upstream ml-dsa.  The ml-dsa patches actually
changed the definition of authattrs in struct pkcs7_signed_info, which
means I now don't have to justify stepping one back in patch 4
(thanks!).  Just in case I checked that nothing else was affected by
this change.

Original cover letter:

Although the biggest use of signed attributes is PKCS#7 and X509
specific data, they can be added to a signature to support arbitrary
and verifiable objects.  This makes them particularly useful when you
want to take an existing signature scheme and extend it with
additional (but always verified) data in such a way that it still
looks valid to both the old and new schemes.

To use a scheme like this to extend signatures requires that the
authenticated attribute only be pulled out of a signer info that can
be verified by one of the trusted keys, so the implementation loops
over all signer infos, discarding those that haven't been verified and
returns the first OID match it finds in the verified ones.  Note that
if you reparse a pkcs7 it starts out with no trusted signer infos, and
you must anchor trust by calling validate_pkcs7_trust() with the
trusted keyring.

The first three patches in this series are new to v2.  They add the
new validate_pkcs7_trust() call, thread a verified flag through struct
pkcs7_signer_info so we can tell which signers have been validated
against the trusted keyring. And finally thread pkcs7_digest through
the pkcs7_validate functions so they can operate on a plain parsed
pkcs7 structure that hasn't gone through pkcs7_verify.  Note we could
simply drop the last patch and insist that the pkcs7 be re-verified;
it just looked a bit inefficient, especially as the default way of
doing this (verify_pkcs7_signature() frees the pkcs7 structure before
returning.

The final two patches search for the authenticated attribute by OID,
stopping at the first one it finds belonging to a verified signer
info.  The final patch demonstrates how to use it.  I've added a check
to show that if you don't in any way validate the pkcs7 then no signed
attributes get returned.

Regards,

James

---

James Bottomley (5):
  certs: break out pkcs7 check into its own function
  crypto: pkcs7: add flag for validated trust on a signed info block
  crypto: pkcs7: allow pkcs7_digest() to be called from pkcs7_trust
  crypto: pkcs7: add ability to extract signed attributes by OID
  crypto: pkcs7: add tests for pkcs7_get_authattr

 certs/system_keyring.c                  | 76 +++++++++++++----------
 crypto/asymmetric_keys/Makefile         |  4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1    | 18 ++++++
 crypto/asymmetric_keys/pkcs7_key_type.c | 42 ++++++++++++-
 crypto/asymmetric_keys/pkcs7_parser.c   | 81 +++++++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.h   |  4 ++
 crypto/asymmetric_keys/pkcs7_trust.c    |  9 +++
 crypto/asymmetric_keys/pkcs7_verify.c   | 13 ++--
 include/crypto/pkcs7.h                  |  4 ++
 include/linux/verification.h            |  2 +
 10 files changed, 216 insertions(+), 37 deletions(-)
 create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

-- 
2.51.0


