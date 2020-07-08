Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96221867C
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2020 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGHL4Z (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Jul 2020 07:56:25 -0400
Received: from sitav-80046.hsr.ch ([152.96.80.46]:60122 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgGHL4Z (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Jul 2020 07:56:25 -0400
Received: from obook (unknown [185.12.128.224])
        by mail.strongswan.org (Postfix) with ESMTPSA id 4FC2F40463;
        Wed,  8 Jul 2020 13:56:23 +0200 (CEST)
Message-ID: <0f96bc45b0394ffa80ff215f4db8092c577a1d91.camel@strongswan.org>
Subject: Re: [PATCH] crypto: x86/chacha-sse3 - use unaligned loads for state
 array
From:   Martin Willi <martin@strongswan.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Wed, 08 Jul 2020 13:56:23 +0200
In-Reply-To: <20200708091118.1389-1-ardb@kernel.org>
References: <20200708091118.1389-1-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


> Due to the fact that the x86 port does not support allocating objects
> on the stack with an alignment that exceeds 8 bytes, we have a rather
> ugly hack in the x86 code for ChaCha to ensure that the state array
> is aligned to 16 bytes, allowing the SSE3 implementation of the
> algorithm to use aligned loads.
> 
> Given that the performance benefit of using of aligned loads appears
> to be limited (~0.25% for 1k blocks using tcrypt on a Corei7-8650U),
> and the fact that this hack has leaked into generic ChaCha code,
> let's just remove it.

Reviewed-by: Martin Willi <martin@strongswan.org>

Thanks,
Martin

