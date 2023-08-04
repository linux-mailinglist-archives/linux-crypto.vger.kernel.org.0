Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C176FD0C
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Aug 2023 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHDJQ7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Aug 2023 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHDJQZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Aug 2023 05:16:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBA5BBC;
        Fri,  4 Aug 2023 02:14:07 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRqsj-003b2H-K5; Fri, 04 Aug 2023 17:14:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 17:14:01 +0800
Date:   Fri, 4 Aug 2023 17:14:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc:     Bastian Krause <bst@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>
Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
Message-ID: <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 24, 2023 at 05:13:23AM +0000, Meenakshi Aggarwal wrote:
> Hi Bastian,
> 
> Please share the required information.

Any progress on this?

Should we revert the offending patch?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
