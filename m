Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4738972D0
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Aug 2019 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfHUGoB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 21 Aug 2019 02:44:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58086 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfHUGoB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 21 Aug 2019 02:44:01 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1i0KLX-00023X-Tn; Wed, 21 Aug 2019 16:43:52 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1i0KLV-0005nN-HP; Wed, 21 Aug 2019 16:43:49 +1000
Date:   Wed, 21 Aug 2019 16:43:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] padata: always acquire cpu_hotplug_lock before
 pinst->lock
Message-ID: <20190821064349.GA22104@gondor.apana.org.au>
References: <20190809192857.26585-1-daniel.m.jordan@oracle.com>
 <20190815051518.GB24982@gondor.apana.org.au>
 <f25cc77e-d467-c7a9-415c-eb9f46ac8493@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25cc77e-d467-c7a9-415c-eb9f46ac8493@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 21, 2019 at 12:14:19AM -0400, Daniel Jordan wrote:
>
> I'll try fixing the flushing with Steffen's refcounting idea assuming he hasn't already started on that.  So we're on the same page, the problem is that if padata's ->parallel() punts to a cryptd thread, flushing the parallel work will return immediately without necessarily indicating the parallel job is finished, so flushing is pointless and padata_replace needs to wait till the instance's refcount drops to 0.  Did I get it right?

Yeah you can never flush an async crypto job.  You have to wait
for it to finish.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
