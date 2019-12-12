Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9911CCCE
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Dec 2019 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfLLMJK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Dec 2019 07:09:10 -0500
Received: from sitav-80046.hsr.ch ([152.96.80.46]:47108 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfLLMJK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Dec 2019 07:09:10 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 07:09:09 EST
Received: from obook.fritz.box (unknown [IPv6:2a01:2a8:8500:5c01:6946:d015:47d4:9c3d])
        by mail.strongswan.org (Postfix) with ESMTPSA id 46AD2401A2;
        Thu, 12 Dec 2019 13:03:28 +0100 (CET)
Message-ID: <d55e0390c7187b09f820e123b05df1e5e680df0b.camel@strongswan.org>
Subject: Re: [PATCH crypto-next v2 1/3] crypto: poly1305 - add new 32 and
 64-bit generic versions
From:   Martin Willi <martin@strongswan.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org
Date:   Thu, 12 Dec 2019 13:03:27 +0100
In-Reply-To: <20191212093008.217086-1-Jason@zx2c4.com>
References: <20191211170936.385572-1-Jason@zx2c4.com>
         <20191212093008.217086-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Jason,

> These two C implementations from Zinc -- a 32x32 one and a 64x64 one,
> depending on the platform -- come from Andrew Moon's public domain
> poly1305-donna portable code, modified for usage in the kernel. The
> precomputation in the 32-bit version and the use of 64x64 multiplies
> in the 64-bit version make these perform better than the code it
> replaces.

Can you provide some numbers to testify that? In my tests, the 32-bit
version gives me exact the same results. 

The 64-bit version is roughly 10% faster. However, what are the
platforms where the 64-bit version matters? Won't any SIMD version
outperform the 64-bit version anyway?

Martin

