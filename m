Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B2793699
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Sep 2023 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjIFH5T (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Sep 2023 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjIFH5S (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Sep 2023 03:57:18 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F51E50
        for <linux-crypto@vger.kernel.org>; Wed,  6 Sep 2023 00:57:07 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qdnP3-00BFV8-Qk; Wed, 06 Sep 2023 15:56:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Sep 2023 15:56:47 +0800
Date:   Wed, 6 Sep 2023 15:56:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Guo Zihua <guozihua@huawei.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3] crypto: Fix hungtask for PADATA_RESET
Message-ID: <ZPgwvwcYDoPOCjTJ@gondor.apana.org.au>
References: <20230904133341.2528440-1-lujialin4@huawei.com>
 <ZPb4ovJ+eatyPk1E@gauss3.secunet.de>
 <f06917ed-a0ba-30f1-4b65-57fe96bbf741@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06917ed-a0ba-30f1-4b65-57fe96bbf741@huawei.com>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [167.179.156.38 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [167.179.156.38 listed in zen.spamhaus.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 RDNS_DYNAMIC Delivered to internal network by host with
        *      dynamic-looking rDNS
        *  3.6 HELO_DYNAMIC_IPADDR2 Relay HELO'd using suspicious hostname (IP
        *       addr 2)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 06, 2023 at 03:49:30PM +0800, Lu Jialin wrote:
> Hi Steffen,
> 
> padata_do_parallel is only called by pcrypt_aead_encrypt/decrypt, therefore,
> changing in padata_do_parallel and changing in pcrypt_aead_encrypt/decrypt
> have the same effect. Both should be ok.
> 
> Thanks.
> 
> Herbert, the two ways look both right. What is your suggestion?

Either way is fine by me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
