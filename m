Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4D2EA4E4
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jan 2021 06:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbhAEF30 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jan 2021 00:29:26 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53756 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbhAEF30 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jan 2021 00:29:26 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kwete-0008S2-HW; Tue, 05 Jan 2021 16:28:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 Jan 2021 16:28:42 +1100
Date:   Tue, 5 Jan 2021 16:28:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-crypto@vger.kernel.org, tony@atomide.com
Subject: Re: [BISECTED REGRESSION] v5.10 stalles on assoication with a wpa2
 802.11 ap
Message-ID: <20210105052842.GA23936@gondor.apana.org.au>
References: <20210104205348.ba98a7a6c7dc905ba4c684c7@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210104205348.ba98a7a6c7dc905ba4c684c7@uvos.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 04, 2021 at 08:53:48PM +0100, Carl Philipp Klemm wrote:
>
> I bisected this regession to the commit
> 00b99ad2bac256e3e4f10214c77fce6603afca26 "crypto: arm/aes-neonbs - Use
> generic cbc encryption path", reverting this commit and
> 5f254dd440fbad0c00632f9ac7645f07d8df9229 "crypto: cbc - Remove cbc.h"
> to allow the v5.10 tag to compile restores full functionality.

This should already be fixed in mainline by

commit a2715fbdc6fc387e85211df917a4778761ec693d
Author: Horia Geantă <horia.geanta@nxp.com>
Date:   Wed Oct 28 11:03:20 2020 +0200

    crypto: arm/aes-neonbs - fix usage of cbc(aes) fallback

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
