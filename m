Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0911DC61
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Dec 2019 04:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfLMDEy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Dec 2019 22:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731465AbfLMDEy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Dec 2019 22:04:54 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118902073B;
        Fri, 13 Dec 2019 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576206294;
        bh=9/fe6gRSM8GDHa+UTvtXG0TTnmTVSN+Lo/15bEMwwgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfQqc4ki0lT4VdS/qB08BR2xhYGv4WrfCtrA1qy06V8Ah/SJ3fSYScWP7/twxQSk9
         E8aaMbmajuzIPMsnKCHhefWaNXSfq3tVPQVHrHMpjQ7Mdkwk5/5NbIeR1FCeqz4VZV
         W45cHomYCuGgf29At/8KwCgfnlfy9Et1OZKkTzkk=
Date:   Thu, 12 Dec 2019 19:04:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Polyakov <appro@openssl.org>
Subject: Re: [PATCH crypto-next v3 2/3] crypto: x86_64/poly1305 - add faster
 implementations
Message-ID: <20191213030452.GB1109@sol.localdomain>
References: <20191212173258.13358-1-Jason@zx2c4.com>
 <20191212173258.13358-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212173258.13358-3-Jason@zx2c4.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 12, 2019 at 06:32:57PM +0100, Jason A. Donenfeld wrote:
> diff --git a/arch/x86/crypto/poly1305-x86_64.pl b/arch/x86/crypto/poly1305-x86_64.pl
> new file mode 100644
> index 000000000000..f994855cdbe2
> --- /dev/null
> +++ b/arch/x86/crypto/poly1305-x86_64.pl
> @@ -0,0 +1,4266 @@
> +#!/usr/bin/env perl
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#
> +# Copyright (C) 2017-2018 Samuel Neves <sneves@dei.uc.pt>. All Rights Reserved.
> +# Copyright (C) 2017-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> +# Copyright (C) 2006-2017 CRYPTOGAMS by <appro@openssl.org>. All Rights Reserved.
> +#
> +# This code is taken from the OpenSSL project but the author, Andy Polyakov,
> +# has relicensed it under the licenses specified in the SPDX header above.
> +# The original headers, including the original license headers, are
> +# included below for completeness.

Which version of OpenSSL is this from?  It doesn't match the latest version.

- Eric
