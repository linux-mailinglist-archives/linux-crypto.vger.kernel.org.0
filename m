Return-Path: <linux-crypto+bounces-21366-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ+aFltFpWkl7gUAu9opvQ
	(envelope-from <linux-crypto+bounces-21366-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 09:07:55 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE441D4685
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 09:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA0473055EE5
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908D3A9D93;
	Mon,  2 Mar 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pciav5Rm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF13A1D01;
	Mon,  2 Mar 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438489; cv=none; b=mvj/rrFcMx4OJhwVUK8sDqmxNjaMHHb3jem5GNUzSDSzajj2HjH87b10TwuMN+AKQ1R9uR3u2F5TheME+Ttpq5vpp+GL3NyDBUXxSN1+ken6fXOweK2S3ODCPM2Z/s8QO1PKbLbpvC4nyDCzOt8FqhmQuq/Oj34lqfksJ+9Za9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438489; c=relaxed/simple;
	bh=Lp2OjfkVFaBG9FhdDQb2hnxI9JJpj41THxQ0Ey2WbFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4tEKijQWesGkd3xJJktHtSDtLjeMjxN9xjenEaFwDuKUQqLA86825wl6UiUfpi6ca+xWRIaJ6BA3sWfG0yEAC6ZmyxD4LIf+HDqCENZxrSUmtrwohndRgwiSfD2TNwvHzvvtrGM9Z6AxLskkApFovQphyUf0a/9xvWlccgwUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pciav5Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA5C2BCC4;
	Mon,  2 Mar 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438489;
	bh=Lp2OjfkVFaBG9FhdDQb2hnxI9JJpj41THxQ0Ey2WbFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pciav5Rmd8mXtmCpTVRHLS8dUSXgg85gvcGRF6qf+UWPuE5Xp+KtEkB8fnJhkC6lV
	 cdkUGFcIbB/drmszw4ZNefsIzfnkqTHbnlpz1xjQvnp5sGtUzqgP9qwIE/z12CfUZF
	 VlSmSlXY6FUshYqS9I4TA4x8sQUCCib4ep5DJCxg9gVPfbSSBi8t0qWd8Iyb7+3Tq6
	 eLbImORfeF37+S6mDTJZY8PKcmShD/JHGRbLo2hJqf7AkDz4PcR8Gx1ZFVRQVXcu3F
	 DHCj5JE38V3cSFQvxm1ZpVRGahJbvhV+Dn3f5bMVHtD3tDw2n7o1kUHfM24qH9aHqx
	 WCDt2pSfrHiMA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 20/21] nvme-auth: common: remove selections of no-longer used crypto modules
Date: Sun,  1 Mar 2026 23:59:58 -0800
Message-ID: <20260302075959.338638-21-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21366-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDE441D4685
X-Rspamd-Action: no action

Now that nvme-auth uses the crypto library instead of crypto_shash,
remove obsolete selections from the NVME_AUTH kconfig option.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 1ec507d1f9b5f..f1639db65fd38 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -5,16 +5,12 @@ config NVME_KEYRING
        select KEYS
 
 config NVME_AUTH
 	tristate
 	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA256
-	select CRYPTO_SHA512
 	select CRYPTO_DH
 	select CRYPTO_DH_RFC7919_GROUPS
-	select CRYPTO_HKDF
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
 
 config NVME_AUTH_KUNIT_TEST
 	tristate "KUnit tests for NVMe authentication" if !KUNIT_ALL_TESTS
-- 
2.53.0


