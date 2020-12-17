Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447182DD92A
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgLQTLY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 14:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgLQTLY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 14:11:24 -0500
Date:   Thu, 17 Dec 2020 11:10:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608232243;
        bh=h1cs6P1xSezEvY7zbfyx2PldwdicPnwi3rt+WTj26Cg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6pH0OSAe59mGCEQe9OrkQ7wOFFdaHCFQbo2xjTzcNxMwTTewICwM6d9q/7geeV1w
         mDzRR1ZvrY+j5gUs8Us6CSnIXKxg/fSWAf2pb5ipKIljtH9BYvePJ2gOwj/nJ57LJb
         AiKYZqpKl5qnu/Wbq6hgQsbbb/6Yc68HvRtyvgNX2PQatqJtRR+ZeqhpBhyr/eOxXC
         v8KLTjzQu36v5G8VEwT/ggfoXQHZhLs03NGXqTT2SdaA5ZXOXgohbhVFbaem1qB3x6
         ho7+fiqAvDY/PYP8KKzY24DZIxrabp0q5f7caDqyEo75S+3PJRdBjP5nFk03D1dXAL
         3nl2oO5RsXMWg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] x86: Support Intel Key Locker
Message-ID: <X9utMeDKfjdghy1M@sol.localdomain>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216174146.10446-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 16, 2020 at 09:41:38AM -0800, Chang S. Bae wrote:
> [1] Intel Architecture Instruction Set Extensions Programming Reference:
>     https://software.intel.com/content/dam/develop/external/us/en/documents/architecture-instruction-set-$
> [2] Intel Key Locker Specification:
>     https://software.intel.com/content/dam/develop/external/us/en/documents/343965-intel-key-locker-speci$

Both of these links are broken.

- Eric
