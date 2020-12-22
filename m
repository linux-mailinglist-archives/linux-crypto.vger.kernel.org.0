Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF852DD5DF
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQRP7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 12:15:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:58236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgLQRP7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 12:15:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEE7AAC90;
        Thu, 17 Dec 2020 17:15:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD9E2DA83A; Thu, 17 Dec 2020 18:13:37 +0100 (CET)
Date:   Thu, 17 Dec 2020 18:13:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH 1/5] crypto: blake2b - rename constants for consistency
 with blake2s
Message-ID: <20201217171337.GS6430@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
References: <20201215234708.105527-1-ebiggers@kernel.org>
 <20201215234708.105527-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215234708.105527-2-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 15, 2020 at 03:47:04PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Rename some BLAKE2b-related constants to be consistent with the names
> used in the BLAKE2s implementation (see include/crypto/blake2s.h):
> 
> 	BLAKE2B_*_DIGEST_SIZE  => BLAKE2B_*_HASH_SIZE
> 	BLAKE2B_BLOCKBYTES     => BLAKE2B_BLOCK_SIZE
> 	BLAKE2B_KEYBYTES       => BLAKE2B_KEY_SIZE
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: David Sterba <dsterba@suse.com>
