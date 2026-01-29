Return-Path: <linux-crypto+bounces-20467-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N1lHLyKe2mlFQIAu9opvQ
	(envelope-from <linux-crypto+bounces-20467-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 17:28:44 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D525AB22C5
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 17:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C432B30094C4
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239833E35F;
	Thu, 29 Jan 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q8oNaXQy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FA33B6F8
	for <linux-crypto@vger.kernel.org>; Thu, 29 Jan 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704121; cv=none; b=ccdoQ5r1ybDplqJv0K8cJ8ljxriSS6xwnrB62dm6Le3fr16QNPeN2JAvVE2tnVbcMOodDU03hW53Bxkl+NqAI+1smBoi4PXyH5XlXf0nh+yt2wfu0ho9pSa82ONagDruAr8REtgsOREbA/kSHAVgahASyj1Ly3Gfe03LEI2T7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704121; c=relaxed/simple;
	bh=bg0nB5zJz+oUF/2yWzv6OLnyjcs2iI23Y2/WofTkQOY=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=JpnholJkGQnBr9l20n6NyII2f2DIpXav44QabatHnaHI35OuBWhCGwmVQ3XTGfHTQ3BFrHBWh7Lx6U4aGHXoZRvb7BzrdLLHjMTf6X7sWATLbPeftAIxfWbpIYaaTWKjekUgE4rAnqpwQMh9FnJy16qoKDFtP7f799/zoLQ2edc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q8oNaXQy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769704120; x=1801240120;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=bg0nB5zJz+oUF/2yWzv6OLnyjcs2iI23Y2/WofTkQOY=;
  b=Q8oNaXQySIWjcVsRJTg6QO8qXNqtixE9c503p6Qwwnrv1GNBKu6SOJCN
   MCwmEWQeAqW5C+NueqZZ4+TPMXoDpGmkFUlrTitI0gKS4ixACFUY8BqHX
   e4xM6qt0afSNlRNdZPGRVMZd/FP7ZkTes36FE9zwAOOqR0uxhQAb4pAJp
   IPpdj2vlt6SSWFVvNd5bKkj6ERWCulzGQxd1wT5rrXN9MrpdtNUtilh96
   ds2Dj38yGhdzLPQ2IhLu2elHILUQUNomhK8phiOOSQH42LkUg/krn3jWO
   s9ddp5qDB0REW+mTFK12nxN5TXRclJU0ViJoSDabqPDl293dyQPUVuOaV
   Q==;
X-CSE-ConnectionGUID: Z2z9pO38R9W5gSIwLcScPQ==
X-CSE-MsgGUID: ATf9vy1jTGictqaD8lpZ4w==
X-IronPort-AV: E=Sophos;i="6.21,261,1763449200"; 
   d="scan'208";a="51905918"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 09:28:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 29 Jan 2026 09:28:18 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 29 Jan 2026 09:28:17 -0700
Message-ID: <25e13e64-f39c-44b4-9877-1e3b6caed458@microchip.com>
Date: Thu, 29 Jan 2026 09:28:51 -0700
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
To: <linux-crypto@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>
Subject: AFALG with TLS on Openssl questions
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-crypto=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.wanner@microchip.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: D525AB22C5
X-Rspamd-Action: no action

Hello,

I am working on kernel v6.12 and trying to use
authenc(hmac(sha256),cbc(aes)) for a TLS connection. The driver I am
using atmel-aes.c and atmel-sha.c both do support this and I did pass
the kernel self tests for these drivers.

It seems that afalg does not call the authenc part of this driver, but
seems to call aes separately even though authenc is detected registered
and tested. Can I get confirmation if this is supported in afalg? From
what I understand afalg does not support hashes but cryptodev does. I
see cryptodev call both sha and aes while afalg just calls aes.

I do have CRYPTO_DEV_ATMEL_AUTHENC=y CRYPTO_USER_API_HASH=y
CRYPTO_USER_API_SKCIPHER=y CRYPTO_USER=y this is a SAMA7G54, ARM CORTEX-A7.

I also would like to know if authenc(hmac(sha512),gcm(aes)) is
supported? I would like to add that to the driver as well but due to the
issues I highlighted above and no selftest suite for authenc gcm I do
not know a good way to verify the driver integrates with the crypto system.

Thank you,

Ryan

