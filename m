Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46C322C649
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Jul 2020 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGXNYw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jul 2020 09:24:52 -0400
Received: from ozlabs.org ([203.11.71.1]:54591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGXNYw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgL0JnKz9sTT; Fri, 24 Jul 2020 23:24:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     nayna@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        pfsmorigo@gmail.com, herbert@gondor.apana.org.au,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, corbet@lwn.net,
        davem@davemloft.net, linux-doc@vger.kernel.org, paulus@samba.org,
        benh@kernel.crashing.org, linux-crypto@vger.kernel.org,
        leitao@debian.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au
In-Reply-To: <20200718103958.5455-1-grandmaster@al2klimov.de>
References: <20200718103958.5455-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] powerpc: Replace HTTP links with HTTPS ones
Message-Id: <159559696781.1657499.3467682028636656801.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:24:44 +1000 (AEST)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, 18 Jul 2020 12:39:58 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied to powerpc/next.

[1/1] powerpc: Replace HTTP links with HTTPS ones
      https://git.kernel.org/powerpc/c/c8ed9fc9d29e24dafd08971e6a0c6b302a8ade2d

cheers
