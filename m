Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF659AA42
	for <lists+linux-crypto@lfdr.de>; Sat, 20 Aug 2022 02:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbiHTAkw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Aug 2022 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbiHTAkf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Aug 2022 20:40:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FA113DF2
        for <linux-crypto@vger.kernel.org>; Fri, 19 Aug 2022 17:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39BB9B829A0
        for <linux-crypto@vger.kernel.org>; Sat, 20 Aug 2022 00:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6EDC433D6;
        Sat, 20 Aug 2022 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660956032;
        bh=Jq/31toTBgAKQQbUL07ibEi8mCofG0AbmDhRDO/xawU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5kzgyNrqk3wakHwnP0EnuAGlxdHs4XnEd4o7k2sGVKH/puZavaOuCcbBeFY06u6C
         OKCW8FIMeEtAJ2vKCgUbT3USrUjxqkkDcPwOe/f0qrJ8HFqzVbyPvTiMlBOd7f/1Jd
         yWINXa3/jzeMGm6tC2bIi8D3BKLJcbzggeURIHTu1o6eVHZtVnk+iC3xzo+aCt8o6e
         ZW1PRvR1nnSptn3kQ6fn5J2ZIxQQRAU19FynmciQzOOKUuKFrFM64awtKl8cFuQsXD
         N2YHw1d38vsi1pAtWUDPe7qp0JOIchbfldnvrtg2BjzzER3h8TxoSg0g/IL1EiEZPX
         OnqNR+jDdXLBQ==
Date:   Fri, 19 Aug 2022 17:40:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Wright, Randy (HPE Servers Linux)" <rwright@hpe.com>
Subject: Re: [PATCH] crypto: testmgr - don't generate WARN for missing modules
Message-ID: <YwAtfgc3ftCp3Joy@sol.localdomain>
References: <20220813231443.2706-1-elliott@hpe.com>
 <Yv9uhQY7UAPN7QDE@gondor.apana.org.au>
 <YwAZhFLCrlHXegr9@sol.localdomain>
 <MW5PR84MB1842130E7FA4D064D50DC1EDAB6F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842130E7FA4D064D50DC1EDAB6F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Aug 20, 2022 at 12:15:41AM +0000, Elliott, Robert (Servers) wrote:
> Per Stephan, it sounds like this was a hacky way to get some/most of
> the modules loaded.
> 
> It'd be good if there was a way to run all registered tests on all
> available modules, not just the ones that someone remembered to put
> in tcrypt.c.

Most algorithms can be allocated via a userspace program using AF_ALG.  The only
exception is algorithm types that AF_ALG doesn't support.

> I do worry this WARN() isn't really helpful even for real self-test
> failures - it's dumping the call trace to alg_test(), not the
> trace to whatever crypto function alg_test called that is failing. 
> With Linus always expressing concern with too many BUG and WARN
> calls, it might be better as just pr_warn() or pr_err().

It's very helpful because WARN is the standard way for the kernel to report that
a kernel bug has been encountered.  A test failure is a kernel bug.

The stack trace printed by WARN indeed isn't useful here, as it will always be
the same.  But it's just a side effect.  The important things here are that a
WARN is triggered at all, and that some log messages that describe what failed
are printed.

- Eric
