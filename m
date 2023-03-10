Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFC6B3595
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 05:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCJEYV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Mar 2023 23:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJEXy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Mar 2023 23:23:54 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC9FCBC1
        for <linux-crypto@vger.kernel.org>; Thu,  9 Mar 2023 20:21:46 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paUG6-002Ok2-AG; Fri, 10 Mar 2023 12:21:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 12:21:34 +0800
Date:   Fri, 10 Mar 2023 12:21:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Mathew McBride <matt@traverse.com.au>,
        linux-crypto@vger.kernel.org
Subject: Re: Hitting BUG_ON in crypto_unregister_alg() on reboot with
 caamalg_qi2 driver
Message-ID: <ZAqwTqw3lR+dnImO@gondor.apana.org.au>
References: <87r0tyq8ph.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0tyq8ph.fsf@toke.dk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 09, 2023 at 03:51:22PM +0100, Toke H�iland-J�rgensen wrote:
> Hi folks
> 
> I'm hitting what appears to be a deliberate BUG_ON() in
> crypto_unregister_alg() when rebooting my traverse ten64 device on a
> 6.2.2 kernel (using the Arch linux-aarch64 build, which is basically an
> upstream kernel).
> 
> Any idea what might be causing this? It does not appear on an older
> (5.17, which is the newest kernel that works reliably, for unrelated
> reasons).

On the face of it this looks like a generic issue with drivers
and the Crypto API.  Historically crypto modules weren't meant
to be removed/unregistered until the last user has freed the tfm.

Obviously with drivers that start unregistering the algorithms when
the hardware goes away this paradigm breaks.  What should happen is
that the driver continues to hold onto the crypto algorithm registration
even when the hardware has gone away.

Some work has to be done in the driver to actually make this safe
(all the drivers I've looked at are broken in this way).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
