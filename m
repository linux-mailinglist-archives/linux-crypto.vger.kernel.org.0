Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7E62524D
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Nov 2022 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKKEPS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Nov 2022 23:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKEPD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Nov 2022 23:15:03 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7D67131
        for <linux-crypto@vger.kernel.org>; Thu, 10 Nov 2022 20:15:01 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1otLRT-00Cq7H-4Z; Fri, 11 Nov 2022 12:15:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Nov 2022 12:14:59 +0800
Date:   Fri, 11 Nov 2022 12:14:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 6/6] crypto: compile out test-related algboss code
 when tests disabled
Message-ID: <Y23MQzy9biQUF6ZJ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110081346.336046-7-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> @@ -171,15 +171,17 @@ static int cryptomgr_schedule_probe(struct crypto_larval *larval)
>        return NOTIFY_OK;
> }
> 
> +#ifdef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> +static int cryptomgr_schedule_test(struct crypto_alg *alg)
> +{
> +       return NOTIFY_DONE;
> +}
> +#else

Could you please do this inline with an if statement rather than
as #ifdefs? That is,

static int cryptomgr_schedule_test(struct crypto_alg *alg)
{
	struct task_struct *thread;
	struct crypto_test_param *param;
	u32 type;

	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
		return NOTIFY_DONE;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
