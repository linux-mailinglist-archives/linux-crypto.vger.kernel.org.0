Return-Path: <linux-crypto+bounces-3228-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8F8937BB
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Apr 2024 05:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21ED1F216F9
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Apr 2024 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AFC523A;
	Mon,  1 Apr 2024 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lq6Z0jMS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1D46B5
	for <linux-crypto@vger.kernel.org>; Mon,  1 Apr 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941734; cv=none; b=quyU72MYSVaZ09zxIzu9Hjqrseoli8GY83KXs28hBnGspnGCCsNVXa2DUVIgpsCCcUABAk2ByEuq/9pbe4JmWFYKS8y6EnU4Ftq5mEyZkwQUNbmuldhIgUmouop7nJynaTNuJGOTKapNKGGUNeMHKX2b8BiRkn5d4dkz8Yool1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941734; c=relaxed/simple;
	bh=bFZG8fdwOXmY5gp/Ygvlq6Ww6X3u42PHaZcD+BB2dRk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G5RiaaAL/9jY35762iCDxnxx/AdnkW4n4bwtTJWz8zigdp5OCKSeiICvgaQYwAIJKrdnyl0Tc0mNVZgT/NrKxR/vOz7fsXKhCgf9cmLIuUH7MWHmBHw8zUoTroAOCLH5Ipi26vEiVyfsyb/9E57ccH6utyMz/LtmHIDqrO3E5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lq6Z0jMS; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711941730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFZG8fdwOXmY5gp/Ygvlq6Ww6X3u42PHaZcD+BB2dRk=;
	b=Lq6Z0jMSLgfpkaXPiKGWrriY+Gir/Xdh6UbGT4GOVc3DljvxjojyAz/WMXSFeg72CkUJox
	Ryhzo98vQSuKrUnjbCYI1z1BXBJSyb0ixueDHg/Sbn+FM9pMnRQJEeyycz/xoIV6NoULX4
	xon7jCh0byFYcLVQ0RihpPUJD9jS87E=
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/7] memory: Remove the now superfluous sentinel element
 from ctl_table array
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240328-jag-sysctl_remset_misc-v1-1-47c1463b3af2@samsung.com>
Date: Mon, 1 Apr 2024 11:21:25 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Atish Patra <atishp@atishpatra.org>,
 Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Luis Chamberlain <mcgrof@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 io-uring@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E19B519-9035-42E0-92DC-7C21471543D8@linux.dev>
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
 <20240328-jag-sysctl_remset_misc-v1-1-47c1463b3af2@samsung.com>
To: j.granados@samsung.com
X-Migadu-Flow: FLOW_OUT



> On Mar 28, 2024, at 23:57, Joel Granados via B4 Relay =
<devnull+j.granados.samsung.com@kernel.org> wrote:
>=20
> From: Joel Granados <j.granados@samsung.com>
>=20
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which =
will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> =
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>=20
> Remove sentinel from all files under mm/ that register a sysctl table.
>=20
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

THanks.


