Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA44BD33B
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Feb 2022 02:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiBUBqN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 20 Feb 2022 20:46:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245467AbiBUBqN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 20 Feb 2022 20:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B95517CC;
        Sun, 20 Feb 2022 17:45:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 518846101A;
        Mon, 21 Feb 2022 01:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B0DC340E8;
        Mon, 21 Feb 2022 01:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645407948;
        bh=33KkTmZUCFrZDC4MSXVCMJpi9jP7GBSc9fXQNM6W5xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgO+kEDvmWyECWfvJYNR9L29Nv99GLA2dy4Ln0atgeOdSEntwiRsafY7uTJzNARmK
         x+OTCvunnZPFUAO7R0e9UeE0aHq6ETfEYxpK1FEy/X5p5NKVE+uvlls0Wa5/RiJtca
         Ex9CS5JbZK8cxN7z9Uyrl88IvX0kgt+1JqOJ5OLXA1JgJsScKjiwyU2GbRTJYxOb5b
         08/VxPEF6enr4FttftMVwOj8UqD1ArZSHVfW3Kpl6dm9jG2WhpE15zWadXlqZ2CGqs
         0WCxxvuzyEB1NJj3FboGzsETjdbBg7gPORZDAF6BuFALWzbjNwwV7WbMgx2px5ROsb
         X6T3+Di9hI2Ig==
Date:   Mon, 21 Feb 2022 02:46:26 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: asymmetric: properly validate hash_algo and
 encoding
Message-ID: <YhLu8gZtdpphy5mB@kernel.org>
References: <20220201003414.55380-1-ebiggers@kernel.org>
 <20220201003414.55380-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201003414.55380-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 31, 2022 at 04:34:14PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> It is insecure to allow arbitrary hash algorithms and signature
> encodings to be used with arbitrary signature algorithms.  Notably,
> ECDSA, ECRDSA, and SM2 all sign/verify raw hash values and don't
> disambiguate between different hash algorithms like RSA PKCS#1 v1.5
> padding does.  Therefore, they need to be restricted to certain sets of
> hash algorithms (ideally just one, but in practice small sets are used).
> Additionally, the encoding is an integral part of modern signature
> algorithms, and is not supposed to vary.
> 
> Therefore, tighten the checks of hash_algo and encoding done by
> software_key_determine_akcipher().
> 
> Also rearrange the parameters to software_key_determine_akcipher() to
> put the public_key first, as this is the most important parameter and it
> often determines everything else.
> 
> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
> Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/public_key.c | 111 +++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 35 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index aba7113d86c76..a603ee8afdb8d 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -60,39 +60,83 @@ static void public_key_destroy(void *payload0, void *payload3)
>  }
>  
>  /*
> - * Determine the crypto algorithm name.
> + * Given a public_key, and an encoding and hash_algo to be used for signing
> + * and/or verification with that key, determine the name of the corresponding
> + * akcipher algorithm.  Also check that encoding and hash_algo are allowed.
>   */
> -static
> -int software_key_determine_akcipher(const char *encoding,
> -				    const char *hash_algo,
> -				    const struct public_key *pkey,
> -				    char alg_name[CRYPTO_MAX_ALG_NAME])
> +static int
> +software_key_determine_akcipher(const struct public_key *pkey,
> +				const char *encoding, const char *hash_algo,
> +				char alg_name[CRYPTO_MAX_ALG_NAME])

Why is changing parameter order necessary?

BR, Jarkko
