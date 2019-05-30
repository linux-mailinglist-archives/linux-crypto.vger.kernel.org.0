Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8489C2FC6B
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfE3Nfd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:35:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37900 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3Nfd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:35:33 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLDK-0005N5-NP; Thu, 30 May 2019 21:35:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLDD-0003ai-Cu; Thu, 30 May 2019 21:35:19 +0800
Date:   Thu, 30 May 2019 21:35:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vaneet Narang <v.narang@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        "terrelln@fb.com" <terrelln@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: [PATCH 1/2] zstd: pass pointer rathen than structure to functions
Message-ID: <20190530133519.gdkxey5lv4hrrv7q@gondor.apana.org.au>
References: <1557468704-3014-1-git-send-email-maninder1.s@samsung.com>
 <CGME20190510061311epcas5p19e9bf3d08319ac99890e03e0bd59e478@epcms5p1>
 <20190530091327epcms5p11a7725e9c01286b1a7c023737bf4e448@epcms5p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530091327epcms5p11a7725e9c01286b1a7c023737bf4e448@epcms5p1>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 30, 2019 at 02:43:27PM +0530, Vaneet Narang wrote:
> [Reminder] Any updates ?

I was assuming that Andrew was going to pick this up.  Andrew?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
