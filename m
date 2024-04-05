Return-Path: <linux-crypto+bounces-3356-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46B18996EE
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Apr 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642EF282DC2
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Apr 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED913FD79;
	Fri,  5 Apr 2024 07:49:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9813FD6C;
	Fri,  5 Apr 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303399; cv=none; b=f+yUITy/BNmTa0uCWqrrGbpjUa4YjV69DRKDFQcsgChSml6DLVE8xWVZqvRNF37xuDF3DaxtnKMYdmZRVkR9U39j4XyObiHv+p3PAtxfDS7oIh6uzzw10p2dOEXjCcC023ZXOl+EPyQ5Gle2pnSRFXNM81Ytf/B6b3buITXvqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303399; c=relaxed/simple;
	bh=6p5TH+A0z2QhIipX5BPFmQFnC42BmlS+fNNeFzzEFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r5VxEivN19P8pUlQkVZcegM2NLyKhP7uY947UMT0+LTLjT0letjkIf0AAskVq23ouvy6//xg64ymOvpji+t27JSNSuss8eVw0o2cj4yWwbbFu2ABCSy8ZTJMzuN4jEedk1s4Pk8ahA0FNd3lC9HKc/iW6QL8NaCm3Zwww9bKdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rseKX-00FU0N-Ki; Fri, 05 Apr 2024 15:49:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 15:50:02 +0800
Date: Fri, 5 Apr 2024 15:50:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: giovanni.cabiddu@intel.com, davem@davemloft.net, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: qat - Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Zg+tKna1el6xr6Dq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHiR7j2NYl5M4mW@neat>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Use the `__struct_group()` helper to separate the flexible array
> from the rest of the members in flexible `struct qat_alg_buf_list`,
> through tagged `struct qat_alg_buf_list_hdr`, and avoid embedding the
> flexible-array member in the middle of `struct qat_alg_fixed_buf_list`.
> 
> Also, use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> So, with these changes, fix the following warnings:
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> drivers/crypto/intel/qat/qat_common/qat_bl.c |  6 ++++--
> drivers/crypto/intel/qat/qat_common/qat_bl.h | 11 +++++++----
> 2 files changed, 11 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

