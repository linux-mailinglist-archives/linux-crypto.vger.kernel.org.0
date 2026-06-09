Return-Path: <linux-crypto+bounces-24987-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GIfCNlTFJ2p41wIAu9opvQ
	(envelope-from <linux-crypto+bounces-24987-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 09:48:36 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149365D5D6
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 09:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P7BqX9qL;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24987-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24987-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E57F30398A2
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Jun 2026 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709634752A;
	Tue,  9 Jun 2026 07:45:57 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A438F620
	for <linux-crypto@vger.kernel.org>; Tue,  9 Jun 2026 07:45:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991157; cv=pass; b=Ovd3AKcrGwbO/hC4Au2SefnWKRKEdUCL6NntaFOFu4lXlJl5/LKh+ZhJUnMyPw0YILW7j7kXtvU3kYtqYtCfcSZIIVS9a3a0EZS85kYbdBP8xaV4rSLGA+TY8u+z588pq8mgMf1WBcwMV8L0lUU2UDCGmUcZImDrnGPYyKcfEkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991157; c=relaxed/simple;
	bh=T6YFbkP3twu5xtyti5g54Y5Ktg7J2jPBjU2ubQSjAEc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oizegqy6IMiMCKCnNUyDjLZnM3hPkKZb7aI5sHr1PrpurvHT8whVGrnUY+Pb+/0GkhOqDcxfhOkYqH4r6LRkxQIdsAPuggsrC7Bv+LPlMaQ21L7j/hcNHCxojCz/3Gd2OKXE3tE+i/PYD9JKj3AwOmhuL4SA0du/7YpV50ssf7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7BqX9qL; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51790c0a692so52934141cf.2
        for <linux-crypto@vger.kernel.org>; Tue, 09 Jun 2026 00:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780991153; cv=none;
        d=google.com; s=arc-20240605;
        b=gE8tc6Qy8UBg2m2kWzqzNF0YO0Ywqa3/01WFBLbzwbcZW9fDrnw5pKhLoBMekEhbLs
         q/Rv3kMttS9+R7eCVcbWVpdhM0dBpqre2eg0C5AYwNCvjTg/bXVmlU3NoHRVHECHUAS2
         4cB+Hhug0qEa9auG5yXMHa3VjpU/JUkCr2xIekrzgboM7V58+JsBve6to+HNRLCNY7VA
         9yXUAlShXqXfEiRBAOaKvRcf1I9rz+jo5WVwykCOk2ASUR8wB9QityMwKlhXzzTO4vaE
         FNbkQZ3wERQ69CzQK/UErkv7SIGtooAqFG0/LMNkTs4WCiZOWqfjsckZE2G+Urtklyuf
         pDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=urpL+fiHLvhD0YlxHm6lv0pz7GciQhJgWs2mBbx+7kI=;
        fh=ItmFxu5FhRur1Ece1KnkfBKb+RBW9F7oMUIZo1M3uvs=;
        b=jzJiuoDnC8cpdB62mfJhTB5itJb2R+OiDlsro6Fvdg4LiKW/2g5SnELlOu/CB0Yltz
         sq1+eUr8plRddJHhxLNAIeLvda9Uz3K85VAFBQ5KxTHCJIttuYFik7tZneULpM1EnTx3
         TMRmZV/6OMp5//HCbJEmPJBdxlx05Kd9RScxYXdbauv63pmMe+GAhULXT9ZipdN1T3+J
         yfnI4KUENkwBngLnAduaVP5Pbj6FAMjwlHGnASNQlnZzA1o5c/aB5Xs+A5kaeydcBKD8
         MIvNJ2gs/xVRHLI46kWyWvn2weCtu1CL9PSm1CbwuCypvpCVFMZD4BwmdRs4R/z6O/yj
         ZRzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780991153; x=1781595953; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urpL+fiHLvhD0YlxHm6lv0pz7GciQhJgWs2mBbx+7kI=;
        b=P7BqX9qLewwWPyMPWKr1y7YAQ6M9Q2GM7+2psB5bEelGC615lwi3A824F/6saEpjAe
         gztqjLftu/j/PT3Uu9sIX9s8gTi8BTGMxbhMRBrsROuURMVnNgVXEZK8YtLDMJbkJSr0
         9Lw+6N5AN4F2ByEH4KjehEYP/brXu9taLkppl5hoh6+ZoTR2S5R8nSACohTenBDgNFmA
         Gy8EzVVELeus+evwZTaVUL/Bdt0UafwE5Gd9hMVYZYzEYsxTEnUGBvKDNj2qBw1SnCpA
         YBYH8sK/RGg2LWY0fyoTYXqir3XfBd2TJ2fIbPVScvCMLMbU7SdZqap8GhoaYrXKvRxj
         bM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991153; x=1781595953;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urpL+fiHLvhD0YlxHm6lv0pz7GciQhJgWs2mBbx+7kI=;
        b=QGoJZP9ylWZ0jyyPKnEpoGiYfNfTTjZB7w/fzbu6Hm9BY5SEHU9JDXaZ77U7CvMGGV
         asDOOgcP0sIeDuY2fu7M2NBUQ8ISX1XNByA356zWqc6p/yalswFvmiJz5Rz41n5OaXmV
         QN/KLsNR7nFu6ILBkqvQs3i51qmI5uIpVnxNzBeKMDU81D6LyKueGebUOC574WscMP/U
         KAPvP3ki18Ni1gPZc1AzYJDZFcAyIuQeg4oi0KyUnCpnG9mmtpjw3cyGoeu6qmHUKakV
         a0A8Bz9TjXn6meIupfWKzvVgSbGMdFqnwv8hLxeEsd/zAR6i6dUzv7wi51TIUoR5p0Vx
         kM4A==
X-Gm-Message-State: AOJu0YyJM7tyd7qwMMr0Bd96vrn7CFpjc9V4CLq+YYPnl0N53BByJqsB
	loLWXoFy4Irrrm7H8mLdvdDgG/Hdw6OEcRFuEdG2qxw7gJRCaNnfNLa3r+2X7gBiPgeeShbtBvL
	eoHAT8vRJWO2xWlOIo6ff8jaZ7WI4bL5bBw==
X-Gm-Gg: Acq92OGr9rgv7MhQgd9Kf3QDvpH+VYbDVBpy8ZRPuoQXFcJOrBbTfj2i2xIOOv69L+J
	jV5gLjYX7a0h0V8Ep7QC9QkHVQZtO2zDofU9WJ7kt1zko2QomqldpwbNJjJrCgLxqMjHcQ18358
	+1yWsXqEXXb8cQnt61zTZhjS65crsdC5icyOvEYJqk78tWGoUnjnRxA9yiTJXh1dlxQRLlNxKNV
	hFWzbyLJTfqK0TSO0al+NKYhr3uMrddzQlaM/iC3yZwrRFvS/BJdwk1vyXBbOWWm3cjmp9vFPTU
	RDoj07Pkkl8a/xHG
X-Received: by 2002:a05:622a:1811:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-517959d5f02mr282746081cf.2.1780991152780; Tue, 09 Jun 2026
 00:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kstzavertaylo <kstzavertaylo@gmail.com>
Date: Tue, 9 Jun 2026 10:45:48 +0300
X-Gm-Features: AVVi8Cfwajj5XEJ7pIKcZhG--5hU3DBI63DrBFTukdyyHyHo35CDqHtWBmUjef4
Message-ID: <CAMho2RfgwvNhWJidb_Xn3RRt71TFjQ2QBKP9Xt8ur22L-ZWP9A@mail.gmail.com>
Subject: [RFC] ML-KEM (FIPS 203) implementation with reusable decapsulation pool
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, 
	ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24987-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kstzavertaylo@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kstzavertaylo@gmail.com,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5149365D5D6

Hello,
I have been working on an ML-KEM (FIPS 203) implementation for the
Linux kernel. This is an early RFC to solicit feedback on the overall
design and architecture before further polishing.

The implementation consists of two closely related variants sharing
the same core cryptographic logic:
    1. A userspace implementation accompanied by a set of validation
programs, including NIST KAT vectors, timing-leakage testing (dudect),
pool stress tests, and additional functional tests.
    2. A Linux kernel module implementing the KPP interface and
reusing the same core architecture where possible.

Key features include:
   1. Support for all three parameter sets: ML-KEM-512, ML-KEM-768,
and ML-KEM-1024.
   2. The implementation uses a reusable decapsulation pool consisting
of preallocated slots associated with a key context. The goal of this
design is to move memory allocation to key initialization and avoid
per-decapsulation allocations.
   3. Explicit zeroization of sensitive data and constant-time
operations where required.
   4. Portable C11 codebase with minimal differences between userspace
and kernel versions.

I am aware that some aspects (local SHA3/SHAKE implementation, coding
style, etc.) will likely need adjustment to align with upstream
expectations.

At this stage, I would like to ask for feedback on the following points:
   1. Is the general direction (KPP integration + reusable
decapsulation pool) acceptable?
   2. Are there any fundamental concerns with the pool-based architecture?
   3. Would you prefer to reuse kernel crypto primitives for
SHA3/SHAKE, or is the current embedded approach acceptable at this
stage?

The implementation is available at: repository - https://github.com/kstzv/ml-kem

Documentation and implementation details are available in the repository.

Any feedback, criticism or suggestions would be greatly appreciated.

Thank you for your time.
Best regards,
K. Zavertailo

