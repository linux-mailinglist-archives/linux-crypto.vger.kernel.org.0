Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1770979E
	for <lists+linux-crypto@lfdr.de>; Fri, 19 May 2023 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjESMyl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 May 2023 08:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESMyl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 May 2023 08:54:41 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C5D2
        for <linux-crypto@vger.kernel.org>; Fri, 19 May 2023 05:54:39 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzzcv-00AtOE-5M; Fri, 19 May 2023 20:54:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 20:54:33 +0800
Date:   Fri, 19 May 2023 20:54:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [herbert-cryptodev-2.6:master 21/22]
 drivers/tty/serial/amba-pl011.c:379:30: error: implicit declaration of
 function 'phys_to_page'; did you mean 'pfn_to_page'?
Message-ID: <ZGdxiZhTdatjFG0O@gondor.apana.org.au>
References: <202305191929.Eq4OVZ6D-lkp@intel.com>
 <d4751f66-6e57-66da-f8ad-4ac2c8c46fd2@starfivetech.com>
 <ZGdvGWenGxwzOU4C@gondor.apana.org.au>
 <5cb75db7-0293-1cee-02aa-ac7159404f65@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb75db7-0293-1cee-02aa-ac7159404f65@starfivetech.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 19, 2023 at 08:50:23PM +0800, Jia Jie Ho wrote:
>
> Sure, should I submit new patch series again or just a new patch with this change?

Once your patch has been applied you should always send an
incremental patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
