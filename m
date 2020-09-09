Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1C263822
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Sep 2020 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIIVAT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Sep 2020 17:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIIVAT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Sep 2020 17:00:19 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1242021D6C;
        Wed,  9 Sep 2020 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599685219;
        bh=F54bqorDuvelZki9nxOOlNdsM5DvMPojI/Jd5SSxJks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMb1BsJzG52BRZM9eeeYGF1iHGTjV31IFv2Jksk757l2elt+n5h1QvDlntH32ANje
         MOf+M5SoHhFUhLC2LLiw/g5JQ4tInmlfDjjtC6FJqctXGQIOExS56x5QFArWm+hDIF
         NWtK6uHXpbDCRCX/s90PinFXkisEkllW9ZjH9UEQ=
Date:   Wed, 9 Sep 2020 14:00:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Elena Petrova <lenaptr@google.com>
Cc:     linux-crypto@vger.kernel.org,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH v7] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200909210017.GA1080156@gmail.com>
References: <20200909043554.GA8311@sol.localdomain>
 <20200909182947.2879849-1-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909182947.2879849-1-lenaptr@google.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 09, 2020 at 07:29:47PM +0100, Elena Petrova wrote:
> Extend the user-space RNG interface:
>   1. Add entropy input via ALG_SET_DRBG_ENTROPY setsockopt option;
>   2. Add additional data input via sendmsg syscall.
> 
> This allows DRBG to be tested with test vectors, for example for the
> purpose of CAVP testing, which otherwise isn't possible.
> 
> To prevent erroneous use of entropy input, it is hidden under
> CRYPTO_USER_API_RNG_CAVP config option and requires CAP_SYS_ADMIN to
> succeed.
> 
> Signed-off-by: Elena Petrova <lenaptr@google.com>
> Acked-by: Stephan Müller <smueller@chronox.de>

Reviewed-by: Eric Biggers <ebiggers@google.com>
