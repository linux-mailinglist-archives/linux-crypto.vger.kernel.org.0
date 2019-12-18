Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1312472F
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Dec 2019 13:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRMqP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Dec 2019 07:46:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfLRMqP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Dec 2019 07:46:15 -0500
Received: from zn.tnic (p200300EC2F0B8B004C237F05E7CC242C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:4c23:7f05:e7cc:242c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA5171EC09F1;
        Wed, 18 Dec 2019 13:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576673170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yXwLnW+PoY25pshD8Wq5cZaWHHz1WD1asE9i3LHbFgo=;
        b=CObDVqosp5y7Z8sELy68i2YofwvsnqQOrexIoHXuwx4iBrrN1Ec2LK/g2G2LFmAiahNTHg
        KIiIEFVVTQ/7/vwqbtJd3690sOFs622Qt+IGBBhv3TTl1kj/mGgkbqwxQazwVNQmuphqqd
        SBLhof85IDWs90nsRlzcY4JsHr0Bl6I=
Date:   Wed, 18 Dec 2019 13:46:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/11] x86/crypto: Adapt assembly for PIE support
Message-ID: <20191218124604.GE24886@zn.tnic>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-2-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205000957.112719-2-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 04, 2019 at 04:09:38PM -0800, Thomas Garnier wrote:
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.

FFS, how many times do we have to talk about this auto-sprinkled
sentence?!

https://lkml.kernel.org/r/20190805163202.GD18785@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
