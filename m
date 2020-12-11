Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1F2D8244
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgLKWlX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 17:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732249AbgLKWkw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 17:40:52 -0500
Date:   Fri, 11 Dec 2020 14:40:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726411;
        bh=DAxzeqfioxjcacZ40rUzeDuWoUPixFe9dhg7upn4o6g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwNQTRNJx5aZUzbW8g9cp4818f5rAIY3ouY0cdVO2lnU2CGqb2d2RhVKUYsYq3yoo
         MpvJGwxEkyHmT5Ik5Jn3PWu2rOEb3J3adBP06hTTyH+OOLmZsWPuAgx9vsMvyjTU0l
         G1YME5GgSKYRhCV7mMicbF04PkBFv4biYzcoWJI8xCN415m9clNqNXO0LxsV7ejzYG
         JGqhRknx/aU4NQf1ypTtLMM1s33zP3qaG5DwK3m4I1zZrdN6+K8XpkqAlXl/CeDktQ
         iJnv/tq3Gj2ooGwjqT8diZVrUlkGOSrMLn/TSIEogy2FmqkqK3c+pbkNuMwIk2ROvZ
         ydJp4l2lavsoA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>
Subject: Re: [PATCH v2 1/2] chcr_ktls: use AES library for single use cipher
Message-ID: <X9P1ShL9qtw/KMkK@sol.localdomain>
References: <20201211122715.15090-1-ardb@kernel.org>
 <20201211122715.15090-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211122715.15090-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 11, 2020 at 01:27:14PM +0100, Ard Biesheuvel wrote:
> Allocating a cipher via the crypto API only to free it again after using
> it to encrypt a single block is unnecessary in cases where the algorithm
> is known at compile time. So replace this pattern with a call to the AES
> library.
> 
> Cc: Ayush Sawal <ayush.sawal@chelsio.com>
> Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
> Cc: Rohit Maheshwari <rohitm@chelsio.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>
