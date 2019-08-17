Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8790D13
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Aug 2019 07:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfHQFTp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 17 Aug 2019 01:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfHQFTp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 17 Aug 2019 01:19:45 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E2C2133F;
        Sat, 17 Aug 2019 05:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566019184;
        bh=0m42WxpnNvB2LIIoXV3Qt7RozsFwLPhdGtSDshLxu/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYwco9Y0vgtdu7K3kODtpMJ4HtpuvNU7e8UGNub397SYEx5RU2n86BfXBlwstep8K
         xaSCL7XzkJuT1rxzuVUBL12jh3zpsEd+MLtMSJmzClS3NKy9loo1CgfmnpTeRwpM8e
         s9g+iAQu8jHnQOIpMYYmnn4sdcLHW/ZzulmZPjAI=
Date:   Fri, 16 Aug 2019 22:19:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] crypto: sha256 - Move lib/sha256.c to lib/crypto
Message-ID: <20190817051942.GB8209@sol.localdomain>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211611.2568-4-hdegoede@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 16, 2019 at 11:16:08PM +0200, Hans de Goede wrote:
> diff --git a/include/linux/sha256.h b/include/crypto/sha256.h
> similarity index 100%
> rename from include/linux/sha256.h
> rename to include/crypto/sha256.h

<crypto/sha.h> already has the declarations for both SHA-1 and SHA-2, including
SHA-256.  So I'm not sure a separate sha256.h is appropriate.  How about putting
these declarations in <crypto/sha.h>?

- Eric
